Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QHbJX9012556
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 12:37:19 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1QHcePM012073
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 17:38:40 GMT
Received: by py-out-1112.google.com with SMTP id a78so778138pyh
        for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 09:38:40 -0800 (PST)
Message-ID: <45E31B86.8080200@kaigai.gr.jp>
Date: Tue, 27 Feb 2007 02:40:22 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: Yuichi Nakamura <ynakam@hitachisoft.jp>, busybox@busybox.net,
        selinux@tycho.nsa.gov, busybox@kaigai.gr.jp
Subject: Re: [PATCH 7/8] busybox -- SELinux option support for coreutils:
 ver3
References: <20070223174823.8109ef4c.ynakam@hitachisoft.jp> <200702241601.12758.vda.linux@googlemail.com>
In-Reply-To: <200702241601.12758.vda.linux@googlemail.com>
Content-Type: multipart/mixed;
 boundary="------------060407060300080406080807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060407060300080406080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Denis.

Thanks for your reviews.

Denis Vlasenko wrote:
> On Friday 23 February 2007 09:48, Yuichi Nakamura wrote:
>> [7/8] busybox-coreutils-07-chcon.v3.patch
>>  - chcon - change security context of file. 
>>
>> Signed-off-by: KaiGai Kohei <kaigai@kaigai.gr.jp>
> 
> +#define OPT_QUIET              (1<<3)  /* 'f' */
> +#define OPT_REFERENCE          (1<<4)  /* '\n' */
> +#define OPT_USER               (1<<5)  /* 'u' */
> 
> ...
> 
> 
> +       {"quiet",       0,      NULL,   'f'},
> +       {"reference",   1,      NULL,   '\n' }, /* no short option */
> +       {"user",        1,      NULL,   'u' },
> +       {"role",        1,      NULL,   'r' },
> +       {"type",        1,      NULL,   't' },
> +       {"range",       1,      NULL,   'l' },
> +       {"verbose",     0,      NULL,   'v' },
> +       {NULL,          0,      NULL,   0 },
> +};
> +#endif
> +
> +int chcon_main(int argc, char *argv[]);
> +int chcon_main(int argc, char *argv[])
> +{
> +       char *reference_file;
> +       char **target_files;
> +       int i, opts, errors = 0;
> +
> +#ifdef CONFIG_FEATURE_CHCON_LONG_OPTIONS
> +       applet_long_options = chcon_options;
> +#endif
> +       opt_complementary = "-1"  /* at least 1 param */
> +               ":q--v:v--q";     /* 'verbose' and 'quiet' are exclusive */
> +       opts = getopt32(argc, argv, "Rchf\n:u:r:t:l:v",
> +                       &reference_file, &user, &role, &type, &range);
> +       if (opts & OPT_REFERENCE) {
> +               if (opts & OPT_COMPONENT_SPECIFIED)
> +                       bb_error_msg_and_die("conflicting security context specifiers given");
> 
> 
> Again see wget.c how to not pass '\n' to getopt32.
> 
> You can make OPT_REFERENCE and OPT_COMPONENT_SPECIFIED
> exclusive by using suitable opt_complementary.

OK, fixed.

* '\n' was replaced by '0xff'
* Checks for exclusive options were added. chcon applet will will abort
   if --reference and '-u','-r','-t','-l' are appeared concurrently,

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------060407060300080406080807
Content-Type: text/x-patch;
 name="busybox-coreutils-chcon-07.v4.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="busybox-coreutils-chcon-07.v4.patch"

Index: selinux/chcon.c
===================================================================
--- selinux/chcon.c	(リビジョン 0)
+++ selinux/chcon.c	(リビジョン 0)
@@ -0,0 +1,214 @@
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
+static int change_dir_context(const char *dir_name, unsigned int opts);
+
+static context_t compute_context_from_mask(security_context_t context, unsigned int opts)
+{
+	context_t new_context = context_new(context);
+	if (!new_context)
+		return NULL;
+
+	if ((opts & OPT_USER)  && context_user_set(new_context, user))
+		goto error;
+	if ((opts & OPT_RANGE) && context_range_set(new_context, range))
+		goto error;
+	if ((opts & OPT_ROLE)  && context_role_set(new_context, role))
+		goto error;
+	if ((opts & OPT_TYPE)  && context_type_set(new_context, type))
+		goto error;
+
+	return new_context;
+error:
+	context_free (new_context);
+	return NULL;
+}
+
+static int change_file_context(const char *fname, unsigned long opts)
+{
+	security_context_t file_context = NULL;
+	security_context_t context_string;
+	context_t context;
+	int errors = 0;
+	int status = 0;
+
+	if (opts & OPT_NODEREFERENCE) {
+		status = lgetfilecon(fname, &file_context);
+	} else {
+		status = getfilecon(fname, &file_context);
+	}
+	if (status < 0 && errno != ENODATA) {
+		if (!(opts & OPT_QUIET) == 0)
+			bb_error_msg("could not obtain security context: %s", fname);
+		return 1;
+	}
+
+	if (file_context == NULL && specified_context == NULL) {
+		bb_error_msg("could not apply partial context to unlabeled file %s", fname);
+		return 1;
+	}
+
+	if (specified_context == NULL) {
+		context = compute_context_from_mask(file_context, opts);
+		if (!context) {
+			bb_error_msg("couldn't compute security context from %s", file_context);
+			return 1;
+		}
+	} else {
+		context = context_new(specified_context);
+		if (!context) {
+			bb_error_msg("invalid context: %s", specified_context);
+			return 1;
+		}
+	}
+
+	context_string = context_str(context);
+	if (file_context == NULL || strcmp(context_string, file_context) != 0) {
+		int fail = 0;
+
+		if (opts & OPT_NODEREFERENCE) {
+			fail = lsetfilecon (fname, context_string);
+		} else {
+			fail = setfilecon (fname, context_string);
+		}
+		if ((opts & OPT_VERBOSE)
+		    || ((opts & OPT_CHANHES) && !fail)) {
+			printf(!fail
+			       ? "context of %s changed to %s\n"
+			       : "failed to change context of %s to %s\n",
+			       fname, context_string);
+		}
+		if (fail) {
+			errors = 1;
+			if ((opts & OPT_QUIET) == 0)
+				bb_error_msg("failed to change context of %s to %s",
+					     fname, context_string);
+		}
+	} else if (opts & OPT_VERBOSE) {
+		printf("context of %s retained as %s\n", fname, context_string);
+	}
+	context_free(context);
+	freecon(file_context);
+
+	if (opts & OPT_RECURSIVE) {
+		struct stat file_stats;
+		if (lstat(fname, &file_stats) == 0
+		    && S_ISDIR(file_stats.st_mode))
+			errors |= change_dir_context(fname, opts);
+	}
+	return errors;
+}
+
+static int change_dir_context(const char *dir_name, unsigned int opts)
+{
+	DIR *dir;
+	struct dirent *dent;
+	char buffer[PATH_MAX];
+	int len, rc = 0;
+
+	dir = opendir(dir_name);
+	if (!dir) {
+		if (!(opts & OPT_QUIET))
+			bb_error_msg("failed to open directory '%s'", dir_name);
+		return 1;
+	}
+
+	while ((dent = readdir(dir))) {
+		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
+			continue;
+		len = snprintf(buffer, sizeof(buffer), "%s/%s", dir_name, dent->d_name);
+		if (len > sizeof(buffer)) {
+			bb_error_msg("name too long: %s/%s", dir_name, dent->d_name);
+			continue;
+		}
+		rc |= change_file_context(buffer, opts);
+	}
+
+	closedir(dir);
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
+	int i, opts, errors = 0;
+
+#ifdef CONFIG_FEATURE_CHCON_LONG_OPTIONS
+	applet_long_options = chcon_options;
+#endif
+	opt_complementary = "-1"    /* at least 1 param */
+		":?:f--v:v--f"      /* 'verbose' and 'quiet' are exclusive */
+		":\xff--urtl:u--\xff:r--\xff:t--\xff:l--\xff";
+	opts = getopt32(argc, argv, "Rchf\xff:u:r:t:l:v",
+			&reference_file, &user, &role, &type, &range);
+	if (opts & OPT_REFERENCE) {
+		/* FIXME: lgetfilecon() should be used when '-h' is specified.
+		          But current implementation follows the original one. */
+		if (getfilecon(reference_file, &specified_context) < 0)
+			bb_perror_msg_and_die("getfilecon('%s') failed", reference_file);
+	} else if ((opts & OPT_COMPONENT_SPECIFIED) == 0) {
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
+		errors |= change_file_context(fname, opts);
+
+	}
+	return errors;
+}

--------------060407060300080406080807--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
