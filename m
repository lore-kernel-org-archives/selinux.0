Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFNs30010879
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:23:54 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNKYR012669
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:23:44 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865859nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:23:44 -0800 (PST)
Message-ID: <cadfc0e40711260723iad81a78sb05dc7549c8b04ec@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:23:42 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 5/10] PAM Namespace: enable polyinstantiation of directories with spaces in name
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

pam_namespace cannot polyinstantiate directories that have spaces in their name.
The configuration file processing code uses strtok_r with delimiters space and
tab. There is no functionality to allow escaping of spaces or quoting of strings
so that paths with spaces can be specified.
I picked up some code to do the actual configuration line parsing instead of
writing it my self and I hope the copyright won't be an issue.

 Makefile.am     |    2
 argv_parse.c    |  164 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 argv_parse.h    |   43 ++++++++++++++
 pam_namespace.c |   21 +++++--
 4 files changed, 223 insertions(+), 7 deletions(-)


--- Linux-PAM-0.99.8.1/modules/pam_namespace/argv_parse.c	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/argv_parse.c	2007-06-22
14:41:24.000000000 -0500
@@ -0,0 +1,164 @@
+/*
+ * argv_parse.c --- utility function for parsing a string into a
+ * 	argc, argv array.
+ *
+ * This file defines a function argv_parse() which parsing a
+ * passed-in string, handling double quotes and backslashes, and
+ * creates an allocated argv vector which can be freed using the
+ * argv_free() function.
+ *
+ * See argv_parse.h for the formal definition of the functions.
+ *
+ * Copyright 1999 by Theodore Ts'o.
+ *
+ * Permission to use, copy, modify, and distribute this software for
+ * any purpose with or without fee is hereby granted, provided that
+ * the above copyright notice and this permission notice appear in all
+ * copies.  THE SOFTWARE IS PROVIDED "AS IS" AND THEODORE TS'O (THE
+ * AUTHOR) DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
+ * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
+ * RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
+ * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
+ * IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.  (Isn't
+ * it sick that the U.S. culture of lawsuit-happy lawyers requires
+ * this kind of disclaimer?)
+ *
+ * Version 1.1, modified 2/27/1999
+ */
+
+#include <stdlib.h>
+#include <ctype.h>
+#include <string.h>
+#include "argv_parse.h"
+
+#define STATE_WHITESPACE	1
+#define STATE_TOKEN		2
+#define STATE_QUOTED		3
+
+/*
+ * Returns 0 on success, -1 on failure.
+ */
+int argv_parse(char *in_buf, int *ret_argc, char ***ret_argv)
+{
+	int	argc = 0, max_argc = 0;
+	char 	**argv, **new_argv, *buf, ch;
+	char	*cp = 0, *outcp = 0;
+	int	state = STATE_WHITESPACE;
+
+	buf = malloc(strlen(in_buf)+1);
+	if (!buf)
+		return -1;
+
+	max_argc = 0; argc = 0; argv = 0;
+	outcp = buf;
+	for (cp = in_buf; (ch = *cp); cp++) {
+		if (state == STATE_WHITESPACE) {
+			if (isspace((int) ch))
+				continue;
+			/* Not whitespace, so start a new token */
+			state = STATE_TOKEN;
+			if (argc >= max_argc) {
+				max_argc += 3;
+				new_argv = realloc(argv,
+						  (max_argc+1)*sizeof(char *));
+				if (!new_argv) {
+					if (argv) free(argv);
+					free(buf);
+					return -1;
+				}
+				argv = new_argv;
+			}
+			argv[argc++] = outcp;
+		}
+		if (state == STATE_QUOTED) {
+			if (ch == '"')
+				state = STATE_TOKEN;
+			else
+				*outcp++ = ch;
+			continue;
+		}
+		/* Must be processing characters in a word */
+		if (isspace((int) ch)) {
+			/*
+			 * Terminate the current word and start
+			 * looking for the beginning of the next word.
+			 */
+			*outcp++ = 0;
+			state = STATE_WHITESPACE;
+			continue;
+		}
+		if (ch == '"') {
+			state = STATE_QUOTED;
+			continue;
+		}
+		if (ch == '\\') {
+			ch = *++cp;
+			switch (ch) {
+			case '\0':
+				ch = '\\'; cp--; break;
+			case 'n':
+				ch = '\n'; break;
+			case 't':
+				ch = '\t'; break;
+			case 'b':
+				ch = '\b'; break;
+			}
+		}
+		*outcp++ = ch;
+	}
+	if (state != STATE_WHITESPACE)
+		*outcp++ = '\0';
+	if (argv == 0) {
+		argv = malloc(sizeof(char *));
+		free(buf);
+	}
+	argv[argc] = 0;
+	if (ret_argc)
+		*ret_argc = argc;
+	if (ret_argv)
+		*ret_argv = argv;
+	return 0;
+}
+
+void argv_free(char **argv)
+{
+	if (*argv)
+		free(*argv);
+	free(argv);
+}
+
+#ifdef DEBUG
+/*
+ * For debugging
+ */
+
+#include <stdio.h>
+
+int main(int argc, char **argv)
+{
+	int	ac, ret;
+	char	**av, **cpp;
+	char	buf[256];
+
+	while (!feof(stdin)) {
+		if (fgets(buf, sizeof(buf), stdin) == NULL)
+			break;
+		ret = argv_parse(buf, &ac, &av);
+		if (ret != 0) {
+			printf("Argv_parse returned %d!\n", ret);
+			continue;
+		}
+		printf("Argv_parse returned %d arguments...\n", ac);
+		for (cpp = av; *cpp; cpp++) {
+			if (cpp != av)
+				printf(", ");
+			printf("'%s'", *cpp);
+		}
+		printf("\n");
+		argv_free(av);
+	}
+	exit(0);
+}
+#endif
--- Linux-PAM-0.99.8.1/modules/pam_namespace/argv_parse.h	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/argv_parse.h	2007-06-22
14:41:24.000000000 -0500
@@ -0,0 +1,43 @@
+/*
+ * argv_parse.h --- header file for the argv parser.
+ *
+ * This file defines the interface for the functions argv_parse() and
+ * argv_free().
+ *
+ ***********************************************************************
+ * int argv_parse(char *in_buf, int *ret_argc, char ***ret_argv)
+ *
+ * This function takes as its first argument a string which it will
+ * parse into an argv argument vector, with each white-space separated
+ * word placed into its own slot in the argv.  This function handles
+ * double quotes and backslashes so that the parsed words can contain
+ * special characters.   The count of the number words found in the
+ * parsed string, as well as the argument vector, are returned into
+ * ret_argc and ret_argv, respectively.
+ ***********************************************************************
+ * extern void argv_free(char **argv);
+ *
+ * This function frees the argument vector created by argv_parse().
+ ***********************************************************************
+ *
+ * Copyright 1999 by Theodore Ts'o.
+ *
+ * Permission to use, copy, modify, and distribute this software for
+ * any purpose with or without fee is hereby granted, provided that
+ * the above copyright notice and this permission notice appear in all
+ * copies.  THE SOFTWARE IS PROVIDED "AS IS" AND THEODORE TS'O (THE
+ * AUTHOR) DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
+ * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
+ * RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
+ * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
+ * IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.  (Isn't
+ * it sick that the U.S. culture of lawsuit-happy lawyers requires
+ * this kind of disclaimer?)
+ *
+ * Version 1.1, modified 2/27/1999
+ */
+
+extern int argv_parse(char *in_buf, int *ret_argc, char ***ret_argv);
+extern void argv_free(char **argv);
--- Linux-PAM-0.99.8.1/modules/pam_namespace/Makefile.am	2007-06-22
15:02:25.000000000 -0500
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/Makefile.am	2007-06-22
15:02:48.000000000 -0500
@@ -32,7 +32,7 @@

 if HAVE_UNSHARE
 securelib_LTLIBRARIES = pam_namespace.la
-pam_namespace_la_SOURCES = pam_namespace.c pam_namespace.h md5.c md5.h
+pam_namespace_la_SOURCES = pam_namespace.c pam_namespace.h md5.c
md5.h argv_parse.c argv_parse.h

 secureconf_DATA = namespace.conf
 secureconf_SCRIPTS = namespace.init
--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.c	2007-06-23
05:21:09.000000000 -0500
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.c	2007-06-23
05:22:00.000000000 -0500
@@ -32,7 +32,7 @@

 #include "pam_namespace.h"
 #include "libpam/pam_private.h"
-
+#include "argv_parse.h"
 /*
  * Copies the contents of ent into pent
  */
@@ -143,7 +143,9 @@
     char *tptr;
     struct polydir_s poly;
     int retval = 0;
-
+    int num_config_options = 0;
+    char **config_options = NULL;
+
     poly.uid = NULL;
     poly.num_uids = 0;
     poly.exclusive = 0;
@@ -178,17 +180,23 @@
      * Initialize and scan the five strings from the line from the
      * namespace configuration file.
      */
-    dir = strtok_r(line, " \t", &tptr);
+    retval = argv_parse(line, &num_config_options, &config_options);
+    if (retval != 0) {
+        pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing polydir");
+        goto skipping;
+    }
+
+    dir = config_options[0];
     if (dir == NULL) {
         pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing polydir");
         goto skipping;
     }
-    instance_prefix = strtok_r(NULL, " \t", &tptr);
+    instance_prefix = config_options[1];
     if (instance_prefix == NULL) {
         pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing
instance_prefix");
         goto skipping;
     }
-    method = strtok_r(NULL, " \t", &tptr);
+    method = config_options[2];
     if (method == NULL) {
         pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line missing method");
         goto skipping;
@@ -200,7 +208,7 @@
      * any of the other fields are blank, the line is incomplete so
      * skip it.
      */
-    uids = strtok_r(NULL, " \t", &tptr);
+    uids = config_options[3];

     /*
      * If the directory being polyinstantiated is the home directory
@@ -357,6 +365,7 @@
     else
         retval = PAM_SERVICE_ERR;
 out:
+    argv_free(config_options);
     return retval;
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
