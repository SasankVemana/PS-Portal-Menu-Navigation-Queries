/* Old Portal Query */
SELECT TREELEVEL, 
       CASE 
         WHEN TREELEVEL = 1 THEN '---> ' 
                                 || PORTAL_LABEL 
         ELSE PORTAL_LABEL 
       END AS MENU 
FROM   (SELECT ROWNUM AS ROWNBR, 
               LEVEL  AS TREELEVEL, 
               PORTAL_LABEL 
        FROM   PSPRSMDEFN 
        WHERE  PORTAL_LABEL <> 'Root' 
               AND PORTAL_NAME = 'EMPLOYEE' /* <<< Enter your Portal Name Here */ 
        CONNECT BY PORTAL_OBJNAME = PRIOR PORTAL_PRNTOBJNAME 
                                          AND PORTAL_NAME = PRIOR PORTAL_NAME 
        START WITH PORTAL_URI_SEG2 in('USERMAINT', 'IB_MONITOR') /* <<< Enter your Component Name Here */ 
       ) 
ORDER  BY ROWNBR DESC; 