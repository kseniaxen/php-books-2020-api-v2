<?php
if (isset($_REQUEST['controller'])) {
  //Открываем блок перехвата исключений
	try {
		//Создаем переменную с ответом по умолчанию
		$response = "no results";
		//Подключаем файл работы с БД
		require_once('persistence/db_connector.php');
		//Подключаем файл сущности "Рабочие часы"
		// require_once('../persistence/entities/Hour.php'); 

		//Если связь с БД установлена
		if (getDbContext()) {
			
			//Читаем значение параметра запроса с именем action
			$controller = $_REQUEST['controller'];
		
			//Действуем далее в зависимости от этого значения
			switch ($controller) {
				//Получение списка доступных периодов работы указанного мастера в указанного день
				//(для формы пользовательской бронирования)
				case 'books': {
					//Получаем из БД список заказов в виде многомерного массива
              //$hours = Hour::GetAvailableHours($_REQUEST['manicurist-id'], $_REQUEST['date']);
              $books = json_decode(file_get_contents('php://input'));
			        //Кодируем его в формат json и сохраняем в переменную ответа
	        		$response = json_encode(['books' => $books]);
					break;
				}
				default: {
					
					$response = "unknown action";
					break;
				}
			}
		} else {

			$response = "connection eror";
		}
	} catch (Exception $e) {

            $response = $e->getMessage();
    }
    //Отправляем в браузер то, что получилось в переменной ответа
    //(данные / сообщение об успешном выполнении / об ошибке)
	echo $response;
}
/* $uri = $_SERVER['REQUEST_URI'];
$query = $_SERVER['QUERY_STRING'];
var_dump($uri);
var_dump($query); */

// $data = json_decode($_POST["data"]);
// var_dump($data);

// $p = file_get_contents('php://input');
// var_dump($p);