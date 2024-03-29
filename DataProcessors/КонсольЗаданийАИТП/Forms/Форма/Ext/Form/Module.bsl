﻿#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Попытка
		Если АвтообновлениеСпискаРегламентныхЗаданий = Истина Тогда
			ПодключитьОбработчикОжидания("ОбработчикАвтообновленияРегламентныхЗаданий", ПериодАвтообновленияСпискаРегламентныхЗаданий);	
		КонецЕсли;		
		
		Если АвтообновлениеСпискаФоновыхЗаданий = Истина Тогда
			ПодключитьОбработчикОжидания("ОбработчикАвтообновленияФоновыхЗаданий", ПериодАвтообновленияСпискаФоновыхЗаданий);	
		КонецЕсли;		
		
		ОбновитьСписокРегламентныхЗаданий();
		ОбновитьСписокФоновыхЗаданий();
	Исключение	
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьРегламентныеЗадания(Команда)
	ОбновитьСписокРегламентныхЗаданий();
КонецПроцедуры

&НаКлиенте
Процедура Расписание(Команда)
	ВыделенныеСтроки = Элементы.СписокРегламентныхЗаданий.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() > 0 Тогда
		
		Строка = СписокРегламентныхЗаданий.НайтиПоИдентификатору(ВыделенныеСтроки.Получить(0));
		Расписание = ПолучитьРасписаниеРегламентногоЗадания(Строка.Идентификатор);
		Диалог = Новый ДиалогРасписанияРегламентногоЗадания(Расписание);
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Расписание", Расписание);
		ДополнительныеПараметры.Вставить("Строка", Строка);
		ОписаниеОповещения = Новый ОписаниеОповещения("ОбработчикЗакрытияДиалогаРасписанияРегламентногоЗадания", ЭтаФорма, ДополнительныеПараметры);
		Диалог.Показать(ОписаниеОповещения);
		//Если Диалог.ОткрытьМодально() Тогда
		//	Расписание = Диалог.Расписание;
		//	УстановитьРасписаниеРегламентногоЗадания(Строка.Идентификатор, Строка.Наименование, Расписание, Строка.Метаданные);
		//	Строка.Расписание = Расписание;
		//КонецЕсли;
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьФоновыеЗадания(Команда)
	ОбновитьСписокФоновыхЗаданий();
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьФоновоеЗадание(Команда)
	Отказ = Истина;
	Попытка
		ОтменитьФоновыеЗадания();
		ОбновитьСписокФоновыхЗаданий();
	Исключение	
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура НастройкаСпискаРегламентныхЗаданий(Команда)
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Автообновление", АвтообновлениеСпискаРегламентныхЗаданий);
	СтруктураПараметров.Вставить("ПериодАвтообновления", ПериодАвтообновленияСпискаРегламентныхЗаданий);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработчикЗакрытияДиалогаНастройкиСписка", ЭтаФорма);
	ОткрытьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогНастроекСписка", СтруктураПараметров, ,,,,ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьОтборРегламентныхЗаданий(Команда)
	ОтборРегламентныхЗаданийВключен = Ложь;
	ОбновитьСписокРегламентныхЗаданий();
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьОтборФоновыхЗаданий(Команда)
	ОтборФоновыхЗаданийВключен = Ложь;
	ОбновитьСписокФоновыхЗаданий();
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборФоновыхЗаданий(Команда)
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Отбор", ОтборФоновыхЗаданий);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработчикЗакрытияДиалогаУстановкиОтбораФоновыхЗаданий", ЭтаФорма);
	ОткрытьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогОтбораФоновогоЗадания", СтруктураПараметров, ЭтаФорма,,,,ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца); 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьСписокРегламентныхЗаданий()
	Перем ТекущийИдентификатор;
	
	ТекущаяСтрока = Элементы.СписокРегламентныхЗаданий.ТекущаяСтрока;
	Если ТекущаяСтрока <> Неопределено Тогда
		ТекСтрока = СписокРегламентныхЗаданий.НайтиПоИдентификатору(ТекущаяСтрока);
		ТекущийИдентификатор = ТекСтрока.Идентификатор;
	КонецЕсли;
	
	Идентификаторы = Новый Массив;
	
	ВыделенныеСтроки = Элементы.СписокРегламентныхЗаданий.ВыделенныеСтроки;
	Для Каждого ВыделеннаяСтрока из ВыделенныеСтроки Цикл
		ТекСтрока = СписокРегламентныхЗаданий.НайтиПоИдентификатору(ВыделеннаяСтрока);
		Идентификаторы.Добавить(ТекСтрока.Идентификатор);
	КонецЦикла;
	
	СписокРегламентныхЗаданий.Очистить();
	
	Отбор = Неопределено;
	Если ОтборРегламентныхЗаданийВключен = Истина Тогда
		Отбор = ОтборРегламентныхЗаданий;
	КонецЕсли;
	
	Попытка
		Регламентные = РегламентныеЗадания.ПолучитьРегламентныеЗадания(Отбор);
	Исключение
		//Элементы.СписокРегламентныхЗаданий.Доступность = Ложь;
		Возврат;
	КонецПопытки;
	
	//Элементы.СписокРегламентныхЗаданий.Доступность = Истина;
	
	Для Каждого Регламентное из Регламентные Цикл
		НоваяСтрока = СписокРегламентныхЗаданий.Добавить();
		НоваяСтрока.Метаданные = Регламентное.Метаданные.Представление();
		НоваяСтрока.Наименование = Регламентное.Наименование;
		НоваяСтрока.Ключ = Регламентное.Ключ;
		НоваяСтрока.Расписание = Регламентное.Расписание;
		НоваяСтрока.Пользователь = Регламентное.ИмяПользователя;
		НоваяСтрока.Предопределенное = Регламентное.Предопределенное;
		НоваяСтрока.Использование = Регламентное.Использование;
		НоваяСтрока.Идентификатор = Регламентное.УникальныйИдентификатор;
		
		Попытка
			ПоследнееЗадание = Регламентное.ПоследнееЗадание;
		Исключение
			ПоследнееЗадание = Неопределено;
		КонецПопытки;
		
		Если ПоследнееЗадание <> Неопределено Тогда
			НоваяСтрока.Выполнялось = ПоследнееЗадание.Начало;
			НоваяСтрока.Состояние = ПоследнееЗадание.Состояние;
		КонецЕсли;
	КонецЦикла;
	
	Если ТекущийИдентификатор <> Неопределено Тогда
		Строки = СписокРегламентныхЗаданий.НайтиСтроки(Новый Структура("Идентификатор", ТекущийИдентификатор));
		Если Строки.Количество() > 0 Тогда
			Элементы.СписокРегламентныхЗаданий.ТекущаяСтрока = Строки[0].ПолучитьИдентификатор();
		КонецЕсли;
	КонецЕсли;

	Если Идентификаторы.Количество() > 0 Тогда
		ВыделенныеСтроки.Очистить();
	КонецЕсли;
	
	Для Каждого Идентификатор из Идентификаторы Цикл
		Строки = СписокРегламентныхЗаданий.НайтиСтроки(Новый Структура("Идентификатор", ТекущийИдентификатор));
		Если Строки.Количество() > 0 Тогда
			ВыделенныеСтроки.Добавить(Строки[0].ПолучитьИдентификатор());
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьСписокФоновыхЗаданий()
	
	Перем ТекущийИдентификатор;
	
	ТекущаяСтрока = Элементы.СписокФоновыхЗаданий.ТекущаяСтрока;
	Если ТекущаяСтрока <> Неопределено Тогда
		ТекСтрока = СписокФоновыхЗаданий.НайтиПоИдентификатору(ТекущаяСтрока);
		Если Не ТекСтрока = Неопределено Тогда
			ТекущийИдентификатор = ТекСтрока.Идентификатор;
		КонецЕсли;
	КонецЕсли;
	
	Идентификаторы = Новый Массив;
	
	ВыделенныеСтроки = Элементы.СписокФоновыхЗаданий.ВыделенныеСтроки;
	Для Каждого ВыделеннаяСтрока из ВыделенныеСтроки Цикл
		ТекСтрока = СписокФоновыхЗаданий.НайтиПоИдентификатору(ВыделеннаяСтрока);
		Если Не ТекСтрока = Неопределено Тогда
			Идентификаторы.Добавить(ТекСтрока.Идентификатор);
		КонецЕсли;
	КонецЦикла;

	СписокФоновыхЗаданий.Очистить();
	
	Отбор = Неопределено;
	Если ОтборФоновыхЗаданийВключен = Истина Тогда
		//Отбор = ОтборФоновыхЗаданий;
		Отбор = СформироватьОтборФоновыхЗаданийНаСервере(ОтборФоновыхЗаданий);
	КонецЕсли;
	
	Попытка
		Фоновые = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор);
	Исключение
		//Элементы.СписокФоновыхЗаданий.Доступность = Ложь;
		Возврат;
	КонецПопытки;
	
	//Элементы.СписокФоновыхЗаданий.Доступность = Истина;
	
	Для Каждого Фоновое из Фоновые Цикл
		НоваяСтрока = СписокФоновыхЗаданий.Добавить();
		
		РегламентноеЗадание = Фоновое.РегламентноеЗадание;
		Если РегламентноеЗадание <> Неопределено Тогда
			Строка = РегламентноеЗадание.Метаданные.Представление();
			Если РегламентноеЗадание.Наименование <> "" Тогда
				Строка = Строка + ":" +	РегламентноеЗадание.Наименование;
			КонецЕсли;
			
			НоваяСтрока.Регламентное = Строка;
		КонецЕсли;
			
		НоваяСтрока.Наименование = Фоновое.Наименование;
		НоваяСтрока.Ключ = Фоновое.Ключ;
		НоваяСтрока.Метод = Фоновое.ИмяМетода;
		НоваяСтрока.Состояние = Фоновое.Состояние;
		НоваяСтрока.Начало = Фоновое.Начало;
		НоваяСтрока.Конец = Фоновое.Конец;
		НоваяСтрока.Сервер = Фоновое.Расположение;
		
		Если Фоновое.ИнформацияОбОшибке <> Неопределено Тогда
			НоваяСтрока.Ошибки = Фоновое.ИнформацияОбОшибке.Описание;
		КонецЕсли;
		
		НоваяСтрока.Идентификатор = Фоновое.УникальныйИдентификатор;
		НоваяСтрока.СостояниеЗадания = Фоновое.Состояние;
	КонецЦикла;
	
	Если ТекущийИдентификатор <> Неопределено Тогда
		Строки = СписокФоновыхЗаданий.НайтиСтроки(Новый Структура("Идентификатор", ТекущийИдентификатор));
		Если Строки.Количество() > 0 Тогда
			Элементы.СписокФоновыхЗаданий.ТекущаяСтрока = Строки[0].ПолучитьИдентификатор();
		КонецЕсли;
	КонецЕсли;

	Если Идентификаторы.Количество() > 0 Тогда
		ВыделенныеСтроки.Очистить();
	КонецЕсли;
	
	Для Каждого Идентификатор из Идентификаторы Цикл
		Строки = СписокФоновыхЗаданий.НайтиСтроки(Новый Структура("Идентификатор", ТекущийИдентификатор));
		Если Строки.Количество() > 0 Тогда
			ВыделенныеСтроки.Добавить(Строки[0].ПолучитьИдентификатор());
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикЗакрытияДиалогаРасписанияРегламентногоЗадания(Расписание, ДополнительныеПараметры) Экспорт
	
	Если Не Расписание = Неопределено Тогда
		
		
		ДополнительныеПараметры.Расписание = Расписание;
		УстановитьРасписаниеРегламентногоЗадания(ДополнительныеПараметры.Строка.Идентификатор, ДополнительныеПараметры.Строка.Наименование, ДополнительныеПараметры.Расписание, ДополнительныеПараметры.Строка.Метаданные);
		ДополнительныеПараметры.Строка.Расписание = Расписание;
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокРегламентныхЗаданийПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	Отказ = Истина;
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ИдентификаторЗадания", "");
	
	Диалог = ПолучитьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогРегламентногоЗадания", СтруктураПараметров);
	Если Диалог.ОткрытьМодально() <> Неопределено Тогда
		ОбновитьСписокРегламентныхЗаданий();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СписокРегламентныхЗаданийПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
	ВыделенныеСтроки = Элементы.СписокРегламентныхЗаданий.ВыделенныеСтроки;
	Если ВыделенныеСтроки.Количество() > 0 Тогда
		
		Строка = СписокРегламентныхЗаданий.НайтиПоИдентификатору(ВыделенныеСтроки.Получить(0));
		
		СтруктураПараметров = Новый Структура;
		Ид = Строка.Идентификатор;
		СтруктураПараметров.Вставить("ИдентификаторЗадания", Ид);
		
		//Диалог = ПолучитьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогРегламентногоЗадания", СтруктураПараметров);
		//Если Диалог.ОткрытьМодально() <> Неопределено Тогда
		//ОбновитьСписокРегламентныхЗаданий();
		//КонецЕсли;
		ОписаниеОповещения = Новый ОписаниеОповещения("ОбработатьЗакрытиеФормыДиалогаРегламентногоЗадания", ЭтаФорма);
		ОткрытьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогРегламентногоЗадания", СтруктураПараметров, ЭтаФорма,,,,ОписаниеОповещения,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьЗакрытиеФормыДиалогаРегламентногоЗадания(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	 ОбновитьСписокРегламентныхЗаданий();
КонецПроцедуры

&НаКлиенте
Процедура СписокРегламентныхЗаданийПередУдалением(Элемент, Отказ)
	Попытка
		Отказ = Истина;
		УдалитьРегламентноеЗадание();
		
		ОбновитьСписокРегламентныхЗаданий();
	Исключение
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;
КонецПроцедуры

&НаСервере
Процедура УдалитьРегламентноеЗадание()
	ВыделенныеСтроки = Элементы.СписокРегламентныхЗаданий.ВыделенныеСтроки;
	Для Каждого Стр из ВыделенныеСтроки Цикл
		Строка = СписокРегламентныхЗаданий.НайтиПоИдентификатору(Стр);
		
		РегламентноеЗадание = Обработки.КонсольЗаданийАИТП.Создать().ПолучитьОбъектРегламентногоЗадания(Строка.Идентификатор);
		Если РегламентноеЗадание.Предопределенное Тогда
			ВызватьИсключение("Нельзя удалить предопределенное задание: " + РегламентноеЗадание.Наименование);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого Стр из ВыделенныеСтроки Цикл
		Строка = СписокРегламентныхЗаданий.НайтиПоИдентификатору(Стр);
		РегламентноеЗадание = Обработки.КонсольЗаданийАИТП.Создать().ПолучитьОбъектРегламентногоЗадания(Строка.Идентификатор);
		РегламентноеЗадание.Удалить();
	КонецЦикла
КонецПроцедуры

&НаКлиенте
Процедура СписокФоновыхЗаданийПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	Отказ = Истина;
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ИдентификаторЗадания", "");
	
	Попытка
		Диалог = ПолучитьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогФоновогоЗадания", СтруктураПараметров);
		Если Диалог.ОткрытьМодально() <> Неопределено Тогда
		    ОбновитьСписокФоновыхЗаданий();			
		КонецЕсли;
	Исключение	
		ПоказатьИнформациюОбОшибке(ИнформацияОбОшибке());
	КонецПопытки;
КонецПроцедуры

&НаСервере
Функция ПолучитьРасписаниеРегламентногоЗадания(УникальныйНомерЗадания)
	ОбъектЗадания = Обработки.КонсольЗаданийАИТП.Создать().ПолучитьОбъектРегламентногоЗадания(УникальныйНомерЗадания);
	Если ОбъектЗадания = Неопределено Тогда
		Возврат Новый РасписаниеРегламентногоЗадания;
	КонецЕсли;
	
	Возврат ОбъектЗадания.Расписание;
КонецФункции

&НаСервере
Функция УстановитьРасписаниеРегламентногоЗадания(Идентификатор, Наименование, Расписание, ИмяЗадания)
	ОбъектЗадания = Обработки.КонсольЗаданийАИТП.Создать().ПолучитьОбъектРегламентногоЗадания(Идентификатор);		
	Если ОбъектЗадания = Неопределено Тогда
		РедОбъектЗадания = РегламентныеЗадания.СоздатьРегламентноеЗадание(ИмяЗадания);
		РедОбъектЗадания.Наименование = Наименование;
		РедОбъектЗадания.Использование = Истина;
	Иначе
		РедОбъектЗадания = ОбъектЗадания;
	КонецЕсли;
	
	РедОбъектЗадания.Расписание = Расписание;
	Попытка
		РедОбъектЗадания.Записать();
	Исключение
		ВызватьИсключение "Произошла ошибка при сохранении расписания выполнения обменов. Возможно данные расписания были изменены. Закройте форму настройки и повторите попытку изменения расписания еще раз.
		|Подробное описание ошибки: " + ОписаниеОшибки();
	КонецПопытки;
	
	Возврат Истина;
КонецФункции

&НаКлиенте
Процедура СписокФоновыхЗаданийПередНачаломИзменения(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура СписокФоновыхЗаданийПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаСервере
Процедура ОтменитьФоновыеЗадания()
	ВыделенныеСтроки = Элементы.СписокФоновыхЗаданий.ВыделенныеСтроки;
	Для Каждого Стр из ВыделенныеСтроки Цикл
		Строка = СписокФоновыхЗаданий.НайтиПоИдентификатору(Стр);
		ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(Строка.Идентификатор);
		ФоновоеЗадание.Отменить();
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикЗакрытияДиалогаНастройкиСписка(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(РезультатЗакрытия) = Тип("Структура") Тогда
		
		АвтообновлениеСпискаРегламентныхЗаданий = РезультатЗакрытия.Автообновление;
		ПериодАвтообновленияСпискаРегламентныхЗаданий = РезультатЗакрытия.ПериодАвтообновления;
		
		ОтключитьОбработчикОжидания("ОбработчикАвтообновленияРегламентныхЗаданий");
		
		Если АвтообновлениеСпискаРегламентныхЗаданий = Истина Тогда
			ПодключитьОбработчикОжидания("ОбработчикАвтообновленияРегламентныхЗаданий", ПериодАвтообновленияСпискаРегламентныхЗаданий);	
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НастройкаСпискаФоновыхЗаданий(Команда)
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Автообновление", АвтообновлениеСпискаФоновыхЗаданий);
	СтруктураПараметров.Вставить("ПериодАвтообновления", ПериодАвтообновленияСпискаФоновыхЗаданий);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработчикЗакрытияДиалогаНастройкиСпискаФоновыхЗаданий", ЭтаФорма);
	ОткрытьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогНастроекСписка", СтруктураПараметров, ,,,,ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);

КонецПроцедуры

&НаКлиенте
Процедура ОбработчикЗакрытияДиалогаНастройкиСпискаФоновыхЗаданий(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(РезультатЗакрытия) = Тип("Структура") Тогда
		
		АвтообновлениеСпискаФоновыхЗаданий = РезультатЗакрытия.Автообновление;
		ПериодАвтообновленияСпискаФоновыхЗаданий = РезультатЗакрытия.ПериодАвтообновления;
		
		ОтключитьОбработчикОжидания("ОбработчикАвтообновленияФоновыхЗаданий");
		Если АвтообновлениеСпискаРегламентныхЗаданий = Истина Тогда
			ПодключитьОбработчикОжидания("ОбработчикАвтообновленияФоновыхЗаданий", ПериодАвтообновленияСпискаФоновыхЗаданий);	
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработчикАвтообновленияФоновыхЗаданий()
	ОбновитьСписокФоновыхЗаданий();
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикАвтообновленияРегламентныхЗаданий()
	ОбновитьСписокРегламентныхЗаданий();
КонецПроцедуры

&НаКлиенте
Процедура УстановитьОтборРегламентныхЗаданий(Команда)
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Отбор", ОтборРегламентныхЗаданий);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработчикЗакрытияДиалогаУстановкиОтбораРегламентныхЗаданий", ЭтаФорма);
	ОткрытьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогОтбораРегламентногоЗадания", СтруктураПараметров, ЭтаФорма,,,,ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца); 
	//Диалог = ПолучитьФорму("Обработка.КонсольЗаданийАИТП.Форма.ДиалогОтбораРегламентногоЗадания", СтруктураПараметров);
	//Результат = Диалог.ОткрытьМодально();
	//
	//Если Результат <> Неопределено Тогда
	//	ОтборРегламентныхЗаданий = Результат;
	//	ОтборРегламентныхЗаданийВключен = Истина;
	//	ОбновитьСписокРегламентныхЗаданий();
	//КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикЗакрытияДиалогаУстановкиОтбораРегламентныхЗаданий(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(РезультатЗакрытия) = Тип("Структура") Тогда
		
		ОтборРегламентныхЗаданий = РезультатЗакрытия;
		ОтборРегламентныхЗаданийВключен = Истина;
		ОбновитьСписокРегламентныхЗаданий();
		
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ОбработчикЗакрытияДиалогаУстановкиОтбораФоновыхЗаданий(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(РезультатЗакрытия) = Тип("Структура") Тогда
		
		ОтборФоновыхЗаданий = РезультатЗакрытия;
		ОтборФоновыхЗаданийВключен = Истина;
		ОбновитьСписокФоновыхЗаданий();
		
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция СформироватьОтборФоновыхЗаданийНаСервере(ОтборИсточник)
	
	ОтборДанные = Новый Структура;
	
	Если ОтборИсточник.Свойство("Начало") Тогда
		ОтборДанные.Вставить("Начало", ОтборИсточник.Начало);
	КонецЕсли;
	
	Если ОтборИсточник.Свойство("Конец") Тогда
		ОтборДанные.Вставить("Конец", ОтборИсточник.Конец);
	КонецЕсли;
	
	Если ОтборИсточник.Свойство("Ключ") Тогда
		ОтборДанные.Вставить("Ключ", ОтборИсточник.Ключ);
	КонецЕсли;
	
	Если ОтборИсточник.Свойство("Наименование") Тогда
		ОтборДанные.Вставить("Наименование", ОтборИсточник.Наименование);
	КонецЕсли;
	
	Если ОтборИсточник.Свойство("Метод") Тогда
		ОтборДанные.Вставить("ИмяМетода", ОтборИсточник.Метод);
	КонецЕсли;
	
	Если ОтборИсточник.Свойство("РегламентноеЗадание") Тогда
		ОтборДанные.Вставить("РегламентноеЗадание", ОтборИсточник.РегламентноеЗадание);
	КонецЕсли;
	
	
	Если ОтборИсточник.Свойство("Состояние") Тогда
		
		Массив = Новый Массив;
		
		Для Каждого ОтборСостояние Из ОтборИсточник.Состояние Цикл
			
			Если ОтборСостояние = "Активно" Тогда
				Массив.Добавить(СостояниеФоновогоЗадания.Активно);
			КонецЕсли;
			
			Если ОтборСостояние = "Завершено" Тогда
				Массив.Добавить(СостояниеФоновогоЗадания.Завершено);
			КонецЕсли;
			
			Если ОтборСостояние = "ЗавершеноАварийно" Тогда
				Массив.Добавить(СостояниеФоновогоЗадания.ЗавершеноАварийно);
			КонецЕсли;
			
			Если ОтборСостояние = "Отменено" Тогда
				Массив.Добавить(СостояниеФоновогоЗадания.Отменено);
			КонецЕсли;
		
		КонецЦикла;

		Если Массив.Количество() > 0 ТОгда
			ОтборДанные.Вставить("Состояние", Массив);
		КонецЕсли;
			
		
	КонецЕсли;
	
	Возврат ОтборДанные;

КонецФункции

#КонецОбласти

