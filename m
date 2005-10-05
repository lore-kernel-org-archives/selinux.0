Subject: RE: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, SELinux-dev@tresys.com
In-Reply-To: <1128366074.26285.210.camel@moss-spartans.epoch.ncsc.mil>
References: <200510031440.j93EebYs015780@gotham.columbia.tresys.com>
	 <1128354097.26285.126.camel@moss-spartans.epoch.ncsc.mil>
	 <1128366074.26285.210.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-7vXh4jDQPpJ/+IpV9ePz"
Date: Wed, 05 Oct 2005 17:12:46 -0400
Message-Id: <1128546766.24059.239.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-7vXh4jDQPpJ/+IpV9ePz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-10-03 at 15:01 -0400, Stephen Smalley wrote:
> /sbin/init would call the interface with (setlocaldefs=1,
> preservebools=0), equivalent to load_policy -b as before.  However, note
> that this means that the init SELinux patch still has to change when the
> new infrastructure for regenerating binary policy files upon all policy
> changes is in place, to instead call the interface with
> (setlocaldefs=0,preservebools=0), equivalent to load_policy -lb.  That
> seems unfortunate, and could be avoided if we hid the setting of
> setlocaldefs within libselinux.  Possibly libselinux could determine
> setlocaldefs automatically based on an /etc/selinux/config setting, and
> we could just change that setting when the new infrastructure is in
> place?  Thereby removing it from the load interface and dropping down to
> just the preservebools flag there?

Updated patches below.  Back to preservebools as the only argument (and
-b as the only option to load_policy), with localdefs determined
from /etc/selinux/config (defaulting to enabled if not specified).
Thus, when we cut over to the new infrastructure, we don't have to
repatch /sbin/init again, but only change /etc/selinux/config to include
SETLOCALDEFS=1.  Look sane?

-- 
Stephen Smalley
National Security Agency

--=-7vXh4jDQPpJ/+IpV9ePz
Content-Disposition: attachment; filename=libselinux-mkload.patch
Content-Type: text/x-patch; name=libselinux-mkload.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.45
diff -u -p -r1.45 selinux.h
--- libselinux/include/selinux/selinux.h	30 Sep 2005 18:27:17 -0000	1.45
+++ libselinux/include/selinux/selinux.h	5 Oct 2005 19:56:14 -0000
@@ -171,6 +171,22 @@ extern int security_compute_user_raw(sec
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
+ * 'preservebools' is a boolean flag indicating whether current 
+ * policy boolean values should be preserved into the new policy (if 1) 
+ * or reset to the saved policy settings (if 0).  The former case is the
+ * default for policy reloads, while the latter case is an option for policy
+ * reloads but is primarily for the initial policy load.
+ */
+extern int selinux_mkload_policy(int preservebools);
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
+++ libselinux/src/Makefile	5 Oct 2005 19:55:32 -0000
@@ -22,7 +22,7 @@ $(LIBA):  $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -Wl,-soname,$(LIBSO),-z,defs
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -Wl,-soname,$(LIBSO),-z,defs
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h
Index: libselinux/src/booleans.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/booleans.c,v
retrieving revision 1.19
diff -u -p -r1.19 booleans.c
--- libselinux/src/booleans.c	25 Aug 2005 14:11:38 -0000	1.19
+++ libselinux/src/booleans.c	5 Oct 2005 20:20:46 -0000
@@ -91,6 +91,7 @@ bad_freen:
 bad:
 	goto out;
 }
+hidden_def(security_get_boolean_names)
 
 #define STRBUF_SIZE 3 
 static int get_bool_value(const char *name, char **buf)
Index: libselinux/src/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/load_policy.c,v
retrieving revision 1.5
diff -u -p -r1.5 load_policy.c
--- libselinux/src/load_policy.c	18 Dec 2003 17:33:47 -0000	1.5
+++ libselinux/src/load_policy.c	5 Oct 2005 20:22:24 -0000
@@ -1,10 +1,13 @@
 #include <unistd.h>
 #include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
+#include <sepol/sepol.h>
 #include "policy.h"
 #include <limits.h>
 
@@ -24,4 +27,82 @@ int security_load_policy(void *data, siz
 		return -1;
 	return 0;
 }
+hidden_def(security_load_policy)
+
+int load_setlocaldefs hidden = 1;
+
+int selinux_mkload_policy(int preservebools)
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
+	if (load_setlocaldefs || preservebools) 
+		prot |= PROT_WRITE;
+
+	size = sb.st_size;
+	data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED) 
+		goto close;
+
+	if (load_setlocaldefs) {
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
+	} else if (load_setlocaldefs) {
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
 
Index: libselinux/src/policyvers.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/policyvers.c,v
retrieving revision 1.5
diff -u -p -r1.5 policyvers.c
--- libselinux/src/policyvers.c	9 Apr 2004 15:20:59 -0000	1.5
+++ libselinux/src/policyvers.c	5 Oct 2005 20:24:04 -0000
@@ -4,9 +4,10 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 #include <stdio.h>
 #include "policy.h"
+#include "dso.h"
 #include <limits.h>
 
 #define DEFAULT_POLICY_VERSION 15
@@ -37,3 +38,5 @@ int security_policyvers(void)
 
 	return vers;
 }
+hidden_def(security_policyvers)
+
Index: libselinux/src/selinux_config.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_config.c,v
retrieving revision 1.17
diff -u -p -r1.17 selinux_config.c
--- libselinux/src/selinux_config.c	30 Sep 2005 18:27:18 -0000	1.17
+++ libselinux/src/selinux_config.c	5 Oct 2005 20:54:40 -0000
@@ -15,6 +15,7 @@
 #define SELINUXDEFAULT "targeted"
 #define SELINUXTYPETAG "SELINUXTYPE="
 #define SELINUXTAG "SELINUX="
+#define SETLOCALDEFS "SETLOCALDEFS="
 
 /* Indices for file paths arrays. */
 #define BINPOLICY         0
@@ -123,45 +124,69 @@ static void init_selinux_policyroot(void
 
 static void init_selinux_policyroot(void)
 {
-  char *type=SELINUXDEFAULT;
-  int i=0, len=sizeof(SELINUXTYPETAG)-1, len2;
-  char buf[4097];
-  FILE *cfg;
+  int i;
+  size_t rootlen, len;
+  char *line_buf = NULL, *buf_p;
+  FILE *fp;
+
   if (selinux_policyroot) return;
   if (access(SELINUXDIR, F_OK) != 0) {
 	  selinux_policyroot = SECURITYDIR;
 	  use_compat_file_path = 1;
 	  return;
   }
-  cfg = fopen(SELINUXCONFIG,"r");
-  if (cfg) {
-    while (fgets_unlocked(buf, 4096, cfg)) {
-      if (strncmp(buf,SELINUXTYPETAG,len)==0) {
-	type=buf+len;
-	break;
-      }
-    }
-    fclose(cfg);
+
+  fp = fopen(SELINUXCONFIG,"r");
+  if (fp) {
+	  while (getline(&line_buf, &len, fp) > 0) {
+		  len = strlen(line_buf); /* reset in case of embedded NUL */
+		  if (line_buf[len - 1] == '\n')
+			  line_buf[len - 1] = 0;
+		  buf_p = line_buf;
+		  while (isspace(*buf_p))
+			  buf_p++;
+		  if (*buf_p == '#' || *buf_p == 0)
+			  continue;
+
+		  if (!strncasecmp(buf_p, SELINUXTYPETAG, 
+				   sizeof(SELINUXTYPETAG)-1)) {
+			  char *type, *end;
+			  type = buf_p+sizeof(SELINUXTYPETAG)-1;
+			  end  = type + strlen(type)-1;
+			  while ((end > type) && 
+				 (isspace(*end) || iscntrl(*end))) {
+				  *end = 0;
+				  end--;
+			  }
+			  rootlen = sizeof(SELINUXDIR) + strlen(type);
+			  selinux_policyroot = malloc(rootlen);
+			  if (!selinux_policyroot)
+				  return;
+			  snprintf(selinux_policyroot, rootlen, "%s%s", 
+				   SELINUXDIR, type);
+		  } else if (!strncmp(buf_p, SETLOCALDEFS, 
+				      sizeof(SETLOCALDEFS)-1)) {
+			  char *value;
+			  value = buf_p + sizeof(SETLOCALDEFS)-1;
+			  if (isdigit(*value)) 
+				  load_setlocaldefs = atoi(value);
+			  else if (strncasecmp(value, "true", sizeof("true")-1))
+				  load_setlocaldefs = 1;
+			  else if (strncasecmp(value, "false", sizeof("false")-1))
+				  load_setlocaldefs = 0;
+		  }
+	  }
+	  free(line_buf);
+	  fclose(fp);
   }
-  i=strlen(type)-1;
-  while ((i>=0) && 
-	 (isspace(type[i]) || iscntrl(type[i]))) {
-    type[i]=0;
-    i--;
-  }
-  len=sizeof(SELINUXDIR) + strlen(type);
-  selinux_policyroot=malloc(len);
-  if (!selinux_policyroot)
-	  return;
-  snprintf(selinux_policyroot,len, "%s%s", SELINUXDIR, type);
-  
+
   for (i = 0; i < NEL; i++) {
-	  len2 = len + strlen(file_path_suffixes_data.str
-			      + file_path_suffixes_idx[i])+1;
-	  file_paths[i] = malloc(len2);
+	  len = rootlen + strlen(file_path_suffixes_data.str
+				 + file_path_suffixes_idx[i])+1;
+	  file_paths[i] = malloc(len);
 	  if (!file_paths[i])
 		  return;
-	  snprintf(file_paths[i], len2, "%s%s", selinux_policyroot,
+	  snprintf(file_paths[i], len, "%s%s", selinux_policyroot,
 		   file_path_suffixes_data.str + file_path_suffixes_idx[i]);
   }
   use_compat_file_path = 0;
@@ -220,6 +245,7 @@ hidden_def(selinux_removable_context_pat
 const char *selinux_binary_policy_path() {
   return get_path(BINPOLICY);
 }
+hidden_def(selinux_binary_policy_path)
 
 const char *selinux_file_context_path() {
   return get_path(FILE_CONTEXTS);
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.10
diff -u -p -r1.10 selinux_internal.h
--- libselinux/src/selinux_internal.h	30 Sep 2005 18:27:18 -0000	1.10
+++ libselinux/src/selinux_internal.h	5 Oct 2005 20:22:30 -0000
@@ -1,7 +1,10 @@
 #include <selinux/selinux.h>
 #include "dso.h"
 
+hidden_proto(security_policyvers)
+hidden_proto(security_load_policy)
 hidden_proto(security_get_boolean_active)
+hidden_proto(security_get_boolean_names)
 hidden_proto(security_set_boolean)
 hidden_proto(security_commit_booleans)
 hidden_proto(security_check_context)
@@ -38,6 +41,7 @@ hidden_proto(setexeccon_raw)
 hidden_proto(getfscreatecon_raw)
 hidden_proto(setfscreatecon_raw)
 hidden_proto(security_getenforce)
+hidden_proto(selinux_binary_policy_path)
 hidden_proto(selinux_default_context_path)
 hidden_proto(selinux_failsafe_context_path)
 hidden_proto(selinux_removable_context_path)
@@ -54,3 +58,6 @@ hidden_proto(selinux_usersconf_path);
 extern int context_translations hidden;
 extern int hidden trans_to_raw_context(char *trans, char **rawp);
 extern int hidden raw_to_trans_context(char *raw, char **transp);
+
+extern int load_setlocaldefs hidden;
+

--=-7vXh4jDQPpJ/+IpV9ePz
Content-Disposition: attachment; filename=policycoreutils-mkload.patch
Content-Type: text/x-patch; name=policycoreutils-mkload.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: policycoreutils/load_policy/load_policy.8
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/load_policy/load_policy.8,v
retrieving revision 1.2
diff -u -p -r1.2 load_policy.8
--- policycoreutils/load_policy/load_policy.8	26 Aug 2004 17:05:09 -0000	1.2
+++ policycoreutils/load_policy/load_policy.8	5 Oct 2005 21:02:17 -0000
@@ -1,22 +1,25 @@
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
+when loading the policy.
+
+.SH "OPTIONS"
+.TP
+.B \-b
+reset the policy boolean values to the saved policy settings.
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
+++ policycoreutils/load_policy/load_policy.c	5 Oct 2005 21:01:36 -0000
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
+	fprintf(stderr, _("usage:  %s [-bq]\n"), progname);
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
+	int ret, opt, quiet=0, preservebools = 1, i, nargs;
 
 #ifdef USE_NLS
 	setlocale (LC_ALL, "");
@@ -42,10 +32,10 @@ int main(int argc, char **argv) 
 	textdomain (PACKAGE);
 #endif
 
-	while ((opt = getopt(argc, argv, "qb")) > 0) {
+	while ((opt = getopt(argc, argv, "bq")) > 0) {
 		switch (opt) {
 		case 'b':
-			setbools = 1;
+			preservebools = 0;
 			break;
 		case 'q':
 			quiet = 1;
@@ -56,100 +46,21 @@ int main(int argc, char **argv) 
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
+	ret = selinux_mkload_policy(preservebools);
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

--=-7vXh4jDQPpJ/+IpV9ePz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
