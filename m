Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8MKQi6r032440
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 16:26:47 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8MKQk1V025944
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 20:26:46 GMT
Received: from [192.168.2.2] (151.76.41.242) by cp-out7.libero.it (8.5.133)
        id 4E68B6BF0239CFF8 for selinux@tycho.nsa.gov; Thu, 22 Sep 2011 22:26:46 +0200
Message-ID: <1316723205.2259.63.camel@vortex>
Subject: [PATCH] Indentation error for Python module seobject (fix typo)
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux <selinux@tycho.nsa.gov>
Date: Thu, 22 Sep 2011 22:26:45 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

I get an IndentationError from Python when running code which imports
seobject.py (line 182).

The following simple patch fixes the problem for current git:

--- selinux-22092011/policycoreutils/semanage/seobject.py	2011-09-17 07:03:41.147162393 +0200
+++ selinux-22092011-fix-indentation-error-in-seobject-python/policycoreutils/semanage/seobject.py	2011-09-22 22:19:19.036640459 +0200
@@ -182,7 +182,7 @@ class semanageRecords:
 
                if not semanageRecords.transaction and store != "":
                       semanage_select_store(handle, store, SEMANAGE_CON_DIRECT);
-                     semanageRecords.store = store
+                      semanageRecords.store = store
 
                if not semanage_is_managed(handle):
                       semanage_handle_destroy(handle)

Thanks.

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
