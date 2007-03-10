Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2A5hHNi022045
	for <selinux@tycho.nsa.gov>; Sat, 10 Mar 2007 00:43:17 -0500
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2A5hE6Z013454
	for <selinux@tycho.nsa.gov>; Sat, 10 Mar 2007 05:43:15 GMT
Received: by ug-out-1314.google.com with SMTP id y2so1865757uge
        for <selinux@tycho.nsa.gov>; Fri, 09 Mar 2007 21:43:14 -0800 (PST)
Message-ID: <45F24565.40103@kaigai.gr.jp>
Date: Sat, 10 Mar 2007 14:43:01 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: busybox@kaigai.gr.jp
CC: Denis Vlasenko <vda.linux@googlemail.com>, busybox@busybox.net,
        selinux@tycho.nsa.gov
Subject: Ver.6 (Re: [PATCH 7/8] busybox -- SELinux option support for coreutils:
 ver3)
References: <20070223174823.8109ef4c.ynakam@hitachisoft.jp> <200702241601.12758.vda.linux@googlemail.com> <45E31B86.8080200@kaigai.gr.jp> <20070308132308.GE32231@aon.at>
In-Reply-To: <20070308132308.GE32231@aon.at>
Content-Type: multipart/mixed;
 boundary="------------000003070304000707020102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000003070304000707020102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello, Thanks for your reviewing.

>> * '\n' was replaced by '0xff'
>> * Checks for exclusive options were added. chcon applet will will abort
>>  if --reference and '-u','-r','-t','-l' are appeared concurrently,
> 
> Please move the change_dir_context() function around to remove the
> forward decl.

I replaced change_dir_context() function by recursive_action(), not only
its declaration.

> +static context_t compute_context_from_mask(security_context_t context,
> +       context_free (new_context);
> 
> surplus space
> Smaller if you goto ret where
> ret:
> 	return NULL;
> }

As you say, we can share the above function between runcon and chcon,
so I removed the compute_context_from_mask() and added a new function
in libbb/selinux_common.c.
See, busybox-coreutils-libbb-09.v6.patch

> +       context_string = context_str(context);
> +       if (file_context == NULL || strcmp(context_string, file_context) != 0) {
> 
> Can context_str() return NULL?

Yes, it can return NULL, if malloc() used internally didn't succeed.
So, I added the following check:

+        context_string = context_str(context);
+        if (!context_string) {
+                bb_error_msg("couldn't obtain security context in text expression");
+                goto skip;
+        }

> +               int fail = 0;
> 
> superfluous set. Remove initialization to 0

Fixed,

> +
> +               if (opts & OPT_NODEREFERENCE) {
> +                       fail = lsetfilecon (fname, context_string);
> +               } else {
> +                       fail = setfilecon (fname, context_string);
> +               }
> +               if ((opts & OPT_VERBOSE)
> +                   || ((opts & OPT_CHANHES) && !fail)) {
> +                       printf(!fail
> 
> bb_perror_msg() instead of printf?

bb_perror_msg() prints a message into stderr, although upstreamed chcon
prints a message into stdout. It will make an incompatibility.
So, I didn't use bb_error_msg() here.

> +                              ? "context of %s changed to %s\n"
> +                              : "failed to change context of %s to
> %s\n",
> +                              fname, context_string);
> +               }
> 
> change_dir_context() sounds a bit overdone. Don't we have an opendir
> wrapper with diagnostics? Perhaps this is a candidate for
> recursive_action() 

It was replaced by recursive_action().

> Manually inlining compute_context_from_mask() smaller?

It was moved into libbb/selinux_common.o to share with 'runcon'.

> Smaller to resuse the global option_mask32 rather than using opts in
> chcon_main() ?

I replaced any local 'opts' by option_mask32.

> +               ":?:f--v:v--f"      /* 'verbose' and 'quiet' are exclusive */
> Sounds like there is the word mutual missing.

'-f' is a option for the silent purpose.
It is a definition of upstreamed chcon.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------000003070304000707020102
Content-Type: text/x-diff;
 name="busybox-coreutils-libbb-09.v6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-coreutils-libbb-09.v6.patch"

Index: include/libbb.h
===================================================================
--- include/libbb.h	(revision 18056)
+++ include/libbb.h	(working copy)
@@ -41,6 +41,7 @@
 
 #if ENABLE_SELINUX
 #include <selinux/selinux.h>
+#include <selinux/context.h>
 #endif
 
 #if ENABLE_LOCALE_SUPPORT
@@ -598,6 +599,8 @@
 #if ENABLE_SELINUX
 extern void renew_current_security_context(void);
 extern void set_current_security_context(security_context_t sid);
+extern context_t set_security_context_component(security_context_t cur_context,
+						char *user, char *role, char *type, char *range);
 #endif
 extern void selinux_or_die(void);
 extern int restricted_shell(const char *shell);
Index: libbb/Kbuild
===================================================================
--- libbb/Kbuild	(revision 18056)
+++ libbb/Kbuild	(working copy)
@@ -106,6 +106,7 @@
 lib-$(CONFIG_LOGIN) += correct_password.o
 lib-$(CONFIG_DF) += find_mount_point.o
 lib-$(CONFIG_MKFS_MINIX) += find_mount_point.o
+lib-$(CONFIG_SELINUX) += selinux_common.o
 
 # We shouldn't build xregcomp.c if we don't need it - this ensures we don't
 # require regex.h to be in the include dir even if we don't need it thereby
Index: libbb/selinux_common.c
===================================================================
--- libbb/selinux_common.c	(revision 0)
+++ libbb/selinux_common.c	(revision 0)
@@ -0,0 +1,30 @@
+/*
+ * libbb/selinux_common.c
+ *   -- common SELinux utility functions
+ * 
+ * Copyright 2007 KaiGai Kohei <kaigai@kaigai.gr.jp>
+ */
+#include "busybox.h"
+#include <selinux/context.h>
+
+context_t set_security_context_component(security_context_t cur_context,
+					 char *user, char *role, char *type, char *range)
+{
+	context_t con = context_new(cur_context);
+	if (!con)
+		return NULL;
+
+	if (user && context_user_set(con, user))
+		goto error;
+	if (type && context_type_set(con, type))
+		goto error;
+	if (range && context_range_set(con, range))
+		goto error;
+	if (role && context_role_set(con, role))
+		goto error;
+	return con;
+
+error:
+	context_free(con);
+	return NULL;
+}

--------------000003070304000707020102
Content-Type: text/x-diff;
 name="busybox-coreutils-runcon-08.v6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-coreutils-runcon-08.v6.patch"

Index: selinux/runcon.c
===================================================================
--- selinux/runcon.c	(revision 0)
+++ selinux/runcon.c	(revision 0)
@@ -0,0 +1,131 @@
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
+static context_t
+runcon_compute_new_context(char *user, char *role, char *type, char *range, char *command)
+{
+	context_t con;
+	security_context_t cur_context;
+
+	if (getcon(&cur_context))
+		bb_error_msg_and_die("could not get current context.");
+
+	if (option_mask32 & OPTS_COMPUTE) {
+		security_context_t file_context, new_context;
+
+		if (getfilecon(command, &file_context) < 0)
+			bb_error_msg_and_die("unable to retrieve attributes of '%s'.", command);
+		if (security_compute_create(cur_context, file_context,
+					    SECCLASS_PROCESS, &new_context))
+			bb_error_msg_and_die("unable to compute a new context.");
+		cur_context = new_context;
+	}
+
+	con = set_security_context_component(cur_context, user, role, type, range);
+	if (!con)
+		bb_error_msg_and_die("failed to set new context");
+
+	return con;
+}
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
+	context_t con;
+
+	selinux_or_die();
+
+#ifdef CONFIG_FEATURE_RUNCON_LONG_OPTIONS
+	applet_long_options = runcon_options;
+#endif
+	opt_complementary="-1"; /* need at least one non-option parm */
+	getopt32(argc, argv, "r:t:u:l:ch", &role, &type, &user, &range);
+
+	if (!(option_mask32 & OPTS_CONTEXT_COMPONENT))
+		context = argv[optind++];
+
+	if (optind >= argc)
+		bb_error_msg_and_die((option_mask32 & OPTS_CONTEXT_COMPONENT)
+				     ? "no command found"
+				     : "must specify -c, -t, -u, -l, -r, or context");
+	command = argv[optind];
+	command_args = argv + optind;
+
+	if (context) {
+		con = context_new(context);
+		if (!con)
+			bb_error_msg_and_die("'%s' is not a valid context", context);
+	} else {
+		con = runcon_compute_new_context(user, role, type, range, command);
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

--------------000003070304000707020102
Content-Type: text/x-diff;
 name="busybox-coreutils-chcon-07.v6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="busybox-coreutils-chcon-07.v6.patch"

Index: selinux/chcon.c
===================================================================
--- selinux/chcon.c	(revision 0)
+++ selinux/chcon.c	(revision 0)
@@ -0,0 +1,171 @@
+/*
+ * chcon -- change security context, based on coreutils-5.97-13
+ *
+ * Port to busybox: KaiGai Kohei <kaigai@kaigai.gr.jp>
+ * 
+ * Copyright (C) 2006 - 2007 KaiGai Kohei <kaigai@kaigai.gr.jp>
+ */
+#include "busybox.h"
+#include <getopt.h>
+#include <selinux/context.h>
+
+#define OPT_RECURSIVE		(1<<0)	/* 'R' */
+#define OPT_CHANHES		(1<<1)	/* 'c' */
+#define OPT_NODEREFERENCE	(1<<2)	/* 'h' */
+#define OPT_QUIET		(1<<3)	/* 'f' */
+#define OPT_REFERENCE		(1<<4)	/* 0xff */
+#define OPT_USER		(1<<5)	/* 'u' */
+#define OPT_ROLE		(1<<6)	/* 'r' */
+#define OPT_TYPE		(1<<7)	/* 't' */
+#define OPT_RANGE		(1<<8)	/* 'l' */
+#define OPT_VERBOSE		(1<<9)	/* 'v' */
+#define OPT_COMPONENT_SPECIFIED	(OPT_USER | OPT_ROLE | OPT_TYPE | OPT_RANGE)
+
+static char *user = NULL;
+static char *role = NULL;
+static char *type = NULL;
+static char *range = NULL;
+static char *specified_context = NULL;
+
+static int change_filedir_context(const char *fname, struct stat *stbuf, void *userData, int depth)
+{
+	context_t context = NULL;
+	security_context_t file_context = NULL;
+	security_context_t context_string;
+	int rc = FALSE;
+	int status = 0;
+
+	if (option_mask32 & OPT_NODEREFERENCE) {
+		status = lgetfilecon(fname, &file_context);
+	} else {
+		status = getfilecon(fname, &file_context);
+	}
+	if (status < 0 && errno != ENODATA) {
+		if ((option_mask32 & OPT_QUIET) == 0)
+			bb_error_msg("could not obtain security context: %s", fname);
+		goto skip;
+	}
+
+	if (file_context == NULL && specified_context == NULL) {
+		bb_error_msg("could not apply partial context to unlabeled file %s", fname);
+		goto skip;
+	}
+
+	if (specified_context == NULL) {
+		context = set_security_context_component(file_context,
+							 user, role, type, range);
+		if (!context) {
+			bb_error_msg("couldn't compute security context from %s", file_context);
+			goto skip;
+		}
+	} else {
+		context = context_new(specified_context);
+		if (!context) {
+			bb_error_msg("invalid context: %s", specified_context);
+			goto skip;
+		}
+	}
+
+	context_string = context_str(context);
+	if (!context_string) {
+		bb_error_msg("couldn't obtain security context in text expression");
+		goto skip;
+	}
+
+	if (file_context == NULL || strcmp(context_string, file_context) != 0) {
+		int fail;
+
+		if (option_mask32 & OPT_NODEREFERENCE) {
+			fail = lsetfilecon(fname, context_string);
+		} else {
+			fail = setfilecon(fname, context_string);
+		}
+		if ((option_mask32 & OPT_VERBOSE) || ((option_mask32 & OPT_CHANHES) && !fail)) {
+			printf(!fail
+			       ? "context of %s changed to %s\n"
+			       : "failed to change context of %s to %s\n",
+			       fname, context_string);
+		}
+		if (!fail) {
+			rc = TRUE;
+		} else if ((option_mask32 & OPT_QUIET) == 0) {
+			bb_error_msg("failed to change context of %s to %s",
+				     fname, context_string);
+		}
+	} else if (option_mask32 & OPT_VERBOSE) {
+		printf("context of %s retained as %s\n", fname, context_string);
+		rc = TRUE;
+	}
+skip:
+	if (context)
+		context_free(context);
+	if (file_context)
+		freecon(file_context);
+
+	return rc;
+}
+
+#ifdef CONFIG_FEATURE_CHCON_LONG_OPTIONS
+static struct option chcon_options[] = {
+	{"recursive",	0,	NULL,	'R'},
+	{"changes",	0,	NULL,	'c'},
+	{"no-dereference",	0,	NULL,	'h'},
+	{"silent",	0,	NULL,	'f'},
+	{"quiet",	0,	NULL,	'f'},
+	{"reference",	1,	NULL,	0xff },	/* no short option */
+	{"user",	1,	NULL,	'u' },
+	{"role",	1,	NULL,	'r' },
+	{"type",	1,	NULL,	't' },
+	{"range",	1,	NULL,	'l' },
+	{"verbose",	0,	NULL,	'v' },
+	{NULL,		0,	NULL,	0 },
+};
+#endif
+
+int chcon_main(int argc, char *argv[]);
+int chcon_main(int argc, char *argv[])
+{
+	char *reference_file;
+	char **target_files;
+	int i, errors = 0;
+
+#ifdef CONFIG_FEATURE_CHCON_LONG_OPTIONS
+	applet_long_options = chcon_options;
+#endif
+	opt_complementary = "-1"    /* at least 1 param */
+		":?:f--v:v--f"      /* 'verbose' and 'quiet' are exclusive */
+		":\xff--urtl:u--\xff:r--\xff:t--\xff:l--\xff";
+	getopt32(argc, argv, "Rchf\xff:u:r:t:l:v",
+		 &reference_file, &user, &role, &type, &range);
+	if (option_mask32 & OPT_REFERENCE) {
+		/* FIXME: lgetfilecon() should be used when '-h' is specified.
+		   But current implementation follows the original one. */
+		if (getfilecon(reference_file, &specified_context) < 0)
+			bb_perror_msg_and_die("getfilecon('%s') failed", reference_file);
+	} else if ((option_mask32 & OPT_COMPONENT_SPECIFIED) == 0) {
+		specified_context = argv[optind++];
+		if (!specified_context)
+			bb_error_msg_and_die("too few arguments");
+	}
+	target_files = argv + optind;
+	if (!target_files[0])
+		bb_error_msg_and_die("too few arguments");
+
+	for (i=0; target_files[i]; i++) {
+		char *fname = target_files[i];
+		int fname_len = strlen(fname);
+		while (fname_len > 1 && fname[fname_len - 1] == '/')
+			fname_len--;
+		fname[fname_len] = '\0';
+
+		if (recursive_action(fname,
+				     (option_mask32 & OPT_RECURSIVE ? TRUE : FALSE),
+				     FALSE,	/* followLinks */
+				     FALSE,	/* depthFirst */
+				     change_filedir_context,
+				     change_filedir_context,
+				     NULL, 0) != TRUE)
+			errors = 1;
+	}
+	return errors;
+}

--------------000003070304000707020102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
