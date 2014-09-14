Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sF009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:11 -0400
Received: by mail-we0-f172.google.com with SMTP id k48so3067309wev.17
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:17 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.15
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:16 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 04/20] policycoreutils/sandbox: fix debug build
Date: Sun, 14 Sep 2014 23:41:35 +0200
Message-Id: <1410730911-14512-5-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Building from the root directory with "make DEBUG=1" enables -Wshadow
option.  This makes the compilation fails with the following error:

  cc -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror -g
  -I/usr/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra
  -W   -c -o seunshare.o seunshare.c

  seunshare.c: In function 'spawn_command':
  seunshare.c:141:6: error: declaration of 'child' shadows a global declaration [-Werror=shadow]
    int child;
        ^
  seunshare.c:58:12: error: shadowed declaration is here [-Werror=shadow]
   static int child = 0;
              ^

Fix this error by renaming the "child" variable in spawn_command.
---
 policycoreutils/sandbox/seunshare.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index c92e3948219a..6ca6d329dbb4 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -138,19 +138,19 @@ static int set_signal_handles(void)
  * TODO: avoid system() and use exec*() instead
  */
 static int spawn_command(const char *cmd, uid_t uid){
-	int child;
+	int childpid;
 	int status = -1;
 
 	if (verbose > 1)
 		printf("spawn_command: %s\n", cmd);
 
-	child = fork();
-	if (child == -1) {
+	childpid = fork();
+	if (childpid == -1) {
 		perror(_("Unable to fork"));
 		return status;
 	}
 
-	if (child == 0) {
+	if (childpid == 0) {
 		if (drop_privs(uid) != 0) exit(-1);
 
 		status = system(cmd);
@@ -158,7 +158,7 @@ static int spawn_command(const char *cmd, uid_t uid){
 		exit(status);
 	}
 
-	waitpid(child, &status, 0);
+	waitpid(childpid, &status, 0);
 	status_to_retval(status, status);
 	return status;
 }
-- 
2.1.0
