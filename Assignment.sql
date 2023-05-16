--SELECT *
--FROM AddressBook
--;

--���K�P
--���Ӑ�}�X�^���瓾�Ӑ�R�[�h�A���Ӑ於���������ĉ������B
SELECT T_CODE, T_NAME
FROM TOKUI_M
;

--���K�Q
--���i�}�X�^�̑S���ڂ��������ĉ������B
SELECT *
FROM SHOHIN_M
;

--���K�R
--���Ӑ�}�X�^���瓾�Ӑ�R�[�h���1010��̓��Ӑ�R�[�h�A���Ӑ於���������ĉ������B
SELECT T_CODE, T_NAME
FROM TOKUI_M
WHERE T_CODE = 1010
;

--���K�S
--���i�}�X�^���甄��P����1,000�~�ȏ�̏��i�R�[�h�A���i���A����P�����������ĉ������B
SELECT S_CODE, S_NAME, S_TANKA
FROM SHOHIN_M
WHERE S_TANKA >= 1000
;

--���K�T��
--����w�b�_�[���甄��N�������P�X�X�U�N�ł͂Ȃ�����ɂ��đS���ڂ��������ĉ������B
SELECT *
FROM URIAGE_H
WHERE UH_DATE not between 19960000 and 19969999
;

SELECT *
FROM URIAGE_H
WHERE LEFT(UH_DATE, 4) != 1996
;

--���K�U��
--���i�}�X�^���甄��P����1,000�~�ȏ�2,000�~�ȉ��̏��i�̑S���ڂ��������ĉ������B
SELECT *
FROM SHOHIN_M
WHERE S_TANKA between 1000 and 2000
;

--���K�V��
--���i�}�X�^���珤�i�R�[�h���u1001�v���u1003�v�̏��i�ɂ��đS���ڂ��������ĉ������B
SELECT *
FROM SHOHIN_M
WHERE S_CODE = 1001 OR S_CODE = 1003
;

--���K�W��
--���Ӑ�}�X�^���瓾�Ӑ於�Ɂu��X�v�������Ӑ�̓��Ӑ�R�[�h�A���Ӑ於���������ĉ������B
SELECT T_CODE, T_NAME
FROM TOKUI_M
WHERE T_NAME LIKE '%��X%'
;

--���K�X��
--���Ӑ�}�X�^����Z���P���u��c��v�ł͂��܂链�Ӑ�̓��Ӑ�R�[�h�A���Ӑ於���������ĉ������B
SELECT T_CODE, T_NAME
FROM TOKUI_M
WHERE T_ADD1 LIKE '��c��%'
;

--���K�P�O
--���i�}�X�^����e���i�̏��i���ƒP���e�����������ĉ������B �i�P���e�� �� ����P�� �| ���P���j
SELECT S_NAME, S_TANKA - S_GENTAN AS '�P���e��'
FROM SHOHIN_M
;

--���K�P�P
--���i�}�X�^���甄��P���̂P��������1,000�~�𒴂��鏤�i�����������ĉ������B
SELECT S_NAME
FROM SHOHIN_M
WHERE S_TANKA *1.1 > 1000
;

--���K�P�Q
--���Ӑ�}�X�^����Z���P���u��c��v����͂��܂链�Ӑ�ɂ��ėX�֔ԍ������ɑS���ڂ��������ĉ������B
SELECT *
FROM TOKUI_M
WHERE T_ADD1 LIKE '��c��%'
ORDER BY T_YUBIN ASC
;

--���K�P�R
--���i�}�X�^���甄��P�����������ɁA�܂������P���̏ꍇ�͏��i�R�[�h�����������ɑS���ڂ��������ĉ������B
SELECT * 
FROM SHOHIN_M
ORDER BY S_TANKA DESC, S_CODE ASC
;

--���K�P�S
--���i�}�X�^����S���i�̕��ϔ���P�����������ĉ������B
SELECT AVG(S_TANKA) AS '�S���i�̕��ϔ���P��'
FROM SHOHIN_M
;

--���K�P�T
--����w�b�_�[�̔��㍇�v���z��1���~�𒴂��錏�����������ĉ������B
SELECT count(*)
FROM URIAGE_H
WHERE UH_GOKEI > 10000
;

--���K�P�U
--����w�b�_�[���瓾�Ӑ�R�[�h���̍��v���z�𓾈Ӑ�R�[�h���Ɍ������ĉ������B
SELECT UH_TCODE, SUM(UH_GOKEI)
FROM URIAGE_H
Group BY UH_TCODE
ORDER BY UH_TCODE
;

--���K�P�V
--���㖾�ׂ��珤�i�R�[�h���̐��ʍ��v�Ə��i�R�[�h�𐔗ʂ̑������Ɍ������ĉ������B
select UM_SCODE, sum(UM_SU)
from URIAGE_M
group by UM_SCODE
order by sum(UM_SU) desc
;

--���K�P�W
--���㖾�ׂƏ��i�}�X�^���珤�i�R�[�h�A���i���A������z���������ĉ������B
--�������A���㖾�ׂɂȂ����i�ɂ��Ă����i�R�[�h�A���i����\�����ĉ������B
select SHOHIN_M.S_CODE, SHOHIN_M.S_NAME, URIAGE_M.UM_URIKIN --���i�R�[�h�A���i���A������z
from URIAGE_M
right join SHOHIN_M
on URIAGE_M.UM_SCODE = SHOHIN_M.S_CODE
order by SHOHIN_M.S_CODE
;

--���K�P�X��
--���㖾�ׂƏ��i�}�X�^���珤�i�R�[�h���ɏ��i�R�[�h�A���i��, ���㐔�ʂ��������ĉ������B
--�������A���㖾�ׂɂȂ����i�ɂ��Ă͏��i�R�[�h�A���i����\�����Ȃ��ŉ������B
select UM_SCODE, SHOHIN_M.S_NAME, SUM(UM_SU)
from URIAGE_M
INNER JOIN SHOHIN_M
ON URIAGE_M.UM_SCODE = SHOHIN_M.S_CODE
group by UM_SCODE, SHOHIN_M.S_NAME
order by S_NAME
;

--���K�Q�O
--���㖾�ׂƏ��i�}�X�^���珤�i�R�[�h���ɏ��i�R�[�h�A���i��, ���㐔�ʂ��������ĉ������B
--�������A���㖾�ׂɂȂ����i�ɂ��Ă����i�R�[�h�A���i����\�����ĉ������B
select S_CODE, SHOHIN_M.S_NAME, SUM(UM_SU)
from SHOHIN_M
LEFT JOIN URIAGE_M
ON URIAGE_M.UM_SCODE = SHOHIN_M.S_CODE
group by S_CODE, SHOHIN_M.S_NAME
;

--���K�Q�P��
--����w�b�_�[�A���㖾�ׁA���Ӑ�}�X�^�A���i�}�X�^����
--����N�������P�X�X�V�N�̓��Ӑ�R�[�h�A���Ӑ於�A����N�����A�`�[�ԍ��A���i�R�[�h�A���i���A������z��
--���Ӑ�R�[�h�������� 
--�������A���т��Ȃ����Ӑ�A���i�͕\�����Ȃ�

SELECT T_CODE, T_NAME, UH_DATE, UH_DENNO, S_CODE, S_NAME, UM_URITAN
FROM URIAGE_H
JOIN URIAGE_M
ON URIAGE_H.UH_DENNO = URIAGE_M.UM_DENNO
JOIN TOKUI_M
ON TOKUI_M.T_CODE = URIAGE_H.UH_TCODE
JOIN SHOHIN_M
ON URIAGE_M.UM_SCODE = SHOHIN_M.S_CODE
WHERE URIAGE_H.UH_DATE between 19970000 and 19979999
ORDER BY  T_CODE ASC
;


--���K�Q�Q
--���i�}�X�^����
--�S���i�̕��ϔ���P����荂��
--���i�̏��i�R�[�h�A���i���A����P��������
SELECT S_CODE, S_NAME, S_TANKA
FROM SHOHIN_M
WHERE S_TANKA > (
	SELECT AVG(S_TANKA)
	FROM SHOHIN_M
)

--���K�Q�R
--���i�}�X�^����
--�P�����P�Ԉ������i�ƂP�ԍ������i�̏��i�R�[�h�A���i���A����P��������
SELECT S_CODE, S_NAME, S_TANKA
FROM SHOHIN_M
WHERE S_TANKA = (SELECT MIN(S_TANKA) FROM SHOHIN_M) OR S_TANKA = (SELECT MAX(S_TANKA) FROM SHOHIN_M)
;

--���K�Q�S��
--���Ӑ�R�[�h�u1001�v�ɔ̔��������i�����������ĉ������B
SELECT S_NAME
FROM TOKUI_M
--WHERE T_CODE = 1001
INNER JOIN URIAGE_H
ON T_CODE = UH_TCODE
INNER JOIN URIAGE_M
ON UH_DENNO = UM_DENNO
JOIN SHOHIN_M
ON UM_SCODE = S_CODE
GROUP BY S_NAME, T_CODE
HAVING T_CODE = 1001
;

--���K�Q�T��
--���i�R�[�h�u1001�v��̔����������Ȃ����Ӑ於���������ĉ������B
--(�̔��������Ƃ��Ȃ����Ӑ�Ƃ������Ƃ́E�E�E�B
SELECT T_NAME
FROM TOKUI_M
WHERE T_CODE not in (
	SELECT T_CODE
	FROM URIAGE_H
	JOIN TOKUI_M
	ON T_CODE = UH_TCODE
	JOIN URIAGE_M
	ON UH_DENNO = UM_DENNO
	WHERE UM_SCODE = 1001
	GROUP BY T_CODE
)
;

--�Q�D�f�[�^�̒ǉ�
--���K�Q�U
--���i�}�X�^�Ɉȉ��̃f�[�^��ǉ����ĉ������B
INSERT INTO SHOHIN_M
(S_CODE, S_NAME, S_TANI, S_TANKA, S_GENTAN)
VALUES (5, '���R��', '��', 500, 400), (6, '�É��}�X�J�b�g', '��', 2200, 1700)
;
SELECT *
FROM SHOHIN_M
;

--���K�Q�V
--���i�}�X�^�[��́u���i�R�[�h��5001�v�̏��i�R�[�h�A���i�������i���[�N�ɒǉ����ĉ������B
INSERT INTO SHOHIN_W
(S_CODE, S_NAME)
VALUES (5001, '�}�X�J�b�g��')
;
SELECT * FROM SHOHIN_W;

--���K�Q�W
--���Ӑ�R�[�h�u1001�v�ɔ̔��������i�R�[�h�A���i�������i���[�N�ɒǉ����ĉ������B
INSERT INTO SHOHIN_W
(S_CODE, S_NAME)
SELECT S_CODE, S_NAME
FROM SHOHIN_M
JOIN URIAGE_M
ON UM_SCODE = S_CODE
JOIN URIAGE_H
ON UM_DENNO = UH_DENNO
JOIN TOKUI_M
ON UH_TCODE = T_CODE
WHERE T_CODE = 1001
GROUP BY S_CODE, S_NAME
;
SELECT * FROM SHOHIN_W;

--�R�D�f�[�^�̕ύX
--���K�Q�X
--���Ӑ�}�X�^�̃f�[�^���ȉ��̃f�[�^�ɕύX���ĉ������B�i�ύX�ӏ��͖Ԋ|�������j
UPDATE TOKUI_M
SET T_TEL = '03-5125-2552'
WHERE T_CODE = 1001
;
UPDATE TOKUI_M
SET 
	T_NAME = '������Џ�B��',
	T_ADD2 = '��7�r��1�K'
WHERE T_CODE = 1002
;
SELECT *
FROM TOKUI_M
WHERE T_CODE = 1001 OR T_CODE = 1002
;

--���K�R�O
--����w�b�_�[�̔���N�������u�P�X�X�V�N�S���P���v�ȍ~�̓`�[�ɂ��āA���㍇�v�~0.05�ɏ���ł�ύX���ĉ������B
SELECT *
FROM URIAGE_H 
WHERE UH_DATE > 19970401
;
UPDATE URIAGE_H
SET UH_ZEI = UH_GOKEI * 0.05
WHERE UH_DATE > 19970401
;
SELECT *
FROM URIAGE_H 
WHERE UH_DATE > 19970401
;

--�S�D�f�[�^�̍폜
--���K�R�P
--���i�}�X�^�̈ȉ��̃f�[�^���폜���ĉ������B
DELETE FROM SHOHIN_M
WHERE S_CODE = 5 OR S_CODE = 6
;
SELECT *
FROM SHOHIN_M
;

--���K�R�Q
--���i���[�N���瓾�Ӑ�R�[�h�u1001�v�ɔ̔��������i���폜���ĉ������B
--�i���i�}�X�^�ł͂Ȃ����i���[�N�ł��B�ԈႦ�Ȃ��ŉ������j
DELETE FROM SHOHIN_W
WHERE S_CODE IN (
SELECT S_CODE--, S_NAME
	FROM SHOHIN_M
	JOIN URIAGE_M
	ON UM_SCODE = S_CODE
	JOIN URIAGE_H
	ON UM_DENNO = UH_DENNO
	JOIN TOKUI_M
	ON UH_TCODE = T_CODE
	WHERE T_CODE = 1001
	GROUP BY S_CODE, S_NAME
)
;
SELECT * FROM SHOHIN_W;

--All Done!!!