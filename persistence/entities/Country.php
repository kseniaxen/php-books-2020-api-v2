<?php
// Сущность "Страна"
class Country {
  // уникальный id - будет генерироваться БД при вставке строки
  protected $id;
  // название страны
  protected $name;
  // Конструктор
  function __construct(
    $name
    , $id = 0
    ) {
    $this->id = $id;
    $this->name = $name;
  }
  // вставка строки о стране в БД
  function create () {
    try {
      // Получаем контекст для работы с БД
      $pdo = getDbContext();
      // Готовим sql-запрос добавления строки в таблицу "Страна"
      $ps = $pdo->prepare("INSERT INTO `Country` (`name`) VALUES (:name)");
      // Превращаем объект в массив
      $ar = get_object_vars($this);
      // Удаляем из него первый элемент - id потому что его создаст СУБД
      array_shift($ar);
      // Выполняем запрос к БД для добавления записи
      $ps->execute($ar);
    } catch (PDOException $e) {
      // Если произошла ошибка - возвращаем ее текст
      $err = $e->getMessage();
      if (substr($err, 0, strrpos($err, ":")) == 'SQLSTATE[23000]:Integrity constraint violation') {
        return 1062;
      } else {
        return $e->getMessage();
      }
    }
  }
  // Редактирование строки о стране по ее идентификатору
  function edit() {
    try {
      // Удаляем старую версию строки из БД
      Country::delete($this->id);
      // Вставляем новую версию строки в БД
      $this->create();
    } catch (PDOException $e) {
      $err = $e->getMessage();
      if (substr($err, 0, strrpos($err, ":")) == 'SQLSTATE[23000]:Integrity constraint violation') {
        return 1062;
      } else {
        return $e->getMessage();
      }
    }
  }
  // Удаление строки из БД по идентификатору
  function delete ($id) {
    try {
      // Получаем контекст для работы с БД
      $pdo = getDbContext();
      // Готовим sql-запрос удаления строки из таблицы  "Страна"
      $pdo->exec("DELETE FROM `Country` WHERE `id` = $id");
    } catch (PDOException $e) {
      $err = $e->getMessage();
      if (substr($err, 0, strrpos($err, ":")) == 'SQLSTATE[23000]:Integrity constraint violation') {
        return 1062;
      } else {
        return $e->getMessage();
      }
    }
  }
  //Получение списка всех стран из БД
  static function getAll () {
    // Переменная для подготовленного запроса
    $ps = null;
    // Переменная для результата запроса
    $countries = null;
    try {
        // Получаем контекст для работы с БД
        $pdo = getDbContext();
        // пытаемся получить все записи и странах
        $ps = $pdo->prepare("SELECT * FROM `Country`");
        // Выполняем
        $ps->execute();
        //Сохраняем полученные данные в ассоциативный массив
        $countries = $ps->fetchAll();
        return $countries;
    } catch (PDOException $e) {
        echo $e->getMessage();
        return false;
    }
  }
}