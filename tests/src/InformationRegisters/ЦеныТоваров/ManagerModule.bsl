
&Вместо("ЗаполненоКорректно")
Процедура Расш1_ЗаполненоКорректно(НаборЗаписей) Экспорт
	
	ПараметрыМетода = Мокито.МассивПараметров(НаборЗаписей);
	
	ПрерватьВыполнение = Ложь;
	Мокито.АнализВызова(РегистрыСведений.ЦеныТоваров, "ЗаполненоКорректно", ПараметрыМетода, ПрерватьВыполнение);
	
	Если НЕ ПрерватьВыполнение Тогда
		ПродолжитьВызов(НаборЗаписей);
	КонецЕсли;
	
КонецПроцедуры
