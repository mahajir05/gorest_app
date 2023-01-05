import 'package:flutter/material.dart';

void printWhite(String message) => debugPrint('\x1B[37m$message\x1B[0m');
void printGreen(String message) => debugPrint('\x1B[32m$message\x1B[0m');
void printRed(String message) => debugPrint('\x1B[31m$message\x1B[0m');
void printYellow(String message) => debugPrint('\x1B[33m$message\x1B[0m');
void printBlack(String message) => debugPrint('\x1B[30m$message\x1B[0m');
