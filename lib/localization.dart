/*
The MIT License (MIT)

Copyright (c) 2019 Sami Benyoussef

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

This File Is Created By Sami Benyoussef

Developer: Sami Benyoussef
Email: contact@samibenyoussef.com
Github Repo: https://github.com/samiby/caloriya

*/

// Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Caloriya/localization_strings.dart';

class Localization {
  final Locale locale;

  Localization(this.locale);

  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en' : en,
    'fr' : fr,
  };

  _getValue(String key) => _localizedValues[locale.languageCode][key];

  String get quitterApp => _getValue(QuitterApp);
  String get quitterAppConfirmation => _getValue(QuitterAppConfirmation);
  String get remplissezTousLesChamps => _getValue(RemplissezTousLesChamps);
  String get quitterAppConfirmationNON => _getValue(QuitterAppConfirmationNon);
  String get quitterAppConfirmationOUI => _getValue(QuitterAppConfirmationOui);
  String get genteFemme => _getValue(GenteFemme);
  String get genteHomme => _getValue(GenteHomme);
  String get appuyerPourEntrerVotreAge => _getValue(AppuyerPourEntrerVotreAge);
  String get entrezVotrePoidsEnKilos => _getValue(EntrezVotrePoidsEnKilos);
  String get quelleEstVotreActiviteSportive => _getValue(QuelleEstVotreActiviteSportive);
  String get calculerCalories => _getValue(CalculerCalories);
  String get votreBesoinEnCalories => _getValue(VotreBesoinEnCalories);
  String get erreurChampsObligatoires => _getValue(ErreurChampsObligatoires);
  String get erreurTousLesChampsNeSontPasRemplis => _getValue(ErreurTousLesChampsNeSontPasRemplis);

}

class LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of Localization.
    return SynchronousFuture<Localization>(Localization(locale));
  }

  @override
  bool shouldReload(LocalizationDelegate old) => false;
}