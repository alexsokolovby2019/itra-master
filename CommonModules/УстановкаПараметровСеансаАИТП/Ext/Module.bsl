﻿//////////////////////////////////////////////////////////////////////// 
//
// Установка параметров сеанса 
//
////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Для вызова из обработчика УстановкаПараметровСеанса модуля сеанса.
//
// Параметры
//  ИменаПараметровСеанса - Массив, Неопределено - в массиве имена параметров сеанса для инициализации.
//
//  Возвращает массив имен установленных параметров сеанса
//
Функция УстановкаПараметровСеанса(ИменаПараметровСеанса) Экспорт
	
	Если ИменаПараметровСеанса = Неопределено Тогда
		Возврат Новый Массив;
	КонецЕсли;
	
	// Параметры сеанса, инициализация которых требует обращения к одним и тем же данным
	// следует инициализировать сразу группой. Для того, чтобы избежать их повторной инициализации,
	// имена уже установленных параметров сеанса сохраняются в массиве УстановленныеПараметры
	УстановленныеПараметры = Новый Массив;
	Обработчики = Новый Соответствие;
	
	ПриДобавленииОбработчиковУстановкиПараметровСеанса(Обработчики);
	УстановкаПараметровСеансаПереопределяемыйАИТП.ПриДобавленииОбработчиковУстановкиПараметровСеанса(Обработчики);
	ВыполнитьОбработчикиУстановкиПараметровСеанса(ИменаПараметровСеанса, Обработчики, УстановленныеПараметры);
	
	Возврат УстановленныеПараметры;
	
КонецФункции

// Устанавливает обработчики установки параметров сеанса.
//  
//  
//  Для задания обработчиков параметров сеанса следует использовать шаблон:
//  Обработчики.Вставить("<ИмяПараметраСеанса>|<НачалоИмениПараметраСеанса*>", "Обработчик");
//  
//  Примечание. Символ '*'используется в конце имени параметра сеанса и обозначает,
//  что один обработчик будет вызван для инициализации всех параметров сеанса
//  с именем, начинающимся на слово НачалоИмениПараметраСеанса
//
// Параметры:
//  Обработчики	 - 	Соответствие - список обработчиков параметров сеанса
//
Процедура ПриДобавленииОбработчиковУстановкиПараметровСеанса(Обработчики) Экспорт
	
	Обработчики.Вставить("ТекущийПользовательАИТП", "ПользователиАИТП.УстановитьПараметрыСеанса");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Выполняет обработчики установки параметров сеанса
//
Процедура ВыполнитьОбработчикиУстановкиПараметровСеанса(ИменаПараметровСеанса, Обработчики, УстановленныеПараметры)
	
	Перем ТекстСообщения;
	
	// Массив с ключами параметров сеанса
	// задаются начальным словом в имени параметра сеанса и символом "*"
	ПараметрыСеансаКлючи = Новый Массив;
	
	Для Каждого Запись Из Обработчики Цикл
		
		Если Найти(Запись.Ключ, "*") > 0 Тогда
			
			КлючПараметра = СокрЛП(Запись.Ключ);
			ПараметрыСеансаКлючи.Добавить(Лев(КлючПараметра, СтрДлина(КлючПараметра)-1));
			
		КонецЕсли;
		
	КонецЦикла;
	
	Для каждого ИмяПараметра Из ИменаПараметровСеанса Цикл
		
		Если УстановленныеПараметры.Найти(ИмяПараметра) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Обработчик = Обработчики.Получить(ИмяПараметра);
		
		Если Обработчик <> Неопределено Тогда
			
			Выполнить (Обработчик + "(ИмяПараметра, УстановленныеПараметры);");
			Продолжить;
			
		КонецЕсли;
		
		Для Каждого ИмяКлючаПараметра Из ПараметрыСеансаКлючи Цикл
			
			Если Лев(ИмяПараметра, СтрДлина(ИмяКлючаПараметра)) = ИмяКлючаПараметра Тогда
				
				Обработчик = Обработчики.Получить(ИмяКлючаПараметра+"*");
				Выполнить (Обработчик + "(ИмяПараметра, УстановленныеПараметры);");
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

