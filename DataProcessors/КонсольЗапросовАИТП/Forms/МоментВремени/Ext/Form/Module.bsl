﻿#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОбработкаОбъект 			= ОбъектОбработки();
	Объект.ПутьКФормам 			= ОбработкаОбъект.Метаданные().ПолноеИмя() + ".Форма";

	// Считывание параметров передачи.
	ПараметрыПередачи 	= ПолучитьИзВременногоХранилища(Параметры.АдресХранилища);
	Объект.Запросы.Загрузить(ПараметрыПередачи.Запросы);	
	Объект.Параметры.Загрузить(ПараметрыПередачи.Параметры);
	Объект.ИмяФайла 	= ПараметрыПередачи.ИмяФайла;
	ИдентификаторТекущегоЗапроса 	= ПараметрыПередачи.ИдентификаторТекущегоЗапроса;
	ИдентификаторТекущегоПараметра	= ПараметрыПередачи.ИдентификаторТекущегоПараметра;
	
	Попытка   // Если форма открывается не из главной формы
		МоментВремени 	= ЗначениеИзСтрокиВнутр(Параметры.Значение);
		Дата 			= МоментВремени.Дата;
		Ссылка			= МоментВремени.Ссылка;
	Исключение
		ЗаполнитьЗначения();
	КонецПопытки;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	ВыгрузитьМоментВремениСервер();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ОбъектОбработки()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

&НаКлиенте
Процедура ВыгрузитьМоментВремениСервер()
	Владелец			= ЭтаФорма.ВладелецФормы;
	ИмяФормыВладельца 	= Владелец.ИмяФормы;
	ИмяОсновнойФормы 	= Объект.ПутьКФормам + ".Форма";
	
	Если  ИмяФормыВладельца = ИмяОсновнойФормы Тогда 
		ПараметрыПередачи = ПоместитьЗапросыВСтруктуру(ИдентификаторТекущегоЗапроса, ИдентификаторТекущегоПараметра);
		Закрыть(); 
		Владелец.Модифицированность = Истина;
		Оповестить("ВыгрузитьЗапросыВРеквизиты", ПараметрыПередачи);
	Иначе
		ПредставлениеМоментаВремени = "";
		ВнутрМоментВремени = ВнутрЗначениеОбъектаМВ(ПредставлениеМоментаВремени);
		Закрыть();
		ПараметрыПередачи = Новый Структура("ВнутрМоментВремени, ПредставлениеМоментаВремени",
			ВнутрМоментВремени, ПредставлениеМоментаВремени);
		Оповестить("ПолучениеМоментаВремени", ПараметрыПередачи);
	КонецЕсли;	
КонецПроцедуры	

&НаСервере
Функция ПоместитьЗапросыВСтруктуру(ИдентификаторЗапроса, ИдентификаторПараметра)
	ПараметрыФормы = Объект.Параметры;
	
	ПредставлениеМоментаВремени = "";
	Для каждого Стр из ПараметрыФормы Цикл
		Если Стр.Идентификатор = ИдентификаторТекущегоПараметра Тогда
			Стр.Тип		 		= "МоментВремени";
			Стр.Значение 		= ВнутрЗначениеОбъектаМВ(ПредставлениеМоментаВремени);
			Стр.ТипВФорме		= "Момент времени";
			Стр.ЗначениеВФорме	= ПредставлениеМоментаВремени;
		КонецЕсли;
	КонецЦикла;
		
	ПараметрыПередачи = Новый Структура;
	ПараметрыПередачи.Вставить("АдресХранилища", ОбъектОбработки().ПоместитьЗапросыВоВременноеХранилище(Объект,ИдентификаторЗапроса,ИдентификаторПараметра));
	Возврат ПараметрыПередачи;
КонецФункции	

&НаСервере
Функция ВнутрЗначениеОбъектаМВ(Представление)
	МоментВремени = Новый МоментВремени(Дата, Ссылка);	
	Представление = ОбъектОбработки().ФормированиеПредставленияЗначения(МоментВремени);
	
	Возврат ЗначениеВСтрокуВнутр(МоментВремени);
КонецФункции

&НаСервере
Процедура ЗаполнитьЗначения()
	ПарметрыФормы = Объект.Параметры;
	Для каждого ТекущийпПараметр из ПарметрыФормы Цикл 
		Если ТекущийпПараметр.Идентификатор = ИдентификаторТекущегоПараметра Тогда 
			Значение = ТекущийпПараметр.Значение;
			Если ПустаяСтрока(Значение) Тогда 
				Возврат;
			Иначе
				Прервать;
			КонецЕсли;
		КонецЕсли;	
	КонецЦикла;
	
	МоментВремени = ЗначениеИзСтрокиВнутр(Значение);
	Если ТипЗнч(МоментВремени) <> Тип("МоментВремени") Тогда 
		Возврат;
	КонецЕсли;
	
	Дата 	= МоментВремени.Дата;
	Ссылка 	= МоментВремени.Ссылка;
КонецПроцедуры	

#КонецОбласти