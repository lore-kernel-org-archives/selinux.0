From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 14/15] [src-policy] semodule: user message support
Date: Tue, 26 Jan 2010 17:08:20 -0500
Message-Id: <1264543701-20638-15-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-14-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
 <1264543701-20638-6-git-send-email-ccase@tresys.com>
 <1264543701-20638-7-git-send-email-ccase@tresys.com>
 <1264543701-20638-8-git-send-email-ccase@tresys.com>
 <1264543701-20638-9-git-send-email-ccase@tresys.com>
 <1264543701-20638-10-git-send-email-ccase@tresys.com>
 <1264543701-20638-11-git-send-email-ccase@tresys.com>
 <1264543701-20638-12-git-send-email-ccase@tresys.com>
 <1264543701-20638-13-git-send-email-ccase@tresys.com>
 <1264543701-20638-14-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This adds the -m,--message option to semodule so that users can specify
a message for the ChangeLog.

  -m,--message=MSG user message for the ChangeLog

Example:

# semodule -E alsa -m "Allow alsa to execute cowsay."
---
 policycoreutils/semodule/semodule.8 |    3 +++
 policycoreutils/semodule/semodule.c |   24 +++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 8baad8b..97d31dd 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -87,6 +87,9 @@ prints help message and quit
 .TP
 .B  \-v,\-\-verbose     
 be verbose
+.TP
+.B  \-m,\-\-message=MSG
+user message for the ChangeLog
 
 .SH EXAMPLE
 .nf
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 3536253..c8bf986 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -58,6 +58,7 @@ static int create_store;
 static int build;
 static int disable_dontaudit;
 static uint16_t priority;
+static char *message = NULL;
 
 static semanage_handle_t *sh = NULL;
 static char *store;
@@ -72,6 +73,8 @@ static void cleanup(void)
 		free(commands[num_commands].output);
 	}
 	free(commands);
+
+	free(message);
 }
 
 /* Signal handlers. */
@@ -134,6 +137,7 @@ static void usage(char *progname)
 	printf("  -h,--help        print this message and quit\n");
 	printf("  -v,--verbose     be verbose\n");
 	printf("  -D,--disable_dontaudit	Remove dontaudits from policy\n");
+	printf("  -m,--message=MSG user message for the ChangeLog\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -186,6 +190,7 @@ static void parse_command_line(int argc, char **argv)
 		{"output", required_argument, NULL, 'o'},
 		{"cil", 0, NULL, 'c'},
 		{"edit", required_argument, NULL, 'E'},
+		{"message", required_argument, NULL, 'm'},
 		{NULL, 0, NULL, 0}
 	};
 	int i;
@@ -195,7 +200,7 @@ static void parse_command_line(int argc, char **argv)
 	create_store = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnBDp:e:d:g:o:cE:", opts,
+		getopt_long(argc, argv, "s:b:hi:l::vqr:u:RnBDp:e:d:g:o:cE:m:", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -294,6 +299,13 @@ static void parse_command_line(int argc, char **argv)
 		case 'E':
 			set_mode(EDIT_M, optarg);
 			break;
+		case 'm':
+			message = strdup(optarg);
+			if (message == NULL) {
+				fprintf(stderr, "Failed to set message (out of memory).");
+				exit(1);
+			}
+			break;
 		case '?':
 		default:{
 				usage(argv[0]);
@@ -414,6 +426,16 @@ int main(int argc, char *argv[])
 		goto cleanup;
 	}
 
+	if (message) {
+		result = semanage_set_log_message(sh, message);
+		if (result != 0) {
+			fprintf(stderr,
+				"%s: Failed to set ChangeLog message.",
+				argv[0]);
+			goto cleanup;
+		}
+	}
+
 	for (i = 0; i < num_commands; i++) {
 		enum client_modes mode = commands[i].mode;
 		char *mode_arg = commands[i].arg;
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
