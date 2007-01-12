Message-ID: <45A7BC87.9070804@redhat.com>
Date: Fri, 12 Jan 2007 11:51:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: New test program for libselinux/utils that helped with testing
 MLS/Role/Level coding
References: <45A68F43.3050101@redhat.com> <1168615518.7993.501.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168615518.7993.501.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------030708010103090108020909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030708010103090108020909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixed level part of patch

> This is very similar to the existing getseuser utility that likewise
> does a getseuserbyname() but then calls
> get_ordered_context_list_with_level() and displays all of the contexts
> in it.  Differences are that you permit specification of the role (and
> level, if fixed) via options and you only get the default value rather
> than the entire list.
I found this test program much easier to figure out what the application 
(locallogin, sshd ...) would do when I logged in.

Probably be worth while adding some of the mls constraints tests in 
also.  IE Make sure mls is working so if I have a process running s0:s0 
it can't generate a SystemHigh user, as well as a user with s0:s0 can 
not ask for a level of SystemHigh.


--------------030708010103090108020909
Content-Type: text/x-patch;
 name="libselinux-getdefaultcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-getdefaultcon.patch"

--- nsalibselinux/utils/getdefaultcon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.4/utils/getdefaultcon.c	2007-01-12 11:28:22.000000000 -0500
@@ -0,0 +1,80 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <ctype.h>
+#include <selinux/selinux.h>
+#include <selinux/get_context_list.h>
+
+void usage(char *name, char *detail, int rc)
+{
+	fprintf(stderr, "usage:  %s [-l level] user fromcon\n", name);
+	if (detail)
+		fprintf(stderr, "%s:  %s\n", name, detail);
+	exit(rc);
+}
+
+int main(int argc, char **argv)
+{
+	security_context_t usercon = NULL, cur_context = NULL;
+	char *user = NULL, *level = NULL, *role=NULL, *seuser=NULL, *dlevel=NULL;
+	int ret, opt;
+
+	while ((opt = getopt(argc, argv, "l:r:")) > 0) {
+		switch (opt) {
+		case 'l':
+			level = strdup(optarg);
+			break;
+		case 'r':
+			role = strdup(optarg);
+			break;
+		default:
+			usage(argv[0], "invalid option", 1);
+		}
+	}
+
+	if (((argc - optind) < 1) || ((argc - optind) > 2))
+		usage(argv[0], "invalid number of arguments", 2);
+
+	/* If selinux isn't available, bail out. */
+	if (!is_selinux_enabled()) {
+		fprintf(stderr,
+			"%s may be used only on a SELinux kernel.\n", argv[0]);
+		return 1;
+	}
+
+	user = argv[optind];
+
+	/* If a context wasn't passed, use the current context. */
+	if (((argc - optind) < 2)) {
+		if (getcon(&cur_context) < 0) {
+			fprintf(stderr, "Couldn't get current context.\n");
+			return 2;
+		}
+	} else
+		cur_context = argv[optind + 1];
+
+	if (getseuserbyname(user, &seuser, &dlevel)==0) {
+		if (! level) level=dlevel;
+		if (role != NULL && role[0]) 
+			ret=get_default_context_with_rolelevel(seuser, role, level,cur_context,&usercon);
+		else
+			ret=get_default_context_with_level(seuser, level, cur_context,&usercon);
+	}
+	if (ret < 0)
+		perror(argv[0]);
+	else
+		printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context, seuser, role, level, usercon);
+
+
+	free(role);
+	free(seuser);
+	if (level != dlevel) free(level);
+	free(dlevel);
+	free(usercon);
+
+	return 0;
+}

--------------030708010103090108020909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
