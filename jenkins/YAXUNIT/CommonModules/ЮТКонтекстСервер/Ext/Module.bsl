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

Процедура ИнициализироватьКонтекст() Экспорт
	
	Контекст = ЮТКонтекст.ОписаниеКонтекста();
	АдресХранилища = ПоместитьВоВременноеХранилище(Контекст, Новый УникальныйИдентификатор());
	ХранилищеОбщихНастроек.Сохранить(КлючНастроекКонтекста(), "АдресХранилища", АдресХранилища);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

Функция ДанныеКонтекста() Экспорт
	
	Адрес = АдресСерверногоКонтекста();
	
	Если ЭтоАдресВременногоХранилища(Адрес) Тогда
		
		Возврат ПолучитьИзВременногоХранилища(АдресСерверногоКонтекста());
		
	КонецЕсли;
	
КонецФункции

// УстановитьЗначениеКонтекста
// Устанавливает значение вложенного контекста, вложенного реквизита контекста
// 
// Параметры:
//  ИмяРеквизита - Строка - Имя реквизита/вложенного контекста
//  Значение - Произвольный - Новое значение реквизита/вложенного контекста
Процедура УстановитьЗначениеКонтекста(Знач ИмяРеквизита, Знач Значение) Экспорт
	
	ЮТКонтекст.УстановитьЗначениеКонтекста(ИмяРеквизита, Значение);
	
КонецПроцедуры

Функция ЗначениеКонтекста(Знач ИмяРеквизита) Экспорт
	
	Возврат ЮТКонтекст.ЗначениеКонтекста(ИмяРеквизита);
	
КонецФункции

Функция КлючНастроекКонтекста() Экспорт
	
	Возврат СтрШаблон("ЮТ%1.Контекста", НомерСеансаИнформационнойБазы());
	
КонецФункции

Функция АдресСерверногоКонтекста(Кэшировать = Истина) Экспорт
	
	Если Кэшировать Тогда
		
		Возврат ЮТПовторногоИспользования.АдресСерверногоКонтекста();
		
	Иначе
		
		Возврат ХранилищеОбщихНастроек.Загрузить(КлючНастроекКонтекста(), "АдресХранилища");
		
	КонецЕсли;
	
КонецФункции

Процедура УдалитьКонтекст() Экспорт
	
	Адрес = АдресСерверногоКонтекста();
	
	Если ЭтоАдресВременногоХранилища(Адрес) Тогда
		УдалитьИзВременногоХранилища(Адрес);
		ХранилищеОбщихНастроек.Удалить(КлючНастроекКонтекста(), "АдресХранилища", Неопределено);
		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
