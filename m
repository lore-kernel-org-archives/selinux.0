Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l17H9D82024082
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 12:09:13 -0500
Received: from tex.courtesan.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l17HAJf5009537
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 17:10:20 GMT
Received: from tex.courtesan.com (smmsp@localhost [127.0.0.1])
	by tex.courtesan.com (8.14.0/8.13.8) with ESMTP id l17H9u85030835
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 7 Feb 2007 12:09:56 -0500 (EST)
Date: Wed, 7 Feb 2007 12:09:56 -0500 (EST)
Message-Id: <200702071709.l17H9ute004872@tex.courtesan.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
From: Todd.Miller@sparta.com
Subject: PATCH: setfiles memory leak
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a memory leak on an error path.

 - todd

--- policycoreutils-1.34.1/setfiles/setfiles.c	2006-06-29 14:21:16.000000000 -0400
+++ policycoreutils-1.34.1/setfiles/setfiles.c	2007-02-06 17:00:19.000000000 -0500
@@ -357,6 +357,7 @@
 				"%s: %s not reset customized by admin to %s\n",
 				progname, my_file, context);
 		}
+		freecon(context);
 		goto out;
 	}
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
