import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/key_value.dart';
import 'form_dropdown.dart';
import 'form_label.dart';
import 'form_textfield.dart';

class CCForm extends StatefulWidget {
  const CCForm();

  @override
  State<CCForm> createState() => _CCFormState();
}

class _CCFormState extends State<CCForm> {
  String companyTitle = '';

  List<KeyValue> types = [];

  List<KeyValue> scopes = [];

  List<KeyValue> users = [];

  List<KeyValue> gitmojis = [];

  String? typeValue;

  String? scopeValue;

  String? userValue;

  final ValueNotifier<bool> breakingChange = ValueNotifier(true);

  final ValueNotifier<bool> showCopyMessage = ValueNotifier(false);

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _bItemController = TextEditingController();

  final TextEditingController _messageController = TextEditingController();

  final TextEditingController _bChangeDescController = TextEditingController();

  final TextEditingController _versionController = TextEditingController();

  setTypeValue(String value) {
    typeValue = value;
    generateCommit();
  }

  setScopeValue(String value) {
    scopeValue = value;
    generateCommit();
  }

  setUserValue(String value) {
    userValue = value;
    generateCommit();
  }

  setBreakingChange(bool checked) {
    breakingChange.value = checked;
    generateCommit();
  }

  generateCommit() {
    if (typeValue != '' &&
        typeValue != null &&
        scopeValue != '' &&
        scopeValue != null &&
        userValue != '' &&
        userValue != null &&
        _titleController.value.text != '' &&
        _versionController.value.text != '') {
      final DateTime date = DateTime.now();

      String commitMessage = '${_bChangeDescController.value.text != '' ? '!' : ''}$typeValue [${getEmoji(typeValue!)}] ($scopeValue): ${_titleController.value.text} \n\n'
          '${_descriptionController.value.text != '' ? '${descriptionParser(_descriptionController.value.text)} \n\n' : ''}'
          '${_bChangeDescController.value.text != '' ? 'BREAKING CHANGES: ${_bChangeDescController.value.text} \n\n' : ''}'
          '${_bItemController.value.text != '' ? 'Refs: ${formatBoardItems()} \n' : ''}'
          'Version: ${_versionController.value.text}-${date.year}${date.month < 10 ? '0${date.month}' : date.month}${date.day} \n'
          'User: ${getUser(userValue!)} $userValue';

      _messageController.text = commitMessage;
    }
  }

  clearData() {
    setState(() {
      typeValue = null;
      scopeValue = null;
      userValue = null;
    });

    _titleController.text = '';
    _messageController.text = '';
    _bChangeDescController.text = '';
    _descriptionController.text = '';
    _versionController.text = '';
    _bItemController.text = '';
  }

  String descriptionParser(String description) {
    return _descriptionController.value.text != '' ? (description.split('\n')).where((line) => line != '').map((line) => '- ' + line).join('\n') : '';
  }

  String getEmoji(String selectedType) {
    return gitmojis.firstWhere((gitmoji) => gitmoji.key == selectedType).value;
  }

  String formatBoardItems() {
    String formattedBA = '';
    final splittedBA = _bItemController.value.text.replaceAll(' ', '').split(',');
    for (var id in splittedBA) {
      formattedBA += '${formattedBA == '' ? '' : ', '}BA#$id';
    }
    return formattedBA;
  }

  String getUser(String selectedUser) {
    return users.firstWhere((user) => user.key == selectedUser).value;
  }

  Future<void> waitTask({required Function callback, seconds = 1}) async {
    await Future.delayed(Duration(seconds: seconds));
    callback();
  }

  Future<dynamic> readJson() async {
    final String response = await rootBundle.loadString('assets/config/config.json');
    return await json.decode(response);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readJson(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data != null) {
          companyTitle = snapshot.data['companyTitle'];
          types = keyValueFromJson(snapshot.data['types']);
          scopes = keyValueFromJson(snapshot.data['scopes']);
          users = keyValueFromJson(snapshot.data['users']);
          gitmojis = keyValueFromJson(snapshot.data['gitmojis']);
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: FormLabel(label: 'Title'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: FormTextField(
                      inputFormatters: [FilteringTextInputFormatter(RegExp(r'.*'), allow: true)],
                      onChangeCallback: generateCommit,
                      placeholder: 'Brief Description',
                      controller: _titleController,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: FormLabel(label: 'Type'),
                  ),
                  const SizedBox(width: 10),
                  FormDropdown(types, setTypeValue),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    flex: 1,
                    child: FormLabel(label: 'Scope'),
                  ),
                  const SizedBox(width: 10),
                  FormDropdown(scopes, setScopeValue),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    flex: 1,
                    child: FormLabel(
                      label: 'Description',
                      size: 10,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: FormTextField(
                      inputFormatters: null,
                      onChangeCallback: generateCommit,
                      controller: _descriptionController,
                      height: 90,
                      maxLines: 60,
                      placeholder: 'Description',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    flex: 1,
                    child: FormLabel(label: 'Board Items #'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: FormTextField(
                      inputFormatters: [FilteringTextInputFormatter(RegExp(r'[0-9, ]'), allow: true)],
                      onChangeCallback: generateCommit,
                      controller: _bItemController,
                      placeholder: 'Ex: 45, 2, 89',
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     Expanded(
              //       flex: 1,
              //       child: FormLabel(label: 'Breaking Changes', size: 11),
              //     ),
              //     const SizedBox(width: 10),
              //     Expanded(
              //       flex: 5,
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           CustomCheckbox(SetBreakingChange),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              ValueListenableBuilder(
                  valueListenable: breakingChange,
                  builder: (_, value, __) {
                    return value != false
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: FormLabel(
                                      label: 'Breaking Changes',
                                      size: 10,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 5,
                                    child: FormTextField(
                                      inputFormatters: [FilteringTextInputFormatter(RegExp(r'.*'), allow: true)],
                                      controller: _bChangeDescController,
                                      onChangeCallback: generateCommit,
                                      height: 60,
                                      maxLines: 60,
                                      placeholder: 'Breaking Changes Description',
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Column();
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    flex: 1,
                    child: FormLabel(
                      label: 'System Version',
                      size: 10,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: FormTextField(
                      inputFormatters: [FilteringTextInputFormatter(RegExp(r'[0-9.]'), allow: true)],
                      onChangeCallback: generateCommit,
                      controller: _versionController,
                      placeholder: 'Ex: 2.3.53',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    flex: 1,
                    child: FormLabel(label: 'User'),
                  ),
                  const SizedBox(width: 10),
                  FormDropdown(users, setUserValue),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.white,
              ),
              const FormLabel(label: 'Commit Message'),
              const SizedBox(
                height: 10,
              ),
              FormTextField(
                inputFormatters: [FilteringTextInputFormatter(RegExp(r'.*'), allow: true)],
                onChangeCallback: () {},
                controller: _messageController,
                height: 180,
                maxLines: 40,
                placeholder: '',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: clearData,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white54,
                    ),
                    iconSize: 18,
                    splashRadius: 20,
                    tooltip: 'Clear',
                  ),
                  ValueListenableBuilder(
                    valueListenable: showCopyMessage,
                    builder: (_, value, __) {
                      return value != false
                          ? const Text(
                              'Copied!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                  IconButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: _messageController.value.text));
                      showCopyMessage.value = true;
                      waitTask(
                          callback: () {
                            showCopyMessage.value = false;
                          },
                          seconds: 1);
                    },
                    icon: const Icon(
                      Icons.copy,
                      color: Colors.white54,
                    ),
                    iconSize: 18,
                    splashRadius: 20,
                    tooltip: 'Copy',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Commit Creator Utility',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white12,
                      fontSize: 9,
                    ),
                  ),
                  Text(
                    'v 1.0.0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white12,
                      fontSize: 9,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
