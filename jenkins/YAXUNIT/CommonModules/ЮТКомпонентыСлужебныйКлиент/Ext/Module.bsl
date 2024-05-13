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

#Область СлужебныйПрограммныйИнтерфейс

Процедура ТихаяУстановкаКомпонент(ОбработчикЗавершения) Экспорт
	
	ПараметрыТихойУстановки = ПараметрыТихойУстановки();
	ПараметрыТихойУстановки.Компоненты.Добавить(ЮТКомпоненты.ОписаниеКомпонентыСервисногоНазначения());
	ПараметрыТихойУстановки.Компоненты.Добавить(ЮТКомпоненты.ОписаниеКомпонентыРегулярныхВыражений());
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ДобавитьОбработчикЦепочки(ПараметрыТихойУстановки,
																	ЭтотОбъект,
																	"УстановитьПараметрыОкружения");
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ДобавитьОбработчикЦепочки(ПараметрыТихойУстановки,
																	ЭтотОбъект,
																	"ТихаяУстановкаВнешнихКомпонент");
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ДобавитьОбработчикЦепочки(ПараметрыТихойУстановки,
																	ЭтотОбъект,
																	"ТихаяУстановкаВнешнихКомпонент");
	Если НЕ ЮТМетаданные.РазрешеныСинхронныеВызовы() Тогда
		ЮТАсинхроннаяОбработкаСлужебныйКлиент.ДобавитьОбработчикЦепочки(ПараметрыТихойУстановки,
																		ЭтотОбъект,
																		"ПодключениеВнешнихКомпонент");
	КонецЕсли;
	
	ПараметрыТихойУстановки.Цепочка.Добавить(ОбработчикЗавершения);
	
	Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.СледующийОбработчик(ПараметрыТихойУстановки);
	НачатьПолучениеРабочегоКаталогаДанныхПользователя(Обработчик);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПараметрыТихойУстановки()
	
	ПараметрыТихойУстановки = ЮТАсинхроннаяОбработкаСлужебныйКлиент.ЦепочкаАсинхроннойОбработки();
	ПараметрыТихойУстановки.Вставить("Компоненты", Новый Массив());
	ПараметрыТихойУстановки.Вставить("РабочийКаталог", "");
	ПараметрыТихойУстановки.Вставить("ОперационнаяСистема", "");
	ПараметрыТихойУстановки.Вставить("Архитектура", "");
	ПараметрыТихойУстановки.Вставить("ДанныеРеестра", "");
	ПараметрыТихойУстановки.Вставить("ИзмененРеестр", Ложь);
	ПараметрыТихойУстановки.Вставить("ПодключенныеКомпоненты", Новый Массив());
	
	Возврат ПараметрыТихойУстановки;
	
КонецФункции

Процедура УстановитьПараметрыОкружения(Результат, ПараметрыТихойУстановки) Экспорт
	
	КорневойКаталог = ЮТФайлы.ОбъединитьПути(Результат, "..", "..", "..");
	КаталогКомпонент = ЮТФайлы.ОбъединитьПути(КорневойКаталог, "ExtCompT");
	
	ПараметрыТихойУстановки.РабочийКаталог = КаталогКомпонент;
	Информация = Новый СистемнаяИнформация();
	ОперационнаяСистема = Неопределено;
	Архитектура = Неопределено;
	
	Linux = "Linux";
	Windows = "Windows";
	MacOS = "MacOS";
	
	//@skip-check bsl-variable-name-invalid
	x86 = "i386";
	//@skip-check bsl-variable-name-invalid
	x64 = "x86_64";
	
	ТипКлиентскойПлатформы = Информация.ТипПлатформы;
	
	Если ТипКлиентскойПлатформы = ТипПлатформы.Linux_x86 Тогда
		ОперационнаяСистема = Linux;
		Архитектура = x86;
	ИначеЕсли ТипКлиентскойПлатформы = ТипПлатформы.Linux_x86_64 Тогда
		ОперационнаяСистема = Linux;
		Архитектура = x64;
	ИначеЕсли ТипКлиентскойПлатформы = ТипПлатформы.Windows_x86 Тогда
		ОперационнаяСистема = Windows;
		Архитектура = x86;
	ИначеЕсли ТипКлиентскойПлатформы = ТипПлатформы.Windows_x86_64 Тогда
		ОперационнаяСистема = Windows;
		Архитектура = x64;
	ИначеЕсли ТипКлиентскойПлатформы = ТипПлатформы.MacOS_x86 Тогда
		ОперационнаяСистема = MacOS;
		Архитектура = x86;
	ИначеЕсли ТипКлиентскойПлатформы = ТипПлатформы.MacOS_x86_64 Тогда
		ОперационнаяСистема = MacOS;
		Архитектура = x64;
	Иначе
		ЮТИсполнительСлужебныйКлиент.ОбработкаОшибки("Неподдерживаемый тип платформы");
	КонецЕсли;
	
	ПараметрыТихойУстановки.ОперационнаяСистема = ОперационнаяСистема;
	ПараметрыТихойУстановки.Архитектура = Архитектура;
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыТихойУстановки);
	
КонецПроцедуры

Процедура ПрочитатьФайлRegistry(ПараметрыТихойУстановки) Экспорт
	
#Если ВебКлиент Тогда
	ЮТИсполнительСлужебныйКлиент.ОбработкаОшибки(ЮТИсключения.МетодНеДоступен("ЮТКомпонентыКлиент.ПрочитатьФайлRegistry"));
	Возврат;
#Иначе
	ФайлРеестра = ЮТФайлы.ОбъединитьПути(ПараметрыТихойУстановки.РабочийКаталог, "registry.xml");
	Чтение = Новый ЧтениеТекста(ФайлРеестра);
	Данные = Чтение.Прочитать();
	Чтение.Закрыть();
	ПараметрыТихойУстановки.ДанныеРеестра = Данные;
	
#КонецЕсли
	
КонецПроцедуры

Процедура ЗаписатьФайлRegistry(ПараметрыТихойУстановки) Экспорт
	
#Если ВебКлиент Тогда
	ЮТИсполнительСлужебныйКлиент.ОбработкаОшибки(ЮТИсключения.МетодНеДоступен("ЮТКомпонентыКлиент.ЗаписатьФайлRegistry"));
	Возврат;
#Иначе
	Если ПараметрыТихойУстановки.ИзмененРеестр Тогда
		ФайлРеестра = ЮТФайлы.ОбъединитьПути(ПараметрыТихойУстановки.РабочийКаталог, "registry.xml");
		Запись = Новый ЗаписьТекста(ФайлРеестра);
		Запись.Записать(ПараметрыТихойУстановки.ДанныеРеестра);
		Запись.Закрыть();
	КонецЕсли;
#КонецЕсли
	
КонецПроцедуры

Процедура ТихаяУстановкаВнешнихКомпонент(Результат, ПараметрыТихойУстановки) Экспорт
	
	ПрочитатьФайлRegistry(ПараметрыТихойУстановки);
	
	Для Каждого Компонента Из ПараметрыТихойУстановки.Компоненты Цикл
		ТихаяУстановкаВнешнейКомпоненты(Компонента, ПараметрыТихойУстановки);
	КонецЦикла;
	
	ЗаписатьФайлRegistry(ПараметрыТихойУстановки);
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыТихойУстановки);
	
КонецПроцедуры

Процедура ПодключениеВнешнихКомпонент(Результат, ПараметрыТихойУстановки) Экспорт
	
	КомпонентаДляПодключения = Неопределено;
	
	Для Каждого Компонента Из ПараметрыТихойУстановки.Компоненты Цикл
		Если ПараметрыТихойУстановки.ПодключенныеКомпоненты.Найти(Компонента) = Неопределено Тогда
			КомпонентаДляПодключения = Компонента;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если КомпонентаДляПодключения = Неопределено Тогда
		ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьСледующийОбработчик(ПараметрыТихойУстановки);
		Возврат;
	КонецЕсли;
	
	ПараметрыТихойУстановки.ПодключенныеКомпоненты.Добавить(КомпонентаДляПодключения);
	Обработчик = ЮТАсинхроннаяОбработкаСлужебныйКлиент.ТекущийОбработчик(ПараметрыТихойУстановки);
	НачатьПодключениеВнешнейКомпоненты(Обработчик,
									   КомпонентаДляПодключения.ИмяМакета,
									   КомпонентаДляПодключения.ИмяКомпоненты,
									   ТипВнешнейКомпоненты.Native);
	
КонецПроцедуры

Процедура ТихаяУстановкаВнешнейКомпоненты(Компонента, Параметры)
	
	ДанныеФайла = ЮТКомпонентыСлужебныйВызовСервера.ФайлКомпоненты(Компонента.ИмяМакета, Параметры.ОперационнаяСистема, Параметры.Архитектура);
	
	Если ЗаписатьВРеестр(Параметры.ДанныеРеестра, ДанныеФайла.ИмяФайла) Тогда
		Параметры.ИзмененРеестр = Истина;
	КонецЕсли;
	
	ФайлКомпоненты = ЮТФайлы.ОбъединитьПути(Параметры.РабочийКаталог, ДанныеФайла.ИмяФайла);
	ДанныеФайла.Данные.Записать(ФайлКомпоненты);
	
КонецПроцедуры

Функция ЗаписатьВРеестр(ДанныеРеестра, ИмяФайла)
	
	Если СтрНайти(ДанныеРеестра, "<component") = 0 Тогда // Файл пустой
		ДанныеРеестра = СтрШаблон("<?xml version=""1.0"" encoding=""UTF-8""?>
						  |<registry xmlns=""http://v8.1c.ru/8.2/addin/registry"">
						  |	<component path=""%1"" type=""native""/>
						  |</registry>", ИмяФайла);
	ИначеЕсли СтрНайти(ДанныеРеестра, СтрШаблон("path=""%1""", ИмяФайла)) <> 0 Тогда // Компонента уже зарегистрированна
		Возврат Ложь;
	Иначе // Добавляем компоненту
		Запись = СтрШаблон("	<component path=""%1"" type=""native""/>", ИмяФайла);
		ДанныеРеестра = СтрЗаменить(ДанныеРеестра, "</registry>", Запись + Символы.ПС + "</registry>");
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти
