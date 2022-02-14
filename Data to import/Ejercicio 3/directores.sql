use colegio;

/*
	update departamento set director=1 where id=1;
	update departamento set director=13 where id=2;
	update departamento set director=23 where id=3;
	update departamento set director=34 where id=4;
	update departamento set director=39 where id=5;
	update departamento set director=46 where id=6;
	update departamento set director=42 where id=7;
	update departamento set director=50 where id=8;
	update departamento set director=30 where id=9;
	update departamento set director=33 where id=10;
*/
update departamento set director=(select nrp from profesor where depto=1 limit 1) where id=1;
update departamento set director=(select nrp from profesor where depto=2 limit 1) where id=2;
update departamento set director=(select nrp from profesor where depto=3 limit 1) where id=3;
update departamento set director=(select nrp from profesor where depto=4 limit 1) where id=4;
update departamento set director=(select nrp from profesor where depto=5 limit 1) where id=5;
update departamento set director=(select nrp from profesor where depto=6 limit 1) where id=6;
update departamento set director=(select nrp from profesor where depto=7 limit 1) where id=7;
update departamento set director=(select nrp from profesor where depto=8 limit 1) where id=8;
update departamento set director=(select nrp from profesor where depto=9 limit 1) where id=9;
update departamento set director=(select nrp from profesor where depto=10 limit 1) where id=10;