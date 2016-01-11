Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0B9Uv74006631
 for <selinux@tycho.nsa.gov>; Mon, 11 Jan 2016 04:31:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id CE6A58DFF8
 for <selinux@tycho.nsa.gov>; Mon, 11 Jan 2016 09:30:57 +0000 (UTC)
From: Lukas Vrabec <lvrabec@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] Added missing descriptions for --*-key params in secon
 man page.
Date: Mon, 11 Jan 2016 10:30:41 +0100
Message-Id: <1452504641-26411-2-git-send-email-lvrabec@redhat.com>
In-Reply-To: <1452504641-26411-1-git-send-email-lvrabec@redhat.com>
References: <1452504641-26411-1-git-send-email-lvrabec@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixed secon help, merged descriptions for --current-* and --self-*
params.

Signed-off-by: Lukas Vrabec <lvrabec@redhat.com>
---
 policycoreutils/secon/secon.1 |  9 ++++++++
 policycoreutils/secon/secon.c | 53 +++++++++++++++++++++----------------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/secon.1
index 3a8e0dd..a0ff795 100644
--- a/policycoreutils/secon/secon.1
+++ b/policycoreutils/secon/secon.1
@@ -69,6 +69,9 @@ gets the exec context from the specified process PID
 \fB\-\-pid\-fs\fR
 gets the fscreate context from the specified process PID
 .TP
+\fB\-\-pid\-key\fR
+gets the key context from the specified process PID
+.TP
 \fB\-\-current\fR, \fB\-\-self\fR
 gets the context from the current process
 .TP
@@ -78,6 +81,9 @@ gets the exec context from the current process
 \fB\-\-current\-fs\fR, \fB\-\-self\-fs\fR
 gets the fscreate context from the current process
 .TP
+\fB\-\-current\-key\fR, \fB\-\-self\-key\fR
+gets the key context from the current process
+.TP
 \fB\-\-parent\fR
 gets the context from the parent of the current process
 .TP
@@ -86,6 +92,9 @@ gets the exec context from the parent of the current process
 .TP
 \fB\-\-parent\-fs\fR
 gets the fscreate context from the parent of the current process
+.TP
+\fB\-\-parent\-key\fR
+gets the key context from the parent of the current process
 .PP
 Additional argument
 .I CONTEXT
diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index ab4f7d0..134f4ee 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -77,33 +77,32 @@ static void usage(const char *name, int exit_code)
 {
 	fprintf(exit_code ? stderr : stdout,
 		"  Usage: %s [-%s] [ context | - ]\n"
-		"          --help        -h     Show this message.\n"
-		"          --version     -V     Show the version.\n"
-		"          --prompt      -P     Output in a format good for a prompt.\n"
-		"          --user        -u     Show the user of the context.\n"
-		"          --role        -r     Show the role of the context.\n"
-		"          --type        -t     Show the type of the context.\n"
-		"          --sensitivity -s     Show the sensitivity level of the context.\n"
-		"          --clearance   -c     Show the clearance level of the context.\n"
-		"          --mls-range   -m     Show the sensitivity to clearance range of \n"
-		"                               the context.\n"
-		"          --raw         -R     Show the context in \"raw\" format.\n"
-		"          --color       -C     Output using ANSI color codes (requires -P).\n"
-		"          --current            Get the context for the current process.\n"
-		"          --self               Get the context for the current process.\n"
-		"          --self-exec          Get the exec context for the current process.\n"
-		"          --self-fs            Get the fs context for the current process.\n"
-		"          --self-key           Get the key context for the current process.\n"
-		"          --parent             Get the context for the parent process.\n"
-		"          --parent-exec        Get the exec context for the parent process.\n"
-		"          --parent-fs          Get the fs context for the parent process.\n"
-		"          --parent-key         Get the key context for the parent process.\n"
-		"          --pid       -p <arg> Use the context from the specified pid.\n"
-		"          --pid-exec     <arg> Use the exec context from the specified pid.\n"
-		"          --pid-fs       <arg> Use the fs context from the specified pid.\n"
-		"          --pid-key      <arg> Use the key context from the specified pid.\n"
-		"          --file      -f <arg> Use the context from the specified file.\n"
-		"          --link      -L <arg> Use the context from the specified link.\n",
+		"          --help          -h            Show this message.\n"
+		"          --version       -V            Show the version.\n"
+		"          --prompt        -P            Output in a format good for a prompt.\n"
+		"          --user          -u            Show the user of the context.\n"
+		"          --role          -r            Show the role of the context.\n"
+		"          --type          -t            Show the type of the context.\n"
+		"          --sensitivity   -s            Show the sensitivity level of the context.\n"
+		"          --clearance     -c            Show the clearance level of the context.\n"
+		"          --mls-range     -m            Show the sensitivity to clearance range of \n"
+		"                                        the context.\n"
+		"          --raw           -R            Show the context in \"raw\" format.\n"
+		"          --color         -C            Output using ANSI color codes (requires -P).\n"
+		"          --current,      --self        Get the context for the current process.\n"
+		"          --current-exec, --self-exec   Get the exec context for the current process.\n"
+		"          --current-fs,   --self-fs     Get the fs context for the current process.\n"
+		"          --current-key,  --self-key    Get the key context for the current process.\n"
+		"          --parent                      Get the context for the parent process.\n"
+		"          --parent-exec                 Get the exec context for the parent process.\n"
+		"          --parent-fs                   Get the fs context for the parent process.\n"
+		"          --parent-key                  Get the key context for the parent process.\n"
+		"          --pid           -p <arg>      Use the context from the specified pid.\n"
+		"          --pid-exec      <arg>         Use the exec context from the specified pid.\n"
+		"          --pid-fs        <arg>         Use the fs context from the specified pid.\n"
+		"          --pid-key       <arg>         Use the key context from the specified pid.\n"
+		"          --file          -f <arg>      Use the context from the specified file.\n"
+		"          --link          -L <arg>      Use the context from the specified link.\n",
 		name, SECON_OPTS_SM);
 
 	exit(exit_code);
-- 
2.5.0
