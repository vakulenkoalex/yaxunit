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

Функция ОбработчикиСобытий(Знач ГруппаОбработчиков, Знач Серверные = Истина, Знач Клиентские = Истина) Экспорт
	
	Модули = Новый Массив();
	
	Для Каждого ПодсистемаОбработчикиСобытий Из ПодсистемыПодключаемыхМодулей("ОбработчикиСобытий") Цикл
		
		ЮТКоллекции.ДополнитьМассив(Модули, МодулиПодсистемы(ПодсистемаОбработчикиСобытий, Серверные, Клиентские));
		
		ПодсистемаГруппыОбработчиков = ПодсистемаОбработчикиСобытий.Подсистемы.Найти(ГруппаОбработчиков);
		
		Если ПодсистемаГруппыОбработчиков <> Неопределено Тогда
			ЮТКоллекции.ДополнитьМассив(Модули, МодулиПодсистемы(ПодсистемаГруппыОбработчиков, Серверные, Клиентские));
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Модули;
	
КонецФункции

Функция ПодключаемыеМодулиПодсистемы(Знач ИмяПодсистемы, Знач Серверные = Истина, Знач Клиентские = Истина) Экспорт
	
	Модули = Новый Массив();
	
	Для Каждого Подсистема Из ПодсистемыПодключаемыхМодулей(ИмяПодсистемы) Цикл
		
		ЮТКоллекции.ДополнитьМассив(Модули, МодулиПодсистемы(Подсистема, Серверные, Клиентские));
		
	КонецЦикла;
	
	Возврат Модули;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПодсистемыПодключаемыхМодулей(ИмяПодсистемы)
	
	ИменаПодсистем = ЮТМетаданныеСлужебныйПовтИсп.ПодсистемыПодключаемыхМодулей();
	
	Подсистемы = Новый Массив();
	
	Для Каждого ИмяПодсистемыПодключаемыхМодулей Из ИменаПодсистем Цикл
		
		ПодсистемаПодключаемыхМодулей = Метаданные.Подсистемы[ИмяПодсистемыПодключаемыхМодулей];
		
		ВложеннаяПодсистема = ПодсистемаПодключаемыхМодулей.Подсистемы.Найти(ИмяПодсистемы);
		
		Если ВложеннаяПодсистема <> Неопределено Тогда
			Подсистемы.Добавить(ВложеннаяПодсистема);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Подсистемы;
	
КонецФункции

Функция МодулиПодсистемы(Знач Подсистема, Знач Серверные, Знач Клиентские)
	
	Модули = Новый Массив();
	
	Для Каждого Объект Из Подсистема.Состав Цикл
		
		Если Метаданные.ОбщиеМодули.Содержит(Объект) Тогда
			
			Добавить = (Серверные И Клиентские)
				ИЛИ (Серверные И (Объект.Сервер))
				ИЛИ (Клиентские И (Объект.КлиентУправляемоеПриложение Или Объект.ВызовСервера));
				// КлиентОбычноеПриложение сознательно не анализируется, он должен идти в паре с другой настройкой
			
			Если Добавить Тогда
				Модули.Добавить(Объект.Имя);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Модули;
	
КонецФункции

#КонецОбласти
