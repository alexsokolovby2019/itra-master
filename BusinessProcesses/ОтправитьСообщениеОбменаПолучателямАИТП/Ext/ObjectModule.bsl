﻿
Процедура СтартПередСтартом(ТочкаМаршрутаБизнесПроцесса, Отказ)
	// Вставить содержимое обработчика.
	БизнесПроцессыАИТП.ПередСтартомБП(ТочкаМаршрутаБизнесПроцесса, ЭтотОбъект);

КонецПроцедуры

Процедура ЗавершениеПриЗавершении(ТочкаМаршрутаБизнесПроцесса, Отказ)
	// Вставить содержимое обработчика.
	БизнесПроцессыАИТП.ПриЗавершенииБП(
		ТочкаМаршрутаБизнесПроцесса
		, ЭтотОбъект
		, Перечисления.РезультатыВыполненияДействияАИТП.Положительный
		, Перечисления.ДальнейшиеДействияАИТП.Продолжить
		);

КонецПроцедуры

Процедура ОтправитьСообщениеОбменаПриСозданииЗадач(ТочкаМаршрутаБизнесПроцесса, ФормируемыеЗадачи, Отказ)
	// Вставить содержимое обработчика.
		БизнесПроцессыАИТП.ПриСозданииЗадачи(ТочкаМаршрутаБизнесПроцесса
			, ФормируемыеЗадачи[0]
			, Перечисления.ВидыЗадачАИТП.Действие
			);
	
	Для Индекс = 1 По Индекс = Получатели.Количество() - 1 Цикл
		
		Задача = Задачи.ЗадачаАИТП.СоздатьЗадачу();
		Задача.Дата = ТекущаяДата();
		Задача.БизнесПроцесс = ЭтотОбъект.Ссылка;
		Задача.ТочкаМаршрута = ТочкаМаршрутаБизнесПроцесса;
		Задача.Наименование = Строка(БизнесПроцессы.ОтправитьСообщениеОбменаПолучателямАИТП.ТочкиМаршрута.ОтправитьСообщениеОбмена);
		
		БизнесПроцессыАИТП.ПриСозданииЗадачи(ТочкаМаршрутаБизнесПроцесса
			, Задача
			, Перечисления.ВидыЗадачАИТП.Действие
			);
			
		ФормируемыеЗадачи.Добавить(Задача);
			
	КонецЦикла;
	
КонецПроцедуры

Процедура ОтправитьСообщениеОбменаПриСозданииВложенныхБизнесПроцессов(ТочкаМаршрутаБизнесПроцесса, ФормируемыеБизнесПроцессы, Отказ)
	// Вставить содержимое обработчика.
	Для Индекс = 0 По ФормируемыеБизнесПроцессы.Количество() - 1 Цикл
		
		Процесс = ФормируемыеБизнесПроцессы[Индекс];
		Процесс.Получатель = ЭтотОбъект.Получатели[Индекс].Получатель;
		Процесс.ТелоСообщения = ЭтотОбъект.Получатели[Индекс].ТелоСообщения;

	КонецЦикла;
		
КонецПроцедуры
