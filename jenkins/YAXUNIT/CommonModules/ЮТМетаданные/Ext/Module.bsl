﻿//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2024 BIA-Technologies Limited Liability Company
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

// Описание объекта метаданных.
// 
// Параметры:
//  Значение - ОбъектМетаданных
//           - Тип - Тип объекта информационной базы
//           - Строка - Полное имя объекта метаданных
//           - см. СтруктураОписанияОбъектаМетаданных
//           - Произвольный - Объект информационной базы
// 
// Возвращаемое значение:
//  см. СтруктураОписанияОбъектаМетаданных
Функция ОписаниеОбъектаМетаданных(Знач Значение) Экспорт
	
	Если ЮТМетаданныеСлужебный.ЭтоОписаниеОбъектаМетаданных(Значение) Тогда
		//@skip-check constructor-function-return-section
		Возврат Значение;
	КонецЕсли;
	
	ТипЗначения = ТипЗнч(Значение);
	
	ТипТип = Тип("Тип");
#Если Сервер Тогда
	Если ТипЗначения = Тип("ОбъектМетаданных") Тогда
		Значение = Значение.ПолноеИмя();
		ТипЗначения = Тип("Строка");
	КонецЕсли;
#КонецЕсли
	
	Если ТипЗначения <> ТипТип И ТипЗначения <> Тип("Строка") Тогда
		Значение = ТипЗнч(Значение);
		ТипЗначения = ТипТип;
	КонецЕсли;
	
	Если ТипЗначения = ТипТип Тогда
		ИдентификаторТипа = ЮТТипыДанныхСлужебный.ИдентификаторТипа(Значение); // Для работы кэширования
		//@skip-check constructor-function-return-section
		Возврат ЮТМетаданныеСлужебныйПовтИсп.ОписаниеОбъектаМетаданныхПоИдентификаторуТипа(ИдентификаторТипа);
	Иначе
		//@skip-check constructor-function-return-section
		Возврат ЮТМетаданныеСлужебныйПовтИсп.ОписаниеОбъектаМетаданных(Значение);
	КонецЕсли;
	
КонецФункции

// Возвращает нормализованное имя таблицы, то которое можно использовать в запросах
// 
// Параметры:
//  Значение - ОбъектМетаданных
//           - Тип - Тип объекта информационной базы
//           - Строка - Полное имя объекта метаданных
//           - см. СтруктураОписанияОбъектаМетаданных
//           - Произвольный - Объект информационной базы
// 
// Возвращаемое значение:
//  Строка - Нормализованное имя таблицы
Функция НормализованноеИмяТаблицы(Значение) Экспорт
	
	Описание = ОписаниеОбъектаМетаданных(Значение);
	
	Возврат СтрШаблон("%1.%2", Описание.ОписаниеТипа.Имя, Описание.Имя);
	
КонецФункции

// Проверка, что переданное значение относится к перечислениям.
// 
// Параметры:
//  Значение - ОбъектМетаданных
//           - Тип - Тип объекта информационной базы
//           - Строка - Полное имя объекта метаданных
//           - см. СтруктураОписанияОбъектаМетаданных
//           - Произвольный - Объект информационной базы
// 
// Возвращаемое значение:
//  Булево - Это перечисление
Функция ЭтоПеречисление(Значение) Экспорт
	
	Описание = ОписаниеОбъектаМетаданных(Значение);
	Возврат Описание <> Неопределено И Описание.ОписаниеТипа.Имя = "Перечисление";
	
КонецФункции

// Проверка, что переданное значение относится к регистрам.
// 
// Параметры:
//  Значение - ОбъектМетаданных
//           - Тип - Тип объекта информационной базы
//           - Строка - Полное имя объекта метаданных
//           - см. СтруктураОписанияОбъектаМетаданных
//           - Произвольный - Объект информационной базы
// 
// Возвращаемое значение:
//  Булево - Это перечисление
Функция ЭтоРегистр(Значение) Экспорт
	
	Описание = ОписаниеОбъектаМетаданных(Значение);
	Возврат Описание <> Неопределено И СтрНачинаетсяС(Описание.ОписаниеТипа.Имя, "Регистр");
	
КонецФункции

// Разрешены ли синхронные вызовы в параметрах конфигурации.
// 
// Возвращаемое значение:
//  Булево - Разрешены синхронные вызовы
Функция РазрешеныСинхронныеВызовы() Экспорт
	
	Возврат ЮТМетаданныеСлужебныйПовтИсп.РазрешеныСинхронныеВызовы();
	
КонецФункции

// Возвращяет набор регистров движений документа
// 
// Параметры:
//  Документ - ОбъектМетаданных
//           - Тип - Тип объекта информационной базы
//           - Строка - Полное имя объекта метаданных
//           - см. СтруктураОписанияОбъектаМетаданных
//           - ДокументСсылка, ДокументОбъект - Объект информационной базы
//           - ДокументМенеджер - Менеджер вида документа
// 
// Возвращаемое значение:
//  Структура - Регистры движений документа. Ключи - Имя регистра, Значение - Полное имя регистра
Функция РегистрыДвиженийДокумента(Документ) Экспорт
	
	ОписаниеОбъектаМетаданных = ОписаниеОбъектаМетаданных(Документ);
	
	ПолноеИмя = СтрШаблон("%1.%2", ОписаниеОбъектаМетаданных.ОписаниеТипа.ИмяКоллекции, ОписаниеОбъектаМетаданных.Имя);
	
	Возврат ЮТМетаданныеСлужебныйПовтИсп.РегистрыДвиженийДокумента(ПолноеИмя);
	
КонецФункции

// Возвращает текущую версию тестового движка (YAxUnit)
// 
// Возвращаемое значение:
//  Строка - Версия движка
Функция ВерсияДвижка() Экспорт
	
	Возврат ЮТМетаданныеСлужебныйПовтИсп.ВерсияДвижка();
	
КонецФункции

// Описание типа объекта метаданных.
// 
// Возвращаемое значение:
//  Структура - Описание типа метаданных:
//  * Имя - Строка
//  * ИмяКоллекции - Строка
//  * Конструктор - Строка
//  * Группы - Булево
//  * Ссылочный - Булево
//  * Регистр - Булево
//  * ОбработкаОтчет - Булево
//  * СтандартныеРеквизиты - Булево
//  * Реквизиты - Булево
//  * Измерения - Булево
//  * Ресурсы - Булево
//  * РеквизитыАдресации - Булево
//  * ТабличныеЧасти - Булево
Функция ОписаниеТипаМетаданных() Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Имя", "");
	Описание.Вставить("ИмяКоллекции", "");
	Описание.Вставить("Конструктор", "");
	Описание.Вставить("Группы", Ложь);
	Описание.Вставить("Ссылочный", Ложь);
	Описание.Вставить("Регистр", Ложь);
	Описание.Вставить("ОбработкаОтчет", Ложь);
	Описание.Вставить("СтандартныеРеквизиты", Ложь);
	Описание.Вставить("Реквизиты", Ложь);
	Описание.Вставить("Измерения", Ложь);
	Описание.Вставить("Ресурсы", Ложь);
	Описание.Вставить("РеквизитыАдресации", Ложь);
	Описание.Вставить("ТабличныеЧасти", Ложь);
	
	Возврат Описание;
	
КонецФункции

// Описание объекта метаданных.
// 
// Возвращаемое значение:
//  Структура - Описание объекта метаданных:
// * Имя - Строка
// * ОписаниеТипа - см. ОписаниеТипаМетаданных 
// * Реквизиты - Структура
// * ТабличныеЧасти - Структура
Функция СтруктураОписанияОбъектаМетаданных() Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("Имя", "");
	Описание.Вставить("ОписаниеТипа", Неопределено);
	Описание.Вставить("Реквизиты", Новый Структура());
	Описание.Вставить("ТабличныеЧасти", Новый Структура());
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// Описание реквизита объекта метаданных
//
// Возвращаемое значение:
//  Структура - Описание реквизита:
// * Имя - Строка
// * Тип - ОписаниеТипов
// * Обязательный - Булево
// * ЭтоКлюч - Булево
Функция ОписаниеРеквизита() Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Имя", "");
	Описание.Вставить("Тип", Новый ОписаниеТипов("Неопределено"));
	Описание.Вставить("Обязательный", Ложь);
	Описание.Вставить("ЭтоКлюч", Ложь);
	
	Возврат Описание;
	
КонецФункции

#КонецОбласти
