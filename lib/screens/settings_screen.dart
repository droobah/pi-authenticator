/*
  privacyIDEA Authenticator

  Authors: Timo Sturm <timo.sturm@netknights.it>

  Copyright (c) 2017-2020 NetKnights GmbH

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import 'dart:async';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privacyidea_authenticator/utils/application_theme_utils.dart';
import 'package:privacyidea_authenticator/utils/storage_utils.dart';
import 'package:privacyidea_authenticator/widgets/password_dialogs.dart';
import 'package:privacyidea_authenticator/widgets/settings_groups.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen(this._title);

  final String _title;

  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  StreamController<bool> _isPasswordSetController;

  Stream<bool> get isPasswordSet => _isPasswordSetController.stream;

  @override
  void initState() {
    super.initState();

    var checkPassword = () async =>
        _isPasswordSetController.add(await StorageUtil.isPasswordSet());

    _isPasswordSetController = StreamController<bool>(
      onListen: checkPassword,
      onResume: checkPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSystemDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget._title,
          textScaleFactor: screenTitleScaleFactor,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SettingsGroup(
              title: 'Theme',
              children: <Widget>[
                RadioListTile(
                  title: Text('Light theme'),
                  value: Brightness.light,
                  groupValue: Theme.of(context).brightness,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: !isSystemDarkMode
                      ? (value) {
                          setState(() => changeBrightness(value));
                        }
                      : null,
                ),
                RadioListTile(
                  title: Text('Dark theme'),
                  value: Brightness.dark,
                  groupValue: Theme.of(context).brightness,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: !isSystemDarkMode
                      ? (value) {
                          setState(() => changeBrightness(value));
                        }
                      : null,
                ),
              ],
            ),
            Divider(),
            SettingsGroup(
              title: 'Security', // TODO Translate
              children: <Widget>[
                ListTile(
                  title: Text('Lock app'),
                  // TODO Translate
                  subtitle: Text('Ask for Password on app start'),
                  // TODO Translate
                  trailing: StreamBuilder<bool>(
                    stream: isPasswordSet,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        // Because initial data causes weird ui update.
                        return Switch(
                          value: false,
                          onChanged: (value) {},
                        );
                      }

                      return Switch(
                        value: snapshot.data,
                        onChanged: (value) async {
                          if (snapshot.data && !value) {
                            // Disable password
                            _attemptRemovePassword(() async {
                              await StorageUtil.deletePassword();
                              _isPasswordSetController.add(false);
                            });
                          } else if (!snapshot.data && value) {
                            // Enable password
                            _setNewAppPassword();
                          }
                        },
                      );
                    },
                  ),
                ),
                PreferenceBuilder<bool>(
                  preference: AppSettings.of(context).streamHideOpts(),
                  builder: (context, bool hideOTP) {
                    print('Rebuild switch');
                    return ListTile(
                      title: Text('Hide passwords'),
                      // TODO Translate
                      subtitle: Text('Obscure passwords'),
                      // TODO Translate
                      trailing: Switch(
                        value: hideOTP,
                        onChanged: (value) async {
                          AppSettings.of(context).setHideOpts(value);
//                            AppSettings.of(context).setHideOpts(value);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
//            Divider(),
//            SettingsGroup(
//              title: 'Behavior',
//              children: <Widget>[
//                ListTile(
//                  title: Text('Hide otp'),
//                  subtitle: Text('Description'),
//                  trailing: Switch(
//                    value: _hideOTP,
//                    onChanged: (value) {
//                      _hideOTP = value;
//                    },
//                  ),
//                ),
//              ],
//            ),
          ],
        ),
      ),
    );
  }

  void _setNewAppPassword() async {
    String newPassword = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => EnterNewPasswordDialog(),
    );

    if (newPassword != null) {
      await StorageUtil.setPassword(newPassword);
      _isPasswordSetController.add(true);
    }
  }

  _attemptRemovePassword(VoidCallback callback) async {
    if (!(await StorageUtil.isPasswordSet())) return;
    await validatePassword(
        context: context,
        allowCancel: true,
        success: () async {
          await StorageUtil.deletePassword();
          _isPasswordSetController.add(false);
        });
  }

  void changeBrightness(Brightness value) {
    DynamicTheme.of(context).setBrightness(value);
  }
}

class AppSettings extends InheritedWidget {
  // Preferences
  static String _prefHideOtps = 'KEY_HIDE_OTPS';

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppSettings of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppSettings>();

  AppSettings({Widget child, StreamingSharedPreferences preferences})
      : _hideOpts = preferences.getBool(_prefHideOtps, defaultValue: false),
        super(child: child);

  final Preference<bool> _hideOpts;

  Stream<bool> streamHideOpts() => _hideOpts;

  void setHideOpts(bool value) => _hideOpts.setValue(value);
}
