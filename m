Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5FGeGDN008555
	for <selinux@tycho.nsa.gov>; Fri, 15 Jun 2012 12:40:16 -0400
Message-Id: <201206151640.q5FGeDaE024142@vivaldi22.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH]: relabel all mount runtime files in the restorecond example config
Date: Fri, 15 Jun 2012 18:40:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ship a restorecond.conf file that relabels all mount runtime files under /etc and
not just /etc/mtab.

Mount also uses /etc/mtab~[0-9]{0,20} lock files (the number corresponds to the
PID) and the /etc/mtab.tmp temporary file.

The above refers to mount from util-linux-2.21.2 from kernel.org. See mount -vvv
for the location of such files.

A patch is also available for the reference policy to fix this issue.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 policycoreutils/restorecond/restorecond.conf |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- selinux-04062012/policycoreutils/restorecond/restorecond.conf	2011-11-15 00:32:56.865740944 +0100
+++ selinux-04062012-restorecond-conf-relabel-mount-runtime-files/policycoreutils/restorecond/restorecond.conf	2012-06-15 19:46:08.178417897 +0200
@@ -1,7 +1,7 @@
 /etc/services
 /etc/resolv.conf
 /etc/samba/secrets.tdb
-/etc/mtab
+/etc/mtab*
 /var/run/utmp
 /var/log/wtmp
 /root/* 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
