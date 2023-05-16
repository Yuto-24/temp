--SELECT *
--FROM AddressBook
--;

--演習１
--得意先マスタから得意先コード、得意先名を検索して下さい。
SELECT T_CODE, T_NAME
FROM TOKUI_M
;

--演習２
--商品マスタの全項目を検索して下さい。
SELECT *
FROM SHOHIN_M
;

--演習３
--得意先マスタから得意先コードが｢1010｣の得意先コード、得意先名を検索して下さい。
SELECT T_CODE, T_NAME
FROM TOKUI_M
WHERE T_CODE = 1010
;

--演習４
--商品マスタから売上単価が1,000円以上の商品コード、商品名、売上単価を検索して下さい。
SELECT S_CODE, S_NAME, S_TANKA
FROM SHOHIN_M
WHERE S_TANKA >= 1000
;

--演習５★
--売上ヘッダーから売上年月日が１９９６年ではない売上について全項目を検索して下さい。
SELECT *
FROM URIAGE_H
WHERE UH_DATE not between 19960000 and 19969999
;

SELECT *
FROM URIAGE_H
WHERE LEFT(UH_DATE, 4) != 1996
;

--演習６★
--商品マスタから売上単価が1,000円以上2,000円以下の商品の全項目を検索して下さい。
SELECT *
FROM SHOHIN_M
WHERE S_TANKA between 1000 and 2000
;

--演習７★
--商品マスタから商品コードが「1001」か「1003」の商品について全項目を検索して下さい。
SELECT *
FROM SHOHIN_M
WHERE S_CODE = 1001 OR S_CODE = 1003
;

--演習８★
--得意先マスタから得意先名に「酒店」がつく得意先の得意先コード、得意先名を検索して下さい。
SELECT T_CODE, T_NAME
FROM TOKUI_M
WHERE T_NAME LIKE '%酒店%'
;

--演習９★
--得意先マスタから住所１が「大田区」ではじまる得意先の得意先コード、得意先名を検索して下さい。
SELECT T_CODE, T_NAME
FROM TOKUI_M
WHERE T_ADD1 LIKE '大田区%'
;

--演習１０
--商品マスタから各商品の商品名と単価粗利を検索して下さい。 （単価粗利 ＝ 売上単価 － 原単価）
SELECT S_NAME, S_TANKA - S_GENTAN AS '単価粗利'
FROM SHOHIN_M
;

--演習１１
--商品マスタから売上単価の１割増しが1,000円を超える商品名を検索して下さい。
SELECT S_NAME
FROM SHOHIN_M
WHERE S_TANKA *1.1 > 1000
;

--演習１２
--得意先マスタから住所１が「大田区」からはじまる得意先について郵便番号昇順に全項目を検索して下さい。
SELECT *
FROM TOKUI_M
WHERE T_ADD1 LIKE '大田区%'
ORDER BY T_YUBIN ASC
;

--演習１３
--商品マスタから売上単価が高い順に、また同じ単価の場合は商品コードが小さい順に全項目を検索して下さい。
SELECT * 
FROM SHOHIN_M
ORDER BY S_TANKA DESC, S_CODE ASC
;

--演習１４
--商品マスタから全商品の平均売上単価を検索して下さい。
SELECT AVG(S_TANKA) AS '全商品の平均売上単価'
FROM SHOHIN_M
;

--演習１５
--売上ヘッダーの売上合計金額が1万円を超える件数を検索して下さい。
SELECT count(*)
FROM URIAGE_H
WHERE UH_GOKEI > 10000
;

--演習１６
--売上ヘッダーから得意先コード毎の合計金額を得意先コード順に検索して下さい。
SELECT UH_TCODE, SUM(UH_GOKEI)
FROM URIAGE_H
Group BY UH_TCODE
ORDER BY UH_TCODE
;

--演習１７
--売上明細から商品コード毎の数量合計と商品コードを数量の多い順に検索して下さい。
select UM_SCODE, sum(UM_SU)
from URIAGE_M
group by UM_SCODE
order by sum(UM_SU) desc
;

--演習１８
--売上明細と商品マスタから商品コード、商品名、売上金額を検索して下さい。
--ただし、売上明細にない商品についても商品コード、商品名を表示して下さい。
select SHOHIN_M.S_CODE, SHOHIN_M.S_NAME, URIAGE_M.UM_URIKIN --商品コード、商品名、売上金額
from URIAGE_M
right join SHOHIN_M
on URIAGE_M.UM_SCODE = SHOHIN_M.S_CODE
order by SHOHIN_M.S_CODE
;

--演習１９★
--売上明細と商品マスタから商品コード毎に商品コード、商品名, 売上数量を検索して下さい。
--ただし、売上明細にない商品については商品コード、商品名を表示しないで下さい。
select UM_SCODE, SHOHIN_M.S_NAME, SUM(UM_SU)
from URIAGE_M
INNER JOIN SHOHIN_M
ON URIAGE_M.UM_SCODE = SHOHIN_M.S_CODE
group by UM_SCODE, SHOHIN_M.S_NAME
order by S_NAME
;

--演習２０
--売上明細と商品マスタから商品コード毎に商品コード、商品名, 売上数量を検索して下さい。
--ただし、売上明細にない商品についても商品コード、商品名を表示して下さい。
select S_CODE, SHOHIN_M.S_NAME, SUM(UM_SU)
from SHOHIN_M
LEFT JOIN URIAGE_M
ON URIAGE_M.UM_SCODE = SHOHIN_M.S_CODE
group by S_CODE, SHOHIN_M.S_NAME
;

--演習２１★
--売上ヘッダー、売上明細、得意先マスタ、商品マスタから
--売上年月日が１９９７年の得意先コード、得意先名、売上年月日、伝票番号、商品コード、商品名、売上金額を
--得意先コード昇順検索 
--ただし、実績がない得意先、商品は表示しない

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


--演習２２
--商品マスタから
--全商品の平均売上単価より高い
--商品の商品コード、商品名、売上単価を検索
SELECT S_CODE, S_NAME, S_TANKA
FROM SHOHIN_M
WHERE S_TANKA > (
	SELECT AVG(S_TANKA)
	FROM SHOHIN_M
)

--演習２３
--商品マスタから
--単価が１番安い商品と１番高い商品の商品コード、商品名、売上単価を検索
SELECT S_CODE, S_NAME, S_TANKA
FROM SHOHIN_M
WHERE S_TANKA = (SELECT MIN(S_TANKA) FROM SHOHIN_M) OR S_TANKA = (SELECT MAX(S_TANKA) FROM SHOHIN_M)
;

--演習２４★
--得意先コード「1001」に販売した商品名を検索して下さい。
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

--演習２５★
--商品コード「1001」を販売した事がない得意先名を検索して下さい。
--(販売したことがない得意先ということは・・・。
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

--２．データの追加
--演習２６
--商品マスタに以下のデータを追加して下さい。
INSERT INTO SHOHIN_M
(S_CODE, S_NAME, S_TANI, S_TANKA, S_GENTAN)
VALUES (5, '岡山桃', '個', 500, 400), (6, '静岡マスカット', '箱', 2200, 1700)
;
SELECT *
FROM SHOHIN_M
;

--演習２７
--商品マスター上の「商品コード＝5001」の商品コード、商品名を商品ワークに追加して下さい。
INSERT INTO SHOHIN_W
(S_CODE, S_NAME)
VALUES (5001, 'マスカット飴')
;
SELECT * FROM SHOHIN_W;

--演習２８
--得意先コード「1001」に販売した商品コード、商品名を商品ワークに追加して下さい。
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

--３．データの変更
--演習２９
--得意先マスタのデータを以下のデータに変更して下さい。（変更箇所は網掛け部分）
UPDATE TOKUI_M
SET T_TEL = '03-5125-2552'
WHERE T_CODE = 1001
;
UPDATE TOKUI_M
SET 
	T_NAME = '株式会社上州屋',
	T_ADD2 = '第7ビル1階'
WHERE T_CODE = 1002
;
SELECT *
FROM TOKUI_M
WHERE T_CODE = 1001 OR T_CODE = 1002
;

--演習３０
--売上ヘッダーの売上年月日が「１９９７年４月１日」以降の伝票について、売上合計×0.05に消費税を変更して下さい。
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

--４．データの削除
--演習３１
--商品マスタの以下のデータを削除して下さい。
DELETE FROM SHOHIN_M
WHERE S_CODE = 5 OR S_CODE = 6
;
SELECT *
FROM SHOHIN_M
;

--演習３２
--商品ワークから得意先コード「1001」に販売した商品を削除して下さい。
--（商品マスタではなく商品ワークです。間違えないで下さい）
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