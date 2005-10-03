Subject: RE: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, SELinux-dev@tresys.com
In-Reply-To: <1128354097.26285.126.camel@moss-spartans.epoch.ncsc.mil>
References: <200510031440.j93EebYs015780@gotham.columbia.tresys.com>
	 <1128354097.26285.126.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-BR8h1WbKyp9BlTfTSjVt"
Date: Mon, 03 Oct 2005 15:01:14 -0400
Message-Id: <1128366074.26285.210.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BR8h1WbKyp9BlTfTSjVt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-10-03 at 11:41 -0400, Stephen Smalley wrote:
> Ok, so it sounds like we want to drop the optional path argument, retain
> the preservebools flag argument and its functionality, and add a
> setlocaldefs flag argument to control the use of sepol_genusers/genbools
> functionality.

Updated patches for libselinux and load_policy below.  New interface
takes the two flag arguments, as discussed.  load_policy defaults to
loading local user definitions but preserving current boolean values
(setlocaldefs=1, preservebools=1), but allows disabling either or both
behaviors via -l and -b:
-l	Suppress loading of local users.
-b	Suppress preservation of current booleans.
-lb	No modification of the binary policy file at all prior to load.

/sbin/init would call the interface with (setlocaldefs=1,
preservebools=0), equivalent to load_policy -b as before.  However, note
that this means that the init SELinux patch still has to change when the
new infrastructure for regenerating binary policy files upon all policy
changes is in place, to instead call the interface with
(setlocaldefs=0,preservebools=0), equivalent to load_policy -lb.  That
seems unfortunate, and could be avoided if we hid the setting of
setlocaldefs within libselinux.  Possibly libselinux could determine
setlocaldefs automatically based on an /etc/selinux/config setting, and
we could just change that setting when the new infrastructure is in
place?  Thereby removing it from the load interface and dropping down to
just the preservebools flag there?

-- 
Stephen Smalley
National Security Agency

--=-BR8h1WbKyp9BlTfTSjVt
Content-Disposition: attachment; filename=libselinux-mkload2.patch
Content-Type: text/x-patch; name=libselinux-mkload2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.45
diff -u -p -r1.45 selinux.h
--- libselinux/include/selinux/selinux.h	30 Sep 2005 18:27:17 -0000	1.45
+++ libselinux/include/selinux/selinux.h	3 Oct 2005 17:16:17 -0000
@@ -171,6 +171,27 @@ extern int security_compute_user_raw(sec
 /* Load a policy configuration. */
 extern int security_load_policy(void *data, size_t len);
 
+/*
+ * Make a policy image and load it.
+ * This function provides a higher level interface for loading policy
+ * than security_load_policy, internally determining the right policy
+ * version, locating and opening the policy file, mapping it into memory,
+ * manipulating it as needed for current boolean settings and/or local 
+ * definitions, and then calling security_load_policy to load it.
+ *
+ * 'setlocaldefs' is a boolean flag indicating whether local policy 
+ * definitions (booleans, users) should be applied to the policy image
+ * prior to loading (if 1) or not (if 0).  The latter case is for when
+ * the policy file has already been regenerated with all local settings.
+ *
+ * 'preservebools' is a boolean flag indicating whether current 
+ * policy boolean values should be preserved into the new policy (if 1) 
+ * or reset to the saved policy settings (if 0).  The former case is the
+ * default for policy reloads, while the latter case is an option for policy
+ * reloads but is primarily for the initial policy load.
+ */
+extern int selinux_mkload_policy(int setlocaldefs, int preservebools);
+
 /* Translate boolean strict to name value pair. */
 typedef struct {
 	char *name;
Index: libselinux/src/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/Makefile,v
retrieving revision 1.27
diff -u -p -r1.27 Makefile
--- libselinux/src/Makefile	18 Jul 2005 13:42:20 -0000	1.27
+++ libselinux/src/Makefile	3 Oct 2005 17:07:18 -0000
@@ -22,7 +22,7 @@ $(LIBA):  $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -Wl,-soname,$(LIBSO),-z,defs
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -Wl,-soname,$(LIBSO),-z,defs
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h
Index: libselinux/src/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/load_policy.c,v
retrieving revision 1.5
diff -u -p -r1.5 load_policy.c
--- libselinux/src/load_policy.c	18 Dec 2003 17:33:47 -0000	1.5
+++ libselinux/src/load_policy.c	3 Oct 2005 17:21:11 -0000
@@ -1,10 +1,13 @@
 #include <unistd.h>
 #include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
 #include <selinux/selinux.h>
+#include <sepol/sepol.h>
 #include "policy.h"
 #include <limits.h>
 
@@ -25,3 +28,78 @@ int security_load_policy(void *data, siz
 	return 0;
 }
 
+int selinux_mkload_policy(int setlocaldefs, int preservebools)
+{
+	int vers = security_policyvers();
+	char path[PATH_MAX], **names;
+	struct stat sb;
+	size_t size;
+	void *map, *data;
+	int fd, rc = -1, *values, len, i, prot;
+
+	if (vers < 0)
+		return -1;
+
+	snprintf(path, sizeof(path), "%s.%d", 
+		 selinux_binary_policy_path(), vers);
+	fd = open(path, O_RDONLY);
+	while (fd < 0 && errno == ENOENT && --vers > 0) {
+		/* Check prior versions to see if old policy is available */
+		snprintf(path, sizeof(path), "%s.%d", 
+			 selinux_binary_policy_path(), vers);
+		fd = open(path, O_RDONLY);
+	}
+	if (fd < 0)
+		return -1;
+
+	if (fstat(fd, &sb) < 0)
+		goto close;
+
+	prot = PROT_READ;
+	if (setlocaldefs || preservebools) 
+		prot |= PROT_WRITE;
+
+	size = sb.st_size;
+	data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED) 
+		goto close;
+
+	if (setlocaldefs) {
+		rc = sepol_genusers(data, size, selinux_users_path(), &data, &size);
+		if (rc < 0) {
+			/* Fall back to the base image if genusers failed. */
+			data = map;
+			size = sb.st_size;
+			rc = 0;
+		}
+	}
+
+	if (preservebools) {
+		rc = security_get_boolean_names(&names, &len);
+		if (!rc) {
+			values = malloc(sizeof(int)*len);
+			if (!values)
+				goto unmap;
+			for (i = 0; i < len; i++)
+				values[i] = security_get_boolean_active(names[i]);
+			(void) sepol_genbools_array(data, size, names, values, len);
+			free(values);
+			for (i = 0; i < len; i++)
+				free(names[i]);
+			free(names);
+		}
+	} else if (setlocaldefs) {
+		(void) sepol_genbools(data, size, (char*)selinux_booleans_path());
+	}
+
+	rc = security_load_policy(data, size);
+
+unmap:
+	if (data != map)
+		free(data);
+	munmap(map, sb.st_size);
+close:
+	close(fd);
+	return rc;
+}
+

--=-BR8h1WbKyp9BlTfTSjVt
Content-Disposition: attachment; filename=policycoreutils-mkload2.patch
Content-Type: text/x-patch; name=policycoreutils-mkload2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/load_policy/load_policy.8
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/load_policy/load_policy.8,v
retrieving revision 1.2
diff -u -p -r1.2 load_policy.8
--- policycoreutils/load_policy/load_policy.8	26 Aug 2004 17:05:09 -0000	1.2
+++ policycoreutils/load_policy/load_policy.8	3 Oct 2005 18:15:57 -0000
@@ -1,22 +1,28 @@
 .TH LOAD_POLICY "8" "May 2003" "Security Enhanced Linux" NSA
 .SH NAME
-load_policy \- load a newly compiled policy into the kernel
+load_policy \- load a new policy into the kernel
 
 .SH SYNOPSIS
 .B load_policy 
-[-q] [-b] policyfile [booleanfile]
+[-blq]
 .br
 .SH DESCRIPTION
 .PP
 load_policy is the tool used to load/replace the policy in the kernel.
-By default, load_policy will maintain the booleans settings from the previous policy.
+By default, load_policy will preserve the current policy boolean values
+and will set local definitions prior to loading the policy.
+
+.SH "OPTIONS"
+.TP
+.B \-b
+reset the policy boolean values to the saved policy settings.
+.TP
+.B \-l
+ignore local definitions, use only the policy definitions.
 .TP
-.B -q
-quiet mode.  Do not report warning messages.
-.B -b
-replace the booleans settings with the ones from the [booleanfile] or the default on the system /etc/selinux/$SELINUXTYPE/booleans.  (SELINUXTYPE is defined in /etc/selinux/config).
+.B \-q
+suppress warning messages.
 
-.SH FILES
 .SH SEE ALSO
 .B booleans
 (8),
Index: policycoreutils/load_policy/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/load_policy/load_policy.c,v
retrieving revision 1.18
diff -u -p -r1.18 load_policy.c
--- policycoreutils/load_policy/load_policy.c	11 Jul 2005 19:18:41 -0000	1.18
+++ policycoreutils/load_policy/load_policy.c	3 Oct 2005 18:09:23 -0000
@@ -1,12 +1,7 @@
 #include <unistd.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <string.h>
 #include <errno.h>
-#include <sys/mman.h>
 #include <getopt.h>
 #include <selinux/selinux.h>
 #include <sepol/sepol.h>
@@ -23,18 +18,13 @@
 
 void usage(char *progname) 
 {
-	fprintf(stderr, _("usage:  %s [-q] [-b] policyfile [booleanfile]\n"), progname);
+	fprintf(stderr, _("usage:  %s [-blq]\n"), progname);
 	exit(1);
 }
 
 int main(int argc, char **argv) 
 {
-	int fd, ret, opt, quiet=0, setbools = 0, *values;
-	int i, len;
-	size_t data_size;
-	struct stat sb;
-	void *map, *data;
-	char *polpath, *boolpath = NULL, **names;
+	int ret, opt, quiet=0, preservebools = 1, setlocaldefs = 1, i, nargs;
 
 #ifdef USE_NLS
 	setlocale (LC_ALL, "");
@@ -42,10 +32,13 @@ int main(int argc, char **argv) 
 	textdomain (PACKAGE);
 #endif
 
-	while ((opt = getopt(argc, argv, "qb")) > 0) {
+	while ((opt = getopt(argc, argv, "blq")) > 0) {
 		switch (opt) {
 		case 'b':
-			setbools = 1;
+			preservebools = 0;
+			break;
+		case 'l':
+			setlocaldefs = 0;
 			break;
 		case 'q':
 			quiet = 1;
@@ -56,100 +49,21 @@ int main(int argc, char **argv) 
 		}
 	}
 
-	if ((argc-optind) != 1 && (argc-optind) != 2) {
+	nargs = argc - optind;
+	if (nargs > 2)
 		usage(argv[0]);
+	if (nargs >= 1) {
+		fprintf(stderr, "%s:  Warning!  Policy file argument (%s) is no longer supported, installed policy is always loaded.  Continuing...\n", argv[0], argv[optind++]);
 	}
-
-	if ((argc - optind) == 2) {
-		/* Implicit enable when they specify a boolean file */
-		setbools = 1;
-	}
-
-	polpath = argv[optind++];
-	fd = open(polpath, O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, _("Can't open '%s':  %s\n"),
-			polpath, strerror(errno));
-		exit(2);
-	}
-
-	if (fstat(fd, &sb) < 0) {
-		fprintf(stderr, _("Can't stat '%s':  %s\n"),
-			polpath, strerror(errno));
-		exit(2);
-	}
-
-	map = mmap(NULL, sb.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if (map == MAP_FAILED) {
-		fprintf(stderr, _("Can't map '%s':  %s\n"),
-			polpath, strerror(errno));
-		exit(2);
+	if (nargs == 2) {
+		fprintf(stderr, "%s:  Warning!  Boolean file argument (%s) is no longer supported, installed booleans file is always used.  Continuing...\n", argv[0], argv[optind++]);
 	}
 
-	ret = sepol_genusers(map, sb.st_size, selinux_users_path(), &data, &data_size);
+	ret = selinux_mkload_policy(setlocaldefs, preservebools);
 	if (ret < 0) {
-		/* No users file; non-fatal. */
-		if (! quiet) 
-			fprintf(stderr, _("%s:  Error while setting user configuration from %s/{local.users,system.users}:  %s\n"), argv[0], selinux_users_path(), strerror(errno));
-		data = map;
-		data_size = sb.st_size;
-	}
-
-	if (setbools) {
-		/* Set booleans based on a booleans configuration file. */
-		boolpath = (optind < argc) ? argv[optind++] : (char*) selinux_booleans_path();
-		ret = sepol_genbools(data, data_size, boolpath);
-		if (ret < 0) {
-			if (errno == ENOENT || errno == EINVAL) {
-				/* No booleans file or stale booleans in the file; non-fatal. */
-				if (! quiet) 
-					fprintf(stderr, _("%s:  Warning while setting booleans from %s\n"), argv[0], boolpath);
-			} else {
-				fprintf(stderr, _("%s:  Error while setting booleans from %s:  %s\n"), argv[0], boolpath, strerror(errno));
-				exit(2);
-			}
-		}
-	} else {
-		/* Preserve current boolean values. */
-		ret = security_get_boolean_names(&names, &len);
-		if (ret) {
-			/* Possibly ok, as there may be no booleans. */
-			if (! quiet) 
-				fprintf(stderr, _("%s:  Warning! unable to get boolean names:  %s\n"), argv[0], strerror(errno));
-			goto load;
-		}
-		if (!len)
-			goto load;
-		values = malloc(sizeof(int)*len);
-		if (!values) {
-			fprintf(stderr, _("%s:  out of memory\n"), argv[0]);
-			exit(2);
-		}
-		for (i = 0; i < len; i++) {
-			values[i] = security_get_boolean_active(names[i]);
-			if (values[i] < 0) {
-				fprintf(stderr, _("%s:  Error while getting value for boolean %s:  %s\n"), argv[0], names[i], strerror(errno));
-				exit(2);
-			}
-		}
-		ret = sepol_genbools_array(data, data_size, names, values, len);
-		if (ret < 0) {
-			if (errno == EINVAL) {
-				/* Stale booleans in the file; non-fatal. */
-				if (! quiet) 
-					fprintf(stderr, _("%s:  Warning!  Unable to reset all booleans\n"), argv[0]);
-			} else {
-				fprintf(stderr, _("%s:  Error while setting booleans:  %s\n"), argv[0], strerror(errno));
-				exit(2);
-			}
-		}
-	}
-load:	
-	ret = security_load_policy(data, data_size);
-	if (ret < 0) {
-		fprintf(stderr, _("%s:  security_load_policy failed\n"), argv[0]);
-		exit(3);
+		fprintf(stderr, _("%s:  Can't load policy:  %s\n"),
+			argv[0], strerror(errno));
+		exit(2);
 	}
-	
 	exit(0);
 }

--=-BR8h1WbKyp9BlTfTSjVt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
