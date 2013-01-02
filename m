Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r02KPUPw029396
	for <selinux@tycho.nsa.gov>; Wed, 2 Jan 2013 15:25:30 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r02KOv1x032618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 2 Jan 2013 15:24:57 -0500
Subject: [PATCH] secon: add support for setrans color information in prompt
 output
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: dwalsh@redhat.com
Date: Wed, 02 Jan 2013 15:24:55 -0500
Message-ID: <20130102202455.26783.9263.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for displaying SELinux context information in
colors defined by mcstrans(8)/secolor.conf(5).  The new behavior is
enabled through the use of the "-C/--color" option and requires the
"-P" option also be specified.

The reason for this addition is that in some situations, notably MLS,
users find it helpful to add SELinux context information to their prompt:

	# example taken from the RHEL6 CC certification bash scripts
	SEROLE=`secon -rP 2>/dev/null`
	SEMLS=`secon -lP 2>/dev/null`
	PS1="[\u/$SEROLE/$SEMLS@\h \W]\\$ "
	export PS1

With the added functionality provided by this patch we can also display
the associated color information (note the addition of the "C" option):

	SEROLE=`secon -rP 2>/dev/null`
	SEMLS=`secon -lPC 2>/dev/null`
	PS1="[\u/$SEROLE/$SEMLS@\h \W]\\$ "
	export PS1

Note that in the example above only the MLS range is colored, but the
patch does provide support for all of the color information provided
by mcstransd/secolor.conf (user,role,type,range).

Finally, one quick word on the colors themselves; the secolor.conf
configuration file allows 32-bit colors but the ANSI color coding only
allows 8-bit colors so the colors displayed by secon using the "-C"
option will be a bit lossy.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 policycoreutils/secon/secon.1 |    3 +
 policycoreutils/secon/secon.c |  207 ++++++++++++++++++++++++++++++++---------
 2 files changed, 167 insertions(+), 43 deletions(-)

diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/secon.1
index fcffbd8..6c30734 100644
--- a/policycoreutils/secon/secon.1
+++ b/policycoreutils/secon/secon.1
@@ -30,6 +30,9 @@ shows the usage information for secon
 \fB\-P\fR, \fB\-\-prompt\fR
 outputs data in a format suitable for a prompt
 .TP
+\fB\-C\fR, \fB\-\-color\fR
+outputs data with the associated ANSI color codes (requires -P)
+.TP
 \fB\-u\fR, \fB\-\-user\fR
 show the user of the security context
 .TP
diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index 6ba47e9..ab4f7d0 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -19,8 +19,8 @@
 #define FALSE 0
 
 #define SECON_CONF_PROG_NAME "secon"	/* default program name */
-#define SECON_OPTS_SM "hVurtscmPRfLp"	/* small options available, print */
-#define SECON_OPTS_GO "hVurtlscmPRf:L:p:"	/* small options available, getopt */
+#define SECON_OPTS_SM "hVurtscmPRCfLp"	/* small options available, print */
+#define SECON_OPTS_GO "hVurtlscmPRCf:L:p:"	/* small options available, getopt */
 
 #define OPTS_FROM_ARG      0
 #define OPTS_FROM_FILE     1
@@ -35,6 +35,19 @@
 #define OPTS_FROM_PROCFS   10
 #define OPTS_FROM_PROCKEY  11
 
+struct context_color_t {
+	unsigned int valid;
+
+	char *user_fg;
+	char *user_bg;
+	char *role_fg;
+	char *role_bg;
+	char *type_fg;
+	char *type_bg;
+	char *range_fg;
+	char *range_bg;
+};
+
 struct {
 	unsigned int disp_user:1;
 	unsigned int disp_role:1;
@@ -44,6 +57,7 @@ struct {
 	unsigned int disp_mlsr:1;
 
 	unsigned int disp_raw:1;
+	unsigned int disp_color:1;
 
 	unsigned int disp_prompt:1;	/* no return, use : to sep */
 
@@ -57,8 +71,7 @@ struct {
 	} f;
 } opts[1] = { {
 		FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
-		    FALSE, FALSE, OPTS_FROM_ARG, {
-0}}};
+		    FALSE, FALSE, FALSE, OPTS_FROM_ARG, {0} } };
 
 static void usage(const char *name, int exit_code)
 {
@@ -75,6 +88,7 @@ static void usage(const char *name, int exit_code)
 		"          --mls-range   -m     Show the sensitivity to clearance range of \n"
 		"                               the context.\n"
 		"          --raw         -R     Show the context in \"raw\" format.\n"
+		"          --color       -C     Output using ANSI color codes (requires -P).\n"
 		"          --current            Get the context for the current process.\n"
 		"          --self               Get the context for the current process.\n"
 		"          --self-exec          Get the exec context for the current process.\n"
@@ -156,6 +170,7 @@ static void cmd_line(int argc, char *argv[])
 		{"mls-range", no_argument, NULL, 'm'},
 
 		{"raw", no_argument, NULL, 'R'},
+		{"color", no_argument, NULL, 'C'},
 
 		{"current", no_argument, NULL, 1},
 		{"self", no_argument, NULL, 1},
@@ -232,6 +247,9 @@ static void cmd_line(int argc, char *argv[])
 		case 'R':
 			opts->disp_raw = !opts->disp_raw;
 			break;
+		case 'C':
+			opts->disp_color = !opts->disp_color;
+			break;
 		case 1:
 			opts->from_type = OPTS_FROM_CUR;
 			break;
@@ -370,16 +388,18 @@ static int my_getpidkeycreatecon_raw(pid_t pid, security_context_t * con)
 static security_context_t get_scon(void)
 {
 	static char dummy_NIL[1] = "";
-	security_context_t con = NULL;
+	security_context_t con = NULL, con_tmp;
 	int ret = -1;
-	int raw = TRUE;
 
 	switch (opts->from_type) {
 	case OPTS_FROM_ARG:
-		if (!(con = strdup(opts->f.arg)))
+		if (!(con_tmp = strdup(opts->f.arg)))
 			err(EXIT_FAILURE,
 			    " Couldn't allocate security context");
-		raw = !opts->disp_raw;	/* always do conversion */
+		if (selinux_trans_to_raw_context(con_tmp, &con) < 0)
+			err(EXIT_FAILURE,
+			    " Couldn't translate security context");
+		freecon(con_tmp);
 		break;
 
 	case OPTS_FROM_STDIN:
@@ -396,11 +416,13 @@ static security_context_t get_scon(void)
 				ptr[strcspn(ptr, " \n\t")] = 0;
 			}
 
-			if (!(con = strdup(ptr)))
+			if (!(con_tmp = strdup(ptr)))
 				err(EXIT_FAILURE,
 				    " Couldn't allocate security context");
-
-			raw = !opts->disp_raw;	/* always do conversion */
+			if (selinux_trans_to_raw_context(con_tmp, &con) < 0)
+				err(EXIT_FAILURE,
+				    " Couldn't translate security context");
+			freecon(con_tmp);
 			break;
 		}
 
@@ -511,26 +533,69 @@ static security_context_t get_scon(void)
 		assert(FALSE);
 	}
 
-	if (opts->disp_raw != raw) {
-		security_context_t ncon = NULL;
+	return (con);
+}
 
-		if (opts->disp_raw)
-			selinux_trans_to_raw_context(con, &ncon);
-		else
-			selinux_raw_to_trans_context(con, &ncon);
+static unsigned int disp__color_to_ansi(const char *color_str)
+{
+	int val = 30;
 
-		freecon(con);
-		con = ncon;
-	}
+	/* NOTE: ansi black is 30 for foreground colors */
 
-	return (con);
+	/* red */
+	if (strncasecmp(&color_str[1], "7f", 2) >= 0)
+		val += 1;
+	/* green */
+	if (strncasecmp(&color_str[3], "7f", 2) >= 0)
+		val += 2;
+	/* blue */
+	if (strncasecmp(&color_str[5], "7f", 2) >= 0)
+		val += 4;
+
+	return val;
 }
 
-static void disp__con_val(const char *name, const char *val)
+static char *disp__con_color_ansi(const char *name,
+				  struct context_color_t *color)
+{
+	unsigned int fg, bg;
+	char *ansi;
+	int ansi_len = strlen("\e[99;99m") + 1;
+
+	/* NOTE: ansi background codes are the same as foreground codes +10 */
+
+	if (xstreq("user", name)) {
+		fg = disp__color_to_ansi(color->user_fg);
+		bg = disp__color_to_ansi(color->user_bg) + 10;
+	} else if (xstreq("role", name)) {
+		fg = disp__color_to_ansi(color->role_fg);
+		bg = disp__color_to_ansi(color->role_bg) + 10;
+	} else if (xstreq("type", name)) {
+		fg = disp__color_to_ansi(color->type_fg);
+		bg = disp__color_to_ansi(color->type_bg) + 10;
+	} else if (xstreq("sensitivity", name) ||
+		   xstreq("clearance", name) ||
+		   xstreq("mls-range", name)) {
+		fg = disp__color_to_ansi(color->range_fg);
+		bg = disp__color_to_ansi(color->range_bg) + 10;
+	} else
+		err(EXIT_FAILURE, " No color information for context field");
+
+	if (!(ansi = malloc(ansi_len)))
+		err(EXIT_FAILURE, " Unable to allocate memory");
+	if (snprintf(ansi, ansi_len, "\e[%d;%dm", fg, bg) > ansi_len)
+		err(EXIT_FAILURE, " Unable to convert colors to ANSI codes");
+
+	return ansi;
+}
+
+static void disp__con_val(const char *name, const char *val,
+			  struct context_color_t *color)
 {
 	static int done = FALSE;
 
 	assert(name);
+	assert(color);
 
 	if (!val)
 		val = "";	/* targeted has no "level" etc.,
@@ -540,7 +605,14 @@ static void disp__con_val(const char *name, const char *val)
 		if (xstreq("mls-range", name) && !*val)
 			return;	/* skip, mls-range if it's empty */
 
+		if (opts->disp_color && color->valid) {
+			char *ansi = disp__con_color_ansi(name, color);
+			fprintf(stdout, "%s", ansi);
+			free(ansi);
+		}
 		fprintf(stdout, "%s%s", done ? ":" : "", val);
+		if (opts->disp_color && color->valid)
+			fprintf(stdout, "\e[0m");
 	} else if (disp_multi())
 		fprintf(stdout, "%s: %s\n", name, val);
 	else
@@ -549,35 +621,81 @@ static void disp__con_val(const char *name, const char *val)
 	done = TRUE;
 }
 
-static void disp_con(security_context_t scon)
+static void disp_con(security_context_t scon_raw)
 {
+	security_context_t scon_trans, scon;
 	context_t con = NULL;
+	char *color_str = NULL;
+	struct context_color_t color = { .valid = 0 };
+
+	selinux_raw_to_trans_context(scon_raw, &scon_trans);
+	if (opts->disp_raw)
+		scon = scon_raw;
+	else
+		scon = scon_trans;
 
 	if (!*scon) {		/* --self-exec and --self-fs etc. */
 		if (opts->disp_user)
-			disp__con_val("user", NULL);
+			disp__con_val("user", NULL, &color);
 		if (opts->disp_role)
-			disp__con_val("role", NULL);
+			disp__con_val("role", NULL, &color);
 		if (opts->disp_type)
-			disp__con_val("type", NULL);
+			disp__con_val("type", NULL, &color);
 		if (opts->disp_sen)
-			disp__con_val("sensitivity", NULL);
+			disp__con_val("sensitivity", NULL, &color);
 		if (opts->disp_clr)
-			disp__con_val("clearance", NULL);
+			disp__con_val("clearance", NULL, &color);
 		if (opts->disp_mlsr)
-			disp__con_val("mls-range", NULL);
+			disp__con_val("mls-range", NULL, &color);
 		return;
 	}
 
+	if (opts->disp_color) {
+		if (selinux_raw_context_to_color(scon_raw, &color_str) < 0)
+			errx(EXIT_FAILURE, "Couldn't determine colors for: %s",
+			     scon);
+
+		color.user_fg = strtok(color_str, " ");
+		if (!color.user_fg)
+			errx(EXIT_FAILURE, "Invalid color string");
+		color.user_bg = strtok(NULL, " ");
+		if (!color.user_bg)
+			errx(EXIT_FAILURE, "Invalid color string");
+
+		color.role_fg = strtok(NULL, " ");
+		if (!color.role_fg)
+			errx(EXIT_FAILURE, "Invalid color string");
+		color.role_bg = strtok(NULL, " ");
+		if (!color.role_bg)
+			errx(EXIT_FAILURE, "Invalid color string");
+
+		color.type_fg = strtok(NULL, " ");
+		if (!color.type_fg)
+			errx(EXIT_FAILURE, "Invalid color string");
+		color.type_bg = strtok(NULL, " ");
+		if (!color.type_bg)
+			errx(EXIT_FAILURE, "Invalid color string");
+
+		color.range_fg = strtok(NULL, " ");
+		if (!color.range_fg)
+			errx(EXIT_FAILURE, "Invalid color string");
+		color.range_bg = strtok(NULL, " ");
+
+		color.valid = 1;
+	};
+
 	if (!(con = context_new(scon)))
 		errx(EXIT_FAILURE, "Couldn't create context from: %s", scon);
 
-	if (opts->disp_user)
-		disp__con_val("user", context_user_get(con));
-	if (opts->disp_role)
-		disp__con_val("role", context_role_get(con));
-	if (opts->disp_type)
-		disp__con_val("type", context_type_get(con));
+	if (opts->disp_user) {
+		disp__con_val("user", context_user_get(con), &color);
+	}
+	if (opts->disp_role) {
+		disp__con_val("role", context_role_get(con), &color);
+	}
+	if (opts->disp_type) {
+		disp__con_val("type", context_type_get(con), &color);
+	}
 	if (opts->disp_sen) {
 		const char *val = NULL;
 		char *tmp = NULL;
@@ -594,7 +712,7 @@ static void disp_con(security_context_t scon)
 		if (strchr(tmp, '-'))
 			*strchr(tmp, '-') = 0;
 
-		disp__con_val("sensitivity", tmp);
+		disp__con_val("sensitivity", tmp, &color);
 
 		free(tmp);
 	}
@@ -612,30 +730,33 @@ static void disp_con(security_context_t scon)
 			errx(EXIT_FAILURE, "Couldn't create context from: %s",
 			     scon);
 		if (strchr(tmp, '-'))
-			disp__con_val("clearance", strchr(tmp, '-') + 1);
+			disp__con_val("clearance", strchr(tmp, '-') + 1, &color);
 		else
-			disp__con_val("clearance", tmp);
+			disp__con_val("clearance", tmp, &color);
 
 		free(tmp);
 	}
 
 	if (opts->disp_mlsr)
-		disp__con_val("mls-range", context_range_get(con));
+		disp__con_val("mls-range", context_range_get(con), &color);
 
 	context_free(con);
+	freecon(scon_trans);
+	if (color_str)
+		free(color_str);
 }
 
 int main(int argc, char *argv[])
 {
-	security_context_t scon = NULL;
+	security_context_t scon_raw = NULL;
 
 	cmd_line(argc, argv);
 
-	scon = get_scon();
+	scon_raw = get_scon();
 
-	disp_con(scon);
+	disp_con(scon_raw);
 
-	freecon(scon);
+	freecon(scon_raw);
 
 	exit(EXIT_SUCCESS);
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
