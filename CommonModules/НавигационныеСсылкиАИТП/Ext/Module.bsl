﻿/////////////////////////////////////////////////////////////////////
//
// Функции генерации навигационных ссылок
//
////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Формирует Url для доступа к объекту из web-клиента
//
// Параметры:
//  Объект	 - ОбъектСсылка	 - ссылка на объект информационной базы, для которого формируется навигационная ссылка
// 
// Возвращаемое значение:
//   - Строка - url для доступа к объекту по http
//
Функция ПолучитьUrl(Объект) Экспорт

	UrlWebПубликации = Константы.UrlWebПубликацииАИТП.Получить();
	
	Если Не Прав(UrlWebПубликации, 1) = "/" Тогда
		
		UrlWebПубликации = UrlWebПубликации + "/";
	
	КонецЕсли;
	
	UrlWebПубликации = UrlWebПубликации + "#";
	
	Возврат  UrlWebПубликации + ПолучитьНавигационнуюСсылку(Объект); 

КонецФункции // ПолучитьUrl()

#КонецОбласти