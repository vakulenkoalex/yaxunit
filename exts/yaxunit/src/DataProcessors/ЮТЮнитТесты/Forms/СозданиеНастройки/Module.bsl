//©///////////////////////////////////////////////////////////////////////////©//
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

#Область ОписаниеПеременных
&НаКлиенте
Перем ПоддерживаемыеФорматыОтчетов;
#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Для Каждого УровеньЛог Из ЮТЛогирование.УровниЛога() Цикл
		Элементы.УровеньЛога.СписокВыбора.Добавить(УровеньЛог.Значение, УровеньЛог.Ключ);
	КонецЦикла;
	
	Конфигурация = ЮТФабрика.ПараметрыЗапуска();
	ФорматОтчета = Конфигурация.reportFormat;
	УровеньЛога = Конфигурация.logging.level;
	ОтобразитьОтчет = Конфигурация.showReport;
	ЗакрытьПослеТестирования = Конфигурация.closeAfterTests;
	КаталогПроекта = Конфигурация.projectPath;
	ЛогированиеВКонсоль = Конфигурация.logging.console;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ЗаполнитьДеревоТестов();
	
	ПоддерживаемыеФорматыОтчетов = ЮТОтчетСлужебный.ПоддерживаемыеФорматыОтчетов();
	Для Каждого Формат Из ПоддерживаемыеФорматыОтчетов Цикл
		Элементы.ФорматОтчета.СписокВыбора.Добавить(Формат.Ключ, Формат.Значение.Представление);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ФайлКонфигурацииНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ВыбратьФайл("*.json|*.json", ФайлКонфигурации, Новый ОписаниеОповещения("УстановитьФайлКонфигурации", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура КаталогПроектаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИмяФайлаВРеквизит", ЭтотОбъект, "КаталогПроекта");
	ВыбратьКаталог(КаталогПроекта, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапускИзПредприятияПриИзменении(Элемент)
	
	ОбновитьСтрокуЗапуска();
	
КонецПроцедуры

&НаКлиенте
Процедура ФайлКонфигурацииПриИзменении(Элемент)
	
	ОбновитьСтрокуЗапуска();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыводЛогаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИмяФайлаВРеквизит", ЭтотОбъект, "ИмяФайлаЛога");
	ВыбратьФайл("*.log|*.log|*.txt|*.txt|All files(*.*)|*.*", ИмяФайлаЛога, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаКодаВозвратаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИмяФайлаВРеквизит", ЭтотОбъект, "ИмяФайлаКодаВозврата");
	ВыбратьФайл("All files(*.*)|*.*", ИмяФайлаКодаВозврата, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаОтчетаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОписаниеФормата = Неопределено;
	Если НЕ ПоддерживаемыеФорматыОтчетов.Свойство(ФорматОтчета, ОписаниеФормата) Тогда
		ПоказатьПредупреждение(, "Сначала укажите формат отчета");
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("СохранитьИмяФайлаВРеквизит", ЭтотОбъект, "ИмяФайлаОтчета");
	Если ОписаниеФормата.ЗаписьВКаталог Тогда
		ВыбратьКаталог(ИмяФайлаОтчета, Оповещение);
	Иначе
		ВыбратьФайл(ОписаниеФормата.ФильтрВыбораФайла, ИмяФайлаОтчета, Оповещение);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДеревоТестов

&НаКлиенте
Процедура ДеревоТестовОтметкаПриИзменении(Элемент)
	
	Данные = Элементы.ДеревоТестов.ТекущиеДанные;
	
	Если Данные.Отметка = 2 Тогда
		Данные.Отметка = 0;
	КонецЕсли;
	
	УстановитьРекурсивноЗначение(Данные.ПолучитьЭлементы(), Данные.Отметка);
	ОбновитьОтметкиРодителей(Данные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СнятьФлажки(Команда)
	
	УстановитьРекурсивноЗначение(ДеревоТестов.ПолучитьЭлементы(), 0);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФлажки(Команда)
	
	УстановитьРекурсивноЗначение(ДеревоТестов.ПолучитьЭлементы(), 1);
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПараметры(Команда)
	
	Если НЕ ЕстьОтмеченныеТесты() Тогда
		ПоказатьПредупреждение(, "Отметьте тесты, которые должны выполниться");
		Возврат;
	КонецЕсли;
	
	Если ПустаяСтрока(ФайлКонфигурации) Тогда
		Обработчик = Новый ОписаниеОповещения("СохранитьПараметрыПослеВыбораФайла", ЭтотОбъект);
		ВыбратьФайл("*.json|*.json", ФайлКонфигурации, Обработчик);
	Иначе
		СохранитьПараметрыПослеВыбораФайла(ФайлКонфигурации);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗаполнитьДеревоТестов()
	
	ЮТКонтекстСлужебный.ИнициализироватьКонтекст();
	ТестовыеМодули = ЮТЧитательСлужебный.ЗагрузитьТесты(Новый Структура("filter", Новый Структура));
	ЮТКонтекстСлужебный.УдалитьКонтекст();
	
	СтрокиРасширений = Новый Соответствие();
	
	Для Каждого ОписаниеМодуля Из ТестовыеМодули Цикл
		
		ИмяРасширения = ОписаниеМодуля.МетаданныеМодуля.Расширение;
		
		СтрокаРасширения = СтрокиРасширений[ИмяРасширения];
		Если СтрокаРасширения = Неопределено Тогда
			СтрокаРасширения = ДобавитьСтрокуРасширения(ДеревоТестов, ИмяРасширения);
			СтрокиРасширений.Вставить(ИмяРасширения, СтрокаРасширения);
		КонецЕсли;
		
		СтрокаМодуля = ДобавитьСтрокуМодуля(СтрокаРасширения, ОписаниеМодуля.МетаданныеМодуля);
		
		Если ОписаниеМодуля.НаборыТестов.Количество() = 1 Тогда
			
			Для Каждого Тест Из ОписаниеМодуля.НаборыТестов[0].Тесты Цикл
				
				ДобавитьСтрокуТеста(СтрокаМодуля, Тест);
				
			КонецЦикла;
			
		Иначе
			
			Для Каждого Набор Из ОписаниеМодуля.НаборыТестов Цикл
				
				СтрокаНабора = ДобавитьСтрокуНабора(СтрокаМодуля, Набор);
				
				Для Каждого Тест Из Набор.Тесты Цикл
					
					ДобавитьСтрокуТеста(СтрокаНабора, Тест);
					
				КонецЦикла;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ДобавитьСтрокуРасширения(Владелец, ИмяРасширения)
	
	Строка = Владелец.ПолучитьЭлементы().Добавить();
	Строка.Идентификатор = ИмяРасширения;
	Строка.Представление = ИмяРасширения;
	Строка.ТипОбъекта = 0;
	
	Возврат Строка;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ДобавитьСтрокуМодуля(Владелец, МетаданныеМодуля)
	
	Строка = Владелец.ПолучитьЭлементы().Добавить();
	Строка.Идентификатор = МетаданныеМодуля.Имя;
	Строка.Представление = МетаданныеМодуля.Имя;
	Строка.ТипОбъекта = 1;
	
	Возврат Строка;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ДобавитьСтрокуНабора(Владелец, Набор)
	
	Строка = Владелец.ПолучитьЭлементы().Добавить();
	Строка.Идентификатор = Набор.Имя;
	Строка.Представление = Набор.Представление;
	Строка.ТипОбъекта = 2;
	
	Возврат Строка;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ДобавитьСтрокуТеста(Владелец, Тест)
	
	Представление = ЮТФабрикаСлужебный.ПредставлениеТеста(Тест);
	
	Если Владелец.ТипОбъекта = 1 Тогда
		СтрокаМодуля = Владелец;
	Иначе
		СтрокаМодуля = Владелец.ПолучитьРодителя();
	КонецЕсли;
	
	Строка = Владелец.ПолучитьЭлементы().Добавить();
	Строка.Идентификатор = СтрШаблон("%1.%2", СтрокаМодуля.Идентификатор, Тест.Имя);
	Строка.Представление = СтрШаблон("%1, %2", Представление, СтрСоединить(Тест.КонтекстВызова, ", "));
	Строка.ТипОбъекта = 3;
	
	Возврат Строка;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьРекурсивноЗначение(Элементы, Значение, Колонка = "Отметка")
	
	Для Каждого Элемент Из Элементы Цикл
		
		Элемент[Колонка] = Значение;
		
		Если ЗначениеЗаполнено(Элемент.ПолучитьЭлементы()) Тогда
			УстановитьРекурсивноЗначение(Элемент.ПолучитьЭлементы(), Значение, Колонка);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьОтметкиРодителей(Элемент)
	
	Родитель = Элемент.ПолучитьРодителя();
	
	Если Родитель = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЕстьСОтметкой = Ложь;
	ЕстьБезОтметки = Ложь;
	
	Для Каждого Элемент Из Родитель.ПолучитьЭлементы() Цикл
		
		Если Элемент.Отметка = 0 Тогда
			ЕстьБезОтметки = Истина;
		ИначеЕсли Элемент.Отметка = 1 Тогда
			ЕстьСОтметкой = Истина;
		ИначеЕсли Элемент.Отметка = 2 Тогда
			ЕстьБезОтметки = Истина;
			ЕстьСОтметкой = Истина;
		КонецЕсли;
		
		Если ЕстьБезОтметки И ЕстьСОтметкой Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Если ЕстьСОтметкой И ЕстьБезОтметки Тогда
		НоваяОтметка = 2;
	ИначеЕсли ЕстьСОтметкой Тогда
		НоваяОтметка = 1;
	Иначе
		НоваяОтметка = 0;
	КонецЕсли;
	
	Если Родитель.Отметка = НоваяОтметка Тогда
		Возврат;
	КонецЕсли;
	
	Родитель.Отметка = НоваяОтметка;
	ОбновитьОтметкиРодителей(Родитель);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСтрокуЗапуска()
	
	ПараметрыЗапускаЮнитТестов = СтрШаблон("%1=%2", ЮТПараметрыЗапускаСлужебный.КлючЗапуска(), ФайлКонфигурации);
	
	Если ЗапускИзКонфигуратор Тогда
		
		ПараметрыЗапуска = ПараметрыЗапускаЮнитТестов;
		
	Иначе
		
#Если ВебКлиент Тогда
		ВызватьИсключение "Формирование строки запуска для веб-клиенте не поддерживается";
#Иначе
		СистемнаяИнформация = Новый СистемнаяИнформация;
#Если ТонкийКлиент Тогда
		Файл = "1cv8c";
#Иначе
		Файл = "1cv8";
#КонецЕсли
		ПутьЗапускаемогоКлиента = ЮТФайлы.ОбъединитьПути(КаталогПрограммы(), Файл);
		
		Если СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Windows_x86 Или СистемнаяИнформация.ТипПлатформы = ТипПлатформы.Windows_x86_64 Тогда
			ПутьЗапускаемогоКлиента = ПутьЗапускаемогоКлиента + ".exe";
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ИмяПользователя()) Тогда
			Пользователь = СтрШаблон("/N""%1""", ИмяПользователя());
		Иначе
			Пользователь = "";
		КонецЕсли;
		
		ПараметрыЗапуска = СтрШаблон("""%1"" %2 /IBConnectionString ""%3"" /C""%4""",
									 ПутьЗапускаемогоКлиента,
									 Пользователь,
									 СтрЗаменить(СтрокаСоединенияИнформационнойБазы(), """", """"""),
									 ПараметрыЗапускаЮнитТестов);
#КонецЕсли
	
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьПараметрыПослеВыбораФайла(ВыбранныйФайл, ДополнительныеПараметры = Неопределено) Экспорт
	
	ФайлКонфигурации = ВыбранныйФайл;
	ОбновитьСтрокуЗапуска();
	СохранитьКонфигурациюЗапуска();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФайлКонфигурации(ВыбранныйФайл, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныйФайл <> Неопределено Тогда
		ФайлКонфигурации = ВыбранныйФайл;
		ОбновитьСтрокуЗапуска();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьИмяФайлаВРеквизит(ВыбранныйФайл, ИмяРеквизита) Экспорт
	
	Если ВыбранныйФайл <> Неопределено Тогда
		ЭтотОбъект[ИмяРеквизита] = ВыбранныйФайл;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьФайл(Фильтр, ИмяФайла, Оповещение)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.Фильтр = Фильтр;
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	ДиалогВыбораФайла.ПолноеИмяФайла = ИмяФайла;
	
	ПараметрыОбработчика = Новый Структура("Оповещение", Оповещение);
	Обработчик = Новый ОписаниеОповещения("ПослеВыбораФайла", ЭтотОбъект, ПараметрыОбработчика);
	ДиалогВыбораФайла.Показать(Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьКаталог(ИмяФайла, Оповещение)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	ДиалогВыбораФайла.ПолноеИмяФайла = ИмяФайла;
	
	ПараметрыОбработчика = Новый Структура("Оповещение", Оповещение);
	Обработчик = Новый ОписаниеОповещения("ПослеВыбораФайла", ЭтотОбъект, ПараметрыОбработчика);
	ДиалогВыбораФайла.Показать(Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораФайла(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.Оповещение, ВыбранныеФайлы[0]);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьКонфигурациюЗапуска()
	
#Если ВебКлиент Тогда
	ВызватьИсключение "Сохранение конфигурации из веб-клиента не поддерживается";
#Иначе
	Конфигурация = ЮТФабрика.ПараметрыЗапуска();
	Конфигурация.Удалить("ВыполнятьМодульноеТестирование");
	
	Конфигурация.showReport = ОтобразитьОтчет;
	Конфигурация.closeAfterTests = ЗакрытьПослеТестирования;
	Конфигурация.reportFormat = ФорматОтчета;
	Конфигурация.reportPath = ИмяФайлаОтчета;
	Конфигурация.projectPath = КаталогПроекта;
	
	Конфигурация.logging.level = УровеньЛога;
	Конфигурация.logging.file = ИмяФайлаЛога;
	Конфигурация.logging.console = ЛогированиеВКонсоль;
	
	Если ЗначениеЗаполнено(ИмяФайлаКодаВозврата) Тогда
		Конфигурация.exitCode = ИмяФайлаКодаВозврата;
	КонецЕсли;
	
	Конфигурация.filter.Очистить();
	
	Если НЕ (УстановленФильтрПоРасширению(Конфигурация) ИЛИ УстановленФильтрПоМодулям(Конфигурация)) Тогда
		УстановитьФильтрПоТестам(Конфигурация);
	КонецЕсли;
	
	Запись = Новый ЗаписьJSON();
	СимволыОтступа = "  ";
	ПараметрыЗаписи = Новый ПараметрыЗаписиJSON(, СимволыОтступа);
	Запись.ОткрытьФайл(ФайлКонфигурации, , , ПараметрыЗаписи);
	ЗаписатьJSON(Запись, Конфигурация);
	Запись.Закрыть();
#КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Функция ЕстьОтмеченныеТесты()
	
	Для Каждого СтрокаРасширения Из ДеревоТестов.ПолучитьЭлементы() Цикл
		Если СтрокаРасширения.Отметка > 0 Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

&НаКлиенте
Функция УстановленФильтрПоРасширению(Конфигурация)
	
	Расширения = Новый Массив();
	Для Каждого СтрокаРасширения Из ДеревоТестов.ПолучитьЭлементы() Цикл
		
		Если СтрокаРасширения.Отметка = 2 Тогда
			Возврат Ложь;
		ИначеЕсли СтрокаРасширения.Отметка = 1 Тогда
			Расширения.Добавить(СтрокаРасширения.Идентификатор);
		КонецЕсли;
		
	КонецЦикла;
	
	Если Расширения.Количество() Тогда
		Конфигурация.filter.Вставить("extensions",Расширения);
	КонецЕсли;
	
	Возврат Расширения.Количество() > 0;
	
КонецФункции

&НаКлиенте
Функция УстановленФильтрПоМодулям(Конфигурация)
	
	Модули = Новый Массив();
	
	Для Каждого СтрокаРасширения Из ДеревоТестов.ПолучитьЭлементы() Цикл
		
		Если СтрокаРасширения.Отметка = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Для Каждого СтрокаМодуля Из СтрокаРасширения.ПолучитьЭлементы() Цикл
			
			Если СтрокаМодуля.Отметка = 2 Тогда
				Возврат Ложь;
			ИначеЕсли СтрокаМодуля.Отметка = 1 Тогда
				Модули.Добавить(СтрокаМодуля.Идентификатор);
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Если Модули.Количество() Тогда
		Конфигурация.filter.Вставить("modules", Модули);
	КонецЕсли;
	
	Возврат Модули.Количество() > 0;
	
КонецФункции

&НаКлиенте
Процедура УстановитьФильтрПоТестам(Конфигурация)
	
	Тесты = Новый Массив();
	ДобавитьОтмеченныеТесты(ДеревоТестов.ПолучитьЭлементы(), Тесты);
	
	Конфигурация.filter.Вставить("tests", Тесты);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьОтмеченныеТесты(Строки, Тесты)
	
	Для Каждого Строка Из Строки Цикл
		Если Строка.Отметка = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Если Строка.ТипОбъекта = 3 Тогда
			Тесты.Добавить(Строка.Идентификатор);
		Иначе
			ДобавитьОтмеченныеТесты(Строка.ПолучитьЭлементы(), Тесты);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
