Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8HLCZZa014976
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2011 17:12:35 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8HLCYM2029476
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2011 21:12:35 GMT
Received: from [192.168.2.2] (151.76.41.242) by cp-out8.libero.it (8.5.133)
        id 4E68B786016449C7 for selinux@tycho.nsa.gov; Sat, 17 Sep 2011 23:12:33 +0200
Subject: [PATCH] policycoreutils: cleaning of semodule_unpackage
From: Guido Trentalancia <guido@trentalancia.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Date: Sat, 17 Sep 2011 23:12:33 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316293953.2249.69.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

I've noticed that semodule_unpackage needs cleaning in Makefile:

--- selinux-17092011-orig/policycoreutils/semodule_package/Makefile	2011-09-09 20:12:56.077662873 +0200
+++ selinux-17092011-patched-sds/policycoreutils/semodule_package/Makefile	2011-09-17 23:06:24.580942929 +0200
@@ -24,7 +24,7 @@ install: all
 relabel:
 
 clean:
-	-rm -f semodule_package *.o
+	-rm -f semodule_package semodule_unpackage *.o
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])

Regards,

Guido



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
