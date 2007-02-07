Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17H99cH024071
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 12:09:09 -0500
Received: from tex.courtesan.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l17HAGo6021294
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 17:10:16 GMT
Received: from tex.courtesan.com (smmsp@localhost [127.0.0.1])
	by tex.courtesan.com (8.14.0/8.13.8) with ESMTP id l17H9rAt018325
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 12:09:54 -0500 (EST)
Date: Wed, 7 Feb 2007 12:09:53 -0500 (EST)
Message-Id: <200702071709.l17H9rqk000601@tex.courtesan.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
From: Todd.Miller@sparta.com
Subject: PATCH: libsemanage-1.10.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is no advantage to using strnlen() over strlen() since buf is
guaranteed to be a NUL-terminated string.

 - todd

--- libsemanage-1.10.0/src/semanage_store.c	2007-01-08 16:20:17.000000000 -0500
+++ libsemanage-1.10.0/src/semanage_store.c	2007-02-06 17:04:41.000000000 -0500
@@ -968,14 +968,14 @@
 		if (!strncmp(buf, "HOME_DIR", 8) ||
 		    !strncmp(buf, "HOME_ROOT", 9) || strstr(buf, "ROLE")) {
 			/* This contains one of the template variables, write it to homedir.template */
-			if (write(hd, buf, strnlen(buf, PATH_MAX)) == 0) {
+			if (write(hd, buf, strlen(buf)) == 0) {
 				ERR(sh, "Write to %s failed.",
 				    semanage_path(SEMANAGE_TMP,
 						  SEMANAGE_HOMEDIR_TMPL));
 				goto cleanup;
 			}
 		} else {
-			if (write(fc, buf, strnlen(buf, PATH_MAX)) == 0) {
+			if (write(fc, buf, strlen(buf)) == 0) {
 				ERR(sh, "Write to %s failed.",
 				    semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
 				goto cleanup;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
