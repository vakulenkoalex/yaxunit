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

#Область СлужебныйПрограммныйИнтерфейс

Функция ОписаниеТиповЛюбаяСсылка() Экспорт
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(
	"<TypeDescription xmlns=""http://v8.1c.ru/8.1/data/core"">
	|      <TypeSet xmlns:cc=""http://v8.1c.ru/8.1/data/enterprise/current-config"">cc:AnyRef</TypeSet>
	|</TypeDescription>");
	
	Возврат СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
	
КонецФункции

Функция УстановленБезопасныйРежим() Экспорт
	
	Возврат БезопасныйРежим();
	
КонецФункции

Функция Менеджер(Знач Менеджер) Экспорт
	
	Описание = ЮТМетаданные.ОписаниеОбъектаМетаданных(Менеджер);
	
	Если Описание = Неопределено Тогда
		ВызватьИсключение "Несуществующий объект метаданных, либо " + ЮТОбщий.НеподдерживаемыйПараметрМетода("ЮТОбщийВызовСервера.Менеджер", Менеджер);
	КонецЕсли;
	
	ИмяТипа = СтрШаблон("%1Менеджер.%2", Описание.ОписаниеТипа.Имя, Описание.Имя);
	
	Возврат Новый(ИмяТипа);
	
КонецФункции

Функция Макет(ИмяМакета) Экспорт
	
	ЧастиИмени = СтрРазделить(ИмяМакета, ".");
	
	КоличествоБлоковДляОбщегоМакета = 2;
	КоличествоБлоковМакетаМенеджера = 3;
	
	Если ЧастиИмени.Количество() < КоличествоБлоковДляОбщегоМакета Тогда
		ВызватьИсключение СтрШаблон("Некорректное имя макет, если вы хотите получить данные общего макета необходимо указать `ОбщийМакет.%1`",
									ИмяМакета);
	КонецЕсли;
	
	ИндексОбласти = 0;
	Если СтрСравнить(ЧастиИмени[0], "ОбщийМакет") = 0 Тогда
		Макет = ПолучитьОбщийМакет(ЧастиИмени[1]);
		ИндексОбласти = КоличествоБлоковДляОбщегоМакета;
	ИначеЕсли ЧастиИмени.Количество() >= КоличествоБлоковМакетаМенеджера Тогда
		Менеджер = Менеджер(СтрШаблон("%1.%2", ЧастиИмени[0], ЧастиИмени[1]));
		Макет = Менеджер.ПолучитьМакет(ЧастиИмени[КоличествоБлоковМакетаМенеджера - 1]);
		ИндексОбласти = КоличествоБлоковМакетаМенеджера;
	Иначе
		ВызватьИсключение СтрШаблон("Некорректное имя макета `%1`", ИмяМакета);
	КонецЕсли;
	
	Если ЧастиИмени.Количество() > ИндексОбласти Тогда
		Макет = Макет.ПолучитьОбласть(ЧастиИмени[ИндексОбласти]);
	КонецЕсли;
	
	Возврат Макет;
	
КонецФункции

#КонецОбласти
