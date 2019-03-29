DELIMITER $
   CREATE FUNCTION func_aula(hora time) RETURNS int
   BEGIN
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
   END
   $
   
   delimiter ;
-- -----------------------------------------------------
-- procedure func_DiadaSemana
-- -----------------------------------------------------
   
   delimiter $
create function func_DiadaSemana(Dia varchar(20)) returns int
Begin
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
    
END; $

delimiter ;

-- -----------------------------------------------------
-- procedure proc_CadResponsavel
-- -----------------------------------------------------
/*
DELIMITER $
create procedure proc_CadResponsavel(RA int, NomeResp varchar(45), DescricaoResp varchar(45))
begin
Declare CodResp int;

select Pess_INT_Codigo into CodResp from pcc_tb_pessoas where Pess_ST_Nome = NomeResp; 

insert into pcc_tb_responsavel(alu_int_codigo, resp_int_codigo, res_st_descrição) values (RA, CodResp, DescricaoResp);

END; $
DELIMITER ;
*/
-- -----------------------------------------------------
-- procedure proc_CadHorario
-- -----------------------------------------------------

DELIMITER $$
USE `colegio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_CadHorario`(DiadaSemana varchar(25), Serie varchar (25), Aula int, Disciplina varchar (25), Professor int)
Begin
Declare CodigoH, CodigoD, CodigoS, CodigoDia int;

select func_DiadaSemana(DiadaSemana) into CodigoDia;

select concat(a.Serie_INT_Codigo, CodigoDia, Aula) into CodigoH from pcc_tb_serie a where 
a.Serie_st_descricao = Serie;

select a.disc_int_codigo into CodigoD from pcc_tb_disciplina a where a.Disc_ST_Descricao = Disciplina;

select Serie_INT_Codigo into CodigoS from pcc_tb_serie where Serie_ST_Descricao = Serie;

insert into pcc_tb_horario(hor_int_codigo, Hor_st_DiaDaSemana, Hor_int_Aula, Disc_int_Codigo, Serie_int_codigo, Pro_int_codigo) values 
(CodigoH, CodigoDia, Aula, CodigoD, CodigoS, Professor);


END$$

-- -----------------------------------------------------
-- procedure proc_ListaDeChamada
-- -----------------------------------------------------

DELIMITER $$
USE `colegio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_ListaDeChamada`( Aula int, Serie varchar(20), Professor int, DataChamada date, Disciplina varchar(45))
BEGIN

select a.Pess_INT_Codigo, a.Pess_ST_Nome, b.Lista_ST_SituacaoAluno from pcc_tb_listachamada b, pcc_tb_pessoas a
where Hor_INT_Codigo = (select Hor_INT_Codigo from pcc_tb_horario where Pro_INT_Codigo = Professor and Disc_INT_Codigo = (
select Disc_INT_Codigo from pcc_tb_disciplina where Disc_ST_Descricao = disciplina) and Hor_INT_Aula = Aula and 
Serie_INT_Codigo = (select Serie_INT_Codigo from pcc_tb_serie where Serie_ST_Descricao = Serie)) 
and Lista_DT_Data like DataChamada and a.Pess_INT_Codigo = b.Aluno_INT_Codigo;
End$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_CadastraAlunoSerie
-- -----------------------------------------------------

DELIMITER $
CREATE PROCEDURE proc_CadastraAlunoSerie(CodAluno int, Serie varchar(25))
Begin
Declare CodigoS int;

select a.Serie_INT_Codigo into CodigoS from pcc_tb_serie a where a.Serie_ST_Descricao = Serie;

insert into pcc_tb_aluno_serie(ano_int_codigo, aluno_int_codigo) values(CodigoS, CodAluno);

End; $
DELIMITER ;

-- -----------------------------------------------------
-- procedure SelecionaDisciplina
-- -----------------------------------------------------

DELIMITER $$
USE `colegio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_SelecionaDisciplina`(RA int)
BEGIN

select a.Disc_ST_Descricao from pcc_tb_disciplina a, pcc_tb_pessoas b, pcc_tb_aluno_serie c, pcc_tb_horario d, pcc_tb_serie e where
 b.pess_int_codigo = c.aluno_int_codigo and c.ano_int_codigo = e.serie_int_codigo and
e.serie_int_codigo = d.serie_int_codigo and b.Pess_INT_Codigo = RA;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Frequencia
-- -----------------------------------------------------

DELIMITER $
   CREATE PROCEDURE proc_Frequencia(ra int, disc int) 
   BEGIN
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
    
   END$
 DELIMITER ;  
 
 -- -----------------------------------------------------
-- procedure proc_CodListaDeChamada
-- -----------------------------------------------------

DELIMITER $$
USE `colegio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_CodListaDeChamada`( Aula int, Serie varchar(20), Professor int, DataChamada date, Disciplina varchar(45))
BEGIN

select b.Lista_INT_Codigo from pcc_tb_listachamada b, pcc_tb_pessoas a
where Hor_INT_Codigo = (select Hor_INT_Codigo from pcc_tb_horario where Pro_INT_Codigo = Professor and Disc_INT_Codigo = (
select Disc_INT_Codigo from pcc_tb_disciplina where Disc_ST_Descricao = disciplina) and Hor_INT_Aula = Aula and 
Serie_INT_Codigo = (select Serie_INT_Codigo from pcc_tb_serie where Serie_ST_Descricao = Serie)) 
and Lista_DT_Data like DataChamada and a.Pess_INT_Codigo = b.Aluno_INT_Codigo;
End$$

DELIMITER ;

 -- -----------------------------------------------------
-- procedure proc_CadTelefone
-- -----------------------------------------------------

DELIMITER $
create procedure proc_CadTelefone(NomeTel varchar(45),Telefone varchar(20), DescricaoTel varchar(45))
begin
Declare CodTel  int;
declare maximo, qtd int;


select Pess_INT_Codigo into CodTel from pcc_tb_pessoas where Pess_ST_Nome = NomeTel; 

select count(*) into qtd from pcc_tb_telefone a, pcc_tb_pessoas b where a.Pess_inT_codigo = b.Pess_inT_codigo and b.Pess_ST_Nome = NomeTel;
select max(tel_int_codigo) into maximo from pcc_tb_telefone a, pcc_tb_pessoas b where a.Pess_inT_codigo = b.Pess_inT_codigo and b.Pess_ST_Nome = NomeTel; 
 
 if (qtd = 0)  then
 set maximo = 1;
 else 
 set maximo= maximo+1;
 end if;
 
insert into pcc_tb_telefone(tel_int_codigo, tel_st_numero, tel_st_descricao, Pess_int_codigo ) values (maximo, Telefone, DescricaoTel, CodTel);

END; $
DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_CadResponsavel
-- -----------------------------------------------------

DELIMITER $
create procedure proc_CadResponsavel(NomeResp varchar(45),CodAluno int, DescResp varchar(45))
begin
Declare CodR  int;
declare maximo, qtd int;


select Pess_INT_Codigo into CodR from pcc_tb_pessoas where Pess_ST_Nome = NomeResp; 

select count(*) into qtd from pcc_tb_responsavel a, pcc_tb_pessoas b where a.Alu_INT_Codigo = b.Pess_inT_codigo and b.Pess_INT_Codigo = CodAluno;
select max(a.Res_INT_Codigo) into maximo from pcc_tb_responsavel a, pcc_tb_pessoas b where a.Alu_INT_Codigo = b.Pess_inT_codigo and b.Pess_INT_Codigo = CodAluno;
 
 if (qtd = 0)  then
 set maximo = 1;
 else 
 set maximo= maximo+1;
 end if;
 
insert into pcc_tb_responsavel(res_int_codigo, alu_int_codigo, resp_int_codigo , res_st_descrição ) values (maximo, CodAluno, CodR, DescResp);

END; $
DELIMITER ;

-- -----------------------------------------------------
-- procedure proc_AttHorario
-- -----------------------------------------------------
DELIMITER $

CREATE  PROCEDURE proc_AttHorario(DiadaSemana varchar(25), Serie varchar (25), Aula int, Disciplina varchar (25), Professor int)
Begin
Declare CodigoH, CodigoD, CodigoS, CodigoDia int;

select func_DiadaSemana(DiadaSemana) into CodigoDia;

select concat(a.Serie_INT_Codigo, CodigoDia, Aula) into CodigoH from pcc_tb_serie a where 
a.Serie_st_descricao = Serie;

select a.disc_int_codigo into CodigoD from pcc_tb_disciplina a where a.Disc_ST_Descricao = Disciplina;

select Serie_INT_Codigo into CodigoS from pcc_tb_serie where Serie_ST_Descricao = Serie;

update pcc_tb_horario set Pro_INT_Codigo = Professor, Disc_INT_Codigo = CodigoD where Hor_INT_Codigo = CodigoH; 



END; $

delimiter ; 