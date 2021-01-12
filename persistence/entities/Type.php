<?php
// Сущность "Тип книги"
class Type {
  // уникальный id - будет генерироваться БД при вставке строки
  protected $id;
  // название типа
  protected $name;
  // Конструктор
  function __construct(
    $name
    , $id = 0
    ) {
    $this->id = $id;
    $this->name = $name;
  }
  // вставка строки о типе книге в БД
  function create () {
    try {
      // Получаем контекст для работы с БД
      $pdo = getDbContext();
      // Готовим sql-запрос добавления строки в таблицу "Тип"
      $ps = $pdo->prepare("INSERT INTO `Type` (`name`) VALUES (:name)");
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
  // Редактирование строки о типе книги по его идентификатору
  function edit() {
    try {
      // Удаляем старую версию строки из БД
      Type::delete($this->id);
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
      //Получаем контекст для работы с БД
      $pdo = getDbContext();
      // Готовим sql-запрос удаления строки из таблицы "Тип"
      $pdo->exec("DELETE FROM `Type` WHERE `id` = $id");
    } catch (PDOException $e) {
      $err = $e->getMessage();
      if (substr($err, 0, strrpos($err, ":")) == 'SQLSTATE[23000]:Integrity constraint violation') {
        return 1062;
      } else {
        return $e->getMessage();
      }
    }
  }
  // Получение списка всех периодов из БД
  static function getAll () {
    // Переменная для подготовленного запроса
    $ps = null;
    // Переменная для результата запроса
    $types = null;
    try {
        // Получаем контекст для работы с БД
        $pdo = getDbContext();
        // пытаемся получить только три значения из строк, идентификаторы которых меньше заданного
        $ps = $pdo->prepare("SELECT * FROM `Type`");
        // Выполняем
        $ps->execute();
        //Сохраняем полученные данные в ассоциативный массив
        $types = $ps->fetchAll();
        return $types;
    } catch (PDOException $e) {
        echo $e->getMessage();
        return false;
    }
  }
   // Получение списка типов из БД
   static function filter($args) {
    // Переменная для подготовленного запроса
    $ps = null;
    // Переменная для результата запроса
    $types = null;
    try {
        // Получаем контекст для работы с БД
        $pdo = getDbContext();
        $types = null;
        // if($args['startsWith'] !== ''){
          // пытаемся получить все записи и странах
          $ps = $pdo->prepare("SELECT * FROM `Type` WHERE `id` != 3");
          // Выполняем
          $ps->execute();
          //Сохраняем полученные данные в ассоциативный массив
          $types = $ps->fetchAll();
        // } else {
        //   $countries = [];
        // }
        return $types;
    } catch (PDOException $e) {
        echo $e->getMessage();
        return false;
    }
  }
}