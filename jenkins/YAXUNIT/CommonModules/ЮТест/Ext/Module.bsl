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

/////////////////////////////////////////////////////////////////////////////////
// Основной модуль для запуска тестирования
/////////////////////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

// Возвращает API формирования утверждения для проверки теста.
// 
// Параметры:
//  ПроверяемоеЗначение - Произвольный - Проверяемое фактическое значение
//  Сообщение - Строка - Описание проверки, которое будет выведено при возникновении ошибки
// 
// Возвращаемое значение:
//  ОбщийМодуль - Утверждения, см. ЮТУтверждения
Функция ОжидаетЧто(ПроверяемоеЗначение, Сообщение = "") Экспорт
	
	Возврат ЮТУтверждения.Что(ПроверяемоеЗначение, Сообщение);
	
КонецФункции

// Возвращает API формирования утверждения для проверки данных базы.
// 
// Параметры:
//  ИмяТаблицы - Строка - Имя таблицы базы, например, `Справочник.Пользователи`, `Документ.ПКО`, `РегистрСведений.ИнформацияОбОшибках`
//  Сообщение - Строка - Описание проверки, которое будет выведено при возникновении ошибки
// 
// Возвращаемое значение:
//  ОбщийМодуль - Утверждения для проверки данных базы, см. ЮТУтвержденияИБ
Функция ОжидаетЧтоТаблицаБазы(ИмяТаблицы, Сообщение = "") Экспорт
	
	Возврат ЮТУтвержденияИБ.ЧтоТаблица(ИмяТаблицы, Сообщение);
	
КонецФункции

// Возвращает API для работы с тестовыми данными.
// 
// Возвращаемое значение:
//  ОбщийМодуль - Данные, см. ЮТТестовыеДанные.
Функция Данные() Экспорт
	
	Возврат ЮТТестовыеДанные;
	
КонецФункции

// Возвращает API для формирования предикатов/утверждений, которые могут быть использованы для проверки коллекций.
// 
// Параметры:
//  Условия - Структура, Соответствие из Произвольный - Набор условий, которыми инициализируется предикат
//             Ключ - Строка - Имя реквизита
//             Значение - Произвольный - Значение, которому должен быть равен реквизит
// 
// Возвращаемое значение:
//  ОбщийМодуль - См. ЮТПредикаты.
Функция Предикат(Условия = Неопределено) Экспорт
	
	Возврат ЮТПредикаты.Инициализировать(Условия);
	
КонецФункции

// Конструктор вариантов прогона теста.
// 
// Используется для формирования набора различных параметров выполнения.
// Параметры:
//  Реквизиты - Строка - Список реквизитов варианта разделенных запятой
// 
// Возвращаемое значение:
//  ОбщийМодуль - Варианты, см. ЮТКонструкторВариантов.
Функция Варианты(Реквизиты) Экспорт
	
	Возврат ЮТКонструкторВариантов.Варианты(Реквизиты);
	
КонецФункции

// Умный контекст, в который можно сохранять и получать из него промежуточные данные
// Этот контекст работает с см. КонтекстТеста, см. КонтекстТестовогоНабора и см. КонтекстМодуля.
// При получении значения оно ущется во всех 3 контекста поочереди.
// При установке значения, оно устанавливается в текущий контекст, например, в событии перед тестовым наборов в м. КонтекстТестовогоНабора
// 
// Возвращаемое значение:
//  ОбщийМодуль - Контекст теста, см. ЮТКонтекстТеста
Функция Контекст() Экспорт
	
	Возврат ЮТКонтекстТеста;
	
КонецФункции

// Пропустить выполнение теста.
// 
// Используется если тест выполняется в неподходящих условиях и не нужно его выполнять, но отразить в отчете требуется.
// Параметры:
//  Сообщение - Строка, Неопределено - Сообщение
Процедура Пропустить(Сообщение = Неопределено) Экспорт
	
	ЮТРегистрацияОшибокСлужебный.Пропустить(Сообщение);
	
КонецПроцедуры

// Возвращает структуру, в которой можно хранить данные используемые в тесте.
//  
//  Данные живут в рамках одного теста, но доступны в обработчиках событий `ПередКаждымТестом` и `ПослеКаждогоТеста`.
//  
//  Например, в контекст можно помещать создаваемые данные, что бы освободить/удалить их в обработчике `ПослеКаждогоТеста`.
// Возвращаемое значение:
//  - Структура - Контекст теста
//  - Неопределено - Если метод вызывается за рамками теста
Функция КонтекстТеста() Экспорт
	
	//@skip-check constructor-function-return-section
	Возврат ЮТКонтекстСлужебный.КонтекстТеста();
	
КонецФункции

// Возвращает структуру, в которой можно хранить данные используемые в тестах набора.
//  
//  Данные живут в рамках одного набора тестов (данные между клиентом и сервером не синхронизируются).
//  Доступны в каждом тесте набора и в обработчиках событий:
//  	+ `ПередТестовымНабором`
//  	+ `ПослеТестовогоНабора`
//  	+ `ПередКаждымТестом`
//  	+ `ПослеКаждогоТеста`
//  
//  Например, в контекст можно помещать создаваемые данные, что бы освободить/удалить их в обработчике `ПослеКаждогоТеста`.
// Возвращаемое значение:
//  - Структура - Контекст набора тестов
//  - Неопределено - Если метод вызывается за рамками тестового набора
Функция КонтекстТестовогоНабора() Экспорт
	
	//@skip-check constructor-function-return-section
	Возврат ЮТКонтекстСлужебный.КонтекстНабора();
	
КонецФункции

// Возвращает структуру, в которой можно хранить данные используемые в тестах модуля.
// 
//  Данные живут в рамках одного тестового модуля (данные между клиентом и сервером не синхронизируются).
//  Доступны в каждом тесте модуля и в обработчиках событий.
//  
//  Например, в контекст можно помещать создаваемые данные, что бы освободить/удалить их в обработчике `ПослеВсехТестов`.
// Возвращаемое значение:
//  - Структура - Контекст тестового модуля
//  - Неопределено - Если метод вызывается за рамками тестового модуля
Функция КонтекстМодуля() Экспорт
	
	//@skip-check constructor-function-return-section
	Возврат ЮТКонтекстСлужебный.КонтекстМодуля();
	
КонецФункции

// Преостанавливает поток выполнения на указанное количество секунд
// 
// Параметры:
//  Время - Число - Продолжительность паузы в секундах, возможно указывать дробное значение
Процедура Пауза(Время) Экспорт
	
	ЮТОбщий.Пауза(Время);
	
КонецПроцедуры

// Выводит сообщение в консоль (stdout) приложения
// 
// Параметры:
//  Сообщение - Строка - Выводимое сообщение
Процедура ВывестиВКонсоль(Сообщение) Экспорт
	
	ЮТОбщий.ВывестиВКонсоль(Сообщение);
	
КонецПроцедуры

// Добавляет сообщение в лог исполнения теста.
// 
// Параметры:
//  ТекстСообщения - Строка - Текст сообщения
Процедура ДобавитьСообщение(ТекстСообщения) Экспорт
	
	ЮТЛогИсполненияТестаСлужебный.ДобавитьСообщение(ТекстСообщения);
	
КонецПроцедуры

// Добавляет предупреждение в лог исполнения теста.
// 
// Параметры:
//  ТекстПредупреждения - Строка - Текст предупреждения
Процедура ДобавитьПредупреждение(ТекстПредупреждения) Экспорт
	
	ЮТЛогИсполненияТестаСлужебный.ДобавитьПредупреждение(ТекстПредупреждения);
	
КонецПроцедуры

// Возвращает данные зависимость.
// Результат зависит от реализации зависимости.
// Для указания зависимости используйте методы модуля `ЮТЗависимости`, необходимо указывать туже зависимость, что указана при регистрации.
// 
// Параметры:
//  ОписаниеЗависимости - см. ЮТФабрика.НовоеОписаниеЗависимости
// 
// Возвращаемое значение:
//  Произвольный
// Пример:
// ПолноеИмяФайла = ЮТест.Зависимость(ЮТЗависимости.ФайлыПроекта(".gitignore")).ПолноеИмя;
Функция Зависимость(ОписаниеЗависимости) Экспорт
	
	Возврат ЮТЗависимостиСлужебный.ДанныеЗависимости(ОписаниеЗависимости);
	
КонецФункции

#КонецОбласти
