﻿//////////////////////////////////////////////////////////////////////////////////////////
//
// Переопределяемые функции для отправки оповещений пользователям
//
/////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Процедура - Определить получателей оповещения
//
// Параметры:
//  ПолучателиОповещения - Массив -список получателей оповещения 
//  ПараметрыОповещения	 - Структура - содержит параметры оповещения 
//  СтандартнаяОбработка - Булево - признак использования стандартной обработки 
//
Процедура ОпределитьПолучателейОповещения(ПолучателиОповещения, ПараметрыОповещения, СтандартнаяОбработка) Экспорт
	
	// Переопределяемое добавление получателей в массив
	
	
КонецПроцедуры

// Процедура - Оповестить пользователей
//
// Параметры:
//  ПолучателиОповещения - Массив - список получателей оповещения 
//  ПараметрыОповещения	 - Структура -  содержит параметры оповещения 
//  СтандартнаяОбработка - Булево - признак использования стандартной обработки 
//
Процедура ОповеститьПользователей(ПолучателиОповещения, ПараметрыОповещения, СтандартнаяОбработка) Экспорт
	
	// Переопределение отправки оповещений
	
КонецПроцедуры

#КонецОбласти

