From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: jason@perfinion.com, bigon@debian.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 18 Jul 2017 09:04:54 -0400
Message-Id: <20170718130454.21079-2-sds@tycho.nsa.gov>
In-Reply-To: <20170718130454.21079-1-sds@tycho.nsa.gov>
References: <20170718130454.21079-1-sds@tycho.nsa.gov>
Subject: [PATCH 2/2] open_init_pty: restore stdin/stdout to blocking upon exit
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

At exit, restore stdin and stdout to blocking.

Test: run_init id && run_init id
Test: open_init_pty bash -c 'echo hello; exec >&- 2>&- <&-; sleep 1;'

Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863187
Fixes: https://bugs.gentoo.org/show_bug.cgi?id=621062
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policycoreutils/run_init/open_init_pty.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
index 6e25ea3..150cb45 100644
--- a/policycoreutils/run_init/open_init_pty.c
+++ b/policycoreutils/run_init/open_init_pty.c
@@ -191,6 +191,28 @@ static void setfd_nonblock(int fd)
 	}
 }
 
+static void setfd_block(int fd)
+{
+	int fsflags = fcntl(fd, F_GETFL);
+
+	if (fsflags < 0) {
+		fprintf(stderr, "fcntl(%d, F_GETFL): %s\n", fd, strerror(errno));
+		exit(EX_IOERR);
+	}
+
+	if (fcntl(fd, F_SETFL, fsflags & ~O_NONBLOCK) < 0) {
+		fprintf(stderr, "fcntl(%d, F_SETFL, ... & ~O_NONBLOCK): %s\n", fd, strerror(errno));
+		exit(EX_IOERR);
+	}
+}
+
+static void setfd_atexit(void)
+{
+	setfd_block(STDIN_FILENO);
+	setfd_block(STDOUT_FILENO);
+	return;
+}
+
 static void sigchld_handler(int asig __attribute__ ((unused)))
 {
 }
@@ -280,6 +302,10 @@ int main(int argc, char *argv[])
 	setfd_nonblock(pty_master);
 	setfd_nonblock(STDIN_FILENO);
 	setfd_nonblock(STDOUT_FILENO);
+	if (atexit(setfd_atexit) < 0) {
+		perror("atexit()");
+		exit(EXIT_FAILURE);
+	}
 
 	if (isatty(STDIN_FILENO)) {
 		if (tty_semi_raw(STDIN_FILENO) < 0) {
-- 
2.9.4
