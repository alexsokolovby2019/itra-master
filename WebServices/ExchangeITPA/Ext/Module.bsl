﻿
Функция SendMessage(SenderCode, Data, MessageID)
	// Вставить содержимое обработчика.
	Отправитель = Справочники.УзлыОбменаДаннымиАИТП.НайтиПоКоду(SenderCode);
	
	Если Отправитель.Пустая() Тогда
		ВызватьИсключение "Узел с кодом: " + SenderCode + " не найден в списке узлов";	
	КонецЕсли;
	
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(Data);
	Данные = ПрочитатьJSON(ЧтениеJSON, Истина);

	СтандартнаяОбработка = Истина;
	ОбменДаннымиПереопределяемыйАИТП.ОбработатьВходящееСообщение(Отправитель, MessageID, Данные, СтандартнаяОбработка);
	
	Если СтандартнаяОбработка = Истина Тогда
		ОбменДаннымиАИТП.ОбработатьВходящееСообщение(Отправитель, MessageID, Данные, СтандартнаяОбработка);
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции