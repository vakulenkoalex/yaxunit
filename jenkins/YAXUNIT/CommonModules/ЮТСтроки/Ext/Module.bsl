﻿//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2023 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

#Область ПрограммныйИнтерфейс

// Строка с символами русского алфавита
// 
// Параметры:
//  НижнийРегистр - Булево - добавить символы в нижнем регистре
//  ВерхнийРегистр - Булево - добавить символы в верхнем регистре
// 
// Возвращаемое значение:
//  Строка
Функция РусскиеБуквы(НижнийРегистр = Истина, ВерхнийРегистр = Ложь) Экспорт
	
	Возврат Буквы("абвгдеёжзийклмнопрстуфхцчшщъыьэюя", НижнийРегистр, ВерхнийРегистр);
	
КонецФункции

// Строка с символами английского алфавита
// 
// Параметры:
//  НижнийРегистр - Булево - добавить символы в нижнем регистре
//  ВерхнийРегистр - Булево - добавить символы в верхнем регистре
// 
// Возвращаемое значение:
//  Строка
Функция АнглийскиеБуквы(НижнийРегистр = Истина, ВерхнийРегистр = Ложь) Экспорт
	
	Возврат Буквы("abcdefghijklmnopqrstuvwxyz", НижнийРегистр, ВерхнийРегистр);
	
КонецФункции

// Строка с числами
// 
// Возвращаемое значение:
//  Строка
Функция Цифры() Экспорт
	
	Возврат "1234567890";
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция Буквы(Буквы, НижнийРегистр, ВерхнийРегистр)
	
	Если НижнийРегистр И ВерхнийРегистр Тогда
		Возврат Буквы + ВРег(Буквы);
	ИначеЕсли НижнийРегистр Тогда
		Возврат Буквы;
	ИначеЕсли ВерхнийРегистр Тогда
		Возврат ВРег(Буквы);
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

#КонецОбласти
