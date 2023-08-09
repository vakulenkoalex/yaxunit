//©///////////////////////////////////////////////////////////////////////////©//
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

// Выводит отладочное сообщение
// 
// Параметры:
//  Сообщение - Строка - Сообщение
Процедура Отладка(Сообщение) Экспорт
	
	Записать("DBG", Сообщение, 0);
	
КонецПроцедуры

// Выводит информационное сообщение
// 
// Параметры:
//  Сообщение - Строка - Сообщение
Процедура Информация(Сообщение) Экспорт
	
	Записать("INF", Сообщение, 1);
	
КонецПроцедуры

// Выводит сообщение об ошибке
// 
// Параметры:
//  Сообщение - Строка - Сообщение
Процедура Ошибка(Сообщение) Экспорт
	
	Записать("ERR", Сообщение, 2);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция УровниЛога() Экспорт
	
	Возврат Новый ФиксированнаяСтруктура("Отладка, Информация, Ошибка", "debug", "info", "error");
	
КонецФункции

Процедура ВывестиСерверныеСообщения() Экспорт
	
#Если Клиент Тогда
	Контекст = Контекст();
	Если Контекст = Неопределено ИЛИ НЕ Контекст.Включено ИЛИ Контекст.ФайлЛогаДоступенНаСервере Тогда
		Возврат;
	КонецЕсли;
	
	Сообщения = ЮТЛогированиеВызовСервера.НакопленныеСообщенияЛогирования(Истина);
	ЗаписатьСообщения(Контекст, Сообщения);
#Иначе
	ВызватьИсключение "Метод вывода серверных сообщений в лог должен вызываться с клиента";
#КонецЕсли
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиСобытий

// Инициализация.
// 
// Параметры:
//  ПараметрыЗапуска - см. ЮТФабрика.ПараметрыЗапуска
Процедура Инициализация(ПараметрыЗапуска) Экспорт
	
	УровниЛога = УровниЛога();
	
	ДанныеКонтекста = НовыйДанныеКонтекста();
	ДанныеКонтекста.ФайлЛога = ЮТОбщий.ЗначениеСтруктуры(ПараметрыЗапуска.logging, "file");
	ДанныеКонтекста.ВыводВКонсоль = ЮТОбщий.ЗначениеСтруктуры(ПараметрыЗапуска.logging, "console", Ложь);
	ДанныеКонтекста.Включено = ЮТОбщий.ЗначениеСтруктуры(ПараметрыЗапуска.logging, "enable", Неопределено);
	УровеньЛога = ЮТОбщий.ЗначениеСтруктуры(ПараметрыЗапуска.logging, "level", УровниЛога.Отладка);
	
	Если ДанныеКонтекста.Включено = Неопределено Тогда
		ДанныеКонтекста.Включено = ДанныеКонтекста.ВыводВКонсоль ИЛИ ЗначениеЗаполнено(ДанныеКонтекста.ФайлЛога);
	КонецЕсли;
	
	Если НЕ ДанныеКонтекста.Включено Тогда
		ЮТКонтекст.УстановитьЗначениеКонтекста(ИмяКонтекстаЛогирования(), ДанныеКонтекста, Истина);
		Возврат;
	КонецЕсли;
	
	Если СтрСравнить(УровеньЛога, УровниЛога.Ошибка) = 0 Тогда
		ДанныеКонтекста.УровеньЛога = 2;
	ИначеЕсли СтрСравнить(УровеньЛога, УровниЛога.Информация) = 0 Тогда
		ДанныеКонтекста.УровеньЛога = 1;
	Иначе
		ДанныеКонтекста.УровеньЛога = 0;
	КонецЕсли;
	
	ЗначениеПроверки = Строка(Новый УникальныйИдентификатор());
	ЗаписатьСообщения(ДанныеКонтекста, ЮТОбщий.ЗначениеВМассиве(ЗначениеПроверки), Ложь);
	
	ДанныеКонтекста.ФайлЛогаДоступенНаСервере = ЮТЛогированиеВызовСервера.ФайлЛогаДоступенНаСервере(ДанныеКонтекста.ФайлЛога, ЗначениеПроверки);
	
	ЮТКонтекст.УстановитьЗначениеКонтекста(ИмяКонтекстаЛогирования(), ДанныеКонтекста, Истина);
	
	Разделитель = "------------------------------------------------------";
	ЗаписатьСообщения(ДанныеКонтекста, ЮТОбщий.ЗначениеВМассиве(Разделитель), Ложь);
	Информация("Старт");
	
КонецПроцедуры

// Обработка события "ПередЧтениеСценариев"
Процедура ПередЧтениеСценариев() Экспорт
	
	Информация("Загрузка сценариев");
	
КонецПроцедуры

// Перед чтением сценариев модуля.
// 
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
//  ИсполняемыеСценарии - см. ЮТТесты.СценарииМодуля
Процедура ПередЧтениемСценариевМодуля(МетаданныеМодуля, ИсполняемыеСценарии) Экспорт
	
	Информация(СтрШаблон("Загрузка сценариев модуля `%1`", МетаданныеМодуля.Имя));
	
КонецПроцедуры

// Перед чтением сценариев модуля.
// 
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
//  ИсполняемыеСценарии - см. ЮТТесты.СценарииМодуля
Процедура ПослеЧтенияСценариевМодуля(МетаданныеМодуля, ИсполняемыеСценарии) Экспорт
	
	Информация(СтрШаблон("Загрузка сценариев модуля завершена `%1`", МетаданныеМодуля.Имя));
	
КонецПроцедуры

// Обработка события "ПослеЧтенияСценариев"
// Параметры:
//  Сценарии - Массив из см. ЮТФабрика.ОписаниеТестовогоМодуля - Набор описаний тестовых модулей, которые содержат информацию о запускаемых тестах
Процедура ПослеЧтенияСценариев(Сценарии) Экспорт
	
	Информация("Загрузка сценариев завершена.");
	
КонецПроцедуры

// Обработка события "ПослеФормированияИсполняемыхНаборовТестов"
// Параметры:
//  ИсполняемыеТестовыеМодули - Массив из см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля - Набор исполняемых наборов
Процедура ПослеФормированияИсполняемыхНаборовТестов(ИсполняемыеТестовыеМодули) Экспорт
	
	Количество = 0;
	
	Для Каждого ТестовыйМодуль Из ИсполняемыеТестовыеМодули Цикл
		
		Для Каждого Набор Из ТестовыйМодуль.НаборыТестов Цикл
			
			Если Набор.Выполнять Тогда
				ЮТОбщий.Инкремент(Количество, Набор.Тесты.Количество());
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	ЮТКонтекст.УстановитьЗначениеКонтекста(ИмяКонтекстаЛогирования() + ".ОбщееКоличествоТестов", Количество, Истина);
	
КонецПроцедуры

// Перед всеми тестами.
// 
// Параметры:
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
Процедура ПередВсемиТестами(ОписаниеСобытия) Экспорт
	
#Если Клиент Тогда
	ПрогрессКлиент = Контекст().КоличествоВыполненныхТестов;
	ПрогрессСервер = ЮТКонтекст.ЗначениеКонтекста(ИмяКонтекстаЛогирования() + ".КоличествоВыполненныхТестов", Истина);
	
	Если ПрогрессКлиент < ПрогрессСервер Тогда
		Контекст().КоличествоВыполненныхТестов = ПрогрессСервер;
	КонецЕсли;
#КонецЕсли
	Информация(СтрШаблон("Запуск тестов модуля `%1`", ОписаниеСобытия.Модуль.МетаданныеМодуля.ПолноеИмя));
	
КонецПроцедуры

// Перед тестовым набором.
// 
// Параметры:
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
Процедура ПередТестовымНабором(ОписаниеСобытия) Экспорт
	
	Информация(СтрШаблон("Запуск тестов набора `%1`", ОписаниеСобытия.Набор.Имя));
	
КонецПроцедуры

// Перед каждым тестом.
// 
// Параметры:
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
Процедура ПередКаждымТестом(ОписаниеСобытия) Экспорт
	
	Информация(СтрШаблон("Запуск теста `%1`", ОписаниеСобытия.Тест.Имя));
	
КонецПроцедуры

// Перед каждым тестом.
// 
// Параметры:
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
Процедура ПослеКаждогоТеста(ОписаниеСобытия) Экспорт
	
	Контекст = Контекст();
	Если НЕ ЛогированиеВключено(Контекст) Тогда
		Возврат;
	КонецЕсли;
	
	ЮТОбщий.Инкремент(Контекст.КоличествоВыполненныхТестов);
	Информация(СтрШаблон("%1 Завершен тест `%2`", Прогресс(), ОписаниеСобытия.Тест.Имя));
	
КонецПроцедуры

// Перед каждым тестом.
// 
// Параметры:
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
Процедура ПослеТестовогоНабора(ОписаниеСобытия) Экспорт
	
	Информация(СтрШаблон("Завершен тестовый набор `%1`", ОписаниеСобытия.Набор.Имя));
	
КонецПроцедуры

// Перед каждым тестом.
// 
// Параметры:
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
Процедура ПослеВсехТестов(ОписаниеСобытия) Экспорт
	
	Контекст = Контекст();
	Если НЕ ЛогированиеВключено(Контекст) Тогда
		Возврат;
	КонецЕсли;
#Если Клиент Тогда
	ЮТКонтекст.УстановитьЗначениеКонтекста(ИмяКонтекстаЛогирования() + ".КоличествоВыполненныхТестов", Контекст.КоличествоВыполненныхТестов, Истина);
#КонецЕсли
	
	Информация(СтрШаблон("Завершен модуль `%1`", ОписаниеСобытия.Модуль.МетаданныеМодуля.ПолноеИмя));
	
КонецПроцедуры

#КонецОбласти

#Область Контекст

// Контекст.
// 
// Возвращаемое значение:
//  см. НовыйДанныеКонтекста
Функция Контекст()
	
	Возврат ЮТКонтекст.ЗначениеКонтекста(ИмяКонтекстаЛогирования());
	
КонецФункции

Функция ИмяКонтекстаЛогирования()
	
	Возврат "КонтекстЛогирования";
	
КонецФункции

// Новый данные контекста.
// 
// Возвращаемое значение:
//  Структура - Новый данные контекста:
// * Включено - Булево - Логирование включено
// * ФайлЛога - Неопределено - Файл вывода лога
// * ВыводВКонсоль- Булево - Вывод лога в консоль
// * ФайлЛогаДоступенНаСервере - Булево - Файл лога доступен на сервере
// * НакопленныеЗаписи - Массив из Строка - Буфер для серверных сообщений
// * ОбщееКоличествоТестов - Число
// * КоличествоВыполненныхТестов - Число
// * УровеньЛога - Число - Уровень логирования
Функция НовыйДанныеКонтекста()
	
	ДанныеКонтекста = Новый Структура();
	ДанныеКонтекста.Вставить("Включено", Ложь);
	ДанныеКонтекста.Вставить("ФайлЛога", Неопределено);
	ДанныеКонтекста.Вставить("ВыводВКонсоль", Ложь);
	ДанныеКонтекста.Вставить("ФайлЛогаДоступенНаСервере", Ложь);
	ДанныеКонтекста.Вставить("НакопленныеЗаписи", Новый Массив());
	ДанныеКонтекста.Вставить("ОбщееКоличествоТестов", 0);
	ДанныеКонтекста.Вставить("КоличествоВыполненныхТестов", 0);
	ДанныеКонтекста.Вставить("УровеньЛога", 0);
	
	Возврат ДанныеКонтекста;
	
КонецФункции

#КонецОбласти

#Область Запись

Функция ЛогированиеВключено(Знач Контекст = Неопределено, Приоритет = Неопределено)
	
	Если Контекст = Неопределено Тогда
		Контекст = Контекст();
	КонецЕсли;
	
	Возврат Контекст <> Неопределено И Контекст.Включено И (Приоритет = Неопределено ИЛИ Контекст.УровеньЛога > Приоритет);
	
КонецФункции

Функция НакопленныеСообщенияЛогирования(Очистить = Ложь) Экспорт
	
	Контекст = Контекст();
	
	Сообщения = Контекст.НакопленныеЗаписи;
	
	Если Очистить Тогда
		Контекст.НакопленныеЗаписи = Новый Массив();
	КонецЕсли;
	
	Возврат Сообщения;
	
КонецФункции

Процедура Записать(УровеньЛога, Сообщение, Приоритет)
	
	Контекст = Контекст();
	Если НЕ ЛогированиеВключено(Контекст, Приоритет) Тогда
		Возврат;
	КонецЕсли;
	
#Если Клиент Тогда
	КонтекстИсполнения = "Клиент";
#Иначе
	КонтекстИсполнения = "Сервер";
#КонецЕсли
	Текст = СтрШаблон("%1 [%2][%3]: %4", ЮТОбщий.ПредставлениеУниверсальнойДата(), КонтекстИсполнения, УровеньЛога, Сообщение);
#Если Клиент Тогда
	ЗаписатьСообщения(Контекст, ЮТОбщий.ЗначениеВМассиве(Текст));
#Иначе
	Если Контекст.ФайлЛогаДоступенНаСервере Тогда
		ЗаписатьСообщения(Контекст, ЮТОбщий.ЗначениеВМассиве(Текст));
	Иначе
		Контекст.НакопленныеЗаписи.Добавить(Текст);
	КонецЕсли;
#КонецЕсли
	
КонецПроцедуры

Процедура ЗаписатьСообщения(Контекст, Сообщения, Дописывать = Истина)
	
#Если ВебКлиент Тогда
	ВызватьИсключение "Метод записи лога не доступен в web-клиенте";
#Иначе
	
	Если Контекст.ВыводВКонсоль Тогда
		ЗаписатьЛогВКонсоль(Сообщения);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Контекст.ФайлЛога) Тогда
		ЗаписатьЛогВФайл(Контекст.ФайлЛога, Сообщения, Дописывать);
	КонецЕсли;
	
#КонецЕсли

КонецПроцедуры

Процедура ЗаписатьЛогВФайл(ФайлЛога, Сообщения, Дописывать = Истина)
	
#Если ВебКлиент Тогда
	ВызватьИсключение "Метод записи лога не доступен в web-клиенте";
#Иначе
	
	Запись = Новый ЗаписьТекста(ФайлЛога, КодировкаТекста.UTF8, , Дописывать);
	
	Для Каждого Сообщение Из Сообщения Цикл
		Запись.ЗаписатьСтроку(Сообщение);
	КонецЦикла;
	
	Запись.Закрыть();
#КонецЕсли

КонецПроцедуры

Процедура ЗаписатьЛогВКонсоль(Сообщения)
	
#Если ВебКлиент Тогда
	ВызватьИсключение "Метод записи лога не доступен в web-клиенте";
#Иначе
	
	Попытка
		Консоль = ЮТКомпоненты.Консоль();
		
		Для Каждого Сообщение Из Сообщения Цикл
			Консоль.Напечатать(Сообщение);
		КонецЦикла;
	Исключение
	КонецПопытки;
#КонецЕсли

КонецПроцедуры

Функция Прогресс()
	
	Контекст = Контекст();
	Прогресс = Окр(100 * Контекст.КоличествоВыполненныхТестов / Контекст.ОбщееКоличествоТестов, 0);
	
	Возврат СтрШаблон("%1%% (%2/%3)", Прогресс, Контекст.КоличествоВыполненныхТестов, Контекст.ОбщееКоличествоТестов);
	
КонецФункции

#КонецОбласти

#КонецОбласти
