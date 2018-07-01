Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w61Ex9tX008354
 for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2018 10:59:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 41JYSC5CBVzJ343
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 14:59:07 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 41JYSB5Hf7zJ33t
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5A5DE561294
 for <selinux@tycho.nsa.gov>; Sun,  1 Jul 2018 16:59:05 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  1 Jul 2018 16:59:00 +0200
Message-Id: <20180701145900.1481-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] restorecond: close the PID file if writing to it failed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

write_pid_file() leaks a file descriptor to /var/run/restorecond.pid if
it fails to write the PID to it. Close the file before returning.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 restorecond/restorecond.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index 6fbbd35dc1b3..e1d26cb9190d 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -105,6 +105,7 @@ static int write_pid_file(void)
 	}
 	if (write(pidfd, val, (unsigned int)len) != len) {
 		syslog(LOG_ERR, "Unable to write to pidfile (%s)", strerror(errno));
+		close(pidfd);
 		return 1;
 	}
 	close(pidfd);
-- 
2.17.1
