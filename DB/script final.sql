-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: sql10.freesqldatabase.com
-- Tempo de geração: 23/05/2018 às 19:34
-- Versão do servidor: 5.5.58-0ubuntu0.14.04.1
-- Versão do PHP: 7.0.30-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
create database sql10232285;
use sql10232285;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sql10232285`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE PROCEDURE `proc_AttHorario` (IN `DiadaSemana` VARCHAR(25), IN `Serie` VARCHAR(25), IN `Aula` INT, IN `Disciplina` VARCHAR(25), IN `Professor` INT)  Begin
Declare CodigoH, CodigoD, CodigoS, CodigoDia int;

select func_DiadaSemana(DiadaSemana) into CodigoDia;

select concat(a.Serie_INT_Codigo, CodigoDia, Aula) into CodigoH from pcc_tb_serie a where 
a.Serie_st_descricao = Serie;

select a.disc_int_codigo into CodigoD from pcc_tb_disciplina a where a.Disc_ST_Descricao = Disciplina;

select Serie_INT_Codigo into CodigoS from pcc_tb_serie where Serie_ST_Descricao = Serie;

update pcc_tb_horario set Pro_INT_Codigo = Professor, Disc_INT_Codigo = CodigoD where Hor_INT_Codigo = CodigoH; 



END$$

CREATE PROCEDURE `proc_DelChamada` ()  Begin

delete from pcc_tb_listachamada;
delete from pcc_tb_situacaolista;

END$$

CREATE PROCEDURE `proc_NovasListas` ()  Begin
Declare i int;
set i =1;
while i<=12 do
insert into pcc_tb_situacaolista values (i, 'Fechada', i);
set i = i+1;
END While;

END$$


CREATE PROCEDURE `proc_CadastraAlunoSerie` (`CodAluno` INT, `Serie` VARCHAR(25))  Begin
Declare CodigoS int;

select a.Serie_INT_Codigo into CodigoS from pcc_tb_serie a where a.Serie_ST_Descricao = Serie;

insert into pcc_tb_aluno_serie(ano_int_codigo, aluno_int_codigo) values(CodigoS, CodAluno);

End$$

CREATE PROCEDURE `proc_CadHorario` (IN `DiadaSemana` VARCHAR(25), IN `Serie` VARCHAR(25), IN `Aula` VARCHAR(1), IN `Disciplina` VARCHAR(25), IN `Professor` INT)  Begin
Declare CodigoH, CodigoD, CodigoS, CodigoDia int;

select func_DiadaSemana(DiadaSemana) into CodigoDia;

select concat(a.Serie_INT_Codigo, CodigoDia, Aula) into CodigoH from pcc_tb_serie a where 
a.Serie_st_descricao = Serie;

select a.disc_int_codigo into CodigoD from pcc_tb_disciplina a where a.Disc_ST_Descricao = Disciplina;

select Serie_INT_Codigo into CodigoS from pcc_tb_serie where Serie_ST_Descricao = Serie;

insert into pcc_tb_horario(hor_int_codigo, Hor_st_DiaDaSemana, Hor_int_Aula, Disc_int_Codigo, Serie_int_codigo, Pro_int_codigo) values 
(CodigoH, DiadaSemana, Aula, CodigoD, CodigoS, Professor);


END$$

CREATE PROCEDURE `proc_CadResponsavel` (IN `CodR` INT, IN `CodAluno` INT, IN `DescResp` VARCHAR(45))  begin

declare maximo, qtd int;

select count(*) into qtd from pcc_tb_responsavel a, pcc_tb_pessoas b where a.Alu_INT_Codigo = b.Pess_inT_codigo and b.Pess_INT_Codigo = CodAluno;
select max(a.Res_INT_Codigo) into maximo from pcc_tb_responsavel a, pcc_tb_pessoas b where a.Alu_INT_Codigo = b.Pess_inT_codigo and b.Pess_INT_Codigo = CodAluno;
 
 if (qtd = 0)  then
 set maximo = 1;
 else 
 set maximo= maximo+1;
 end if;
 
insert into pcc_tb_responsavel(res_int_codigo, alu_int_codigo, resp_int_codigo , res_st_descrição ) values (maximo, CodAluno, CodR, DescResp);

END$$

CREATE PROCEDURE `proc_CadTelefone` (IN `Codigo` INT, IN `Telefone` VARCHAR(20), IN `DescricaoTel` VARCHAR(45))  begin
Declare CodTel  int;
declare maximo, qtd int;


set CodTel = Codigo;

select count(*) into qtd from pcc_tb_telefone a, pcc_tb_pessoas b where a.Pess_inT_codigo = b.Pess_inT_codigo and b.Pess_INT_Codigo = CodTel;
select max(tel_int_codigo) into maximo from pcc_tb_telefone a, pcc_tb_pessoas b where a.Pess_inT_codigo = b.Pess_inT_codigo and b.Pess_INT_Codigo = CodTel; 
 
 if (qtd = 0)  then
 set maximo = 1;
 else 
 set maximo= maximo+1;
 end if;
 
insert into pcc_tb_telefone(tel_int_codigo, tel_st_numero, tel_st_descricao, Pess_int_codigo ) values (maximo, Telefone, DescricaoTel, CodTel);

END$$

CREATE PROCEDURE `proc_Frequencia` (`ra` INT, `disc` INT)  BEGIN
   declare aula, presenca, falta int;
   declare porc float;
   declare freq varchar(5);
   declare materia varchar(20);
   
   select count(*) into aula from pcc_tb_listachamada a, pcc_tb_horario b, pcc_tb_disciplina c where a.Aluno_INT_Codigo = ra and a.Hor_INT_Codigo = b.Hor_INT_Codigo and b.Disc_INT_Codigo = c.Disc_INT_Codigo and c.Disc_INT_Codigo = disc;
   
	select Disc_ST_Descricao into materia from pcc_tb_disciplina where Disc_INT_Codigo = disc;

select count(*) into presenca from pcc_tb_listachamada a, pcc_tb_horario b, pcc_tb_disciplina c where a.Aluno_INT_Codigo = ra and a.Hor_INT_Codigo = b.Hor_INT_Codigo and b.Disc_INT_Codigo = c.Disc_INT_Codigo and c.Disc_INT_Codigo = disc and a.Lista_ST_SituacaoAluno = 'Presente';

select count(*) into falta from pcc_tb_listachamada a, pcc_tb_horario b, pcc_tb_disciplina c where a.Aluno_INT_Codigo = ra and a.Hor_INT_Codigo = b.Hor_INT_Codigo and b.Disc_INT_Codigo = c.Disc_INT_Codigo and c.Disc_INT_Codigo = disc and a.Lista_ST_SituacaoAluno = 'falta';
   
      
   set porc = (presenca/aula)*100;
   set freq = concat(porc, "%");
   
   select materia as 'Matéria', aula as 'Quantidade de Aulas', presenca as 'Quantidade de Presenças', falta as 'Quantidade de Faltas', freq as 'Percentual de Frequência';
    
   END$$

CREATE PROCEDURE `proc_ListaDeChamada` (`Aula` INT, `Serie` VARCHAR(20), `Professor` INT, `DataChamada` DATE, `Disciplina` VARCHAR(45))  BEGIN

select a.Pess_INT_Codigo, a.Pess_ST_Nome, b.Lista_ST_SituacaoAluno from pcc_tb_listachamada b, pcc_tb_pessoas a
where Hor_INT_Codigo = (select Hor_INT_Codigo from pcc_tb_horario where Pro_INT_Codigo = Professor and Disc_INT_Codigo = (
select Disc_INT_Codigo from pcc_tb_disciplina where Disc_ST_Descricao = disciplina) and Hor_INT_Aula = Aula and 
Serie_INT_Codigo = (select Serie_INT_Codigo from pcc_tb_serie where Serie_ST_Descricao = Serie)) 
and Lista_DT_Data like '%DataChamada%' and a.Pess_INT_Codigo = b.Aluno_INT_Codigo;
End$$

CREATE PROCEDURE `proc_SelecionaDisciplina` (`RA` INT)  BEGIN

select a.Disc_ST_Descricao from pcc_tb_disciplina a, pcc_tb_pessoas b, pcc_tb_aluno_serie c, pcc_tb_horario d, pcc_tb_serie e where
 b.pess_int_codigo = c.aluno_int_codigo and c.ano_int_codigo = e.serie_int_codigo and
e.serie_int_codigo = d.serie_int_codigo and b.Pess_INT_Codigo = RA;

END$$

--
-- Funções
--
CREATE  FUNCTION `func_aula` (`hora` TIME) RETURNS INT(11) BEGIN
    if (DATE_FORMAT(hora,'%H:%i:%S')>= '07:30:00' && DATE_FORMAT(hora,'%H:%i:%S')< '08:20:00') then
    return 1;
    END IF;
    
    if (DATE_FORMAT(hora,'%H:%i:%S')>= '08:20:00' && DATE_FORMAT(hora,'%H:%i:%S')< '09:10:00') then
    return 2;
    END IF;
    
    if (DATE_FORMAT(hora,'%H:%i:%S')>= '09:10:00' && DATE_FORMAT(hora,'%H:%i:%S')< '10:00:00') then
    return 3;
    END IF;
    
    if (DATE_FORMAT(hora,'%H:%i:%S')>= '10:20:00' && DATE_FORMAT(hora,'%H:%i:%S')< '11:10:00') then
    return 4;
    END IF;
    
    if (DATE_FORMAT(hora,'%H:%i:%S')>= '11:10:00' && DATE_FORMAT(hora,'%H:%i:%S')< '12:00:00') then
    return 5;
    END IF;
   END$$

CREATE  FUNCTION `func_DiadaSemana` (`Dia` VARCHAR(20)) RETURNS INT(11) Begin
Declare D int;

	if(Dia = 'Segunda') then 
		set D = 1;
	end if;
    
    if(Dia = 'Terça') then 
		set D = 2;
	end if;
    
    if(Dia = 'Quarta') then 
		set D = 3;
	end if;
    
    if(Dia = 'Quinta') then 
		set D = 4;
	end if;
    
    if(Dia = 'Sexta') then 
		set D = 5;
	end if;
    
    return D;
    
END$$

CREATE  FUNCTION `func_nomeDia` (`Dia` VARCHAR(20)) RETURNS VARCHAR(20) CHARSET latin1 Begin
	Declare nome_dia varchar(20);
    Declare nome_final varchar(20);
	select dayname(Dia) into nome_dia;
    
    if(nome_dia = 'Monday') then
		set nome_final = 'Segunda';
	end if;
        
	if(nome_dia = 'Tuesday') then
		set nome_final = 'Terça';
	end if;
        
	if(nome_dia = 'Wednesday') then
		set nome_final = 'Quarta';
	end if;
        
	if(nome_dia = 'Thursday') then
		set nome_final = 'Quinta';
	end if;
        
	if(nome_dia = 'Friday') then
		set nome_final = 'Sexta';
	end if;
        
	if(nome_dia = 'Saturday') then
		set nome_final = 'Sábado';
	end if;
        
	if(nome_dia = 'Sunday') then
		set nome_final = 'Domingo';
	end if;
    
    return nome_final;
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_aluno_serie`
--

CREATE TABLE `pcc_tb_aluno_serie` (
  `Ano_INT_Codigo` int(11) NOT NULL,
  `Aluno_INT_Codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `pcc_tb_aluno_serie`
--

INSERT INTO `pcc_tb_aluno_serie` (`Ano_INT_Codigo`, `Aluno_INT_Codigo`) VALUES
(1, 35),
(1, 36),
(1, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(1, 42),
(1, 43),
(1, 44),
(2, 55),
(2, 56),
(2, 57),
(2, 58),
(2, 59),
(2, 60),
(2, 61),
(2, 62),
(2, 63),
(2, 64),
(2, 275),
(3, 75),
(3, 76),
(3, 77),
(3, 78),
(3, 79),
(3, 80),
(3, 81),
(3, 82),
(3, 83),
(3, 84),
(4, 95),
(4, 96),
(4, 97),
(4, 98),
(4, 99),
(4, 100),
(4, 101),
(4, 102),
(4, 103),
(4, 104),
(5, 115),
(5, 116),
(5, 117),
(5, 118),
(5, 119),
(5, 120),
(5, 121),
(5, 122),
(5, 123),
(5, 124),
(6, 135),
(6, 136),
(6, 137),
(6, 138),
(6, 139),
(6, 140),
(6, 141),
(6, 142),
(6, 143),
(6, 144),
(7, 155),
(7, 156),
(7, 157),
(7, 158),
(7, 159),
(7, 160),
(7, 161),
(7, 162),
(7, 163),
(7, 164),
(7, 276),
(8, 175),
(8, 176),
(8, 177),
(8, 178),
(8, 179),
(8, 180),
(8, 181),
(8, 182),
(8, 183),
(8, 184),
(9, 195),
(9, 196),
(9, 197),
(9, 198),
(9, 199),
(9, 200),
(9, 201),
(9, 202),
(9, 203),
(9, 204),
(10, 215),
(10, 216),
(10, 217),
(10, 218),
(10, 219),
(10, 220),
(10, 221),
(10, 222),
(10, 223),
(10, 224),
(11, 255),
(11, 256),
(11, 257),
(11, 258),
(11, 259),
(11, 260),
(11, 261),
(11, 262),
(11, 263),
(11, 264),
(12, 13),
(12, 14),
(12, 15),
(12, 16),
(12, 17),
(12, 18),
(12, 19),
(12, 20);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_disciplina`
--

CREATE TABLE `pcc_tb_disciplina` (
  `Disc_INT_Codigo` int(11) NOT NULL,
  `Disc_ST_Descricao` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `pcc_tb_disciplina`
--

INSERT INTO `pcc_tb_disciplina` (`Disc_INT_Codigo`, `Disc_ST_Descricao`) VALUES
(1, 'Matemática'),
(2, 'Português'),
(3, 'Biologia'),
(4, 'Química'),
(5, 'História'),
(6, 'Ciências'),
(7, 'Sociologia'),
(8, 'Filosofia'),
(9, 'Artes'),
(10, 'Educação Física'),
(11, 'Física'),
(12, 'Inglês'),
(13, 'Espanhol');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_horario`
--

CREATE TABLE `pcc_tb_horario` (
  `Hor_INT_Codigo` int(11) NOT NULL,
  `Hor_ST_DiaDaSemana` varchar(20) NOT NULL,
  `Hor_INT_Aula` int(11) NOT NULL,
  `Disc_INT_Codigo` int(11) NOT NULL,
  `Serie_INT_Codigo` int(11) NOT NULL,
  `Pro_INT_Codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `pcc_tb_horario`
--

INSERT INTO `pcc_tb_horario` (`Hor_INT_Codigo`, `Hor_ST_DiaDaSemana`, `Hor_INT_Aula`, `Disc_INT_Codigo`, `Serie_INT_Codigo`, `Pro_INT_Codigo`) VALUES
(611, 'Segunda', 1, 5, 6, 9),
(612, 'Segunda', 2, 1, 6, 1),
(613, 'Segunda', 3, 2, 6, 2),
(614, 'Segunda', 4, 3, 6, 4),
(615, 'Segunda', 5, 7, 6, 7),
(1211, 'Segunda', 1, 1, 12, 1),
(1212, 'Segunda', 2, 1, 12, 1),
(1213, 'Segunda', 3, 1, 12, 1),
(1214, 'Segunda', 4, 2, 12, 2),
(1215, 'Segunda', 5, 2, 12, 2),
(1221, 'Terça', 1, 2, 12, 2),
(1222, 'Terça', 2, 3, 12, 3),
(1223, 'Terça', 3, 3, 12, 3),
(1224, 'Terça', 4, 4, 12, 4),
(1225, 'Terça', 5, 4, 12, 4),
(1231, 'Quarta', 1, 5, 12, 5),
(1232, 'Quarta', 2, 5, 12, 5),
(1233, 'Quarta', 3, 6, 12, 6),
(1234, 'Quarta', 4, 6, 12, 6),
(1235, 'Quarta', 5, 7, 12, 7),
(1241, 'Quinta', 1, 7, 12, 7),
(1242, 'Quinta', 2, 8, 12, 8),
(1243, 'Quinta', 3, 8, 12, 8),
(1244, 'Quinta', 4, 9, 12, 9),
(1245, 'Quinta', 5, 9, 12, 9),
(1251, 'Sexta', 1, 10, 12, 10),
(1252, 'Sexta', 2, 10, 12, 10),
(1253, 'Sexta', 3, 11, 12, 11),
(1254, 'Sexta', 4, 11, 12, 11),
(1255, 'Sexta', 5, 12, 12, 12);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_listachamada`
--

CREATE TABLE `pcc_tb_listachamada` (
  `Lista_INT_Codigo` int(11) NOT NULL,
  `Lista_ST_SituacaoAluno` varchar(45) NOT NULL,
  `Lista_DT_Data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Aluno_INT_Codigo` int(11) NOT NULL,
  `Hor_INT_Codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_pessoas`
--

CREATE TABLE `pcc_tb_pessoas` (
  `Pess_INT_Codigo` int(11) NOT NULL,
  `Pess_ST_Nome` varchar(45) NOT NULL,
  `Pess_ST_Rua` varchar(45) NOT NULL,
  `Pess_ST_Numero` varchar(45) NOT NULL,
  `Pess_ST_Complemento` varchar(45) DEFAULT NULL,
  `Pess_ST_Bairro` varchar(45) NOT NULL,
  `Pess_ST_Cidade` varchar(45) NOT NULL,
  `Pess_ST_UF` varchar(2) NOT NULL,
  `Pess_ST_DataNasc` varchar(10) NOT NULL,
  `Pess_ST_Rg` varchar(15) NOT NULL,
  `Pess_ST_CPF` varchar(20) NOT NULL,
  `Pess_ST_Tipo` varchar(45) NOT NULL,
  `Pess_ST_Email` varchar(45) DEFAULT NULL,
  `Pess_ST_Senha` varchar(45) DEFAULT NULL,
  `Pess_ST_Situacao` varchar(45) NOT NULL,
  `Pess_INT_CEP` int(11) NOT NULL,
  `Pess_JPG_Foto` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `pcc_tb_pessoas`
--

INSERT INTO `pcc_tb_pessoas` (`Pess_INT_Codigo`, `Pess_ST_Nome`, `Pess_ST_Rua`, `Pess_ST_Numero`, `Pess_ST_Complemento`, `Pess_ST_Bairro`, `Pess_ST_Cidade`, `Pess_ST_UF`, `Pess_ST_DataNasc`, `Pess_ST_Rg`, `Pess_ST_CPF`, `Pess_ST_Tipo`, `Pess_ST_Email`, `Pess_ST_Senha`, `Pess_ST_Situacao`, `Pess_INT_CEP`, `Pess_JPG_Foto`) VALUES
(1, 'Madalena Ramos', 'Rua 1', '165', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(2, 'Joaquim Andrade', 'Rua 2', '53', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(3, 'Carlos Alves', 'Rua 3', '198', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(4, 'Márcio Lisboa', 'Rua 4', '43', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(5, 'Daniela Luz', 'Rua 5', '15', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(6, 'Renan Souza', 'Rua 6', '168', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(7, 'Henrique Dantas', 'Rua 7', '34', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(8, 'Danilo Andrade', 'Rua 8', '125', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(9, 'Marcela Oliveira', 'Rua 9', '87', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(10, 'Renata Sandra da Silva', 'Rua 10', '28', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(11, 'Liliane Santana', 'Rua 11', '29', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(12, 'Thaís Lobo', 'Rua 12', '75', '0', 'Centro', 'Extrema', 'MG', '01/01/1969', '0', '0', 'Professor', NULL, NULL, 'Ativado', 0, NULL),
(13, 'Jonathan Ribeiro', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'Aluno', NULL, NULL, 'Ativado', 0, NULL),
(14, 'Marcelo Silva Lima', 'Rua Limoeiro', '135', '', 'Centro', 'Bragança Paulista', '1', '1', '1', '1', 'Aluno', 'marcelinho.vl@gmail.com', NULL, 'Ativado', 0, NULL),
(15, 'Natália Silva Lima', 'Rua Limoeiro', '135', '', 'Centro', 'Bragança Paulista', '1', '1', '1', '1', 'Aluno', 'naaaty@hotmail.com', NULL, 'Ativado', 0, NULL),
(16, 'Mariana Palazzi', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'Aluno', NULL, NULL, 'Ativado', 0, NULL),
(17, 'Suzanne Cassanha', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'Aluno', NULL, NULL, 'Ativado', 0, NULL),
(18, 'Débora Dias', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'Aluno', NULL, NULL, 'Ativado', 0, NULL),
(19, 'Paulo Alves', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'Aluno', NULL, NULL, 'Ativado', 0, NULL),
(20, 'Sérgio Oliveira', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'Aluno', NULL, NULL, 'Ativado', 0, NULL),
(21, 'João Ribeiro', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'Responsável', 'joao@gmail.com', 'teste', 'Ativado', 0, 'id_h6'),
(22, 'Mário Silva', 'Rua Limoeiro', '135', '', 'Centro', 'Bragança Paulista', '1', '1', '1', '1', 'Responsável', 'mario@gmail.com', 'teste', 'Ativado', 0, 'id_22'),
(23, 'Nataly Lima', 'Rua Limoeiro', '135', '', 'Centro', 'Bragança Paulista', 'SP', '14/08/1975', '23312', '123.456.789-10', 'Responsável', 'nataly@gmail.com', 'teste', 'Ativado', 0, 'id_23'),
(24, 'MARIA PALAZZI', 'AVENIDA DA SAUDADE', '17', '', 'CENTRO', 'EXTREMA', 'MG', '19/12/1986', '21.212.212-12', '321.312.343-43', 'Responsável', 'maria@gmail.com', 'teste', 'Ativado', 0, 'id_m3'),
(25, 'ODETE CASSANHA', 'Rua Nenê', '178', '', 'Centro', 'Extrema', 'MG', '1989-08-11', '11.111.111-11', '121.221.323-32', 'Responsável', 'odete@gmail.com', 'teste', 'Ativado', 0, 'id_m2'),
(26, 'CARLOS DIAS', 'Rua Antoni Bertoleto', '176', '', 'Centro', 'Extrema', 'MG', '1 /  /    ', '12.121.212-11', '098.765.432-12', 'Responsável', 'carlos@gmail.com', 'teste', 'Ativado', 0, 'id_h5'),
(27, 'Pedro Alves', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'Responsável', 'pedro@gmail.com', 'teste', 'Ativado', 0, 'id_h2'),
(28, 'HENRIQUE OLIVEIRA', 'RUA SUEKUNI', '198', '', 'BELA VISTA', 'EXTREMA', 'MG', '11/09/1976', '32.232.232-32', '875.853.454-33', 'Responsável', 'henrique@gmail.com', 'teste', 'Ativado', 0, 'id_h4'),
(29, 'Josefa Costa', 'Rua João Mendes', '45', 'Fundos', 'Centro', 'Joanópolis', 'SP', '18/06/1987', '4370981', '19876149056', 'Funcionário', 'victor.me@hotmail.com', 'login', 'Ativado', 0, NULL),
(30, 'Rogerinho', 'Centro', '741', 'Fundos', 'Centro', 'Piracaia', 'SC', '05/05/2000', '45.646.545-64', '123.132.123-12', 'Aluno', 'rogerinho@uol.com', '1230', 'Ativado', 0, 'null'),
(31, 'Admin', 'Centro', '250', '', 'Jardim', 'piracaia', 'SP', '07/05/2018', '11.111.111-11', '111.111.111-11', 'Funcionário', 'admin@gmail.com', '1111', 'Ativado', 0, 'id_'),
(32, 'Fernando Silva', 'Avenida Geronimo', '2000', '', 'Centro', 'Atibaia', 'SP', '04/05/1998', '89.989.879-79', '564.564.654-65', 'Aluno', 'fernando@uol.com', '1452', 'Ativado', 0, 'id_'),
(33, 'Paulo', 'Centro', '456', '', 'Centro', 'Atibaia', 'SP', '01/02/1982', '45.678.921-31', '564.879.897-23', 'Responsável', 'paulo@hotmail.com', '1452', 'Ativado', 0, 'id_'),
(35, 'Camila Oliveira', 'Rua João Suekumi', '1', '', 'Centro', 'Extrema', 'MG', '10/05/1985', '1544312', '12354190876', 'Aluno', '', '', 'Ativado', 0, ''),
(36, 'Dilma Ramos', 'Rua Padre Carbone', '2', '', 'Centro', 'Extrema', 'MG', '11/05/1985', '1544313', '12354190877', 'Aluno', '', '', 'Ativado', 0, ''),
(37, 'Analia Andrade', 'Rua Capitão Germano', '3', '', 'Centro', 'Extrema', 'MG', '12/05/1985', '1544314', '12354190878', 'Aluno', '', '', 'Ativado', 0, ''),
(38, 'Caio Alves', 'Rua Nenê', '4', '', 'Centro', 'Extrema', 'MG', '13/05/1985', '1544315', '12354190879', 'Aluno', '', '', 'Ativado', 0, ''),
(39, 'Bianca Lisboa', 'Rua Adelino Salvador', '5', '', 'Centro', 'Extrema', 'MG', '14/05/1985', '1544316', '12354190880', 'Aluno', '', '', 'Ativado', 0, ''),
(40, 'Leonardo Luz', 'Rua Diamantina', '6', '', 'Centro', 'Extrema', 'MG', '15/05/1985', '1544317', '12354190881', 'Aluno', '', '', 'Ativado', 0, ''),
(41, 'Florisvaldo Lima', 'Rua Lambari', '7', '', 'Centro', 'Extrema', 'MG', '16/05/1985', '1544318', '12354190882', 'Aluno', '', '', 'Ativado', 0, ''),
(42, 'Raimundo Souza', 'Rua Bragança', '8', '', 'Centro', 'Extrema', 'MG', '17/05/1985', '1544319', '12354190883', 'Aluno', '', '', 'Ativado', 0, ''),
(43, 'Camilla Dantas', 'Rua Domingos Zingari', '9', '', 'Centro', 'Extrema', 'MG', '18/05/1985', '1544320', '12354190884', 'Aluno', '', '', 'Ativado', 0, ''),
(44, 'Janaina Andrade', 'Rua Alexandre Bertolote', '10', '', 'Centro', 'Extrema', 'MG', '19/05/1985', '1544321', '12354190885', 'Aluno', '', '', 'Ativado', 0, ''),
(45, 'Lucas Oliveira', 'Rua João Suekumi', '1', '', 'Centro', 'Extrema', 'MG', '20/05/2012', '1544322', '12354190886', 'Responsável', 'lucas01@gmail.com', 'senha', 'Ativado', 0, 'id_h2'),
(46, 'Esther Ramos', 'Rua Padre Carbone', '2', '', 'Centro', 'Extrema', 'MG', '21/05/2012', '1544323', '12354190887', 'Responsável', 'esther01@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(47, 'Sandra Andrade', 'Rua Capitão Germano', '3', '', 'Centro', 'Extrema', 'MG', '22/05/2012', '1544324', '12354190888', 'Responsável', 'sandra01@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(48, 'Renata Alves', 'Rua Nenê', '4', '', 'Centro', 'Extrema', 'MG', '23/05/2012', '1544325', '12354190889', 'Responsável', 'renata01@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(49, 'Bianca Lisboa', 'Rua Adelino Salvador', '5', '', 'Centro', 'Extrema', 'MG', '24/05/2012', '1544326', '12354190890', 'Responsável', 'bianca01@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(50, 'Gustavo Luz', 'Rua Diamantina', '6', '', 'Centro', 'Extrema', 'MG', '25/05/2012', '1544327', '12354190891', 'Responsável', 'gustavo01@gmail.com', 'senha', 'Ativado', 0, 'id_h1'),
(51, 'Lucas Lima', 'Rua Lambari', '7', '', 'Centro', 'Extrema', 'MG', '26/05/2012', '1544328', '12354190892', 'Responsável', 'luccas01@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(52, 'Laudy Souza', 'Rua Bragança', '8', '', 'Centro', 'Extrema', 'MG', '27/05/2012', '1544329', '12354190893', 'Responsável', 'laudy01@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(53, 'Leonardo Dantas', 'Rua Domingos Zingari', '9', '', 'Centro', 'Extrema', 'MG', '28/05/2012', '1544330', '12354190894', 'Responsável', 'leonardo01@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(54, 'Iris Andrade', 'Rua Alexandre Bertolote', '10', '', 'Centro', 'Extrema', 'MG', '29/05/2012', '1544331', '12354190895', 'Responsável', 'iris01@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(55, 'Adão Dias', 'Rua João Suekumi', '11', '', 'Centro', 'Extrema', 'MG', '10/05/1984', '1544332', '12354190896', 'Aluno', '', '', 'Ativado', 0, ''),
(56, 'Gustavo Santos', 'Rua Padre Carbone', '12', '', 'Centro', 'Extrema', 'MG', '11/05/1984', '1544333', '12354190897', 'Aluno', '', '', 'Ativado', 0, ''),
(57, 'Jennifer Henrique', 'Rua Capitão Germano', '13', '', 'Centro', 'Extrema', 'MG', '12/05/1984', '1544334', '12354190898', 'Aluno', '', '', 'Ativado', 0, ''),
(58, 'Nathália Rodrigues', 'Rua Nenê', '14', '', 'Centro', 'Extrema', 'MG', '13/05/1984', '1544335', '12354190899', 'Aluno', '', '', 'Ativado', 0, ''),
(59, 'Ciene Martins', 'Rua Adelino Salvador', '15', '', 'Centro', 'Extrema', 'MG', '14/05/1984', '1544336', '12354190900', 'Aluno', '', '', 'Ativado', 0, ''),
(60, 'Claudia Martins', 'Rua Diamantina', '16', '', 'Centro', 'Extrema', 'MG', '15/05/1984', '1544337', '12354190901', 'Aluno', '', '', 'Ativado', 0, ''),
(61, 'John Nissa', 'Rua Lambari', '17', '', 'Centro', 'Extrema', 'MG', '16/05/1984', '1544338', '12354190902', 'Aluno', '', '', 'Ativado', 0, ''),
(62, 'Marllon João', 'Rua Bragança', '18', '', 'Centro', 'Extrema', 'MG', '17/05/1984', '1544339', '12354190903', 'Aluno', '', '', 'Ativado', 0, ''),
(63, 'Nathalia Wendder', 'Rua Domingos Zingari', '19', '', 'Centro', 'Extrema', 'MG', '18/05/1984', '1544340', '12354190904', 'Aluno', '', '', 'Ativado', 0, ''),
(64, 'Jéssica Gabrielly', 'Rua Alexandre Bertolote', '20', '', 'Centro', 'Extrema', 'MG', '19/05/1984', '1544341', '12354190905', 'Aluno', '', '', 'Ativado', 0, ''),
(65, 'Gustavo Dias', 'Rua João Suekumi', '1', '', 'Centro', 'Extrema', 'MG', '20/05/2011', '1544342', '12354190906', 'Responsável', 'gustavo02@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(66, 'Livia Santos', 'Rua Padre Carbone', '2', '', 'Centro', 'Extrema', 'MG', '21/05/2011', '1544343', '12354190907', 'Responsável', 'livia02@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(67, 'Júlia Henrique', 'Rua Capitão Germano', '3', '', 'Centro', 'Extrema', 'MG', '22/05/2011', '1544344', '12354190908', 'Responsável', 'julia02@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(68, 'Morgana Rodrigues', 'Rua Nenê', '4', '', 'Centro', 'Extrema', 'MG', '23/05/2011', '1544345', '12354190909', 'Responsável', 'morgana02@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(69, 'Gustavo Martins', 'Rua Adelino Salvador', '5', '', 'Centro', 'Extrema', 'MG', '24/05/2011', '1544346', '12354190910', 'Responsável', 'gusttavo02@gmail.com', 'senha', 'Ativado', 0, 'id_h1'),
(70, 'Rayany Martins', 'Rua Diamantina', '6', '', 'Centro', 'Extrema', 'MG', '25/05/2011', '1544347', '12354190911', 'Responsável', 'rayany02@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(71, 'Fabiane Nissa', 'Rua Lambari', '7', '', 'Centro', 'Extrema', 'MG', '26/05/2011', '1544348', '12354190912', 'Responsável', 'fabiane02@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(72, 'Matheus João', 'Rua Bragança', '8', '', 'Centro', 'Extrema', 'MG', '27/05/2011', '1544349', '12354190913', 'Responsável', 'matheus02@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(73, 'Karolina Wendder', 'Rua Domingos Zingari', '9', '', 'Centro', 'Extrema', 'MG', '28/05/2011', '1544350', '12354190914', 'Responsável', 'karol02@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(74, 'Lorrany Gabrielly', 'Rua Alexandre Bertolote', '10', '', 'Centro', 'Extrema', 'MG', '29/05/2011', '1544351', '12354190915', 'Responsável', 'lorrany02@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(75, 'Arthur Silva', 'Rua João Suekumi', '21', '', 'Centro', 'Extrema', 'MG', '10/05/1983', '1544352', '12354190916', 'Aluno', '', '', 'Ativado', 0, ''),
(76, 'Kayke Ferreira', 'Rua Padre Carbone', '22', '', 'Centro', 'Extrema', 'MG', '11/05/1983', '1544353', '12354190917', 'Aluno', '', '', 'Ativado', 0, ''),
(77, 'José Estevam', 'Rua Capitão Germano', '23', '', 'Centro', 'Extrema', 'MG', '12/05/1983', '1544354', '12354190918', 'Aluno', '', '', 'Ativado', 0, ''),
(78, 'Jennyfer Cabral', 'Rua Nenê', '24', '', 'Centro', 'Extrema', 'MG', '13/05/1983', '1544355', '12354190919', 'Aluno', '', '', 'Ativado', 0, ''),
(79, 'Maik Menezes', 'Rua Adelino Salvador', '25', '', 'Centro', 'Extrema', 'MG', '14/05/1983', '1544356', '12354190920', 'Aluno', '', '', 'Ativado', 0, ''),
(80, 'Paulo Cezar Paulo', 'Rua Diamantina', '26', '', 'Centro', 'Extrema', 'MG', '15/05/1983', '1544357', '12354190921', 'Aluno', '', '', 'Ativado', 0, ''),
(81, 'Pedro Neto', 'Rua Lambari', '27', '', 'Centro', 'Extrema', 'MG', '16/05/1983', '1544358', '12354190922', 'Aluno', '', '', 'Ativado', 0, ''),
(82, 'Antônio Feliciano', 'Rua Bragança', '28', '', 'Centro', 'Extrema', 'MG', '17/05/1983', '1544359', '12354190923', 'Aluno', '', '', 'Ativado', 0, ''),
(83, 'Ana Lucia Almeida', 'Rua Domingos Zingari', '29', '', 'Centro', 'Extrema', 'MG', '18/05/1983', '1544360', '12354190924', 'Aluno', '', '', 'Ativado', 0, ''),
(84, 'Wesley Almeida', 'Rua Alexandre Bertolote', '30', '', 'Centro', 'Extrema', 'MG', '19/05/1983', '1544361', '12354190925', 'Aluno', '', '', 'Ativado', 0, ''),
(85, 'Luana Silva', 'Rua João Suekumi', '21', '', 'Centro', 'Extrema', 'MG', '20/05/2010', '1544362', '12354190926', 'Responsável', 'luana03@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(86, 'Eduarda Ferreira', 'Rua Padre Carbone', '22', '', 'Centro', 'Extrema', 'MG', '21/05/2010', '1544363', '12354190927', 'Responsável', 'eduarda03@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(87, 'Rayane Estevam', 'Rua Capitão Germano', '23', '', 'Centro', 'Extrema', 'MG', '22/05/2010', '1544364', '12354190928', 'Responsável', 'rayane03@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(88, 'Cássio Cabral', 'Rua Nenê', '24', '', 'Centro', 'Extrema', 'MG', '23/05/2010', '1544365', '12354190929', 'Responsável', 'cassio03@gmail.com', 'senha', 'Ativado', 0, 'id_h3'),
(89, 'Nicoli Menezes', 'Rua Adelino Salvador', '25', '', 'Centro', 'Extrema', 'MG', '24/05/2010', '1544366', '12354190930', 'Responsável', 'nicolli03@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(90, 'Lucas Paulo', 'Rua Diamantina', '26', '', 'Centro', 'Extrema', 'MG', '25/05/2010', '1544367', '12354190931', 'Responsável', 'lucas03@gmail.com', 'senha', 'Ativado', 0, 'id_h1'),
(91, 'Kananda Neto', 'Rua Lambari', '27', '', 'Centro', 'Extrema', 'MG', '26/05/2010', '1544368', '12354190932', 'Responsável', 'kananda03@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(92, 'Larissa Feliciano', 'Rua Bragança', '28', '', 'Centro', 'Extrema', 'MG', '27/05/2010', '1544369', '12354190933', 'Responsável', 'larissa03@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(93, 'Paulo Henrique Almeida', 'Rua Domingos Zingari', '29', '', 'Centro', 'Extrema', 'MG', '28/05/2010', '1544370', '12354190934', 'Responsável', 'paulo03@gmail.com', 'senha', 'Ativado', 0, 'id_h3'),
(94, 'Weverton Almeida', 'Rua Alexandre Bertolote', '30', '', 'Centro', 'Extrema', 'MG', '29/05/2010', '1544371', '12354190935', 'Responsável', 'weverton03@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(95, 'José Lima', 'Rua João Suekumi', '31', '', 'Centro', 'Extrema', 'MG', '10/05/1982', '1544372', '12354190936', 'Aluno', '', '', 'Ativado', 0, ''),
(96, 'Débora Correia', 'Rua Padre Carbone', '32', '', 'Centro', 'Extrema', 'MG', '11/05/1982', '1544373', '12354190937', 'Aluno', '', '', 'Ativado', 0, ''),
(97, 'Naldo Rosa', 'Rua Capitão Germano', '33', '', 'Centro', 'Extrema', 'MG', '12/05/1982', '1544374', '12354190938', 'Aluno', '', '', 'Ativado', 0, ''),
(98, 'Ivoneir Ferreira', 'Rua Nenê', '34', '', 'Centro', 'Extrema', 'MG', '13/05/1982', '1544375', '12354190939', 'Aluno', '', '', 'Ativado', 0, ''),
(99, 'Matheus Batista', 'Rua Adelino Salvador', '35', '', 'Centro', 'Extrema', 'MG', '14/05/1982', '1544376', '12354190940', 'Aluno', '', '', 'Ativado', 0, ''),
(100, 'João Ferreira', 'Rua Diamantina', '36', '', 'Centro', 'Extrema', 'MG', '15/05/1982', '1544377', '12354190941', 'Aluno', '', '', 'Ativado', 0, ''),
(101, 'José Magro', 'Rua Lambari', '37', '', 'Centro', 'Extrema', 'MG', '16/05/1982', '1544378', '12354190942', 'Aluno', '', '', 'Ativado', 0, ''),
(102, 'Sérgio Pimentel', 'Rua Bragança', '38', '', 'Centro', 'Extrema', 'MG', '17/05/1982', '1544379', '12354190943', 'Aluno', '', '', 'Ativado', 0, ''),
(103, 'Laestro Santos', 'Rua Domingos Zingari', '39', '', 'Centro', 'Extrema', 'MG', '18/05/1982', '1544380', '12354190944', 'Aluno', '', '', 'Ativado', 0, ''),
(104, 'Édson Joseph', 'Rua Alexandre Bertolote', '40', '', 'Centro', 'Extrema', 'MG', '19/05/1982', '1544381', '12354190945', 'Aluno', '', '', 'Ativado', 0, ''),
(105, 'Kelly Lima', 'Rua João Suekumi', '31', '', 'Centro', 'Extrema', 'MG', '20/05/2009', '1544382', '12354190946', 'Responsável', 'kelly04@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(106, 'Paulo Correia', 'Rua Padre Carbone', '32', '', 'Centro', 'Extrema', 'MG', '21/05/2009', '1544383', '12354190947', 'Responsável', 'paulo04@gmail.com', 'senha', 'Ativado', 0, 'id_h5'),
(107, 'Daniel Rosa', 'Rua Capitão Germano', '33', '', 'Centro', 'Extrema', 'MG', '22/05/2009', '1544384', '12354190948', 'Responsável', 'daniel04@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(108, 'Daniel Ferreira', 'Rua Nenê', '34', '', 'Centro', 'Extrema', 'MG', '23/05/2009', '1544385', '12354190949', 'Responsável', 'danniel04@gmail.com', 'senha', 'Ativado', 0, 'id_h3'),
(109, 'Wilson Batista', 'Rua Adelino Salvador', '35', '', 'Centro', 'Extrema', 'MG', '24/05/2009', '1544386', '12354190950', 'Responsável', 'wilson04@gmail.com', 'senha', 'Ativado', 0, 'id_h3'),
(110, 'Leandro Ferreira', 'Rua Diamantina', '36', '', 'Centro', 'Extrema', 'MG', '25/05/2009', '1544387', '12354190951', 'Responsável', 'leandro04@gmail.com', 'senha', 'Ativado', 0, 'id_h3'),
(111, 'Itamar Magro', 'Rua Lambari', '37', '', 'Centro', 'Extrema', 'MG', '26/05/2009', '1544388', '12354190952', 'Responsável', 'itamar04@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(112, 'Carlos Pimentel', 'Rua Bragança', '38', '', 'Centro', 'Extrema', 'MG', '27/05/2009', '1544389', '12354190953', 'Responsável', 'carlos04@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(113, 'Gabriel Santos', 'Rua Domingos Zingari', '39', '', 'Centro', 'Extrema', 'MG', '28/05/2009', '1544390', '12354190954', 'Responsável', 'gabriel04@gmail.com', 'senha', 'Ativado', 0, 'id_h5'),
(114, 'Renata Joseph', 'Rua Alexandre Bertolote', '40', '', 'Centro', 'Extrema', 'MG', '29/05/2009', '1544391', '12354190955', 'Responsável', 'renata04@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(115, 'Gliebe Gonçalves', 'Rua João Suekumi', '41', '', 'Centro', 'Extrema', 'MG', '10/05/1981', '1544392', '12354190956', 'Aluno', '', '', 'Ativado', 0, ''),
(116, 'Aline Leandro', 'Rua Padre Carbone', '42', '', 'Centro', 'Extrema', 'MG', '11/05/1981', '1544393', '12354190957', 'Aluno', '', '', 'Ativado', 0, ''),
(117, 'Dorivaldo Vicente', 'Rua Capitão Germano', '43', '', 'Centro', 'Extrema', 'MG', '12/05/1981', '1544394', '12354190958', 'Aluno', '', '', 'Ativado', 0, ''),
(118, 'Idinelia Bianca', 'Rua Nenê', '44', '', 'Centro', 'Extrema', 'MG', '13/05/1981', '1544395', '12354190959', 'Aluno', '', '', 'Ativado', 0, ''),
(119, 'Carla Rafaela', 'Rua Adelino Salvador', '45', '', 'Centro', 'Extrema', 'MG', '14/05/1981', '1544396', '12354190960', 'Aluno', '', '', 'Ativado', 0, ''),
(120, 'Brenda Mendes', 'Rua Diamantina', '46', '', 'Centro', 'Extrema', 'MG', '15/05/1981', '1544397', '12354190961', 'Aluno', '', '', 'Ativado', 0, ''),
(121, 'Leandro Batista', 'Rua Lambari', '47', '', 'Centro', 'Extrema', 'MG', '16/05/1981', '1544398', '12354190962', 'Aluno', '', '', 'Ativado', 0, ''),
(122, 'João Oliveira', 'Rua Bragança', '48', '', 'Centro', 'Extrema', 'MG', '17/05/1981', '1544399', '12354190963', 'Aluno', '', '', 'Ativado', 0, ''),
(123, 'Geovana Alves', 'Rua Domingos Zingari', '49', '', 'Centro', 'Extrema', 'MG', '18/05/1981', '1544400', '12354190964', 'Aluno', '', '', 'Ativado', 0, ''),
(124, 'Esterlina Gonzaga', 'Rua Alexandre Bertolote', '50', '', 'Centro', 'Extrema', 'MG', '19/05/1981', '1544401', '12354190965', 'Aluno', '', '', 'Ativado', 0, ''),
(125, 'Flávia Gonçalves', 'Rua João Suekumi', '41', '', 'Centro', 'Extrema', 'MG', '20/05/2008', '1544402', '12354190966', 'Responsável', 'flavia05@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(126, 'Lúcia Leandro', 'Rua Padre Carbone', '42', '', 'Centro', 'Extrema', 'MG', '21/05/2008', '1544403', '12354190967', 'Responsável', 'lucia05@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(127, 'Flávia Vicente', 'Rua Capitão Germano', '43', '', 'Centro', 'Extrema', 'MG', '22/05/2008', '1544404', '12354190968', 'Responsável', 'flavvia05@gmail.com', 'senha', 'Desativado', 0, 'id_m1'),
(128, 'Gean Carlos Bianca', 'Rua Nenê', '44', '', 'Centro', 'Extrema', 'MG', '23/05/2008', '1544405', '12354190969', 'Responsável', 'gean05@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(129, 'Herick Rafaela', 'Rua Adelino Salvador', '45', '', 'Centro', 'Extrema', 'MG', '24/05/2008', '1544406', '12354190970', 'Responsável', 'herick05@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(130, 'Wender Mendes', 'Rua Diamantina', '46', '', 'Centro', 'Extrema', 'MG', '25/05/2008', '1544407', '12354190971', 'Responsável', 'wender05@gmail.com', 'senha', 'Ativado', 0, 'id_h1'),
(131, 'Cristina Batista', 'Rua Lambari', '47', '', 'Centro', 'Extrema', 'MG', '26/05/2008', '1544408', '12354190972', 'Responsável', 'cristina05@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(132, 'Wanderci Oliveira', 'Rua Bragança', '48', '', 'Centro', 'Extrema', 'MG', '27/05/2008', '1544409', '12354190973', 'Responsável', 'wanderci05@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(133, 'Aline Alves', 'Rua Domingos Zingari', '49', '', 'Centro', 'Extrema', 'MG', '28/05/2008', '1544410', '12354190974', 'Responsável', 'aline05@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(134, 'Leandro Gonzaga', 'Rua Alexandre Bertolote', '50', '', 'Centro', 'Extrema', 'MG', '29/05/2008', '1544411', '12354190975', 'Responsável', 'leandro05@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(135, 'Igor Lima', 'Rua João Suekumi', '51', '', 'Centro', 'Extrema', 'MG', '10/05/1980', '1544412', '12354190976', 'Aluno', '', '', 'Ativado', 0, ''),
(136, 'Gianluca Almeida', 'Rua Padre Carbone', '52', '', 'Centro', 'Extrema', 'MG', '11/05/1980', '1544413', '12354190977', 'Aluno', '', '', 'Ativado', 0, ''),
(137, 'Denis Costa', 'Rua Capitão Germano', '53', '', 'Centro', 'Extrema', 'MG', '12/05/1980', '1544414', '12354190978', 'Aluno', '', '', 'Ativado', 0, ''),
(138, 'Donato Souza', 'Rua Nenê', '54', '', 'Centro', 'Extrema', 'MG', '13/05/1980', '1544415', '12354190979', 'Aluno', '', '', 'Ativado', 0, ''),
(139, 'Júlia Duarte', 'Rua Adelino Salvador', '55', '', 'Centro', 'Extrema', 'MG', '14/05/1980', '1544416', '12354190980', 'Aluno', '', '', 'Ativado', 0, ''),
(140, 'Juliano Santos', 'Rua Diamantina', '56', '', 'Centro', 'Extrema', 'MG', '15/05/1980', '1544417', '12354190981', 'Aluno', '', '', 'Ativado', 0, ''),
(141, 'Mariana Campos', 'Rua Lambari', '57', '', 'Centro', 'Extrema', 'MG', '16/05/1980', '1544418', '12354190982', 'Aluno', '', '', 'Ativado', 0, ''),
(142, 'Suellen Carvalho', 'Rua Bragança', '58', '', 'Centro', 'Extrema', 'MG', '17/05/1980', '1544419', '12354190983', 'Aluno', '', '', 'Ativado', 0, ''),
(143, 'Júlia Jesus', 'Rua Domingos Zingari', '59', '', 'Centro', 'Extrema', 'MG', '18/05/1980', '1544420', '12354190984', 'Aluno', '', '', 'Ativado', 0, ''),
(144, 'Weslen Araújo', 'Rua Alexandre Bertolote', '60', '', 'Centro', 'Extrema', 'MG', '19/05/1980', '1544421', '12354190985', 'Aluno', '', '', 'Ativado', 0, ''),
(145, 'Yasmin Lima', 'Rua João Suekumi', '51', '', 'Centro', 'Extrema', 'MG', '20/05/2007', '1544422', '12354190986', 'Responsável', 'yasmin06@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(146, 'Eduardo Almeida', 'Rua Padre Carbone', '52', '', 'Centro', 'Extrema', 'MG', '21/05/2007', '1544423', '12354190987', 'Responsável', 'eduardo06@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(147, 'Fabricio Costa', 'Rua Capitão Germano', '53', '', 'Centro', 'Extrema', 'MG', '22/05/2007', '1544424', '12354190988', 'Responsável', 'fabricio06@gmail.com', 'senha', 'Ativado', 0, 'id_h2'),
(148, 'Larissa Souza', 'Rua Nenê', '54', '', 'Centro', 'Extrema', 'MG', '23/05/2007', '1544425', '12354190989', 'Responsável', 'larissa06@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(149, 'Sandra Duarte', 'Rua Adelino Salvador', '55', '', 'Centro', 'Extrema', 'MG', '24/05/2007', '1544426', '12354190990', 'Responsável', 'sandra06@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(150, 'Mariana Santos', 'Rua Diamantina', '56', '', 'Centro', 'Extrema', 'MG', '25/05/2007', '1544427', '12354190991', 'Responsável', 'mariana06@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(151, 'Jorge Campos', 'Rua Lambari', '57', '', 'Centro', 'Extrema', 'MG', '26/05/2007', '1544428', '12354190992', 'Responsável', 'jorge06@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(152, 'Gabriel Carvalho', 'Rua Bragança', '58', '', 'Centro', 'Extrema', 'MG', '27/05/2007', '1544429', '12354190993', 'Responsável', 'gabriel06@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(153, 'Wesley Jesus', 'Rua Domingos Zingari', '59', '', 'Centro', 'Extrema', 'MG', '28/05/2007', '1544430', '12354190994', 'Responsável', 'wesley06@gmail.com', 'senha', 'Ativado', 0, 'id_h3'),
(154, 'Gabriela Araújo', 'Rua Alexandre Bertolote', '60', '', 'Centro', 'Extrema', 'MG', '29/05/2007', '1544431', '12354190995', 'Responsável', 'gabriela06@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(155, 'Júlia Alvez', 'Rua João Suekumi', '61', '', 'Centro', 'Extrema', 'MG', '10/05/1979', '1544432', '12354190996', 'Aluno', '', '', 'Ativado', 0, ''),
(156, 'Eduardo Souza', 'Rua Padre Carbone', '62', '', 'Centro', 'Extrema', 'MG', '11/05/1979', '1544433', '12354190997', 'Aluno', '', '', 'Ativado', 0, ''),
(157, 'Júlia Emanuelly', 'Rua Capitão Germano', '63', '', 'Centro', 'Extrema', 'MG', '12/05/1979', '1544434', '12354190998', 'Aluno', '', '', 'Ativado', 0, ''),
(158, 'Kathleen Costa', 'Rua Nenê', '64', '', 'Centro', 'Extrema', 'MG', '13/05/1979', '1544435', '12354190999', 'Aluno', '', '', 'Ativado', 0, ''),
(159, 'Fabricio Duarte', 'Rua Adelino Salvador', '65', '', 'Centro', 'Extrema', 'MG', '14/05/1979', '1544436', '12354191000', 'Aluno', '', '', 'Ativado', 0, ''),
(160, 'Juliano Oliveira', 'Rua Diamantina', '66', '', 'Centro', 'Extrema', 'MG', '15/05/1979', '1544437', '12354191001', 'Aluno', '', '', 'Ativado', 0, ''),
(161, 'Larissa Araújo', 'Rua Lambari', '67', '', 'Centro', 'Extrema', 'MG', '16/05/1979', '1544438', '12354191002', 'Aluno', '', '', 'Ativado', 0, ''),
(162, 'Yasmin Mariano', 'Rua Bragança', '68', '', 'Centro', 'Extrema', 'MG', '17/05/1979', '1544439', '12354191003', 'Aluno', '', '', 'Ativado', 0, ''),
(163, 'Mariana Mazzoni', 'Rua Domingos Zingari', '69', '', 'Centro', 'Extrema', 'MG', '18/05/1979', '1544440', '12354191004', 'Aluno', '', '', 'Ativado', 0, ''),
(164, 'Taynara Jesus', 'Rua Alexandre Bertolote', '70', '', 'Centro', 'Extrema', 'MG', '19/05/1979', '1544441', '12354191005', 'Aluno', '', '', 'Ativado', 0, ''),
(165, 'Weslen Alvez', 'Rua João Suekumi', '61', '', 'Centro', 'Extrema', 'MG', '20/05/2006', '1544442', '12354191006', 'Responsável', 'weslen07@gmail.com', 'senha', 'Ativado', 0, 'id_h2'),
(166, 'Suely Souza', 'Rua Padre Carbone', '62', '', 'Centro', 'Extrema', 'MG', '21/05/2006', '1544443', '12354191007', 'Responsável', 'suely07@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(167, 'Luana Emanuelly', 'Rua Capitão Germano', '63', '', 'Centro', 'Extrema', 'MG', '22/05/2006', '1544444', '12354191008', 'Responsável', 'luana07@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(168, 'Mathias Costa', 'Rua Nenê', '64', '', 'Centro', 'Extrema', 'MG', '23/05/2006', '1544445', '12354191009', 'Responsável', 'mathias07@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(169, 'Júlia Duarte', 'Rua Adelino Salvador', '65', '', 'Centro', 'Extrema', 'MG', '24/05/2006', '1544446', '12354191010', 'Responsável', 'julia07@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(170, 'Pedro Oliveira', 'Rua Diamantina', '66', '', 'Centro', 'Extrema', 'MG', '25/05/2006', '1544447', '12354191011', 'Responsável', 'pedro07@gmail.com', 'senha', 'Ativado', 0, 'id_h5'),
(171, 'Júlia Araújo', 'Rua Lambari', '67', '', 'Centro', 'Extrema', 'MG', '26/05/2006', '1544448', '12354191012', 'Responsável', 'juuh07@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(172, 'Beatriz Mariano', 'Rua Bragança', '68', '', 'Centro', 'Extrema', 'MG', '27/05/2006', '1544449', '12354191013', 'Responsável', 'beatriz07@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(173, 'Gabriel Mazzoni', 'Rua Domingos Zingari', '69', '', 'Centro', 'Extrema', 'MG', '28/05/2006', '1544450', '12354191014', 'Responsável', 'gabriel07@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(174, 'Mariana Jesus', 'Rua Alexandre Bertolote', '70', '', 'Centro', 'Extrema', 'MG', '29/05/2006', '1544451', '12354191015', 'Responsável', 'mariana07@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(175, 'Arthur Onishi', 'Rua João Suekumi', '71', '', 'Centro', 'Extrema', 'MG', '10/05/1978', '1544452', '12354191016', 'Aluno', '', '', 'Ativado', 0, ''),
(176, 'Gabriela Bryan', 'Rua Padre Carbone', '72', '', 'Centro', 'Extrema', 'MG', '11/05/1978', '1544453', '12354191017', 'Aluno', '', '', 'Ativado', 0, ''),
(177, 'Leilah Mariano', 'Rua Capitão Germano', '73', '', 'Centro', 'Extrema', 'MG', '12/05/1978', '1544454', '12354191018', 'Aluno', '', '', 'Ativado', 0, ''),
(178, 'Mariana Priscila', 'Rua Nenê', '74', '', 'Centro', 'Extrema', 'MG', '13/05/1978', '1544455', '12354191019', 'Aluno', '', '', 'Ativado', 0, ''),
(179, 'Samela Monteiro', 'Rua Adelino Salvador', '75', '', 'Centro', 'Extrema', 'MG', '14/05/1978', '1544456', '12354191020', 'Aluno', '', '', 'Ativado', 0, ''),
(180, 'Lívia Emanuelly', 'Rua Diamantina', '76', '', 'Centro', 'Extrema', 'MG', '15/05/1978', '1544457', '12354191021', 'Aluno', '', '', 'Ativado', 0, ''),
(181, 'Kathleen Freire', 'Rua Lambari', '77', '', 'Centro', 'Extrema', 'MG', '16/05/1978', '1544458', '12354191022', 'Aluno', '', '', 'Ativado', 0, ''),
(182, 'Augusto Albuquerque', 'Rua Bragança', '78', '', 'Centro', 'Extrema', 'MG', '17/05/1978', '1544459', '12354191023', 'Aluno', '', '', 'Ativado', 0, ''),
(183, 'Larissa Barros', 'Rua Domingos Zingari', '79', '', 'Centro', 'Extrema', 'MG', '18/05/1978', '1544460', '12354191024', 'Aluno', '', '', 'Ativado', 0, ''),
(184, 'Andrew Fragoso', 'Rua Alexandre Bertolote', '80', '', 'Centro', 'Extrema', 'MG', '19/05/1978', '1544461', '12354191025', 'Aluno', '', '', 'Ativado', 0, ''),
(185, 'Júlia Onishi', 'Rua João Suekumi', '71', '', 'Centro', 'Extrema', 'MG', '20/05/2005', '1544462', '12354191026', 'Responsável', 'julia08@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(186, 'Pedro Bryan', 'Rua Padre Carbone', '72', '', 'Centro', 'Extrema', 'MG', '21/05/2005', '1544463', '12354191027', 'Responsável', 'pedro08@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(187, 'Agnes Mariano', 'Rua Capitão Germano', '73', '', 'Centro', 'Extrema', 'MG', '22/05/2005', '1544464', '12354191028', 'Responsável', 'agnes08@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(188, 'Pedro Monteiro', 'Rua Nenê', '74', '', 'Centro', 'Extrema', 'MG', '23/05/2005', '1544465', '12354191029', 'Responsável', 'peter08@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(189, 'Larissa Priscila', 'Rua Adelino Salvador', '75', '', 'Centro', 'Extrema', 'MG', '24/05/2005', '1544466', '12354191030', 'Responsável', 'larissa08@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(190, 'Gabriel Emanuelly', 'Rua Diamantina', '76', '', 'Centro', 'Extrema', 'MG', '25/05/2005', '1544467', '12354191031', 'Responsável', 'gabriel08@gmail.com', 'senha', 'Ativado', 0, 'id_h2'),
(191, 'Donato Freire', 'Rua Lambari', '77', '', 'Centro', 'Extrema', 'MG', '26/05/2005', '1544468', '12354191032', 'Responsável', 'donato08@gmail.com', 'senha', 'Ativado', 0, 'id_h2'),
(192, 'Heloísa Albuquerque', 'Rua Bragança', '78', '', 'Centro', 'Extrema', 'MG', '27/05/2005', '1544469', '12354191033', 'Responsável', 'heloisa08@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(193, 'Ellen Barros', 'Rua Domingos Zingari', '79', '', 'Centro', 'Extrema', 'MG', '28/05/2005', '1544470', '12354191034', 'Responsável', 'ellen08@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(194, 'Taynara Fragoso', 'Rua Alexandre Bertolote', '80', '', 'Centro', 'Extrema', 'MG', '29/05/2005', '1544471', '12354191035', 'Responsável', 'taynara08@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(195, 'Thais Carvalho', 'Rua João Suekumi', '81', '', 'Centro', 'Extrema', 'MG', '10/05/1977', '1544472', '12354191036', 'Aluno', '', '', 'Ativado', 0, ''),
(196, 'Júlia Mazzoni', 'Rua Padre Carbone', '82', '', 'Centro', 'Extrema', 'MG', '11/05/1977', '1544473', '12354191037', 'Aluno', '', '', 'Ativado', 0, ''),
(197, 'Taynara Barros', 'Rua Capitão Germano', '83', '', 'Centro', 'Extrema', 'MG', '12/05/1977', '1544474', '12354191038', 'Aluno', '', '', 'Ativado', 0, ''),
(198, 'Júlia Campos', 'Rua Nenê', '84', '', 'Centro', 'Extrema', 'MG', '13/05/1977', '1544475', '12354191039', 'Aluno', '', '', 'Ativado', 0, ''),
(199, 'Simone Monteiro', 'Rua Adelino Salvador', '85', '', 'Centro', 'Extrema', 'MG', '14/05/1977', '1544476', '12354191040', 'Aluno', '', '', 'Ativado', 0, ''),
(200, 'Gabriel Duarte', 'Rua Diamantina', '86', '', 'Centro', 'Extrema', 'MG', '15/05/1977', '1544477', '12354191041', 'Aluno', '', '', 'Ativado', 0, ''),
(201, 'Juliano Souza', 'Rua Lambari', '87', '', 'Centro', 'Extrema', 'MG', '16/05/1977', '1544478', '12354191042', 'Aluno', '', '', 'Ativado', 0, ''),
(202, 'Júlia Silva', 'Rua Bragança', '88', '', 'Centro', 'Extrema', 'MG', '17/05/1977', '1544479', '12354191043', 'Aluno', '', '', 'Ativado', 0, ''),
(203, 'Fabiana Araújo', 'Rua Domingos Zingari', '89', '', 'Centro', 'Extrema', 'MG', '18/05/1977', '1544480', '12354191044', 'Aluno', '', '', 'Ativado', 0, ''),
(204, 'Yasmin Jesus', 'Rua Alexandre Bertolote', '90', '', 'Centro', 'Extrema', 'MG', '19/05/1977', '1544481', '12354191045', 'Aluno', '', '', 'Ativado', 0, ''),
(205, 'Eduardo Carvalho', 'Rua João Suekumi', '81', '', 'Centro', 'Extrema', 'MG', '20/05/2004', '1544482', '12354191046', 'Responsável', 'eduardo09@gmail.com', 'senha', 'Ativado', 0, 'id_h1'),
(206, 'Weslen Mazzoni', 'Rua Padre Carbone', '82', '', 'Centro', 'Extrema', 'MG', '21/05/2004', '1544483', '12354191047', 'Responsável', 'weslen09@gmail.com', 'senha', 'Ativado', 0, 'id_h2'),
(207, 'Pedro Barros', 'Rua Capitão Germano', '83', '', 'Centro', 'Extrema', 'MG', '22/05/2004', '1544484', '12354191048', 'Responsável', 'pedro09@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(208, 'Larissa Campos', 'Rua Nenê', '84', '', 'Centro', 'Extrema', 'MG', '23/05/2004', '1544485', '12354191049', 'Responsável', 'larissa09@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(209, 'Larissa Monteiro', 'Rua Adelino Salvador', '85', '', 'Centro', 'Extrema', 'MG', '24/05/2004', '1544486', '12354191050', 'Responsável', 'laah09@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(210, 'Alexia Duarte', 'Rua Diamantina', '86', '', 'Centro', 'Extrema', 'MG', '25/05/2004', '1544487', '12354191051', 'Responsável', 'alexia09@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(211, 'Donato Souza', 'Rua Lambari', '87', '', 'Centro', 'Extrema', 'MG', '26/05/2004', '1544488', '12354191052', 'Responsável', 'donato09@gmail.com', 'senha', 'Ativado', 0, 'id_h2'),
(212, 'Cecillia Silva', 'Rua Bragança', '88', '', 'Centro', 'Extrema', 'MG', '27/05/2004', '1544489', '12354191053', 'Responsável', 'cecillia09@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(213, 'Kathleen Araújo', 'Rua Domingos Zingari', '89', '', 'Centro', 'Extrema', 'MG', '28/05/2004', '1544490', '12354191054', 'Responsável', 'kathleen09@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(214, 'Mariana Jesus', 'Rua Alexandre Bertolote', '90', '', 'Centro', 'Extrema', 'MG', '29/05/2004', '1544491', '12354191055', 'Responsável', 'mariana09@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(215, 'Júlia Amorim', 'Rua João Suekumi', '91', '', 'Centro', 'Extrema', 'MG', '10/05/1976', '1544492', '12354191056', 'Aluno', '', '', 'Ativado', 0, ''),
(216, 'Sandra Fernandes', 'Rua Padre Carbone', '92', '', 'Centro', 'Extrema', 'MG', '11/05/1976', '1544493', '12354191057', 'Aluno', '', '', 'Ativado', 0, ''),
(217, 'Mariah Rodrigues', 'Rua Capitão Germano', '93', '', 'Centro', 'Extrema', 'MG', '12/05/1976', '1544494', '12354191058', 'Aluno', '', '', 'Ativado', 0, ''),
(218, 'Ygor Araújo', 'Rua Nenê', '94', '', 'Centro', 'Extrema', 'MG', '13/05/1976', '1544495', '12354191059', 'Aluno', '', '', 'Ativado', 0, ''),
(219, 'Isadora Xavier', 'Rua Adelino Salvador', '95', '', 'Centro', 'Extrema', 'MG', '14/05/1976', '1544496', '12354191060', 'Aluno', '', '', 'Ativado', 0, ''),
(220, 'Filipe Almeida', 'Rua Diamantina', '96', '', 'Centro', 'Extrema', 'MG', '15/05/1976', '1544497', '12354191061', 'Aluno', '', '', 'Ativado', 0, ''),
(221, 'Laura Souza', 'Rua Lambari', '97', '', 'Centro', 'Extrema', 'MG', '16/05/1976', '1544498', '12354191062', 'Aluno', '', '', 'Ativado', 0, ''),
(222, 'Luan Araújo', 'Rua Bragança', '98', '', 'Centro', 'Extrema', 'MG', '17/05/1976', '1544499', '12354191063', 'Aluno', '', '', 'Ativado', 0, ''),
(223, 'Yasmin Costa', 'Rua Domingos Zingari', '99', '', 'Centro', 'Extrema', 'MG', '18/05/1976', '1544500', '12354191064', 'Aluno', '', '', 'Ativado', 0, ''),
(224, 'Fabricio Oliveira', 'Rua Alexandre Bertolote', '100', '', 'Centro', 'Extrema', 'MG', '19/05/1976', '1544501', '12354191065', 'Aluno', '', '', 'Ativado', 0, ''),
(225, 'Gabriele Amorim', 'Rua João Suekumi', '91', '', 'Centro', 'Extrema', 'MG', '20/05/2003', '1544502', '12354191066', 'Responsável', 'gabriele10@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(226, 'Gabriel Fernandes', 'Rua Padre Carbone', '92', '', 'Centro', 'Extrema', 'MG', '21/05/2003', '1544503', '12354191067', 'Responsável', 'gabriel10@gmail.com', 'senha', 'Ativado', 0, 'id_h1'),
(227, 'Juliano Rodrigues', 'Rua Capitão Germano', '93', '', 'Centro', 'Extrema', 'MG', '22/05/2003', '1544504', '12354191068', 'Responsável', 'juliano10@gmail.com', 'senha', 'Ativado', 0, 'id_h3'),
(228, 'Amanda Araújo', 'Rua Nenê', '94', '', 'Centro', 'Extrema', 'MG', '23/05/2003', '1544505', '12354191069', 'Responsável', 'amanda10@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(229, 'Leandro Xavier', 'Rua Adelino Salvador', '95', '', 'Centro', 'Extrema', 'MG', '24/05/2003', '1544506', '12354191070', 'Responsável', 'leandro10@gmail.com', 'senha', 'Ativado', 0, 'id_h2'),
(230, 'Mariana Almeida', 'Rua Diamantina', '96', '', 'Centro', 'Extrema', 'MG', '25/05/2003', '1544507', '12354191071', 'Responsável', 'mariana10@gmail.com', 'senha', 'Ativado', 0, 'id_m5'),
(231, 'Cecilia Souza', 'Rua Lambari', '97', '', 'Centro', 'Extrema', 'MG', '26/05/2003', '1544508', '12354191072', 'Responsável', 'cecilia10@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(232, 'Mariana Araújo', 'Rua Bragança', '98', '', 'Centro', 'Extrema', 'MG', '27/05/2003', '1544509', '12354191073', 'Responsável', 'maah10@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(233, 'Marina Costa', 'Rua Domingos Zingari', '99', '', 'Centro', 'Extrema', 'MG', '28/05/2003', '1544510', '12354191074', 'Responsável', 'marina10@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(234, 'Márcia Oliveira', 'Rua Alexandre Bertolote', '100', '', 'Centro', 'Extrema', 'MG', '29/05/2003', '1544511', '12354191075', 'Responsável', 'marcia10@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(255, 'Júlia Monteiro', 'Rua João Suekumi', '101', '', 'Centro', 'Extrema', 'MG', '10/05/1975', '1544512', '12354191076', 'Aluno', '', '', 'Ativado', 0, ''),
(256, 'Gabriel Leite', 'Rua Padre Carbone', '102', '', 'Centro', 'Extrema', 'MG', '11/05/1975', '1544513', '12354191077', 'Aluno', '', '', 'Ativado', 0, ''),
(257, 'Pedro Duarte', 'Rua Capitão Germano', '103', '', 'Centro', 'Extrema', 'MG', '12/05/1975', '1544514', '12354191078', 'Aluno', '', '', 'Ativado', 0, ''),
(258, 'Juliano Santos', 'Rua Nenê', '104', '', 'Centro', 'Extrema', 'MG', '13/05/1975', '1544515', '12354191079', 'Aluno', '', '', 'Ativado', 0, ''),
(259, 'Mathias Silva', 'Rua Adelino Salvador', '105', '', 'Centro', 'Extrema', 'MG', '14/05/1975', '1544516', '12354191080', 'Aluno', '', '', 'Ativado', 0, ''),
(260, 'Fabiana Amorim', 'Rua Diamantina', '106', '', 'Centro', 'Extrema', 'MG', '15/05/1975', '1544517', '12354191081', 'Aluno', '', '', 'Ativado', 0, ''),
(261, 'Sandra Costa', 'Rua Lambari', '107', '', 'Centro', 'Extrema', 'MG', '16/05/1975', '1544518', '12354191082', 'Aluno', '', '', 'Ativado', 0, ''),
(262, 'Fabricio Santos', 'Rua Bragança', '108', '', 'Centro', 'Extrema', 'MG', '17/05/1975', '1544519', '12354191083', 'Aluno', '', '', 'Ativado', 0, ''),
(263, 'Mariana Araújo', 'Rua Domingos Zingari', '109', '', 'Centro', 'Extrema', 'MG', '18/05/1975', '1544520', '12354191084', 'Aluno', '', '', 'Ativado', 0, ''),
(264, 'Yasmin Bertolotti', 'Rua Alexandre Bertolote', '110', '', 'Centro', 'Extrema', 'MG', '19/05/1975', '1544521', '12354191085', 'Aluno', '', '', 'Ativado', 0, ''),
(265, 'Donato Monteiro', 'Rua João Suekumi', '101', '', 'Centro', 'Extrema', 'MG', '20/05/2002', '1544522', '12354191086', 'Responsável', 'donato11@gmail.com', 'senha', 'Ativado', 0, 'id_h6'),
(266, 'Larissa Leite', 'Rua Padre Carbone', '102', '', 'Centro', 'Extrema', 'MG', '21/05/2002', '1544523', '12354191087', 'Responsável', 'larissa11@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(267, 'Thais Duarte', 'Rua Capitão Germano', '103', '', 'Centro', 'Extrema', 'MG', '22/05/2002', '1544524', '12354191088', 'Responsável', 'thais11@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(268, 'Mariana Santos', 'Rua Nenê', '104', '', 'Centro', 'Extrema', 'MG', '23/05/2002', '1544525', '12354191089', 'Responsável', 'mariana11@gmail.com', 'senha', 'Ativado', 0, 'id_m1'),
(269, 'Nicole Silva', 'Rua Adelino Salvador', '105', '', 'Centro', 'Extrema', 'MG', '24/05/2002', '1544526', '12354191090', 'Responsável', 'nicole11@gmail.com', 'senha', 'Ativado', 0, 'id_m3'),
(270, 'Suellem Amorim', 'Rua Diamantina', '106', '', 'Centro', 'Extrema', 'MG', '25/05/2002', '1544527', '12354191091', 'Responsável', 'suellem11@gmail.com', 'senha', 'Ativado', 0, 'id_m4'),
(271, 'Weslen Costa', 'Rua Lambari', '107', '', 'Centro', 'Extrema', 'MG', '26/05/2002', '1544528', '12354191092', 'Responsável', 'weslen11@gmail.com', 'senha', 'Ativado', 0, 'id_h4'),
(272, 'Larissa Santos', 'Rua Bragança', '108', '', 'Centro', 'Extrema', 'MG', '27/05/2002', '1544529', '12354191093', 'Responsável', 'lari11@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(273, 'Júlia Araújo', 'Rua Domingos Zingari', '109', '', 'Centro', 'Extrema', 'MG', '28/05/2002', '1544530', '12354191094', 'Responsável', 'julia11@gmail.com', 'senha', 'Ativado', 0, 'id_m2'),
(274, 'Eduardo Bertolotti', 'Rua Alexandre Bertolote', '110', '', 'Centro', 'Extrema', 'MG', '29/05/2002', '1544531', '12354191095', 'Responsável', 'eduardo11@gmail.com', 'senha', 'Ativado', 0, 'id_h5'),
(275, 'KAUE VASCOCELLOS', 'Avenida valetim del nero', '489', '', 'Centro', 'Piracaia', 'SP', '05/06/1992', '45.687.978-97', '213.312.123-12', 'Aluno', 'kaue@gmail.com', '123456', 'Ativado', 0, 'null'),
(276, 'GILVANA TORZIO', 'RUA VINÍCIUS DE MORAES', '187', '', 'LOTEAMENTO JARDIM MORUMBI', 'ATIBAIA', 'SP', '10/03/1997', '78.945.646-54', '465.456.465-46', 'Aluno', 'gi@gmail.com', '147852369', 'Desativado', 0, 'null'),
(277, 'JOÃO DE OLIVEIRA', 'RUA ANITA GUASTINI EIRAS', '412', '3 ANDAR', 'VILA MARIANA', 'SÃO PAULO', 'SP', '10/04/1990', '14.785.236-90', '147.852.369-00', 'Responsável', 'joliv@gmail.com', '123456', 'Ativado', 4105070, 'null');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_responsavel`
--

CREATE TABLE `pcc_tb_responsavel` (
  `Res_INT_Codigo` int(11) NOT NULL,
  `Alu_INT_Codigo` int(11) NOT NULL,
  `Resp_INT_Codigo` int(11) NOT NULL,
  `Res_ST_Descrição` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `pcc_tb_responsavel`
--

INSERT INTO `pcc_tb_responsavel` (`Res_INT_Codigo`, `Alu_INT_Codigo`, `Resp_INT_Codigo`, `Res_ST_Descrição`) VALUES
(1, 13, 21, 'Pai'),
(1, 14, 22, 'Pai'),
(1, 15, 22, 'Pai'),
(1, 16, 24, 'Mãe'),
(1, 17, 25, 'Mãe'),
(1, 18, 26, 'Pai'),
(1, 19, 27, 'Pai'),
(1, 20, 28, 'Pai'),
(1, 24, 277, 'Pai'),
(1, 35, 45, 'Pai'),
(1, 36, 46, 'Mãe'),
(1, 37, 47, 'Mãe'),
(1, 38, 48, 'Mãe'),
(1, 39, 49, 'Mãe'),
(1, 40, 50, 'Pai'),
(1, 41, 51, 'Pai'),
(1, 42, 52, 'Mãe'),
(1, 43, 53, 'Pai'),
(1, 44, 54, 'Mãe'),
(1, 55, 65, 'Pai'),
(1, 56, 66, 'Mãe'),
(1, 57, 67, 'Mãe'),
(1, 58, 68, 'Mãe'),
(1, 59, 69, 'Pai'),
(1, 60, 70, 'Mãe'),
(1, 61, 71, 'Mãe'),
(1, 62, 72, 'Pai'),
(1, 63, 73, 'Mãe'),
(1, 64, 74, 'Mãe'),
(1, 75, 85, 'Mãe'),
(1, 76, 86, 'Mãe'),
(1, 77, 87, 'Mãe'),
(1, 78, 88, 'Pai'),
(1, 79, 89, 'Mãe'),
(1, 80, 90, 'Pai'),
(1, 81, 91, 'Mãe'),
(1, 82, 92, 'Mãe'),
(1, 83, 93, 'Pai'),
(1, 84, 94, 'Pai'),
(1, 95, 105, 'Mãe'),
(1, 96, 106, 'Pai'),
(1, 97, 107, 'Pai'),
(1, 98, 108, 'Pai'),
(1, 99, 109, 'Pai'),
(1, 100, 110, 'Pai'),
(1, 101, 111, 'Pai'),
(1, 102, 112, 'Pai'),
(1, 103, 113, 'Pai'),
(1, 104, 114, 'Mãe'),
(1, 115, 125, 'Mãe'),
(1, 116, 126, 'Mãe'),
(1, 117, 127, 'Mãe'),
(1, 118, 128, 'Pai'),
(1, 119, 129, 'Pai'),
(1, 120, 130, 'Pai'),
(1, 121, 131, 'Mãe'),
(1, 122, 132, 'Pai'),
(1, 123, 133, 'Mãe'),
(1, 124, 134, 'Pai'),
(1, 135, 145, 'Mãe'),
(1, 136, 146, 'Pai'),
(1, 137, 147, 'Pai'),
(1, 138, 148, 'Mãe'),
(1, 139, 149, 'Mãe'),
(1, 140, 150, 'Mãe'),
(1, 141, 151, 'Pai'),
(1, 142, 152, 'Pai'),
(1, 143, 153, 'Pai'),
(1, 144, 154, 'Mãe'),
(1, 155, 165, 'Pai'),
(1, 156, 166, 'Mãe'),
(1, 157, 167, 'Mãe'),
(1, 158, 168, 'Pai'),
(1, 159, 169, 'Mãe'),
(1, 160, 170, 'Pai'),
(1, 161, 171, 'Mãe'),
(1, 162, 172, 'Mãe'),
(1, 163, 173, 'Pai'),
(1, 164, 174, 'Mãe'),
(1, 175, 185, 'Mãe'),
(1, 176, 186, 'Pai'),
(1, 177, 187, 'Mãe'),
(1, 178, 188, 'Pai'),
(1, 179, 189, 'Mãe'),
(1, 180, 190, 'Pai'),
(1, 181, 191, 'Pai'),
(1, 182, 192, 'Mãe'),
(1, 183, 193, 'Mãe'),
(1, 184, 194, 'Mãe'),
(1, 195, 205, 'Pai'),
(1, 196, 206, 'Pai'),
(1, 197, 207, 'Pai'),
(1, 198, 208, 'Mãe'),
(1, 199, 209, 'Mãe'),
(1, 200, 210, 'Mãe'),
(1, 201, 211, 'Pai'),
(1, 202, 212, 'Mãe'),
(1, 203, 213, 'Mãe'),
(1, 204, 214, 'Mãe'),
(1, 215, 225, 'Mãe'),
(1, 216, 226, 'Pai'),
(1, 217, 227, 'Pai'),
(1, 218, 228, 'Mãe'),
(1, 219, 229, 'Pai'),
(1, 220, 230, 'Mãe'),
(1, 221, 231, 'Mãe'),
(1, 222, 232, 'Mãe'),
(1, 223, 233, 'Mãe'),
(1, 224, 234, 'Mãe'),
(1, 255, 265, 'Pai'),
(1, 256, 266, 'Mãe'),
(1, 257, 267, 'Mãe'),
(1, 258, 268, 'Mãe'),
(1, 259, 269, 'Mãe'),
(1, 260, 270, 'Mãe'),
(1, 261, 271, 'Pai'),
(1, 262, 272, 'Mãe'),
(1, 263, 273, 'Mãe'),
(1, 264, 274, 'Pai'),
(2, 14, 23, 'Mãe'),
(2, 15, 23, 'Mãe'),
(2, 16, 23, 'Tia');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_retiradaaluno`
--

CREATE TABLE `pcc_tb_retiradaaluno` (
  `Ret_INT_Codigo` int(11) NOT NULL,
  `Res_INT_Codigo` int(11) NOT NULL,
  `Alu_INT_Codigo` int(11) NOT NULL,
  `Ret_DT_HoraRetirada` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_log`
--

CREATE TABLE `pcc_tb_log` (
  `Log_INT_Codigo` int(11) NOT NULL,
  `Pess_INT_Codigo` int(11) NOT NULL,
  `Log_ST_Descricao`varchar(250) not null,
  `Log_DT_Data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
--
-- Estrutura para tabela `pcc_tb_serie`
--

CREATE TABLE `pcc_tb_serie` (
  `Serie_INT_Codigo` int(11) NOT NULL,
  `Serie_ST_Descricao` varchar(45) NOT NULL,
  `Serie_ST_Sala` varchar(10) NOT NULL,
  `Serie_ST_Periodo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `pcc_tb_serie`
--

INSERT INTO `pcc_tb_serie` (`Serie_INT_Codigo`, `Serie_ST_Descricao`, `Serie_ST_Sala`, `Serie_ST_Periodo`) VALUES
(1, '1º Ano', '1', 'Tarde'),
(2, '2º Ano', '2', 'Tarde'),
(3, '3º Ano', '3', 'Tarde'),
(4, '4º Ano', '4', 'Tarde'),
(5, '5º Ano', '5', 'Tarde'),
(6, '6º Ano', '6', 'Tarde'),
(7, '7º Ano', '1', 'Manhã'),
(8, '8º Ano', '2', 'Manhã'),
(9, '9º Ano', '3', 'Manhã'),
(10, 'Colegial 1', '4', 'Manhã'),
(11, 'Colegial 2', '5', 'Manhã'),
(12, 'Colegial 3', '6', 'Manhã');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_situacaolista`
--

CREATE TABLE `pcc_tb_situacaolista` (
  `Lista_INT_Codigo` int(11) NOT NULL,
  `Lista_ST_Situação` varchar(45) DEFAULT NULL,
  `Pro_INT_Codigo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Fazendo dump de dados para tabela `pcc_tb_situacaolista`
--

INSERT INTO `pcc_tb_situacaolista` (`Lista_INT_Codigo`, `Lista_ST_Situação`, `Pro_INT_Codigo`) VALUES
(1, 'Fechada', 1),
(2, 'Fechada', 2),
(3, 'Fechada', 3),
(4, 'Fechada', 4),
(5, 'Fechada', 5),
(6, 'Fechada', 6),
(7, 'Fechada', 7),
(8, 'Fechada', 8),
(9, 'Fechada', 9),
(10, 'Fechada', 10),
(11, 'Fechada', 11),
(12, 'Fechada', 12);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pcc_tb_telefone`
--

CREATE TABLE `pcc_tb_telefone` (
  `Tel_INT_Codigo` int(11) NOT NULL,
  `Tel_ST_Numero` varchar(45) NOT NULL,
  `Tel_ST_Descricao` varchar(45) DEFAULT NULL,
  `Pess_INT_Codigo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Fazendo dump de dados para tabela `pcc_tb_telefone`
--

INSERT INTO `pcc_tb_telefone` (`Tel_INT_Codigo`, `Tel_ST_Numero`, `Tel_ST_Descricao`, `Pess_INT_Codigo`) VALUES
(1, '(35) 92312-3123', 'Celular', 20),
(1, '(11) 11111-1111', '111111111111', 25),
(1, '(35) 99304-7764', 'Celular', 35),
(1, '(35) 12299-0090', 'Casa', 89),
(1, '(11) 99567-9632', 'Celular', 276),
(2, '(11) 99783-3965', 'Casa', 35);

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `pcc_tb_aluno_serie`
--
ALTER TABLE `pcc_tb_aluno_serie`
  ADD PRIMARY KEY (`Aluno_INT_Codigo`),
  ADD KEY `PCC_fk_Ano_idx` (`Ano_INT_Codigo`),
  ADD KEY `PCC_fk_Estudante_idx` (`Aluno_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_disciplina`
--
ALTER TABLE `pcc_tb_disciplina`
  ADD PRIMARY KEY (`Disc_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_horario`
--
ALTER TABLE `pcc_tb_horario`
  ADD PRIMARY KEY (`Hor_INT_Codigo`),
  ADD KEY `PCC_fk_Disc_idx` (`Disc_INT_Codigo`),
  ADD KEY `PCC_fk_Serie_idx` (`Serie_INT_Codigo`),
  ADD KEY `PCC_fk_Professor_idx` (`Pro_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_listachamada`
--
ALTER TABLE `pcc_tb_listachamada`
  ADD PRIMARY KEY (`Lista_INT_Codigo`,`Aluno_INT_Codigo`,`Hor_INT_Codigo`),
  ADD KEY `PCC_fk_Horario_idx` (`Hor_INT_Codigo`),
  ADD KEY `PCC_fk_Aluno_idx` (`Aluno_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_pessoas`
--
ALTER TABLE `pcc_tb_pessoas`
  ADD PRIMARY KEY (`Pess_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_responsavel`
--
ALTER TABLE `pcc_tb_responsavel`
  ADD PRIMARY KEY (`Res_INT_Codigo`,`Alu_INT_Codigo`),
  ADD KEY `pcc_fk_respAluno_idx` (`Alu_INT_Codigo`,`Resp_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_retiradaaluno`
--
ALTER TABLE `pcc_tb_retiradaaluno`
  ADD PRIMARY KEY (`Ret_INT_Codigo`),
  ADD KEY `PCC_FK_Responsavel_idx` (`Res_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_log`
--
ALTER TABLE `pcc_tb_log`
  ADD PRIMARY KEY (`Log_INT_Codigo`),
  ADD KEY `PCC_FK_Funcionario_idx` (`Pess_INT_Codigo`);
--
-- Índices de tabela `pcc_tb_serie`
--
ALTER TABLE `pcc_tb_serie`
  ADD PRIMARY KEY (`Serie_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_situacaolista`
--
ALTER TABLE `pcc_tb_situacaolista`
  ADD PRIMARY KEY (`Lista_INT_Codigo`),
  ADD KEY `pcc_fk_prolista_idx` (`Pro_INT_Codigo`);

--
-- Índices de tabela `pcc_tb_telefone`
--
ALTER TABLE `pcc_tb_telefone`
  ADD PRIMARY KEY (`Tel_INT_Codigo`,`Pess_INT_Codigo`),
  ADD KEY `PCC_fk_PessoaTel_idx` (`Pess_INT_Codigo`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `pcc_tb_disciplina`
--
ALTER TABLE `pcc_tb_disciplina`
  MODIFY `Disc_INT_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de tabela `pcc_tb_pessoas`
--
ALTER TABLE `pcc_tb_pessoas`
  MODIFY `Pess_INT_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=278;
--
-- AUTO_INCREMENT de tabela `pcc_tb_retiradaaluno`
--
ALTER TABLE `pcc_tb_retiradaaluno`
  MODIFY `Ret_INT_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
  --
-- AUTO_INCREMENT de tabela `pcc_tb_log`
--
ALTER TABLE `pcc_tb_log`
  MODIFY `Log_INT_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=0;
--
-- AUTO_INCREMENT de tabela `pcc_tb_serie`
--
ALTER TABLE `pcc_tb_serie`
  MODIFY `Serie_INT_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de tabela `pcc_tb_situacaolista`
--
ALTER TABLE `pcc_tb_situacaolista`
  MODIFY `Lista_INT_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de tabela `pcc_tb_telefone`
--
ALTER TABLE `pcc_tb_telefone`
  MODIFY `Tel_INT_Codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `pcc_tb_aluno_serie`
--
ALTER TABLE `pcc_tb_aluno_serie`
  ADD CONSTRAINT `PCC_fk_Ano` FOREIGN KEY (`Ano_INT_Codigo`) REFERENCES `pcc_tb_serie` (`Serie_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `PCC_fk_Estudante` FOREIGN KEY (`Aluno_INT_Codigo`) REFERENCES `pcc_tb_pessoas` (`Pess_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pcc_tb_horario`
--
ALTER TABLE `pcc_tb_horario`
  ADD CONSTRAINT `PCC_fk_Disc` FOREIGN KEY (`Disc_INT_Codigo`) REFERENCES `pcc_tb_disciplina` (`Disc_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `PCC_fk_Professor` FOREIGN KEY (`Pro_INT_Codigo`) REFERENCES `pcc_tb_pessoas` (`Pess_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `PCC_fk_Serie` FOREIGN KEY (`Serie_INT_Codigo`) REFERENCES `pcc_tb_serie` (`Serie_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pcc_tb_listachamada`
--
ALTER TABLE `pcc_tb_listachamada`
  ADD CONSTRAINT `PCC_fk_Lista` FOREIGN KEY (`Lista_INT_Codigo`) REFERENCES `pcc_tb_situacaolista` (`Lista_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `PCC_fk_Aluno` FOREIGN KEY (`Aluno_INT_Codigo`) REFERENCES `pcc_tb_aluno_serie` (`Aluno_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `PCC_fk_Horario` FOREIGN KEY (`Hor_INT_Codigo`) REFERENCES `pcc_tb_horario` (`Hor_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pcc_tb_responsavel`
--
ALTER TABLE `pcc_tb_responsavel`
  ADD CONSTRAINT `pcc_fk_respAluno` FOREIGN KEY (`Alu_INT_Codigo`) REFERENCES `pcc_tb_pessoas` (`Pess_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pcc_tb_retiradaaluno`
--
ALTER TABLE `pcc_tb_retiradaaluno`
  ADD CONSTRAINT `PCC_FK_Responsavel` FOREIGN KEY (`Res_INT_Codigo`) REFERENCES `pcc_tb_responsavel` (`Res_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pcc_tb_log`
--
ALTER TABLE `pcc_tb_log`
  ADD CONSTRAINT `PCC_FK_Funcionario` FOREIGN KEY (`Pess_INT_Codigo`) REFERENCES `pcc_tb_pessoas` (`Pess_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;
--
-- Restrições para tabelas `pcc_tb_situacaolista`
--
ALTER TABLE `pcc_tb_situacaolista`
  ADD CONSTRAINT `pcc_fk_prolista` FOREIGN KEY (`Pro_INT_Codigo`) REFERENCES `pcc_tb_horario` (`Pro_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restrições para tabelas `pcc_tb_telefone`
--
ALTER TABLE `pcc_tb_telefone`
  ADD CONSTRAINT `PCC_fk_PessoaTel` FOREIGN KEY (`Pess_INT_Codigo`) REFERENCES `pcc_tb_pessoas` (`Pess_INT_Codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

-- Update de endereços errados
update pcc_tb_pessoas set Pess_ST_Rua = 'Rua dos Canários', Pess_ST_Complemento = '', Pess_ST_Bairro = 'Centro', Pess_ST_Cidade = 'Vargem', Pess_ST_UF = 'SP', Pess_ST_DataNasc = '17/02/2000' where Pess_ST_Rua = '1'; 

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
