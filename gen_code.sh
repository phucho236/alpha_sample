#!/usr/bin/env bash

flutter clean
flutter pub get
flutter packages pub run build_runner watch --delete-conflicting-outputs
