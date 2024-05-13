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

// Создает новый элемент и возвращает его ссылку.
//  
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Наименование - Строка, Неопределено - Наименование элемента
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
//  ПараметрыЗаписи - см. ЮТОбщий.ПараметрыЗаписи
// 
// Возвращаемое значение:
//  ЛюбаяСсылка - Ссылка на созданный объект
Функция СоздатьЭлемент(Менеджер, Наименование = Неопределено, Реквизиты = Неопределено, Знач ПараметрыЗаписи = Неопределено) Экспорт
	
	Если Реквизиты <> Неопределено Тогда
		Данные = Реквизиты;
	Иначе
		Данные = Новый Структура;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Наименование) Тогда
		Если ЮТОбщийСлужебныйВызовСервера.ЭтоАнглийскийВстроенныйЯзык() Тогда
			Данные.Вставить("Description", Наименование);
		Иначе
			Данные.Вставить("Наименование", Наименование);
		КонецЕсли;
	КонецЕсли;
	
	Ссылка = ЮТТестовыеДанныеСлужебныйВызовСервера.СоздатьЗапись(Менеджер, Данные, ПараметрыЗаписи, Ложь);
	ЮТТестовыеДанныеСлужебный.ДобавитьТестовуюЗапись(Ссылка);
	
	Возврат Ссылка;
	
КонецФункции

// Создает новый документ и возвращает его ссылку.
//  
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
//  ПараметрыЗаписи - см. ЮТОбщий.ПараметрыЗаписи
// 
// Возвращаемое значение:
//  ДокументСсылка - Ссылка на созданный объект
Функция СоздатьДокумент(Менеджер, Реквизиты = Неопределено, Знач ПараметрыЗаписи = Неопределено) Экспорт
	
	Если Реквизиты <> Неопределено Тогда
		Данные = Реквизиты;
	Иначе
		Данные = Новый Структура;
	КонецЕсли;
	
	Если ПараметрыЗаписи = Неопределено И Данные.Свойство("РежимЗаписи") Тогда
		ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
		ПараметрыЗаписи.РежимЗаписи = Данные.РежимЗаписи;
		Данные.Удалить("РежимЗаписи");
	КонецЕсли;
	
	Ссылка = ЮТТестовыеДанныеСлужебныйВызовСервера.СоздатьЗапись(Менеджер, Данные, ПараметрыЗаписи, Ложь);
	ЮТТестовыеДанныеСлужебный.ДобавитьТестовуюЗапись(Ссылка);
	
	Возврат Ссылка;
	
КонецФункции

// Создает новую группу
//  
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Наименование - Строка, Неопределено - Наименование элемента
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
//  ПараметрыЗаписи - см. ЮТОбщий.ПараметрыЗаписи
// 
// Возвращаемое значение:
//  ЛюбаяСсылка - Ссылка на созданную группу
Функция СоздатьГруппу(Менеджер, Наименование = Неопределено, Реквизиты = Неопределено, Знач ПараметрыЗаписи = Неопределено) Экспорт
	
	Если Реквизиты <> Неопределено Тогда
		Данные = Реквизиты;
	Иначе
		Данные = Новый Структура;
	КонецЕсли;
	
	Данные.Вставить("ЭтоГруппа", Истина);
	
	Возврат СоздатьЭлемент(Менеджер, Наименование, Данные, ПараметрыЗаписи);
	
КонецФункции

#Область ГенерацияСлучайныхЗначений

// Возвращает случайное число в указанном диапазоне.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Минимум - Число - Минимальное значение диапазона. По умолчанию равно 0.
// Максимум - Число - Максимальное значение диапазона. Если значение не указано, то будет использовано максимальное значение для целых чисел.
// ЗнаковПослеЗапятой - Число - Количество знаков после запятой для случайного числа. По умолчанию равно 0.
//
// Возвращаемое значение:
// Число - Случайное число в указанном диапазоне.
//
// Пример:
// Результат = СлучайноеЧисло(); // Результат будет содержать случайное целое число от 0 до максимального значения для целых чисел.
// Результат = СлучайноеЧисло(1, 10); // Результат будет содержать случайное целое число от 1 до 10.
// Результат = СлучайноеЧисло(1, 10, 2); // Результат будет содержать случайное число от 1 до 10 с двумя знаками после запятой.
Функция СлучайноеЧисло(Минимум = 0, Максимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТИсключения.МетодНеДоступен("ЮТТестовыеДанные.СлучайноеЧисло");
#Иначе
	Генератор = ЮТКонтекстСлужебный.ЗначениеКонтекста("ГенераторСлучайныхЧисел");
	
	Если Генератор = Неопределено Тогда
		Генератор = Новый ГенераторСлучайныхЧисел();
		ЮТКонтекстСлужебный.УстановитьЗначениеКонтекста("ГенераторСлучайныхЧисел", Генератор);
	КонецЕсли;
	
	Если Максимум = Неопределено Тогда
		Результат = Генератор.СлучайноеЧисло(Минимум);
	Иначе
		Результат = Генератор.СлучайноеЧисло(Минимум, Максимум);
	КонецЕсли;
	
	Если ЗнаковПослеЗапятой > 0 Тогда
		Множитель = Pow(10, ЗнаковПослеЗапятой);
		Результат = Результат + Окр(Генератор.СлучайноеЧисло(0, Множитель) / Множитель, ЗнаковПослеЗапятой);
	КонецЕсли;
	
	Возврат Результат;
#КонецЕсли
	
КонецФункции

// Возвращает случайное положительное число в указанном диапазоне.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Максимум - Число - Максимальное значение диапазона. Если значение не указано, то будет использовано максимальное значение для целых чисел.
// ЗнаковПослеЗапятой - Число - Количество знаков после запятой для случайного числа. По умолчанию равно 0.
//
// Возвращаемое значение:
// Число - Случайное положительное число в указанном диапазоне.
//
// Пример:
// Результат = СлучайноеПоложительноеЧисло(); // Результат будет содержать случайное целое положительное число от 1 до максимального значения для целых чисел.
// Результат = СлучайноеПоложительноеЧисло(10); // Результат будет содержать случайное целое положительное число от 1 до 10.
// Результат = СлучайноеПоложительноеЧисло(10, 2); // Результат будет содержать случайное положительное число от 1 до 10 с двумя знаками после запятой.
Функция СлучайноеПоложительноеЧисло(Максимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
	Возврат СлучайноеЧисло(1, Максимум, ЗнаковПослеЗапятой);
	
КонецФункции

// Возвращает случайное отрицательное число в указанном диапазоне.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Минимум - Число - Минимальное значение диапазона. Если значение не указано, то будет использовано минимальное значение для целых чисел.
// ЗнаковПослеЗапятой - Число - Количество знаков после запятой для случайного числа. По умолчанию равно 0.
//
// Возвращаемое значение:
// Число - Случайное отрицательное число в указанном диапазоне.
//
// Пример:
// Результат = СлучайноеОтрицательноеЧисло(); // Результат будет содержать случайное целое отрицательное число от минимального значения для целых чисел до -1.
// Результат = СлучайноеОтрицательноеЧисло(-10); // Результат будет содержать случайное целое отрицательное число от -10 до -1.
// Результат = СлучайноеОтрицательноеЧисло(-10, 2); // Результат будет содержать случайное отрицательное число от -10 до -1 с двумя знаками после запятой.
Функция СлучайноеОтрицательноеЧисло(Знач Минимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
	Если Минимум <> Неопределено Тогда
		Минимум = -Минимум;
	КонецЕсли;
	
	Возврат -СлучайноеЧисло(1, Минимум, ЗнаковПослеЗапятой);
	
КонецФункции

// Возвращает случайную строку указанной длины, состоящую из допустимых символов.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Длина - Число - Длина возвращаемой строки. По умолчанию равно 10.
// Префикс - Строка - Префикс, который будет добавлен к началу возвращаемой строки. По умолчанию равно пустой строке.
// ДопустимыеСимволы - Строка - Строка, содержащая допустимые символы для генерации строки. 
//                              Если значение не указано, то будут использованы все русские и английские буквы в верхнем и нижнем регистре,
//                              а также цифры.
//
// Возвращаемое значение:
// Строка - Случайная строка указанной длины, состоящая из допустимых символов.
//
// Пример:
// Результат = СлучайнаяСтрока(); // Результат будет содержать случайную строку длиной 10 символов
// Результат = СлучайнаяСтрока(5, "Привет "); // Результат будет содержать строку "Привет " и случайную строку длиной 5 символов
// Результат = СлучайнаяСтрока(10, "", "abcdefghijklmnopqrstuvwxyz"); // Результат будет содержать случайную строку длиной 10 символов
Функция СлучайнаяСтрока(Знач Длина = 10, Префикс = "", Знач ДопустимыеСимволы = Неопределено) Экспорт
	
	Если ДопустимыеСимволы = Неопределено Тогда
		ДопустимыеСимволы = ЮТСтроки.РусскиеБуквы(Истина, Истина) + ЮТСтроки.АнглийскиеБуквы(Истина, Истина) + ЮТСтроки.Цифры();
	КонецЕсли;
	
	Результат = "";
	КоличествоСимволов = СтрДлина(ДопустимыеСимволы);
	
	Длина = Длина - СтрДлина(Префикс);
	
	Для Инд = 1 По Длина Цикл
		
		Результат = Результат + Сред(ДопустимыеСимволы, СлучайноеЧисло(1, КоличествоСимволов), 1);
		
	КонецЦикла;
	
	Возврат Префикс + Результат;
	
КонецФункции

// Возвращает случайный идентификатор указанной длины, состоящий из букв и цифр.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Длина - Число - Длина возвращаемого идентификатора. По умолчанию равно 10.
// Префикс - Строка - Префикс, который будет добавлен к началу возвращаемого идентификатора. По умолчанию равно пустой строке.
//
// Возвращаемое значение:
// Строка - Случайный идентификатор указанной длины, состоящий из букв и цифр.
//
// Пример:
// Результат = СлучайныйИдентификатор(); // Результат будет содержать случайный идентификатор длиной 10 символов
// Результат = СлучайныйИдентификатор(5, "Привет "); // Результат будет содержать строку "Привет " и случайный идентификатор длиной 5 символов
// Результат = СлучайныйИдентификатор(10, "ID_"); // Результат будет содержать строку "ID_" и случайный идентификатор длиной 10 символов
Функция СлучайныйИдентификатор(Знач Длина = 10, Знач Префикс = "") Экспорт
	
	НаборСимволов = "_" + ЮТСтроки.РусскиеБуквы(Истина, Истина) + ЮТСтроки.АнглийскиеБуквы(Истина, Истина);
	
	Если ПустаяСтрока(Префикс) Тогда
		Префикс = СлучайнаяСтрока(1, "", НаборСимволов);
	КонецЕсли;
	
	НаборСимволов = НаборСимволов + ЮТСтроки.Цифры();
	
	Возврат СлучайнаяСтрока(Длина, Префикс, НаборСимволов);
	
КонецФункции

// Возвращает случайную дату в указанном диапазоне.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Минимум - Дата - Минимальное значение диапазона. По умолчанию равно 01.01.0001.
// Максимум - Дата - Максимальное значение диапазона. По умолчанию равно 31.12.3999.
//
// Возвращаемое значение:
// Дата - Случайная дата в указанном диапазоне.
//
// Пример:
// Результат = СлучайнаяДата(); // Результат будет содержать случайную дату в диапазоне от 01.01.0001 до 31.12.3999.
// Результат = СлучайнаяДата('01.01.2022', '31.12.2022'); // Результат будет содержать случайную дату в диапазоне от 01.01.2022 до 31.12.2022.
// Результат = СлучайнаяДата('01.01.2022', '01.01.2022'); // Результат будет содержать дату 01.01.2022.
// Результат = СлучайнаяДата('01.01.2022', '01.01.2021'); // Вызовет исключение "Некорректные параметры метода 'СлучайнаяДата': максимальное значение должно быть больше минимального".
Функция СлучайнаяДата(Знач Минимум = '00010101', Знач Максимум = '39991231') Экспорт
	
	Если Минимум = Максимум Тогда
		Возврат Минимум;
	ИначеЕсли Максимум < Минимум Тогда
		ВызватьИсключение ЮТИсключения.НекорректныеПараметрыМетода("СлучайнаяДата", "максимальное значение должно быть больше минимального");
	КонецЕсли;
	
	РазностьДат = Максимум - Минимум;
	
	Если РазностьДат <= МаксимумГенератора() Тогда
		Возврат Минимум + СлучайноеЧисло(0, РазностьДат);
	КонецЕсли;
	
	СекундВДне = 86400;
	КоличествоДней = Цел((РазностьДат) / СекундВДне);
	
	Возврат Минимум + СлучайноеЧисло(0, КоличествоДней) * СекундВДне + СлучайноеЧисло(0, СекундВДне);
	
КонецФункции

// Возвращает случайное время в формате "Время".
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Возвращаемое значение:
//  Дата - Случайное время
Функция СлучайноеВремя() Экспорт
	
	СекундВСутках = 60*60*24;
	
	Возврат '00010101000000' + СлучайноеЧисло(0, СекундВСутках - 1);
	
КонецФункции

// Возвращает случайную дату в будущем, начиная с текущей даты и с учетом указанного интервала.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Интервал - Число - Значение интервала, который будет использован для генерации случайной даты. По умолчанию равно неопределенному значению.
// ТипИнтервала - Строка - Тип интервала, который будет использован для генерации случайной даты. Возможные значения
//                 * секунда, секунды, секунд
//                 * минута, минуты, минут
//                 * час, часа, часов
//                 * день, дня, дней
//                 * месяц, месяца, месяцев
//
// Возвращаемое значение:
// Дата - Случайная дата в будущем, начиная с текущей даты и с учетом указанного интервала.
//
// Пример:
// Результат = СлучайнаяДатаВБудущем(30, "дней"); // Результат будет содержать случайную дату в будущем, начиная с текущей даты и с учетом интервала в 30 дней.
// Результат = СлучайнаяДатаВБудущем(1, "месяца"); // Результат будет содержать случайную дату в будущем, начиная с текущей даты и с учетом интервала в 1 месяц.
// Результат = СлучайнаяДатаВБудущем(1, "года"); // Результат будет содержать случайную дату в будущем, начиная с текущей даты и с учетом интервала в 1 год.
// Результат = СлучайнаяДатаВБудущем(); // Результат будет содержать случайную дату в будущем, начиная с текущей даты.
Функция СлучайнаяДатаВБудущем(Интервал = Неопределено, ТипИнтервала = Неопределено) Экспорт
	
	//@skip-check use-non-recommended-method
	Возврат СлучайнаяДатаПосле(ТекущаяДата(), Интервал, ТипИнтервала);
	
КонецФункции

// Возвращает случайную дату в прошлом, начиная с текущей даты и с учетом указанного интервала.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Интервал - Число - Значение интервала, который будет использован для генерации случайной даты. По умолчанию равно неопределенному значению.
// ТипИнтервала - Строка - Тип интервала, который будет использован для генерации случайной даты. Возможные значения
//                 * секунда, секунды, секунд
//                 * минута, минуты, минут
//                 * час, часа, часов
//                 * день, дня, дней
//                 * месяц, месяца, месяцев
//
// Возвращаемое значение:
// Дата - Случайная дата в прошлом, начиная с текущей даты и с учетом указанного интервала.
//
// Пример:
// Результат = СлучайнаяДатаВПрошлом(30, "дней"); // Результат будет содержать случайную дату в прошлом, начиная с текущей даты и с учетом интервала в 30 дней.
// Результат = СлучайнаяДатаВПрошлом(1, "месяца"); // Результат будет содержать случайную дату в прошлом, начиная с текущей даты и с учетом интервала в 1 месяц.
// Результат = СлучайнаяДатаВПрошлом(1, "года"); // Результат будет содержать случайную дату в прошлом, начиная с текущей даты и с учетом интервала в 1 год.
// Результат = СлучайнаяДатаВПрошлом(); // Результат будет содержать случайную дату в прошлом, начиная с текущей даты.
Функция СлучайнаяДатаВПрошлом(Интервал = Неопределено, ТипИнтервала = Неопределено) Экспорт
	
	//@skip-check use-non-recommended-method
	Возврат СлучайнаяДатаДо(ТекущаяДата(), Интервал, ТипИнтервала);
	
КонецФункции

// Возвращает случайную дату после указанной даты и с учетом указанного интервала.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Дата - Дата - Начальная дата для генерации случайной даты.
// Интервал - Число - Значение интервала, который будет использован для генерации случайной даты. По умолчанию равно неопределенному значению.
// ТипИнтервала - Строка - Тип интервала, который будет использован для генерации случайной даты. Возможные значения 
//                 * секунда, секунды, секунд
//                 * минута, минуты, минут
//                 * час, часа, часов
//                 * день, дня, дней
//                 * месяц, месяца, месяцев
// Возвращаемое значение:
// Дата - Случайная дата после указанной даты и с учетом указанного интервала.
//
// Пример:
// Результат = СлучайнаяДатаПосле('01.01.2022', 30, "дней"); // Результат будет содержать случайную дату после 01.01.2022 и с учетом интервала в 30 дней.
// Результат = СлучайнаяДатаПосле('01.01.2022', 1, "месяца"); // Результат будет содержать случайную дату после 01.01.2022 и с учетом интервала в 1 месяц.
// Результат = СлучайнаяДатаПосле('01.01.2022', 1, "года"); // Результат будет содержать случайную дату после 01.01.2022 и с учетом интервала в 1 год.
// Результат = СлучайнаяДатаПосле('01.01.2022'); // Результат будет содержать случайную дату после 01.01.2022.
Функция СлучайнаяДатаПосле(Дата, Интервал = Неопределено, ТипИнтервала = Неопределено) Экспорт
	
	ИнтервалНеУказан = Интервал = Неопределено И ТипИнтервала = Неопределено;
	
	Если ИнтервалНеУказан Тогда
		Возврат СлучайнаяДата(Дата + 1);
	Иначе
		Минимум = Дата + 1;
		Максимум = ЮТОбщий.ДобавитьКДате(Дата, Интервал, ТипИнтервала);
		Возврат СлучайнаяДата(Минимум, Максимум);
	КонецЕсли;
	
КонецФункции

// Возвращает случайную дату до указанной даты и с учетом указанного интервала.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Дата - Дата - Конечная дата для генерации случайной даты.
// Интервал - Число - Значение интервала, который будет использован для генерации случайной даты. По умолчанию равно неопределенному значению.
// ТипИнтервала - Строка - Тип интервала, который будет использован для генерации случайной даты. Возможные значения
//                 * секунда, секунды, секунд
//                 * минута, минуты, минут
//                 * час, часа, часов
//                 * день, дня, дней
//                 * месяц, месяца, месяцев
//
// Возвращаемое значение:
// Дата - Случайная дата до указанной даты и с учетом указанного интервала.
//
// Пример:
// Результат = СлучайнаяДатаДо('01.01.2022', 30, "дней"); // Результат будет содержать случайную дату до 01.01.2022 и с учетом интервала в 30 дней.
// Результат = СлучайнаяДатаДо('01.01.2022', 1, "месяца"); // Результат будет содержать случайную дату до 01.01.2022 и с учетом интервала в 1 месяц.
// Результат = СлучайнаяДатаДо('01.01.2022', 1, "года"); // Результат будет содержать случайную дату до 01.01.2022 и с учетом интервала в 1 год.
// Результат = СлучайнаяДатаДо('01.01.2022'); // Результат будет содержать случайную дату до 01.01.2022.
Функция СлучайнаяДатаДо(Дата, Интервал = Неопределено, ТипИнтервала = Неопределено) Экспорт
	
	ИнтервалНеУказан = Интервал = Неопределено И ТипИнтервала = Неопределено;
	
	Если ИнтервалНеУказан Тогда
		Возврат СлучайнаяДата(, Дата - 1);
	Иначе
		Минимум = ЮТОбщий.ДобавитьКДате(Дата, -Интервал, ТипИнтервала);
		Максимум = Дата - 1;
		Возврат СлучайнаяДата(Минимум, Максимум);
	КонецЕсли;
	
КонецФункции

// Возвращает случайный IP-адрес.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Возвращаемое значение:
// Строка - Случайный IP-адрес в формате "XXX.XXX.XXX.XXX".
//
// Пример:
// Результат = СлучайныйIPАдрес(); // Результат будет содержать случайный IP-адрес в формате "XXX.XXX.XXX.XXX".
Функция СлучайныйIPАдрес() Экспорт
	
	Части = Новый Массив();
	Части.Добавить(СлучайноеЧисло(1, 253));
	Части.Добавить(СлучайноеЧисло(1, 253));
	Части.Добавить(СлучайноеЧисло(1, 253));
	Части.Добавить(СлучайноеЧисло(1, 253));
	
	Возврат СтрСоединить(Части, ".");
	
КонецФункции

// Возвращает случайное значение из указанного списка.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Список - Массив из Произвольный - Список значений, из которых будет выбрано случайное значение.
//
// Возвращаемое значение:
// Произвольный - Случайное значение из указанного списка.
//
// Пример:
// Список = Новый Массив("Аптека", "Магазин", "Кафе", "Ресторан");
// Результат = СлучайноеЗначениеИзСписка(Список); // Результат будет содержать одно из значений из списка ("Аптека", "Магазин", "Кафе", "Ресторан").
Функция СлучайноеЗначениеИзСписка(Список) Экспорт
	
	Индекс = СлучайноеЧисло(0, Список.ВГраница());
	
	Возврат Список[Индекс];
	
КонецФункции

// Возвращает случайное булево значение (Истина или Ложь).
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Возвращаемое значение:
// Булево - Случайное булево значение (Истина или Ложь).
//
// Пример:
// Результат = СлучайноеБулево(); // Результат будет содержать одно из значений: Истина или Ложь.
Функция СлучайноеБулево() Экспорт
	
	Возврат СлучайноеЧисло() % 2 = 0;
	
КонецФункции

// Возвращает случайное значение перечисления.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
//  Перечисление - ПеречислениеМенеджер - Менеджер перечисления.
//               - Строка - мя объекта метаданных перечисления.
// 
// Возвращаемое значение:
// ПеречислениеСсылка - Случайное значение перечисления.
// 
// Пример:
// Перечисление = Перечисления.Пол;
// Результат = СлучайноеЗначениеПеречисления(Перечисление); // Результат будет содержать одно из значений перечисления "Пол" (Мужской, Женский).
Функция СлучайноеЗначениеПеречисления(Перечисление) Экспорт
	
	Возврат ЮТТестовыеДанныеСлужебныйВызовСервера.СлучайноеЗначениеПеречисления(Перечисление);
	
КонецФункции

// Возвращает случайное предопреленное значения объекта конфигурации.
// 
// Параметры:
//  Менеджер - Строка - Имя менеджера. Примеры: "Справочники.ВидыЦен", "Справочник.ВидыЦен"
//           - Произвольный - Менеджер объекта метаданных. Примеры: Справочники.ВидыЦен
//  Отбор - Структура, Соответствие из Произвольный - Отбора поиска предопределенных значений (сравнение на равенство)
// 
// Возвращаемое значение:
//  СправочникСсылка - Случайное предопределенное значение объекта конфигурации.
//
// Пример:
// Менеджер = "Справочники.ВидыЦен";
// Отбор = Новый Соответствие;
// Отбор.Вставить("ПометкаУдаления", "Ложь");
// Результат = СлучайноеПредопределенноеЗначение(Менеджер, Отбор); // Результат будет содержать одно из предопределенных значений
//                                                                 // объекта конфигурации "ВидыЦен" непомеченное на удаление".
Функция СлучайноеПредопределенноеЗначение(Менеджер, Отбор = Неопределено) Экспорт
	
	Возврат ЮТТестовыеДанныеСлужебныйВызовСервера.СлучайноеПредопределенноеЗначение(Менеджер, Отбор);
	
КонецФункции

// Возвращает случайный номер телефона в формате "+КодСтраны(XXX)XXX-XX-XX".
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// КодСтраны - Строка - Код страны по умолчанию "7".
//
// Возвращаемое значение:
// Строка - Случайный номер телефона в формате "+КодСтраны(XXX)XXX-XX-XX".
//
// Пример:
// Результат = СлучайныйНомерТелефона(); // Результат будет содержать случайный номер телефона в формате "+7(XXX)XXX-XX-XX".
// Результат = СлучайныйНомерТелефона("666"); // Результат будет содержать случайный номер телефона в формате "+666(XXX)XXX-XX-XX".
Функция СлучайныйНомерТелефона(КодСтраны = "7") Экспорт
	Результат = СтрШаблон(
		"+%1(%2)%3-%4-%5",
		?(ПустаяСтрока(КодСтраны), "7", КодСтраны),
		Формат(СлучайноеЧисло(0, 999), "ЧЦ=3; ЧН=000; ЧВН=; ЧГ=0;"),
		Формат(СлучайноеЧисло(0, 999), "ЧЦ=3; ЧН=000; ЧВН=; ЧГ=0;"),
		Формат(СлучайноеЧисло(0, 99), "ЧЦ=2; ЧН=00; ЧВН=; ЧГ=0;"),
		Формат(СлучайноеЧисло(0, 99), "ЧЦ=2; ЧН=00; ЧВН=; ЧГ=0;")
	);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

// Возвращает уникальную строку на основе префикса и уникального идентификатора.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Префикс - Строка - Префикс уникальной строки. По умолчанию равно пустой строке.
//
// Возвращаемое значение:
// Строка - Уникальная строка на основе префикса и уникального идентификатора.
//
// Пример:
// Результат = УникальнаяСтрока(); // Результат будет содержать уникальную строку на основе уникального идентификатора.
// Результат = УникальнаяСтрока("Префикс_"); // Результат будет содержать уникальную строку на основе префикса "Префикс_" и уникального идентификатора.
Функция УникальнаяСтрока(Префикс = "") Экспорт
	
	Возврат Префикс + Новый УникальныйИдентификатор();
	
КонецФункции

#Если Не ВебКлиент Тогда
	
// Возвращает путь к созданному временному файлу с указанным содержимым и расширением.
//
// Параметры:
// Содержимое - Неопределено, Строка - Содержимое файла.
// ТолькоЧтение - Булево - Если значение равно Истина, то файл будет создан в режиме только для чтения. По умолчанию равно Ложь.
// Расширение - Неопределено, Строка - Расширение файла.
//
// Возвращаемое значение:
// Строка - Путь к новому временному файлу с указанным содержимым и расширением.
//
// Пример:
// Результат = НовыйФайл("Содержимое файла"); // Результат будет содержать путь к новому временному файлу с содержимым "Содержимое файла".
Функция НовыйФайл(Содержимое = Неопределено, ТолькоЧтение = Ложь, Расширение = Неопределено) Экспорт
	
	Результат = НовоеИмяВременногоФайла(Расширение);
	
	ЗаписьДанных = Новый ЗаписьДанных(Результат);
	
	Если Содержимое <> Неопределено Тогда
		ЗаписьДанных.ЗаписатьСимволы(Содержимое);
	КонецЕсли;
	
	ЗаписьДанных.Закрыть();
	
	Если ТолькоЧтение Тогда
		СозданныйФайл = Новый Файл(Результат);
		СозданныйФайл.УстановитьТолькоЧтение(Истина);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции
	
// Возвращает уникальное имя временного файла с указанным расширением.
//
// Параметры:
// Расширение - Неопределено, Строка - Расширение файла.
//
// Возвращаемое значение:
// Строка - Уникальное имя временного файла с указанным расширением.
//
// Пример:
// Результат = НовоеИмяВременногоФайла("txt"); // Результат будет содержать уникальное имя временного файла с расширением "txt".
// Результат = НовоеИмяВременногоФайла(); // Результат будет содержать уникальное имя временного файла без расширения.
Функция НовоеИмяВременногоФайла(Расширение = Неопределено) Экспорт
	
	Возврат ЮТТестовыеДанныеСлужебный.НовоеИмяВременногоФайла(Расширение);
	
КонецФункции

// Возвращает массив структур, содержащих данные из таблицы Markdown.
//
// Параметры:
// Строки - Строка - Строка в формате Markdown, содержащая таблицу.
//
// Возвращаемое значение:
// Массив из Структура - Массив структур, содержащих данные из таблицы Markdown.
//
// Пример:
// Строки = "| Заголовок1 | Заголовок2 |
//          || --- | --- |
//          || Значение 1 | Значение 2 |
//          || Значение 3 | Значение 4 |";
// Результат = ТаблицаMarkDown(Строки); // Результат будет содержать массив структур(Заголовок1, Заголовок2), содержащих данные из таблицы Markdown.
Функция ТаблицаMarkDown(Строки) Экспорт
	
	ЗагрузилиЗаголовок = Ложь;
	Результат = Новый Массив();
	Ключи = "";
	
	Разделитель = "|";
	
	Кодировка = КодировкаТекста.UTF8;
	Поток = ПолучитьДвоичныеДанныеИзСтроки(Строки, Кодировка).ОткрытьПотокДляЧтения();
	Чтение = Новый ЧтениеТекста(Поток, Кодировка);
	
	Пока Истина Цикл
		
		Строка = Чтение.ПрочитатьСтроку();
		Если Строка = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Строка = СокрЛП(Строка);
		
		Если ПустаяСтрока(Строка) Тогда
			Продолжить;
		ИначеЕсли НЕ СтрНачинаетсяС(Строка, Разделитель) Тогда
			Если ЗагрузилиЗаголовок Тогда
				Прервать;
			Иначе
				Продолжить;
			КонецЕсли;
		КонецЕсли;
		
		Блоки = СтрРазделить(Строка, Разделитель);
		
		Если ЗагрузилиЗаголовок Тогда
			
			Если Блоки.Количество() <> Ключи.Количество() Тогда
				ВызватьИсключение СтрШаблон("Количество значений в строке (%1) Markdown не совпадает с количеством заголовков (%2):
											|%3", Блоки.Количество(), Ключи.Количество(), Строка);
			КонецЕсли;
			
			СтрокаРезультата = Новый Структура();
			Для Инд = 1 По Блоки.ВГраница() - 1 Цикл
				СтрокаРезультата.Вставить(Ключи[Инд], СокрЛП(Блоки[Инд]));
			КонецЦикла;
			Результат.Добавить(СтрокаРезультата);
		Иначе
			Ключи = Новый Массив();
			Для Инд = 0 По Блоки.ВГраница() Цикл
				Ключи.Добавить(СокрЛП(Блоки[Инд]));
			КонецЦикла;
			Чтение.ПрочитатьСтроку(); // Пропуск строки разделителя
			ЗагрузилиЗаголовок = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	Чтение.Закрыть();
	Поток.Закрыть();
	
	Возврат Результат;
	
КонецФункции

// Возвращает структуру, содержащую данные из таблицы Markdown, где ключом является значение указанного столбца.
//
// Ограничения:
// - Метод недоступен в веб-клиенте.
//
// Параметры:
// Ключ - Строка - Название столбца, значение которого будет использовано в качестве ключа в возвращаемой структуре.
// Строки - Строка - Строка в формате Markdown, содержащая таблицу.
//
// Возвращаемое значение:
// Структура - Структура, содержащая данные из таблицы Markdown, где ключом является значение указанного столбца.
//
// Пример:
// Строки = "| Заголовок1 | Заголовок2 |
//          || --- | --- |
//          || Значение 1 | Значение 2 |
//          || Значение 3 | Значение 4 |";
// Результат = СтруктураMarkDown("Заголовок1", Строки); // Результат будет содержать структуру, содержащую данные из таблицы Markdown, где ключом является значение столбца "Заголовок1".
Функция СтруктураMarkDown(Ключ, Строки) Экспорт
	
	Таблица = ТаблицаMarkDown(Строки);
	
	Результат = Новый Структура();
	
	Для Каждого Строка Из Таблица Цикл
		Результат.Вставить(Строка[Ключ], Строка);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

#КонецЕсли

// Формирует массив различных комбинаций параметров
// 
// Предназначено для формирования таблицы возможных значений параметров для краш теста метода.
// 
// Параметры:
//  ЗначенияПоУмолчанию - Структура - Значения параметров по умолчанию.
//  ЗначенияПараметров - Структура - Массивы значений для каждого параметра.
// 
// Возвращаемое значение:
//  Массив из Структура - Варианты параметров.
Функция ВариантыПараметров(ЗначенияПоУмолчанию, ЗначенияПараметров) Экспорт
	
	Варианты = Новый Массив;
	Варианты.Добавить(ЗначенияПоУмолчанию);
	
	Ключи = ЮТКоллекции.ВыгрузитьЗначения(ЗначенияПараметров, "Ключ");
	
	ДобавитьВарианты(Варианты, ЗначенияПоУмолчанию, ЗначенияПараметров, Ключи, 0);
	
	Возврат Варианты;
	
КонецФункции

// Возвращает конструктор создания тестовых данных для указанного объекта метаданных.
//
// Конструктор имеет ряд особенностей:
// 
// * Создание объекта происходит при вызове методов `Записать` и `Провести`, а создание реквизитов происходит во время вызова методов установки.
// * При использовании на клиенте все значения должны быть сериализуемыми.
// 
// Параметры:
//  Менеджер - Строка - Имя менеджера объекта метаданных. Примеры: "Справочники.Товары", "Документы.ПриходТоваров".
//           - Произвольный - Менеджер объекта метаданных. Примеры: Справочники.Товары, Документы.ПриходТоваров
// 
// Возвращаемое значение:
// ОбработкаОбъект.ЮТКонструкторТестовыхДанных - Конструктор создания тестовых данных для указанного объекта метаданных.
//
// Пример:
// Конструктор = КонструкторОбъекта("Справочники.Товары");
// Конструктор.Установить("Наименование", "Товар 1");
// Конструктор.Установить("Цена", 100);
// Конструктор.Записать(); // Создает товар с наименованием "Товар 1" и ценой 100.
//
// Конструктор = КонструкторОбъекта(Документы.ПриходТоваров);
// Конструктор.Установить("Организация", Справочники.Организации.ПустаяСсылка());
// Конструктор.Установить("Склад", Справочники.Склады.ПустаяСсылка());
// Конструктор.Установить("Товар", Справочники.Товары.ПустаяСсылка());
// Конструктор.Установить("Количество", 10);
// Конструктор.Провести(); // Создает документ прихода товаров с указанными реквизитами и проводит его.
Функция КонструкторОбъекта(Менеджер) Экспорт
	
	Возврат ЮТКонструкторТестовыхДанныхСлужебный.Инициализировать(Менеджер);
	
КонецФункции

#Если Сервер Или ТолстыйКлиентОбычноеПриложение  Тогда
// Возвращает конструктор создания объекта XDTO.
//
// Параметры:
// ИмяТипа - Строка - Имя типа объекта XDTO.
// ПространствоИмен - Строка - Пространство имен типа объекта XDTO.
// Фабрика - ФабрикаXDTO - Фабрика, используемая для создания объектов XDTO. По умолчанию используется стандартная фабрика XDTO.
//
// Возвращаемое значение:
// ОбработкаОбъект.ЮТКонструкторОбъектаXDTO - Конструктор объекта XDTO.
//
// Пример:
// Конструктор = КонструкторОбъектаXDTO("Товар", "http://example.com/namespace", Новый ФабрикаXDTO());
// Конструктор.Установить("Наименование", "Товар 1");
// Конструктор.Установить("Цена", 100);
// Объект = Конструктор.ПолучитьОбъект(); // Создает объект XDTO с указанными реквизитами.
//
// Конструктор = КонструкторОбъектаXDTO("ДокументПриходТоваров", "http://example.com/namespace");
// Конструктор.Установить("Организация", Справочники.Организации.ПустаяСсылка());
// Конструктор.Установить("Склад", Справочники.Склады.ПустаяСсылка());
// Конструктор.Установить("Товар", Справочники.Товары.ПустаяСсылка());
// Конструктор.Установить("Количество", 10);
// Объект = Конструктор.ПолучитьОбъект(); // Создает объект XDTO с указанными реквизитами.
Функция КонструкторОбъектаXDTO(ИмяТипа, ПространствоИмен, Фабрика = Неопределено) Экспорт
	
	Обработка = Обработки.ЮТКонструкторОбъектаXDTO.Создать();
	Обработка.Инициализировать(ИмяТипа, ПространствоИмен, Фабрика);
	
	Возврат Обработка;
	
КонецФункции
#КонецЕсли

// Удаляет переданные объекта
// 
// Параметры:
// Ссылки - Массив из ЛюбаяСсылка - Массив ссылок на объекты, которые необходимо удалить.
// Привилегированно - Булево - Выполнить удаление в привилегированном режиме (без учета прав на объекты)
Процедура Удалить(Ссылки, Привилегированно = Ложь) Экспорт

	Если ЗначениеЗаполнено(Ссылки) Тогда
		ЮТТестовыеДанныеСлужебныйВызовСервера.Удалить(Ссылки, Привилегированно);
	КонецЕсли;

КонецПроцедуры

// Возвращает объект подражателя для формирования осмысленных тестовых данных
//
// Возвращаемое значение:
//  ОбщийМодуль - Подражатель
Функция Подражатель() Экспорт
	
	Возврат ЮТПодражательСлужебный.Инициализировать();
	
КонецФункции

// Возвращает таблицу значений из табличного документа
// 
// Параметры:
//  Макет - ТабличныйДокумент - Исходный табличный документ
//  ОписанияТипов - Соответствие из ОписаниеТипов - Соответствие имен колонок таблицы к типам значений
//  КэшЗначений - Соответствие из Произвольный - Соответствие для хранения создаваемых значений
//  ЗаменяемыеЗначения - Соответствие из Произвольный - Значения, использующиеся для замены
//  ПараметрыСозданияОбъектов - см. ЮТФабрика.ПараметрыСозданияОбъектов
// Возвращаемое значение:
//  - ТаблицаЗначений - Для сервера, данные загруженные из макета
//  - Массив из Структура - Для клиента, данные загруженные из макета
Функция ЗагрузитьИзМакета(Макет,
						  ОписанияТипов,
						  КэшЗначений = Неопределено,
						  ЗаменяемыеЗначения = Неопределено,
						  ПараметрыСозданияОбъектов = Неопределено) Экспорт
	
#Если Сервер Тогда
	ТаблицаЗначений = Истина;
#Иначе
	ТаблицаЗначений = Ложь;
#КонецЕсли
	
	Если Макет = Неопределено Тогда
		ВызватьИсключение "Укажите источник данных (Макет)";
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ОписанияТипов) Тогда
		ВызватьИсключение "Укажите описание загружаемых колонок (ОписанияТипов)";
	КонецЕсли;
	
	ЮТПроверкиСлужебный.ПроверитьТипПараметра(ОписанияТипов, "Структура, Соответствие", "ЮТТестовыеДанные.ЗагрузитьИзМакета", "ОписанияТипов");
	
	Возврат ЮТТестовыеДанныеСлужебный.ЗагрузитьИзМакета(Макет,
														ОписанияТипов,
														КэшЗначений,
														ЗаменяемыеЗначения,
														ПараметрыСозданияОбъектов,
														ТаблицаЗначений);
	
КонецФункции

#Если Сервер Тогда
// Возвращает мок для `HTTPСервисЗапрос`.
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPСервисЗапрос - Мок
Функция HTTPСервисЗапрос() Экспорт
	
	Если ЮТОбщийСлужебныйВызовСервера.ЭтоАнглийскийВстроенныйЯзык() Тогда
		Возврат Обработки.ЮТHTTPServiceRequest.Создать();
	Иначе
		Возврат Обработки.ЮТHTTPСервисЗапрос.Создать();
	КонецЕсли;
	
КонецФункции
#КонецЕсли

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Тогда
// Возвращает мок для ADO.RecordSet.
// 
// Параметры:
//  Колонки - Строка - Имена колонок набора данных, разделенные запятой
//  Описание - Строка - Описание, полезно для отладки и проверки
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТRecordSet - Мок ADO.RecordSet
Функция ADORecordSet(Колонки, Описание = Неопределено) Экспорт
	
	Обработка = Обработки.ЮТRecordSet.Создать();
	Обработка.Описание = Описание;
	Обработка.Инициализировать(Колонки);
	
	Возврат Обработка;
	
КонецФункции
#КонецЕсли

// Устанавливает значение реквизита ссылки
// 
// Параметры:
//  Ссылка - ЛюбаяСсылка
//  ИмяРеквизита - Строка
//  ЗначениеРеквизита - Произвольный
//  ПараметрыЗаписи - см. ЮТФабрикаСлужебный.ПараметрыЗаписи
Процедура УстановитьЗначениеРеквизита(Ссылка, ИмяРеквизита, ЗначениеРеквизита, ПараметрыЗаписи = Неопределено) Экспорт
	
	Значения = Новый Соответствие();
	Значения.Вставить(ИмяРеквизита, ЗначениеРеквизита);
	УстановитьЗначенияРеквизитов(Ссылка, Значения, ПараметрыЗаписи);
	
КонецПроцедуры

// Устанавливает значения реквизитов ссылки.
// 
// Параметры:
//  Ссылка - ЛюбаяСсылка -  Ссылка
//  ЗначенияРеквизитов - Структура, Соответствие из Произвольный -  Значения реквизитов
//  ПараметрыЗаписи - см. ЮТФабрикаСлужебный.ПараметрыЗаписи
Процедура УстановитьЗначенияРеквизитов(Ссылка, ЗначенияРеквизитов, ПараметрыЗаписи = Неопределено) Экспорт
	
	ЮТТестовыеДанныеСлужебныйВызовСервера.УстановитьЗначенияРеквизитов(Ссылка, ЗначенияРеквизитов);
	
КонецПроцедуры

// Генерирует новое значение указанного типа.
//  Если `ОписаниеТипа` содержит несколько типов, то выбирается случайный из них.
// Параметры:
//  ОписаниеТипа - ОписаниеТипов, Тип - Тип значения генерируемого значения
//  РеквизитыЗаполнения - Структура - Значения реквизитов заполнения создаваемого объекта базы
//                      - Неопределено
// 
// Возвращаемое значение:
//  Произвольный - Сгенерированное значение указанного типа
Функция Фикция(ОписаниеТипа, РеквизитыЗаполнения = Неопределено) Экспорт
	
	Возврат ЮТТестовыеДанныеСлужебный.Фикция(ОписаниеТипа, РеквизитыЗаполнения);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьВарианты(Варианты, БазоваяСтруктура, ЗначенияПараметров, Ключи, Инд)
	
	Если Инд > Ключи.ВГраница() Тогда
		Возврат;
	КонецЕсли;
	
	Ключ = Ключи[Инд];
	Для Каждого Значение Из ЗначенияПараметров[Ключ] Цикл
		
		Вариант = ЮТКоллекции.СкопироватьСтруктуру(БазоваяСтруктура);
		Вариант[Ключ] = Значение;
		Варианты.Добавить(Вариант);
		
		ДобавитьВарианты(Варианты, Вариант, ЗначенияПараметров, Ключи, Инд + 1);
		
	КонецЦикла;

КонецПроцедуры

Функция МаксимумГенератора()
	
	Возврат 4294967295;
	
КонецФункции

#КонецОбласти
