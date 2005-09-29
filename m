Subject: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux-dev@tresys.com
Content-Type: multipart/mixed; boundary="=-Yr1trEv5Yph7bc2BELOW"
Date: Thu, 29 Sep 2005 17:20:16 -0400
Message-Id: <1128028816.27495.182.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Yr1trEv5Yph7bc2BELOW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

In the past, there have been discussions about the need to migrate more
of the policy loading logic that currently resides in init and
load_policy into a higher level libselinux function than the current
security_load_policy(3) interface.  This will allow us to evolve that
logic more easily, without needing to re-patch init each time (as was
done first for the booleans and then for local users) as well as
eliminating code duplication.

Below are sample patches for libselinux and policycoreutils to implement
a new selinux_mkload_policy(3) interface and to rewrite load_policy to
use it.  Since load_policy presently requires that you specify the
policy file path as an argument, I retained support for specifying the
path in the interface, without requiring it, with load_policy warning on
the old usage but continuing to accept it.  I did however drop the
support for specifying a booleans file other than the default location
entirely, as it was optional and doesn't seem to be used in practice.  I
also retained the ability to specify whether booleans should be
preserved across a load or reset to the policy settings in the interface
for use by load_policy (on policy updates, when you don't want to
disturb the active boolean settings).

However, at least the support for specifying the policy path doesn't
seem likely to survive when the policy server is introduced.  Hence, I
was wondering if I should just drop it now.  In that case, we need to
decide whether load_policy will just warn about the old usage but
proceed to load the active policy (so that current users aren't broken)
or warn and fail in that case.

Comments?

-- 
Stephen Smalley
National Security Agency

--=-Yr1trEv5Yph7bc2BELOW
Content-Disposition: attachment; filename=libselinux-mkload.patch
Content-Type: text/x-patch; name=libselinux-mkload.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.44
diff -u -p -r1.44 selinux.h
--- libselinux/include/selinux/selinux.h	31 Aug 2005 15:56:15 -0000	1.44
+++ libselinux/include/selinux/selinux.h	29 Sep 2005 19:34:14 -0000
@@ -171,6 +171,20 @@ extern int security_compute_user_raw(sec
 /* Load a policy configuration. */
 extern int security_load_policy(void *data, size_t len);
 
+/*
+ * Make a policy image and load it.
+ * This function provides a higher level interface for loading policy
+ * than security_load_policy, handling the creation of the policy image
+ * as well as the loading internally.
+ *
+ * 'path' is optional and may be NULL, in which case the
+ *  active policy configuration will be used.
+ *
+ *  'preservebools' indicates whether current boolean values should
+ *  be preserved (if 1) or reset to the policy settings (if 0).
+ */
+extern int selinux_mkload_policy(const char *path, int preservebools);
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
+++ libselinux/src/Makefile	29 Sep 2005 19:41:07 -0000
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
+++ libselinux/src/load_policy.c	29 Sep 2005 19:49:51 -0000
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
 
@@ -25,3 +28,76 @@ int security_load_policy(void *data, siz
 	return 0;
 }
 
+int selinux_mkload_policy(const char *polpath, int preservebools)
+{
+	int vers = security_policyvers();
+	char path[PATH_MAX], **names;
+	struct stat sb;
+	size_t size;
+	void *map, *data;
+	int fd, rc = -1, *values, len, i;
+
+	if (vers < 0)
+		return -1;
+
+	if (polpath) {
+		fd = open(polpath, O_RDONLY);
+	} else {
+		snprintf(path, sizeof(path), "%s.%d", 
+			 selinux_binary_policy_path(), vers);
+		fd = open(path, O_RDONLY);
+		while (fd < 0 && errno == ENOENT && --vers > 0) {
+			/* Check prior versions to see if old policy is available */
+			snprintf(path, sizeof(path), "%s.%d", 
+				 selinux_binary_policy_path(), vers);
+			fd = open(path, O_RDONLY);
+		}
+	}
+	if (fd < 0)
+		return -1;
+
+	if (fstat(fd, &sb) < 0)
+		goto close;
+
+	size = sb.st_size;
+	data = map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED) 
+		goto close;
+
+	rc = sepol_genusers(data, size, selinux_users_path(), &data, &size);
+	if (rc < 0) {
+		/* Fall back to the base image if genusers failed. */
+		data = map;
+		size = sb.st_size;
+		rc = 0;
+	}
+
+	if (!preservebools) {
+		(void) sepol_genbools(data, size, (char*)selinux_booleans_path());
+	} else {
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

--=-Yr1trEv5Yph7bc2BELOW
Content-Disposition: attachment; filename=policycoreutils-mkload.patch
Content-Type: text/x-patch; name=policycoreutils-mkload.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/load_policy/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/load_policy/load_policy.c,v
retrieving revision 1.18
diff -u -p -r1.18 load_policy.c
--- policycoreutils/load_policy/load_policy.c	11 Jul 2005 19:18:41 -0000	1.18
+++ policycoreutils/load_policy/load_policy.c	29 Sep 2005 20:28:27 -0000
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
@@ -23,18 +18,14 @@
 
 void usage(char *progname) 
 {
-	fprintf(stderr, _("usage:  %s [-q] [-b] policyfile [booleanfile]\n"), progname);
+	fprintf(stderr, _("usage:  %s [-q] [policyfile]\n"), progname);
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
+	int ret, opt, quiet=0, setbools = 0, i, nargs;
+	char *polpath = NULL;
 
 #ifdef USE_NLS
 	setlocale (LC_ALL, "");
@@ -56,100 +47,22 @@ int main(int argc, char **argv) 
 		}
 	}
 
-	if ((argc-optind) != 1 && (argc-optind) != 2) {
+	nargs = argc - optind;
+	if (nargs > 2)
 		usage(argv[0]);
+	if (nargs >= 1) {
+		fprintf(stderr, "%s:  Warning!  Policy file argument (%s) is now optional, will default to active policy if left unspecified.  Continuing...\n", argv[0], argv[optind]);
+		polpath = argv[optind++];
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
+		fprintf(stderr, "%s:  Warning!  Boolean file argument %s is no longer supported.  Ignoring...\n", argv[0], argv[optind++]);
 	}
 
-	ret = sepol_genusers(map, sb.st_size, selinux_users_path(), &data, &data_size);
+	ret = selinux_mkload_policy(polpath, !setbools);
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
+		fprintf(stderr, _("Can't load '%s':  %s\n"),
+			polpath ? polpath : "policy", strerror(errno));
+		exit(2);
 	}
-	
 	exit(0);
 }

--=-Yr1trEv5Yph7bc2BELOW--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
