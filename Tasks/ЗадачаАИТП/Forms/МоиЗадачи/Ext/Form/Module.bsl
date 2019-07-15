﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
	Список.Параметры.УстановитьЗначениеПараметра("ТекущийПользователь", ПараметрыСеанса.ТекущийПользовательАИТП);
	Список.Параметры.УстановитьЗначениеПараметра("ПустойИсполнитель", Справочники.ПользователиАИТП.ПустаяСсылка());
	Список.Параметры.УстановитьЗначениеПараметра("ПустаяГруппа", Справочники.ГруппыАдресацииЗадачАИТП.ПустаяСсылка());

КонецПроцедуры

#КонецОбласти