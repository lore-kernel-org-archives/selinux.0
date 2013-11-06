Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA6COEiT011596
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2013 07:24:15 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 325B61A1A6
	for <selinux@tycho.nsa.gov>; Wed,  6 Nov 2013 13:24:05 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zbTgFSokB1A5 for <selinux@tycho.nsa.gov>;
	Wed,  6 Nov 2013 13:24:02 +0100 (CET)
Received: from soldur.bigon.be (unknown [193.53.238.195])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 2D9AC1A00F
	for <selinux@tycho.nsa.gov>; Wed,  6 Nov 2013 13:24:02 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 2/3] Improve restorecond systemd unit file
Date: Wed,  6 Nov 2013 13:24:00 +0100
Message-Id: <1383740641-9927-2-git-send-email-bigon@debian.org>
In-Reply-To: <1383740641-9927-1-git-send-email-bigon@debian.org>
References: <1383740641-9927-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

Use Type=forking and pass PIDFile option, this allows better tracking of
the livecycle of the daemon.

Only attempt to start the daemon if selinux is enabled.

Drop After=syslog.target, syslog is socket activated anyway
---
 policycoreutils/restorecond/restorecond.service | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/restorecond/restorecond.service b/policycoreutils/restorecond/restorecond.service
index 7d64cc5..0511a1c 100644
--- a/policycoreutils/restorecond/restorecond.service
+++ b/policycoreutils/restorecond/restorecond.service
@@ -1,12 +1,12 @@
 [Unit]
 Description=Restorecon maintaining path file context
-After=syslog.target
 ConditionPathExists=/etc/selinux/restorecond.conf
+ConditionSecurity=selinux
 
 [Service]
-Type=oneshot
+Type=forking
 ExecStart=/usr/sbin/restorecond
-RemainAfterExit=yes
+PIDFile=/var/run/restorecond.pid
 
 [Install]
 WantedBy=multi-user.target
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
