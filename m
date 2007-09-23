Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8NHW5e2027459
	for <selinux@tycho.nsa.gov>; Sun, 23 Sep 2007 13:32:05 -0400
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8NHW3CK006643
	for <selinux@tycho.nsa.gov>; Sun, 23 Sep 2007 17:32:04 GMT
Subject: [refpolicy] minor comment patch for cron.if
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: cpebenito@tresys.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-DpvGYi/DjLYn5Yhx1OBu"
Date: Sun, 23 Sep 2007 18:31:28 +0100
Message-Id: <1190568688.3831.4.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-DpvGYi/DjLYn5Yhx1OBu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The file cron.if at line 470 has a wrong comment I guess.
Please have a look at the patch because I'm not 100% sure if I guessed
the right comment. I saw that only while I run over the cron interfaces.

--=-DpvGYi/DjLYn5Yhx1OBu
Content-Disposition: attachment; filename=cron.if.patch
Content-Type: text/x-patch; name=cron.if.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- ../refpolicy-20070629/policy/modules/services/cron.if	2007-06-27 16:23:21.000000000 +0100
+++ policy/modules/services/cron.if	2007-09-23 18:25:02.000000000 +0100
@@ -465,7 +465,7 @@
 
 ########################################
 ## <summary>
-##	Execute APM in the apm domain.
+##	Execute anacron in the cron system domain.
 ## </summary>
 ## <param name="domain">
 ##	<summary>

--=-DpvGYi/DjLYn5Yhx1OBu--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
