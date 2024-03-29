﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("Предмет") Тогда 
		Предмет = Параметры.Предмет;
		Список.Параметры.УстановитьЗначениеПараметра("Предмет", Предмет);
	КонецЕсли;	
	
	Список.Параметры.УстановитьЗначениеПараметра("Пользователь", ПользователиАИТП.ТекущийПользователь());
	Если ТипЗнч(Предмет) = Тип("ЗадачаСсылка.ЗадачаАИТП") Тогда
		Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьЗаметкиДругихПользователей", Истина);
		ПоказыватьЗаметкиДругихПользователей = Истина;
	Иначе
		Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьЗаметкиДругихПользователей", Истина);
	КонецЕсли;
	
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьУдаленные", Ложь);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьЗаметкиДругихПользователей", ПоказыватьЗаметкиДругихПользователей);
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьУдаленные", ПоказыватьУдаленные);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоказыватьЗаметкиДругихПользователейПриИзменении(Элемент)
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьЗаметкиДругихПользователей", ПоказыватьЗаметкиДругихПользователей);
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьУдаленныеПриИзменении(Элемент)
	Список.Параметры.УстановитьЗначениеПараметра("ПоказыватьУдаленные", ПоказыватьУдаленные);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
	ПараметрыФормы = Новый Структура("Предмет", Предмет);
	ОткрытьФорму("Справочник.ЗаметкиАИТП.ФормаОбъекта", ПараметрыФормы);
КонецПроцедуры

#КонецОбласти
