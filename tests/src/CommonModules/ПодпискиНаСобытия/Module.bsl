
&Вместо("ПередЗаписьюДокумента")
Процедура Расш1_ПередЗаписьюДокумента(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	// Собираем параметры в массив
    ПараметрыМетода = Мокито.МассивПараметров(Источник, Отказ);

    // Отправляем данные на анализ
    ПрерватьВыполнение = Ложь;
    Результат = Мокито.АнализВызова(ПодпискиНаСобытия, "ПередЗаписьюДокумента", ПараметрыМетода, ПрерватьВыполнение);

    // Обрабатываем результат анализа
    Если НЕ ПрерватьВыполнение Тогда
        ПродолжитьВызов(Источник, Отказ);
    КонецЕсли;
    
КонецПроцедуры

&Вместо("ПередЗаписьюСправочника")
Процедура Расш1_ПередЗаписьюСправочника(Источник, Отказ) Экспорт
	
	// Собираем параметры в массив
    ПараметрыМетода = Мокито.МассивПараметров(Источник, Отказ);

    // Отправляем данные на анализ
    ПрерватьВыполнение = Ложь;
    Результат = Мокито.АнализВызова(ПодпискиНаСобытия, "ПередЗаписьюСправочника", ПараметрыМетода, ПрерватьВыполнение);

    // Обрабатываем результат анализа
    Если НЕ ПрерватьВыполнение Тогда
        ПродолжитьВызов(Источник, Отказ);
    КонецЕсли;

КонецПроцедуры
