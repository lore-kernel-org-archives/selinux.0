Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u636KTHc017866
 for <selinux@tycho.nsa.gov>; Sun, 3 Jul 2016 02:20:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id 66so13571394pfy.1
 for <selinux@tycho.nsa.gov>; Sat, 02 Jul 2016 23:20:27 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] open_init_pty: Do not error on EINTR
Date: Sun,  3 Jul 2016 14:20:22 +0800
Message-Id: <1467526822-19491-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There is a signal handler so that the select returns EINTR when the
child exits. EINTR is used to then clean up and flush the remaining
buffers. It should not error.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/run_init/open_init_pty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
index 37805bf..6e25ea3 100644
--- a/policycoreutils/run_init/open_init_pty.c
+++ b/policycoreutils/run_init/open_init_pty.c
@@ -327,8 +327,9 @@ int main(int argc, char *argv[])
 			break;
 		}
 
+		errno = 0;
 		int select_rc = select(pty_master + 1, &readfds, &writefds, NULL, NULL);
-		if (select_rc < 0) {
+		if (select_rc < 0 && errno != EINTR) {
 			perror("select()");
 			exit(EX_IOERR);
 		}
-- 
2.7.3
