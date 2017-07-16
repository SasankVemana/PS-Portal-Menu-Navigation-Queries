SELECT Y.ROLENAME, 
       Y.MENUNAME, 
       Y.COMPONENTNAME, 
       Y.MARKET, 
       Y.PORTAL_LABEL            AS LABEL, 
       To_char(E.PORTAL_NAVPATH) AS PORTAL_NAVPATH, 
       Y.PORTAL_URLTEXT 
FROM   (SELECT X.*, 
               D.PORTAL_NAME, 
               D.PORTAL_REFTYPE, 
               D.PORTAL_OBJNAME, 
               D.PORTAL_PRNTOBJNAME, 
               D.PORTAL_LABEL, 
               D.PORTAL_URLTEXT 
        FROM   (SELECT DISTINCT A.ROLENAME, 
                                B.MENUNAME, 
                                C.PNLGRPNAME AS COMPONENTNAME, 
                                C.MARKET 
                FROM   PSROLECLASS A, 
                       PSAUTHITEM B, 
                       PSMENUITEM C 
                WHERE  A.ROLENAME IN ( 'PeopleSoft User' ) /* <<< Enter your Role Name Here */ 
                       AND A.CLASSID = B.CLASSID 
                       AND B.MENUNAME = C.MENUNAME 
                       AND B.BARNAME = C.BARNAME 
                       AND B.BARITEMNAME = C.ITEMNAME) X 
               LEFT OUTER JOIN PSPRSMDEFN D 
                            ON X.MENUNAME = D.PORTAL_URI_SEG1 
                               AND X.COMPONENTNAME = D.PORTAL_URI_SEG2 
                               AND X.MARKET = D.PORTAL_URI_SEG3 
                               AND D.PORTAL_NAME = 'EMPLOYEE' /* <<< Enter your Portal Name Here */ 
                               AND D.PORTAL_LINKOBJNAME = ' ') Y 
       LEFT OUTER JOIN PSPRSMNAVINFO E 
                    ON Y.PORTAL_NAME = E.PORTAL_NAME 
                       AND Y.PORTAL_REFTYPE = E.PORTAL_REFTYPE 
                       AND Y.PORTAL_OBJNAME = E.PORTAL_OBJNAME 
ORDER  BY 6, 2, 4; 