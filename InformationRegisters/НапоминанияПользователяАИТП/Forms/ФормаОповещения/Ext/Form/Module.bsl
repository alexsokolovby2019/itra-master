﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	СрокПовторногоОповещения = "15м";
	СрокПовторногоОповещения = НапоминанияПользователяКлиентСерверАИТП.ОформитьВремя(СрокПовторногоОповещения);
	
	ОбновитьТаблицуНапоминаний();
	
	ЗаполнитьСрокиПовторногоНапоминания();
	
	ОбновитьВремяВТаблицеНапоминаний();
	ПодключитьОбработчикОжидания("ОбновитьВремяВТаблицеНапоминаний", 5);
	Активизировать();
КонецПроцедуры

&НаКлиенте
Процедура ПриПовторномОткрытии()
	ОбновитьТаблицуНапоминаний();
	ЭтотОбъект.ТекущийЭлемент = Элементы.СрокПовторногоОповещения;
	Активизировать();
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	ОтложитьАктивныеНапоминания();
	НапоминанияПользователяКлиентАИТП.СброситьТаймерПроверкиТекущихОповещений();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СрокПовторногоОповещенияПриИзменении(Элемент)
	СрокПовторногоОповещения = НапоминанияПользователяКлиентСерверАИТП.ОформитьВремя(СрокПовторногоОповещения);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыНапоминания

&НаКлиенте
Процедура НапоминанияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	ОткрытьНапоминание();
КонецПроцедуры

&НаКлиенте
Процедура НапоминанияПриАктивизацииСтроки(Элемент)
	
	Если Элемент.ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	Источник = Элемент.ТекущиеДанные.Источник;
	ИсточникСтрокой = Элемент.ТекущиеДанные.ИсточникСтрокой;
	
	ЕстьИсточник = ЗначениеЗаполнено(Источник);
	Элементы.НапоминанияКонтекстноеМенюОткрыть.Доступность = ЕстьИсточник;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Изменить(Команда)
	РедактироватьНапоминание();
КонецПроцедуры

&НаКлиенте
Процедура КомандаОткрыть(Команда)
	ОткрытьНапоминание();
КонецПроцедуры

&НаКлиенте
Процедура Отложить(Команда)
	ОтложитьАктивныеНапоминания();
КонецПроцедуры

&НаКлиенте
Процедура Прекратить(Команда)
	Если Элементы.Напоминания.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ИндексСтроки Из Элементы.Напоминания.ВыделенныеСтроки Цикл
		ДанныеСтроки = Напоминания.НайтиПоИдентификатору(ИндексСтроки);
	
		ПараметрыНапоминания = НапоминанияПользователяКлиентСерверАИТП.ПолучитьСтруктуруНапоминания(ДанныеСтроки);
		
		ОтключитьНапоминание(ПараметрыНапоминания);
		НапоминанияПользователяКлиентАИТП.УдалитьЗаписьИзКэшаОповещений(ДанныеСтроки);
	КонецЦикла;
	
	ОповеститьОбИзменении(Тип("РегистрСведенийКлючЗаписи.НапоминанияПользователяАИТП"));
	
	ОбновитьТаблицуНапоминаний();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПодключитьНапоминание(ПараметрыНапоминания)
	НапоминанияПользователяСлужебныйАИТП.ПодключитьНапоминание(ПараметрыНапоминания, Истина);
КонецПроцедуры

&НаСервере
Процедура ОтключитьНапоминание(ПараметрыНапоминания)
	НапоминанияПользователяСлужебныйАИТП.ОтключитьНапоминание(ПараметрыНапоминания);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьТаблицуНапоминаний() 

	ОтключитьОбработчикОжидания("ОбновитьТаблицуНапоминаний");
	
	ВремяБлижайшего = Неопределено;
	ТаблицаНапоминаний = НапоминанияПользователяКлиентАИТП.ПолучитьТекущиеОповещения(ВремяБлижайшего);
	Для Каждого Напоминание из ТаблицаНапоминаний Цикл
		НайденныеСтроки = Напоминания.НайтиСтроки(Новый Структура("Источник,ВремяСобытия", Напоминание.Источник, Напоминание.ВремяСобытия));
		Если НайденныеСтроки.Количество() > 0 Тогда
			ЗаполнитьЗначенияСвойств(НайденныеСтроки[0], Напоминание, , "СрокНапоминания");
		Иначе
			НоваяСтрока = Напоминания.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, Напоминание);
		КонецЕсли;
	КонецЦикла;
	
	СтрокиНаУдаление = Новый Массив;
	Для Каждого Напоминание из Напоминания Цикл
		Если ЗначениеЗаполнено(Напоминание.Источник) и ПустаяСтрока(Напоминание.ИсточникСтрокой) Тогда
			ОбновитьПредставленияПредметов();
		КонецЕсли;
			
		СтрокаНайдена = Ложь;
		Для Каждого СтрокаКэша Из ТаблицаНапоминаний Цикл
			Если СтрокаКэша.Источник = Напоминание.Источник И СтрокаКэша.ВремяСобытия = Напоминание.ВремяСобытия Тогда
				СтрокаНайдена = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Если не СтрокаНайдена Тогда 
			СтрокиНаУдаление.Добавить(Напоминание);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Строка Из СтрокиНаУдаление Цикл
		Напоминания.Удалить(Строка);
	КонецЦикла;
	
	УстановитьВидимость();
	
	Интервал = 15; // обновление таблицы не реже чем 1 раз в 15 сек.
	Если ВремяБлижайшего <> Неопределено Тогда 
		Интервал = Макс(Мин(Интервал, ВремяБлижайшего - ОбщегоНазначенияКлиентАИТП.ДатаСеанса()), 1); 
	КонецЕсли;
	
	ПодключитьОбработчикОжидания("ОбновитьТаблицуНапоминаний", Интервал, Истина);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьПредставленияПредметов()
	
	Для Каждого Напоминание Из Напоминания Цикл
		Если ЗначениеЗаполнено(Напоминание.Источник) Тогда
			Напоминание.ИсточникСтрокой = ОбщегоНазначенияАИТП.ПредметСтрокой(Напоминание.Источник);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВремяВТаблицеНапоминаний()
	Для Каждого СтрокаТаблицы Из Напоминания Цикл
		ПредставлениеВремени = "";
		
		Время = ОбщегоНазначенияКлиентАИТП.ДатаСеанса() - СтрокаТаблицы.ВремяСобытия;
		
		Если ЗначениеЗаполнено(СтрокаТаблицы.ВремяСобытия) Тогда
			Если Время > -60 и Время < 60 Тогда
				ПредставлениеВремени = НСтр("ru = 'сейчас'");
			Иначе
				ПредставлениеВремени = НапоминанияПользователяКлиентСерверАИТП.ПредставлениеВремени(Время, Ложь, Ложь);
				
				Если Время > 0 Тогда
					ПредставлениеВремени = НСтр("ru = 'просрочено'") + " " + ПредставлениеВремени;
				Иначе
					ПредставлениеВремени = НСтр("ru = 'через'") + " " + ПредставлениеВремени;
				КонецЕсли;
			КонецЕсли;
		Иначе
			ПредставлениеВремени = НСтр("ru = 'срок не определен'");
		КонецЕсли;
		
		Если СтрокаТаблицы.ВремяСобытияСтрока <> ПредставлениеВремени Тогда
			СтрокаТаблицы.ВремяСобытияСтрока = ПредставлениеВремени;
		КонецЕсли;
		
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ОтложитьАктивныеНапоминания()
	
	ИнтервалВремени = НапоминанияПользователяКлиентСерверАИТП.ПолучитьИнтервалВремениИзСтроки(СрокПовторногоОповещения);
	
	Для Каждого СтрокаТаблицы Из Напоминания Цикл
		
		СтрокаТаблицы.СрокНапоминания = ОбщегоНазначенияКлиентАИТП.ДатаСеанса() + ИнтервалВремени;
		
		ПараметрыНапоминания = НапоминанияПользователяКлиентСерверАИТП.ПолучитьСтруктуруНапоминания(СтрокаТаблицы);
		
		ПодключитьНапоминание(ПараметрыНапоминания);
		НапоминанияПользователяКлиентАИТП.ОбновитьЗаписьВКэшеОповещений(СтрокаТаблицы);
		
	КонецЦикла;
	
	ОбновитьТаблицуНапоминаний();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьНапоминание()
	Если Элементы.Напоминания.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Источник = Элементы.Напоминания.ТекущиеДанные.Источник;
	Если ЗначениеЗаполнено(Источник) Тогда
		ПоказатьЗначение(, Источник);
	Иначе
		РедактироватьНапоминание();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьНапоминание()
	ПараметрыНапоминания = Новый Структура("Пользователь,Источник,ВремяСобытия");
	ЗаполнитьЗначенияСвойств(ПараметрыНапоминания, Элементы.Напоминания.ТекущиеДанные);
	
	//ОткрытьФорму("РегистрСведений.НапоминанияПользователяАИТП.Форма.Напоминание", Новый Структура("Ключ", ПолучитьКлючЗаписи(ПараметрыНапоминания)));
	ОткрытьФорму("РегистрСведений.НапоминанияПользователяАИТП.Форма.Напоминание", Новый Структура("Ключ", ПолучитьКлючЗаписи(ПараметрыНапоминания)));
	
КонецПроцедуры

&НаСервере
Функция ПолучитьКлючЗаписи(ПараметрыНапоминания)
	Возврат РегистрыСведений.НапоминанияПользователяАИТП.СоздатьКлючЗаписи(ПараметрыНапоминания);
КонецФункции

&НаКлиенте
Процедура УстановитьВидимость()
	ЕстьДанныеВТаблице = Напоминания.Количество() > 0;
	
	Если Не ЕстьДанныеВТаблице и ЭтотОбъект.Открыта() Тогда
		ЭтотОбъект.Закрыть();
	КонецЕсли;
	
	Элементы.ПанельКнопок.Доступность = ЕстьДанныеВТаблице;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьСрокиПовторногоНапоминания()
	Для Каждого Элемент Из Элементы.СрокПовторногоОповещения.СписокВыбора Цикл
		Элемент.Представление = НапоминанияПользователяКлиентСерверАИТП.ОформитьВремя(Элемент.Значение); 
	КонецЦикла;
КонецПроцедуры	

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	Если ИмяСобытия = "Запись_НапоминанияПользователя" Тогда 
		ОбновитьТаблицуНапоминаний();
	КонецЕсли;
КонецПроцедуры


#КонецОбласти
