﻿/////////////////////////////////////////////////////////////////////////////////////////
//
// Переопределяемые функции обработки ошибок при выполнении действий
//
/////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик ошибки ПередВыполнениемДействи(й)я
//
// Параметры:
//  ТочкаМаршрута		 - ТочкаМаршрутаБизнесПроцесса - точка маршрута бизнес-процесса 
//  Ошибка				 - ДокументСсылка.ОшибкиВыполненияАИТП - ссылка на документ, описывающий ошибку 
//  СтандартнаяОбработка - Булево - признак использования стандартной обработки ошибок 
//
Процедура ОбработатьОшибкуПередВыполнениемДействий(ТочкаМаршрута, Ошибка, СтандартнаяОбработка) Экспорт
	
	
КонецПроцедуры

// Обработчик ошибки ПриВыполненииДействия
//
// Параметры:
//  ТочкаМаршрута		 - ТочкаМаршрутаБизнесПроцесса - точка маршрута бизнес-процесса 
//  Задача				 - ЗадачаСсылка.ЗадачаАИТП - задача, при выполнении которой произошла ошибка 
//  Ошибка				 - ДокументСсылка.ОшибкиВыполненияАИТП - ссылка на документ, описывающий ошибку 
//  СтандартнаяОбработка - Булево - признак использования стандартной обработки ошибки 
//
Процедура ОбработатьОшибкуПриВыполненииДействия(ТочкаМаршрута, Задача, Ошибка, СтандартнаяОбработка) Экспорт
	
	
КонецПроцедуры

// Обработчик ошибки ПослеВыполнениемДействи(й)я
//
// Параметры:
//  ТочкаМаршрута		 - ТочкаМаршрутаБизнесПроцесса - точка маршрута бизнес-процесса 
//  Ошибка				 - ДокументСсылка.ОшибкиВыполненияАИТП - ссылка на документ, описывающий ошибку 
//  СтандартнаяОбработка - Булево - признак использования стандартной обработки 
//
Процедура ОбработатьОшибкуПослеВыполненияДействий(ТочкаМаршрута, Ошибка, СтандартнаяОбработка) Экспорт

КонецПроцедуры

#КонецОбласти