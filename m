Message-Id: <20080103184515.827642668@tresys.com>
References: <20080103184331.485176161@tresys.com>
Date: Thu, 03 Jan 2008 13:43:35 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@madmethod.com, sds@tycho.nsa.gov
Subject: [patch 4/7] quiet libsemanage scanner warnings
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Supress the generation of unused functions in the scanner.
There are still a few warnings about the generated scanner
code but that has to be fixed in flex.

---
 libsemanage/src/conf-scan.l |    1 +
 1 file changed, 1 insertion(+)

Index: trunk/libsemanage/src/conf-scan.l
===================================================================
--- trunk.orig/libsemanage/src/conf-scan.l
+++ trunk/libsemanage/src/conf-scan.l
@@ -32,6 +32,7 @@ int yywrap(void);
 %}
 
 %option stack prefix="semanage_"
+%option nounput noyy_push_state noyy_pop_state noyy_top_state
 
 %x arg
 

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
