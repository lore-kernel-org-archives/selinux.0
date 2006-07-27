Message-ID: <44C90F7E.4060007@tresys.com>
Date: Thu, 27 Jul 2006 15:09:50 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: sds@tycho.nsa.gov
Subject: [PATCH] restorecond 64bit correctness
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch is necessary for restorecond to compile on x86-64:

Index: policycoreutils/restorecond/restorecond.c
===================================================================
--- policycoreutils/restorecond/restorecond.c	(revision 983)
+++ policycoreutils/restorecond/restorecond.c	(working copy)
@@ -232,7 +232,7 @@
 static void process_config(int fd, FILE * cfg)
 {
 	char *line_buf = NULL;
-	unsigned int len = 0;
+	size_t len = 0;
 
 	while (getline(&line_buf, &len, cfg) > 0) {
 		char *buffer = line_buf;




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
