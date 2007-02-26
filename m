Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QHbaM0012576
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 12:37:36 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1QHcePN012073
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 17:38:55 GMT
Received: by py-out-1112.google.com with SMTP id a78so778138pyh
        for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 09:38:55 -0800 (PST)
Message-ID: <45E31B96.3060406@kaigai.gr.jp>
Date: Tue, 27 Feb 2007 02:40:38 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@busybox.net,
        selinux@tycho.nsa.gov, busybox@kaigai.gr.jp
Subject: Re: [PATCH 8/8] busybox -- SELinux option support for coreutils:
 ver3
References: <20070223174929.18e547ea.ynakam@hitachisoft.jp> <200702241601.13536.vda.linux@googlemail.com>
In-Reply-To: <200702241601.13536.vda.linux@googlemail.com>
Content-Type: multipart/mixed;
 boundary="------------060703070304060604000502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060703070304060604000502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Denis

Thanks for your reviews.

Denis Vlasenko wrote:
> On Friday 23 February 2007 09:49, Yuichi Nakamura wrote:
>> [8/8] busybox-coreutils-08-runcon.v3.patch
>>  - runcon - run application with specified security context.
>>   runcon provides one of the core facilities to run application with explicitly
>>   specified security context. It enables users to run their application under
>>   the least privilege set explicitly.
>>
>> Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>
> 
> +       char *role = NULL;
> +       char *range = NULL;
> +       char *user = NULL;
> +       char *type = NULL;
> +       char *context = NULL;
> +       unsigned int opts;
> +
> +       selinux_or_die();
> +
> +       opts = getopt32(argc, argv, "r:t:u:l:ch", &role, &type, &user, &range);
> +
> +       if (!role && !type && !user && !range) {
> +               if (optind >= argc)
> +                       bb_error_msg_and_die("must specify -c, -t, -u, -l, -r, or context");
> +               context = argv[optind++];
> +       }
> 
> Testing if(!(opt & MASK_role_type_user_range)) will result in smaller code.

I'm sorry, it was overlooked.
The attached patch replace the above if-conditions by a single logical
operation as you suggested.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------060703070304060604000502
Content-Type: text/x-patch;
 name="busybox-coreutils-runcon-08.v4.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="busybox-coreutils-runcon-08.v4.patch"

Index: selinux/runcon.c
===================================================================
--- selinux/runcon.c	(リビジョン 0)
+++ selinux/runcon.c	(リビジョン 0)
@@ -0,0 +1,142 @@
+/*
+ * runcon [ context |
+ *         ( [ -c ] [ -r role ] [-t type] [ -u user ] [ -l levelrange ] )
+ *         command [arg1 [arg2 ...] ]
+ *
+ * attempt to run the specified command with the specified context.
+ *
+ * -r role  : use the current context with the specified role
+ * -t type  : use the current context with the specified type
+ * -u user  : use the current context with the specified user
+ * -l level : use the current context with the specified level range
+ * -c       : compute process transition context before modifying
+ *
+ * Contexts are interpreted as follows:
+ *
+ * Number of       MLS
+ * components    system?
+ *
+ *     1            -         type
+ *     2            -         role:type
+ *     3            Y         role:type:range
+ *     3            N         user:role:type
+ *     4            Y         user:role:type:range
+ *     4            N         error
+ *
+ * Port to busybox: KaiGai Kohei <kaigai@kaigai.gr.jp>
+ *                  - based on coreutils-5.97 (in Fedora Core 6)
+ */
+#include "busybox.h"
+#include <getopt.h>
+#include <selinux/context.h>
+#include <selinux/flask.h>
+
+static context_t runcon_compute_new_context(char *user, char *role, char *type, char *range,
+					    char *command, int compute_trans)
+{
+	context_t con;
+	security_context_t cur_context;
+
+	if (getcon(&cur_context))
+		bb_error_msg_and_die("could not get current context.");
+
+	if (compute_trans) {
+		security_context_t file_context, new_context;
+
+		if (getfilecon(command, &file_context) < 0)
+			bb_error_msg_and_die("unable to retrieve attributes of '%s'.",
+					     command);
+		if (security_compute_create(cur_context, file_context,
+					    SECCLASS_PROCESS, &new_context))
+			bb_error_msg_and_die("unable to compute a new context.");
+		cur_context = new_context;
+	}
+
+	con = context_new(cur_context);
+	if (!con)
+		bb_error_msg_and_die("'%s' is not a valid context.", cur_context);
+	if (user && context_user_set(con, user))
+		bb_error_msg_and_die("failed to set new user '%s'", user);
+	if (type && context_type_set(con, type))
+		bb_error_msg_and_die("failed to set new type '%s'", type);
+	if (range && context_range_set(con, range))
+		bb_error_msg_and_die("failed to set new range '%s'", range);
+	if (role && context_role_set(con, role))
+		bb_error_msg_and_die("failed to set new role '%s'", role);
+
+	return con;
+}
+
+#ifdef CONFIG_FEATURE_RUNCON_LONG_OPTIONS
+static const struct option runcon_options[] = {
+	{"user",	1, NULL, 'u' },
+	{"role",	1, NULL, 'r' },
+	{"type",	1, NULL, 't' },
+	{"range",	1, NULL, 'l' },
+	{"compute",	0, NULL, 'c' },
+	{"help",	0, NULL, 'h' },
+	{NULL,		0, NULL, 0 },
+};
+#endif
+
+#define OPTS_ROLE	(1<<0)	/* r */
+#define OPTS_TYPE	(1<<1)	/* t */
+#define OPTS_USER	(1<<2)	/* u */
+#define OPTS_RANGE	(1<<3)	/* l */
+#define OPTS_COMPUTE	(1<<4)	/* c */
+#define OPTS_HELP	(1<<5)	/* h */
+#define OPTS_CONTEXT_COMPONENT		(OPTS_ROLE | OPTS_TYPE | OPTS_USER | OPTS_RANGE)
+
+int runcon_main(int argc, char *argv[]);
+int runcon_main(int argc, char *argv[])
+{
+	char *role = NULL;
+	char *range = NULL;
+	char *user = NULL;
+	char *type = NULL;
+	char *context = NULL;
+	char *command;
+	char **command_args;
+	unsigned int opts;
+	context_t con;
+
+	selinux_or_die();
+
+#ifdef CONFIG_FEATURE_RUNCON_LONG_OPTIONS
+	applet_long_options = runcon_options;
+#endif
+	opts = getopt32(argc, argv, "r:t:u:l:ch", &role, &type, &user, &range);
+
+	if (!(opts & OPTS_CONTEXT_COMPONENT)) {
+		if (optind >= argc)
+			bb_error_msg_and_die("must specify -c, -t, -u, -l, -r, or context");
+		context = argv[optind++];
+	}
+
+	if (optind >= argc)
+		bb_error_msg_and_die("no command found");
+	command = argv[optind];
+	command_args = argv + optind;
+
+	if (context) {
+		con = context_new(context);
+		if (!con)
+			bb_error_msg_and_die("'%s' is not a valid context", context);
+	} else {
+		con = runcon_compute_new_context(user, role, type, range,
+						 command, opts & OPTS_COMPUTE);
+	}
+
+	if (security_check_context(context_str(con)))
+		bb_error_msg_and_die("'%s' is not a valid context",
+				     context_str(con));
+
+	if (setexeccon(context_str(con)))
+		bb_error_msg_and_die("unable to set up security context '%s'",
+				     context_str(con));
+
+	execvp(command, command_args);
+
+	bb_perror_msg_and_die("unable to execute '%s'", command);
+	return 1;
+}

--------------060703070304060604000502--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
