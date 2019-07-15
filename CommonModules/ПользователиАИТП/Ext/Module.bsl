﻿/////////////////////////////////////////////////////////////////////////
//
// Функции работы с пользователями АИТП
//
/////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Устанавливает параметр сеанса ТекущийПользовательАИТП
//
// Параметры:
//  ИмяПараметра			 - Строка - имя параметра сеанса 
//  УстановленныеПараметры	 - Соответствие - массив установленных параметров 
//
Процедура УстановитьПараметрыСеанса(ИмяПараметра, УстановленныеПараметры) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);

	ТекущийПользователь = ПользователиИнформационнойБазы.ТекущийПользователь();
	
	Если ТекущийПользователь.Имя = "" Тогда
		ПараметрыСеанса.ТекущийПользовательАИТП = Справочники.ПользователиАИТП.ПустаяСсылка();
		Возврат;
	КонецЕсли;
	
	ИдентификаторПользователяИБ = Строка(ТекущийПользователь.УникальныйИдентификатор);
	ПараметрыСеанса.ТекущийПользовательАИТП = Справочники.ПользователиАИТП.НайтиПоКоду(ИдентификаторПользователяИБ);
	УстановленныеПараметры.Добавить("ТекущийПользовательАИТП");	
	
КонецПроцедуры

// Возвращает текущего пользователя
// 
// Возвращаемое значение:
//   - СправочникСсылка.ПользователиАИТП - Ссылка на элемент справочника ПользователиАИТП
//
Функция ТекущийПользователь() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	Возврат ПараметрыСеанса.ТекущийПользовательАИТП;
	
КонецФункции

// Функция - Проверяет, имеет ли пользователь определенную роль
//
// Параметры:
//  Роль - строка - имя роли как в конфигураторе 
// 
// Возвращаемое значение:
//   - Булево - Истина - если пользователь имеет роль, иначе - если нет
//
Функция ИмеетРоль(Роль) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	Попытка
		ИдентификаторПользователя = Новый УникальныйИдентификатор(ТекущийПользователь().Код);
	Исключение
		Возврат Ложь;
	КонецПопытки;
	
	ПользовательИБ = ПользователиИнформационнойБазы.НайтиПоУникальномуИдентификатору(
		ИдентификаторПользователя	
		);
		
	Возврат (Не ПользовательИБ = Неопределено) И РольДоступна(Роль);
	
КонецФункции

#КонецОбласти