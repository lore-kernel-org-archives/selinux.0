Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7QHDpOb026409
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 13:13:51 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7QHDlLr012413
	for <selinux@tycho.nsa.gov>; Fri, 26 Aug 2005 17:13:47 GMT
Subject: memory leak in services.c
From: Jason Tang <jtang@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-1Ps3ZZPdnR5MvndrjiOb"
Date: Fri, 26 Aug 2005 13:13:47 -0400
Message-Id: <1125076427.5306.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1Ps3ZZPdnR5MvndrjiOb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch corrects a memory leak in sepol_context_to_sid()
within libsepol/services.c.  The context was malloc()ed but never
free()ed afterwards.

-- 
Jason Tang / jtang@tresys.com

--=-1Ps3ZZPdnR5MvndrjiOb
Content-Disposition: attachment; filename=patch-memleak
Content-Type: text/plain; name=patch-memleak; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- services.c-old	2005-08-26 12:19:01.000000000 -0400
+++ services.c	2005-08-26 12:18:18.000000000 -0400
@@ -548,11 +548,14 @@ int sepol_context_to_sid(sepol_security_
 		goto err;		
 
 	context_destroy(context);
+        free(context);
 	return STATUS_SUCCESS;
 
 	err:
-	if (context)
+	if (context) {
 		context_destroy(context);
+                free(context);
+        }
 	DEBUG(__FUNCTION__, "could not convert %s to sid\n", scontext);
 	return STATUS_ERR;
 }

--=-1Ps3ZZPdnR5MvndrjiOb--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
