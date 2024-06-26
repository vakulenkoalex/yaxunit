//©///////////////////////////////////////////////////////////////////////////©//
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

&Вместо("ОпределитьТекущегоПользователя")
Процедура Расш1_ОпределитьТекущегоПользователя() Экспорт
	
	ПрерватьВыполнение = Ложь;
	Результат = Мокито.АнализВызова(Пользователи, "ОпределитьТекущегоПользователя", Новый Массив, ПрерватьВыполнение);
	
	Если НЕ ПрерватьВыполнение Тогда
		ПродолжитьВызов();
	КонецЕсли;
	
КонецПроцедуры
