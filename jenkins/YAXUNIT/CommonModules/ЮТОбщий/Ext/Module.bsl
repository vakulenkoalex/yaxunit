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

// Возвращает значение свойства объекта.
// Возможно получение "глубоко" вложенных свойство и элементов коллекции по индексу
//
// Параметры:
//  Объект - Произвольный
//  ИмяСвойства - Строка - Путь к свойству. Примеры: "ИмяСвойства.ИмяВложенногоСвойства", "[2].ИмяСвойства", "ИмяСвойства[2].ИмяВложенногоСвойства"
//              - Число - Индекс элемента. Возможен выбор элемента с конца, для этого нужно указывать отрицательный номер элемента с конца,
//                        например: '-1' - последний элемент, '-2' - предпоследний
// Возвращаемое значение:
//  Произвольный
Функция ЗначениеСвойства(Объект, ИмяСвойства) Экспорт
	
	Путь = ЧастиПути(ИмяСвойства);
	
	Значение = Объект;
	Для Каждого Часть Из Путь Цикл
		
		Если ТипЗнч(Значение) = Тип("ХранилищеЗначения") Тогда
#Если ВебКлиент Или ТонкийКлиент Тогда
			Значение = ЮТОбщийСлужебныйВызовСервера.ИзХранилищаЗначений(Значение);
#Иначе
			Значение = Значение.Получить();
#КонецЕсли
		КонецЕсли;
		
		Если ТипЗнч(Часть) = Тип("Число") И Часть < 0 И ТипЗнч(Значение) <> Тип("Соответствие") Тогда
			Часть = Значение.Количество() + Часть;
		КонецЕсли;
		
		Значение = Значение[Часть];
		
	КонецЦикла;
	
	Возврат Значение;
	
КонецФункции

// Вычисляет хеш по алгоритму md5.
//
// Параметры:
//  Данные - Строка, ДвоичныеДанные - Данные, для которых необходимо вычислить хеш
//
// Возвращаемое значение:
//  Строка
Функция ХешMD5(Данные) Экспорт
	
	Возврат ЮТОбщийСлужебныйВызовСервера.ХешMD5(Данные);
	
КонецФункции

#Область ДатаВремя

// Добавляет к дате указанное значение временных интервалов
//
// Параметры:
//  Дата - Дата
//  Интервал - Число - Добавляемое
//  ТипИнтервала - Строка - Тип интервала
//
// Возвращаемое значение:
//  Дата
Функция ДобавитьКДате(Дата, Интервал, ТипИнтервала) Экспорт
	
	Если ЭтоМесяц(ТипИнтервала) Тогда
		Возврат ДобавитьМесяц(Дата, Интервал);
	КонецЕсли;
	
	Множитель = МножительПериода(ТипИнтервала);
	Возврат Дата + Множитель * Интервал;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область Числа

// Инкрементирует значение
//
// Параметры:
//  Значение - Число
//  Шаг - Число
// Возвращаемое значение:
//  Число - Результат инкремента
Функция Инкремент(Значение, Знач Шаг = 1) Экспорт
	
	Значение = Значение + Шаг;
	Возврат Значение;
	
КонецФункции

Функция ЧислоВСтроку(Значение) Экспорт
	
	Возврат Формат(Значение, "ЧН = 0; ЧГ=");
	
КонецФункции

#КонецОбласти

#Область ДатаВремя

// Человекочитаемое представление продолжительности
//
// Параметры:
//  Продолжительность - Число - Продолжительность в миллисекундах
//
// Возвращаемое значение:
//  Строка - Представление продолжительности
Функция ПредставлениеПродолжительности(Знач Продолжительность) Экспорт
	
	Представление = ЧислоВСтроку(Цел(Продолжительность / 1000));
	Представление = ЮТСтроки.ДобавитьСтроку(Представление, Формат(Продолжительность % 1000, "ЧЦ=3; ЧВН=;"), ".");
	
	Инкремент(Представление, " сек");
	
	Возврат Представление;
	
КонецФункции

Функция ПредставлениеУниверсальнойДата(Знач УниверсальнаяДатаВМиллисекундах = Неопределено) Экспорт
	
	Если УниверсальнаяДатаВМиллисекундах = Неопределено Тогда
		УниверсальнаяДатаВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах();
	КонецЕсли;
	
	Дата = '00010101' + УниверсальнаяДатаВМиллисекундах / 1000;
	Дата = МестноеВремя(Дата);
	
	Возврат СтрШаблон("%1.%2", Дата, Формат(УниверсальнаяДатаВМиллисекундах % 1000, "ЧЦ=3; ЧН=000; ЧВН=; ЧГ=0;"));
	
КонецФункции

#КонецОбласти

#Область ЧтениеДанных

Функция ДанныеТекстовогоФайла(ИмяФайла) Экспорт
	
#Если НЕ ВебКлиент Тогда
	Чтение = Новый ЧтениеТекста;
	Чтение.Открыть(ИмяФайла, "UTF-8");
	Текст = Чтение.Прочитать();
	Чтение.Закрыть();
	
	Возврат Текст;
#Иначе
	ВызватьИсключение "Чтение данных текстовых файлов в веб-клиенте не поддерживается";
#КонецЕсли
	
КонецФункции

Функция ЗначениеИзJSON(СтрокаJSON) Экспорт
	
#Если НЕ ВебКлиент Тогда
	Чтение = Новый ЧтениеJSON;
	Чтение.УстановитьСтроку(СтрокаJSON);
	Значение = ПрочитатьJSON(Чтение);
	Чтение.Закрыть();
	Возврат Значение;
#Иначе
	ВызватьИсключение "Разбор JSON строки в веб-клиенте не поддерживается";
#КонецЕсли
	
КонецФункции

#КонецОбласти

// ПеременнаяСодержитСвойство
//  функция проверяет наличие свойства у значения любого типа данных. Если передано НЕОПРЕДЕЛЕНО, то ф-ия всегда вернет Ложь
//
// Параметры:
//  Переменная	 - Произвольный	 - переменная любого типа, для которой необходимо проверить наличие свойства
//  ИмяСвойства	 - Строка		 - переменная типа "Строка", содержащая искомое свойства
//
// Возвращаемое значение:
//  Булево - признак наличия свойства у значения
//
Функция ПеременнаяСодержитСвойство(Переменная, ИмяСвойства) Экспорт
	
	Если Переменная = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	// Инициализируем структуру для теста с ключом (значение переменной "ИмяСвойства") и значением произвольного GUID'а
	GUIDПроверка = Новый УникальныйИдентификатор;
	СтруктураПроверка = Новый Структура;
	СтруктураПроверка.Вставить(ИмяСвойства, GUIDПроверка);
	// Заполняем созданную структуру из переданного значения переменной
	ЗаполнитьЗначенияСвойств(СтруктураПроверка, Переменная);
	// Если значение для свойства структуры осталось GUIDПроверка, то искомое свойство не найдено, и наоборот.
	Возврат СтруктураПроверка[ИмяСвойства] <> GUIDПроверка;
	
КонецФункции

// СообщитьПользователю
//  Формирует и выводит сообщение
//
// Параметры:
//  ТекстСообщенияПользователю	 - Строка	 - текст сообщения.
Процедура СообщитьПользователю(ТекстСообщенияПользователю) Экспорт
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = СокрЛП(ТекстСообщенияПользователю);
	Сообщение.Сообщить();
	
КонецПроцедуры

Функция СтрокаJSON(Значение, ИспользоватьСериализатор = Истина) Экспорт
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТОбщий.СтрокаJSON");
#Иначе
	ЗаписьJSON = Новый ЗаписьJSON();
	ЗаписьJSON.УстановитьСтроку();
	Если ИспользоватьСериализатор Тогда
		//@skip-check undefined-variable
		СериализаторXDTO.ЗаписатьJSON(ЗаписьJSON, Значение);
	Иначе
		ЗаписатьJSON(ЗаписьJSON, Значение);
	КонецЕсли;
	
	Возврат ЗаписьJSON.Закрыть();
#КонецЕсли
	
КонецФункции // СтрокаJSON

Функция ПредставлениеЗначения(Значение) Экспорт
	
	Попытка
		Возврат СтрокаJSON(Значение);
	Исключение
		Возврат Строка(Значение);
	КонецПопытки;
	
КонецФункции

// Параметры записи объекта
//
// Возвращаемое значение:
//  Структура - Параметры записи:
// * ОбменДаннымиЗагрузка - Булево
// * ДополнительныеСвойства - Структура
// * РежимЗаписи - РежимЗаписиДокумента
//				 - Неопределено
// * УникальныйИдентификаторСсылки - УникальныйИдентификатор
//							 	   - Неопределено
Функция ПараметрыЗаписи() Экспорт
	
	ПараметрыЗаписи = Новый Структура();
	ПараметрыЗаписи.Вставить("ОбменДаннымиЗагрузка", Ложь);
	ПараметрыЗаписи.Вставить("ДополнительныеСвойства", Новый Структура);
	ПараметрыЗаписи.Вставить("УникальныйИдентификаторСсылки", Неопределено);
	ПараметрыЗаписи.Вставить("РежимЗаписи", Неопределено);
	
	Возврат ПараметрыЗаписи;
	
КонецФункции

Функция УстановленБезопасныйРежим() Экспорт
	
	Возврат ЮТОбщийСлужебныйВызовСервера.УстановленБезопасныйРежим();
	
КонецФункции

Функция МестноеВремяПоВременнойМетке(Метка) Экспорт
	
	Если ЗначениеЗаполнено(Метка) Тогда
		Возврат МестноеВремя('00010101' + Метка / 1000);
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

Функция ПродолжительностьВСекундах(Продолжительность) Экспорт
	
	Возврат Продолжительность / 1000;
	
КонецФункции

Функция Модуль(ИмяМодуля) Экспорт
	
	Возврат ЮТМетодыСлужебный.ВычислитьБезопасно(ИмяМодуля);
	
КонецФункции

Функция Менеджер(Знач Менеджер) Экспорт
	
#Если Сервер Тогда
	Возврат ЮТОбщийСлужебныйВызовСервера.Менеджер(Менеджер);
#Иначе
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТОбщий.Менеджер", "клиенте");
#КонецЕсли
	
КонецФункции

Функция ТипСтруктуры(Структура) Экспорт
	
	Возврат ЮТКоллекции.ЗначениеСтруктуры(Структура, "__type__");
	
КонецФункции

Функция ЭтаСтруктураИмеетТип(Структура, ИмяТипа) Экспорт
	
	Возврат ТипСтруктуры(Структура) = ИмяТипа;
	
КонецФункции

Процедура УказатьТипСтруктуры(Структура, ИмяТипа) Экспорт
	
	Структура.Вставить("__type__", ИмяТипа);
	
КонецПроцедуры

// Преостанавливает поток выполнения на указанное количество секунд
//
// Параметры:
//  Время - Число - Продолжительность паузы в секундах, возможно указывать дробное значение
Процедура Пауза(Время) Экспорт
	
	Задержка = Цел(1000 * Время);
	Компонента = ЮТКомпоненты.Пауза();
#Если Сервер Тогда
	Компонента.Ожидать(Задержка);
#Иначе
	Если ЮТМетаданные.РазрешеныСинхронныеВызовы() Тогда
		Компонента.Ожидать(Задержка);
	Иначе
		ВызватьИсключение "Пауза не работает на клиенте при отключенных синхронных вызовах";
	КонецЕсли;
#КонецЕсли
	
КонецПроцедуры

// Выводит сообщение в консоль (stdout) приложения
//
// Параметры:
//  Сообщение - Строка - Выводимое сообщение
Процедура ВывестиВКонсоль(Знач Сообщение) Экспорт
	
	Сообщение = Строка(Сообщение);
	
	Компонента = ЮТКомпоненты.Консоль();
#Если Сервер Тогда
	Компонента.Напечатать(Сообщение);
#Иначе
	Если ЮТМетаданные.РазрешеныСинхронныеВызовы() Тогда
		Компонента.Напечатать(Сообщение);
	Иначе
		Компонента.НачатьВызовНапечатать(ЮТАсинхроннаяОбработкаСлужебныйКлиент.НовыйПустойОбработчик(3), Сообщение);
	КонецЕсли;
#КонецЕсли
	
КонецПроцедуры

// Возвращяет макет
//
// Параметры:
//  ИмяМакета - Строка - Возможные значения
//                       * Общий макет, например, ОбщийМакет.ЮТМетаданные
//                       * Макет объекта метаданных, например, Справочник.Товары.ПечатнаяФорма
//                       * Область макета, например, Справочник.Товары.ПечатнаяФорма.Шапка, ОбщийМакет.ЮТМетаданные.Заголовок
//
// Возвращаемое значение:
//  ТабличныйДокумент, ТекстовыйДокумент, ДвоичныеДанные - Макет или его область
Функция Макет(ИмяМакета) Экспорт
	
	Возврат ЮТОбщийСлужебныйВызовСервера.Макет(ИмяМакета);
	
КонецФункции

#Область УстаревшиеПроцедурыИФункции

// Устарела. Метод перенесен в см. ЮТСтроки.ДобавитьСтроку
//  Конкатенирует строки, разделяя их разделителем
//
// Параметры:
//  ИсходнаяСтрока		 - Строка	 - Исходная строка
//  ДополнительнаяСтрока - Строка	 - Добавляемая строка
//  Разделитель			 - Строка	 - Строка разделитель, любой набор символов - разделитель между подстроками
//
// Возвращаемое значение:
//  Строка - Результат конкатенации строк
Функция ДобавитьСтроку(ИсходнаяСтрока, ДополнительнаяСтрока, Разделитель = ";") Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ДобавитьСтроку", "ЮТСтроки.ДобавитьСтроку", "24.03");
	Возврат ЮТСтроки.ДобавитьСтроку(ИсходнаяСтрока, ДополнительнаяСтрока, Разделитель);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТСтроки.РазделитьСтроку
// Возвращает массив на основании строки
//
// Параметры:
//  Значение - Строка - преобразуемая строка
//  Разделитель - Строка - строка-разделитель
//
// Возвращаемое значение:
//  Массив Из Строка - массив строк
//
Функция РазложитьСтрокуВМассивПодстрок(Значение, Разделитель = ";") Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.РазложитьСтрокуВМассивПодстрок", "ЮТСтроки.РазбитьСтроку", "24.03");
	Возврат ЮТСтроки.РазделитьСтроку(Значение, Разделитель);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТСтроки.СтрокаСимволов
//  Формирует строку из заданного количества повторяемых символов
// Параметры:
//  Символ - Строка - Повторяемый символ
//  Количество - Число - Количество повторений
//
// Возвращаемое значение:
//  Строка - Строка повторяемых символов
Функция СформироватьСтрокуСимволов(Символ, Количество) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.СформироватьСтрокуСимволов", "ЮТСтроки.СтрокаСимволов", "24.03");
	Возврат ЮТСтроки.СтрокаСимволов(Символ, Количество);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.ЗначениеСтруктуры
// Возвращает требуемое поле структуры. В случае отсутствия поля возвращает значение по умолчанию
//
// Параметры:
//  ИсходнаяСтруктура - Структура - Исходная структура
//  ИмяПоля - Строка - Имя поля структуры
//  ЗначениеПоУмолчанию - Произвольный - Значение, которое будет возвращено, если поля в структуре нет
//
// Возвращаемое значение:
//  Произвольный - Значение искомого поля структуры
Функция ЗначениеСтруктуры(ИсходнаяСтруктура, ИмяПоля, ЗначениеПоУмолчанию = Неопределено) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ЗначениеСтруктуры", "ЮТКоллекции.ЗначениеСтруктуры", "24.03");
	Возврат ЮТКоллекции.ЗначениеСтруктуры(ИсходнаяСтруктура, ИмяПоля, ЗначениеПоУмолчанию);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.ДополнитьСтруктуру
//  Функция, объединяющая две коллекции( с типами Структура или Соответствие) в одну структуру, если это возможно
//
// Параметры:
//  Коллекция1 - Соответствие из Произвольный
//             - Структура
//  Коллекция2 - Соответствие из Произвольный
//             - Структура
//
// Возвращаемое значение:
//  Структура - Результат объединения двух коллекций
//
Функция ОбъединитьВСтруктуру(Знач Коллекция1, Коллекция2) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ОбъединитьВСтруктуру", "ЮТКоллекции.ДополнитьСтруктуру", "24.03");
	Если ТипЗнч(Коллекция1) <> Тип("Структура") Тогда
		Коллекция1 = ЮТКоллекции.СкопироватьСтруктуру(Коллекция1);
	КонецЕсли;
	
	ЮТКоллекции.ДополнитьСтруктуру(Коллекция1, Коллекция2);
	
	//@skip-check constructor-function-return-section
	Возврат Коллекция1;
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.СкопироватьРекурсивно
//  Создает копию экземпляра указанного объекта.
//  Примечание:
//  Функцию нельзя использовать для объектных типов (СправочникОбъект, ДокументОбъект и т.п.).
//
// Параметры:
//  Источник - Произвольный	 - объект, который необходимо скопировать.
//
// Возвращаемое значение:
//  Произвольный - копия объекта, переданного в параметре Источник.
//
Функция СкопироватьРекурсивно(Источник) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.СкопироватьРекурсивно", "ЮТКоллекции.СкопироватьРекурсивно", "24.03");
	Возврат ЮТКоллекции.СкопироватьРекурсивно(Источник);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.СкопироватьСтруктуру
//  Создает копию значения типа Структура
//
// Параметры:
//  Источник - Структура - копируемая структура
//
// Возвращаемое значение:
//  Структура - копия исходной структуры.
//
Функция СкопироватьСтруктуру(Источник) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.СкопироватьСтруктуру", "ЮТКоллекции.СкопироватьСтруктуру", "24.03");
	Возврат ЮТКоллекции.СкопироватьСтруктуру(Источник);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.СкопироватьСоответствие
//  Создает копию значения типа Соответствие.
//
// Параметры:
//  Источник - Соответствие из Произвольный - соответствие, копию которого необходимо получить.
//
// Возвращаемое значение:
//  Соответствие Из Произвольный - копия исходного соответствия.
//
Функция СкопироватьСоответствие(Источник) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.СкопироватьСоответствие", "ЮТКоллекции.СкопироватьСоответствие", "24.03");
	Возврат ЮТКоллекции.СкопироватьСоответствие(Источник);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.СкопироватьМассив
//  Создает копию значения типа Массив.
//
// Параметры:
//  Источник - Массив Из Произвольный - массив, копию которого необходимо получить
//
// Возвращаемое значение:
//  Массив Из Произвольный - копия исходного массива.
//
Функция СкопироватьМассив(Источник) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.СкопироватьМассив", "ЮТКоллекции.СкопироватьМассив", "24.03");
	Возврат ЮТКоллекции.СкопироватьМассив(Источник);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.СкопироватьСписокЗначений
//  Создает копию значения типа СписокЗначений.
//
// Параметры:
//  Источник - СписокЗначений Из Произвольный - список значений, копию которого необходимо получить
//
// Возвращаемое значение:
//  СписокЗначений Из Произвольный - копия исходного списка значений
//
Функция СкопироватьСписокЗначений(Источник) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.СкопироватьСписокЗначений", "ЮТКоллекции.СкопироватьСписокЗначений", "24.03");
	Возврат ЮТКоллекции.СкопироватьСписокЗначений(Источник);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.ВыгрузитьЗначения
//
// Параметры:
//  Коллекция - Произвольный
//  ИмяРеквизита - Строка
//
// Возвращаемое значение:
//  Массив из Произвольный - Выгрузить значения
Функция ВыгрузитьЗначения(Коллекция, ИмяРеквизита) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ВыгрузитьЗначения", "ЮТКоллекции.ВыгрузитьЗначения", "24.03");
	Возврат ЮТКоллекции.ВыгрузитьЗначения(Коллекция, ИмяРеквизита);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.ВыгрузитьЗначения
//
// Параметры:
//  Коллекция1 - Массив из Произвольный
//  Коллекция2 - Массив из Произвольный
//
// Возвращаемое значение:
//  Массив из Произвольный - Пересечение массивов
Функция ПересечениеМассивов(Коллекция1, Коллекция2) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ПересечениеМассивов", "ЮТКоллекции.ПересечениеМассивов", "24.03");
	Возврат ЮТКоллекции.ПересечениеМассивов(Коллекция1, Коллекция2);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.ЗначениеВМассиве
// Создает массив с переданными значениями
//
// Параметры:
//  Значение - Произвольный
//  Значение2 - Произвольный
//  Значение3 - Произвольный
//  Значение4 - Произвольный
//  Значение5 - Произвольный
//  Значение6 - Произвольный
//  Значение7 - Произвольный
//  Значение8 - Произвольный
//  Значение9 - Произвольный
//  Значение10 - Произвольный
//
// Возвращаемое значение:
//  Массив из Произвольный
//@skip-check method-too-many-params
Функция ЗначениеВМассиве(Значение,
		Значение2 = "_!%*",
		Значение3 = "_!%*",
		Значение4 = "_!%*",
		Значение5 = "_!%*",
		Значение6 = "_!%*",
		Значение7 = "_!%*",
		Значение8 = "_!%*",
		Значение9 = "_!%*",
		Значение10 = "_!%*") Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ЗначениеВМассиве", "ЮТКоллекции.ЗначениеВМассиве", "24.03");
	Возврат ЮТКоллекции.ЗначениеВМассиве(Значение, Значение2, Значение3, Значение4, Значение5, Значение6, Значение7, Значение8, Значение9, Значение10);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.ДополнитьМассив
//
// Параметры:
//  Приемник - Массив из Произвольный
//  Источник - Массив из Произвольный
Процедура ДополнитьМассив(Приемник, Источник) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ДополнитьМассив", "ЮТКоллекции.ДополнитьМассив", "24.03");
	ЮТКоллекции.ДополнитьМассив(Приемник, Источник);
	
КонецПроцедуры

// Устарела. Метод перенесен в см. ЮТКоллекции.ВСоответствие
// 	Возвращает соответствие элементов переданной коллекции, в качестве ключей выступают значения указанного поля элементов коллекции.
//
// Параметры:
// 	Коллекция - Произвольный - значение, для которого определен итератор, и возможно обращение к полям элементов через квадратные скобки.
// 	ИмяПоляКлюча - Строка - имя поля элемента коллекции, которое будет ключом соответствия.
// 	ИмяПоляЗначения - Строка - если указан, значениями результата будут не элементы, а значения соответствующих полей элементов коллекции.
// Возвращаемое значение:
// 	Соответствие Из Произвольный - полученное соответствие.
Функция ВСоответствие(Коллекция, ИмяПоляКлюча, ИмяПоляЗначения = Неопределено) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ВСоответствие", "ЮТКоллекции.ВСоответствие", "24.03");
	Возврат ЮТКоллекции.ВСоответствие(Коллекция, ИмяПоляКлюча, ИмяПоляЗначения);
	
КонецФункции

// Устарела. Метод перенесен в см. ЮТКоллекции.ВСтруктуру
// Возвращает структуру элементов переданной коллекции, в качестве ключей выступают значения указанного поля элементов коллекции.
//
// Параметры:
// 	Коллекция - Произвольный - значение, для которого определен итератор, и возможно обращение к полям элементов через квадратные скобки.
// 	ИмяПоляКлюча - Строка - имя поля элемента коллекции, которое будет ключом соответствия.
// 	ИмяПоляЗначения - Строка - если указан, значениями результата будут не элементы, а значения соответствующих полей элементов коллекции.
// Возвращаемое значение:
// 	Структура Из Произвольный - полученная структура.
Функция ВСтруктуру(Коллекция, ИмяПоляКлюча, ИмяПоляЗначения = Неопределено) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ВСтруктуру", "ЮТКоллекции.ВСтруктуру", "24.03");
	Возврат ЮТКоллекции.ВСтруктуру(Коллекция, ИмяПоляКлюча, ИмяПоляЗначения);
	
КонецФункции

// Устарела. МетодМодуляСуществует
// Проверяет существование публичного (экспортного) метода у модуля
//
// Параметры:
//  ИмяМодуля - Строка - Имя модуля, метод которого нужно поискать
//  ИмяМетода - Строка - Имя метода, который ищем
//  КоличествоПараметров - Число - Количество параметров метода, увы это никак не влияет на проверку
//  Кешировать - Булево - Признак кеширования результата проверки
//
// Возвращаемое значение:
//  Булево - Метод найден
Функция МетодМодуляСуществует(ИмяМодуля, ИмяМетода, КоличествоПараметров = 0, Кешировать = Истина) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.МетодМодуляСуществует", Неопределено, "24.03");
	Возврат ЮТМетодыСлужебный.МетодМодуляСуществует(ИмяМодуля, ИмяМетода, Кешировать);
	
КонецФункции

// Устарела. Проверяет существование публичного (экспортного) метода у объекта
//
// Параметры:
//  Объект - Произвольный - Объект, метод которого нужно поискать
//  ИмяМетода - Строка - Имя метода, который ищем
//
// Возвращаемое значение:
//  Булево - Метод найден
Функция МетодОбъектаСуществует(Объект, ИмяМетода) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.МетодОбъектаСуществует", Неопределено, "24.03");
	Возврат ЮТМетодыСлужебный.МетодОбъектаСуществует(Объект, ИмяМетода);
	
КонецФункции

// Устарела.
Функция ВыполнитьМетод(ПолноеИмяМетода, Параметры = Неопределено, Объект = Неопределено) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ВыполнитьМетод", Неопределено, "24.03");
	Возврат ЮТМетодыСлужебный.ВыполнитьМетод(ПолноеИмяМетода, Параметры, Объект);
	
КонецФункции

// Устарела.
Функция ВычислитьБезопасно(Выражение) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ВычислитьБезопасно", Неопределено, "24.03");
	Возврат ЮТМетодыСлужебный.ВычислитьБезопасно(Выражение);
	
КонецФункции

// Устарела.
Функция ПредставлениеТипа(Тип) Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ПредставлениеТипа", Неопределено, "24.03");
	Возврат ЮТТипыДанныхСлужебный.ПредставлениеТипа(Тип);
	
КонецФункции

// Устарела. Описание типов любая ссылка.
//
// Возвращаемое значение:
//  ОписаниеТипов - Описание типов любая ссылка
Функция ОписаниеТиповЛюбаяСсылка() Экспорт
	
	ЮТМетодыСлужебный.ВызовУстаревшегоМетода("ЮТОбщий.ОписаниеТиповЛюбаяСсылка", Неопределено, "24.03");
	Возврат ЮТТипыДанныхСлужебный.ОписаниеТиповЛюбаяСсылка();
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПредставлениеОбъекта(Объект, Знач Уровень = 1, ПредставлениеОбъекта = Неопределено)
	
	ТипОбъекта = ТипЗнч(Объект);
	
	Шаблон = "%1 (%2)";
	Представление = "";
	ПредставлениеТипа = ТипОбъекта;
	
	Если ТипОбъекта = Тип("Структура") ИЛИ ТипОбъекта = Тип("Соответствие") Тогда
		ЮТСтроки.СтрокаСимволов(" ", Уровень * 4);
		Шаблон = "%2:
			|%1";
		Представление = ЮТСтроки.СтрокаСимволов(" ", Уровень * 4) + ПредставлениеСтруктуры(Объект, Уровень);
		
	ИначеЕсли ТипОбъекта = Тип("Массив") Тогда
		
		Шаблон = "[%1] (%2)";
		Представление = СтрСоединить(Объект, ", ");
		
	ИначеЕсли ТипОбъекта = Тип("Число") Тогда
		
		Представление = ЧислоВСтроку(Объект);
		
	ИначеЕсли ТипОбъекта = Тип("Дата") Тогда
		
		Представление = Формат(Объект, "ДФ=""dd.MM.yyyy ЧЧ:мм:сс""");
		
	ИначеЕсли ТипОбъекта = Тип("Булево") Тогда
		
		Представление = Строка(Объект);
		
	ИначеЕсли ТипОбъекта = Тип("Строка") Тогда
		
		Представление = Объект;
		
	Иначе
		
		Представление = Строка(Объект);
		ПредставлениеТипа = ПредставлениеТипа(ТипОбъекта); // Для ссылочных
		
	КонецЕсли;
	
	Если ПустаяСтрока(Представление) Тогда
		
		Представление = "<Пусто>";
		
	КонецЕсли;
	
	Возврат СтрШаблон(Шаблон, Представление, ?(ПредставлениеОбъекта = Неопределено, ПредставлениеТипа, ПредставлениеОбъекта));
	
КонецФункции

Функция ПредставлениеСтруктуры(Значение, Уровень)
	
	Строки = Новый Массив();
	
	Для Каждого Элемент Из Значение Цикл
		
		Строки.Добавить(СтрШаблон("%1: %2", Элемент.Ключ, ПредставлениеОбъекта(Элемент.Значение, Уровень + 1)));
		
	КонецЦикла;
	
	Возврат СтрСоединить(Строки, Символы.ПС + ЮТСтроки.СтрокаСимволов(" ", Уровень * 4));
	
КонецФункции

Функция ЧастиПути(Цепочка) Экспорт
	
	ПутьКСвойству = Новый Массив();
	
	ТипПути = ТипЗнч(Цепочка);
	
	Если ТипПути = Тип("Строка") Тогда
		
		Части = СтрРазделить(Цепочка, ".");
		
		Для Каждого Часть Из Части Цикл
			
			Если СодержитИндекс(Часть) Тогда
				
				ИзвлечьИндекс(Часть, ПутьКСвойству);
				
			Иначе
				
				ПутьКСвойству.Добавить(Часть);
				
			КонецЕсли;
			
		КонецЦикла;
		
	Иначе
		
		ПутьКСвойству.Добавить(Цепочка);
		
	КонецЕсли; // BSLLS:IfElseIfEndsWithElse-off
	
	Возврат ПутьКСвойству;
	
КонецФункции

Функция СодержитИндекс(ИмяСвойства)
	
	Возврат СтрНайти(ИмяСвойства, "[") > 0 И СтрЗаканчиваетсяНа(ИмяСвойства, "]");
	
КонецФункции

Процедура ИзвлечьИндекс(ИмяСвойства, БлокиПути)
	
	ПозицияИндекса = СтрНайти(ИмяСвойства, "[");
	
	Если ПозицияИндекса > 1 Тогда
		БлокиПути.Добавить(Лев(ИмяСвойства, ПозицияИндекса - 1));
	КонецЕсли;
	
	Пока ПозицияИндекса > 0 Цикл
		
		ЗакрывающаяПозиция = СтрНайти(ИмяСвойства, "]", , ПозицияИндекса);
		ИндексСтрокой = Сред(ИмяСвойства, ПозицияИндекса + 1, ЗакрывающаяПозиция - ПозицияИндекса - 1);
		Индекс = Число(ИндексСтрокой);
		БлокиПути.Добавить(Индекс);
		
		ПозицияИндекса = СтрНайти(ИмяСвойства, "[", , ЗакрывающаяПозиция);
		
	КонецЦикла;
	
КонецПроцедуры

Функция МножительПериода(ТипИнтервала)
	
	Множители = ЮТСлужебныйПовторногоИспользования.МножителиИнтервалов();
	Возврат Множители[ТипИнтервала];
	
КонецФункции

Функция ЭтоМесяц(ТипИнтервала)
	
	Возврат СтрСравнить(ТипИнтервала, "месяц") = 0
		ИЛИ СтрСравнить(ТипИнтервала, "месяца") = 0
		ИЛИ СтрСравнить(ТипИнтервала, "месяцев") = 0;
	
КонецФункции

#КонецОбласти
