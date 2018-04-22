Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3MJMt3v030657
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 15:22:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 40Tfct3LJczJ343
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 19:22:54 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 40Tfcs5bsnzJ33s
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 19:22:53 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 467855646F3
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 21:22:16 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 22 Apr 2018 21:21:47 +0200
Message-Id: <20180422192148.7320-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/2] sestatus: resolve symlinks in path when looking
 for a process
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"sestatus -v" uses /proc/$PID/exe symbolic link in order to find the
context of processes present in /etc/sestatus.conf. For example, this
file includes "/usr/sbin/sshd".

On Arch Linux, /bin, /sbin and /usr/sbin are symbolic links to /usr/bin,
so sshd process is seen as "/usr/bin/sshd" instead of "/usr/sbin/sshd".
This causes "sestatus -v" to show nothing in "Process contexts:" for
sshd, agetty, etc.

Use realpath() to resolve any symlink components in program paths
defined in /etc/sestatus.conf. This makes "sestatus -v" show the
expected result:

    Process contexts:
    Current context:                sysadm_u:sysadm_r:sysadm_t
    Init context:                   system_u:system_r:init_t
    /sbin/agetty                    system_u:system_r:getty_t
    /usr/sbin/sshd                  system_u:system_r:sshd_t

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/sestatus/sestatus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index b05e794cabe7..d7f198c2fa0d 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -61,6 +61,7 @@ int cmp_cmdline(const char *command, int pid)
 int pidof(const char *command)
 {
 /* inspired by killall5.c from psmisc */
+	char stackpath[PATH_MAX + 1], *p;
 	DIR *dir;
 	struct dirent *de;
 	int pid, ret = -1, self = getpid();
@@ -70,6 +71,11 @@ int pidof(const char *command)
 		return -1;
 	}
 
+	/* Resolve the path if it contains symbolic links */
+	p = realpath(command, stackpath);
+	if (p)
+		command = p;
+
 	while ((de = readdir(dir)) != NULL) {
 		errno = 0;
 		pid = (int)strtol(de->d_name, (char **)NULL, 10);
-- 
2.17.0
