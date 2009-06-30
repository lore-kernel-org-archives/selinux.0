Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5UJWp34022762
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 15:32:51 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5UJWXCl000755
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 19:32:33 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5UJWnFb020006
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 15:32:49 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5UJWmKm003460
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 15:32:49 -0400
Received: from [10.16.2.177] (dhcp-100-2-177.bos.redhat.com [10.16.2.177])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5UJWl6e020153
	for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 15:32:48 -0400
Subject: [PATCH] setfiles converted to fts
From: Thomas Liu <tliu@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-0RVQ9G78aV/z6ncqGl+2"
Date: Tue, 30 Jun 2009 15:32:48 -0400
Message-Id: <1246390368.2856.2.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-0RVQ9G78aV/z6ncqGl+2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch converted setfiles/restorecon to using fts instead of nftw.
It also removed forking, pipes and pre_stat because Dan Walsh and I
could not figure out what it was for.

-Thomas Liu

--=-0RVQ9G78aV/z6ncqGl+2
Content-Disposition: attachment; filename="setfiles_fts.patch"
Content-Type: text/x-patch; name="setfiles_fts.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -up policycoreutils-2.0.63/setfiles/Makefile.old policycoreutils-2.0.63/setfiles/Makefile
--- policycoreutils-2.0.63/setfiles/Makefile.old	2009-06-30 15:28:17.031437301 -0400
+++ policycoreutils-2.0.63/setfiles/Makefile	2009-06-30 15:08:11.057436336 -0400
@@ -3,11 +3,10 @@ PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(DESTDIR)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
-
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
 CFLAGS = -Werror -Wall -W
-override CFLAGS += -D_FILE_OFFSET_BITS=64 -I$(PREFIX)/include
+override CFLAGS += -I$(PREFIX)/include
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
 ifeq (${AUDITH}, /usr/include/libaudit.h)
diff -up policycoreutils-2.0.63/setfiles/setfiles.c.old policycoreutils-2.0.63/setfiles/setfiles.c
--- policycoreutils-2.0.63/setfiles/setfiles.c.old	2009-06-30 15:28:24.899436710 -0400
+++ policycoreutils-2.0.63/setfiles/setfiles.c	2009-06-30 15:26:42.146437987 -0400
@@ -12,7 +12,9 @@
 #include <regex.h>
 #include <sys/vfs.h>
 #define __USE_XOPEN_EXTENDED 1	/* nftw */
-#include <ftw.h>
+#define SKIP -2
+#define ERR -1
+#include <fts.h>
 #include <limits.h>
 #include <sepol/sepol.h>
 #include <selinux/selinux.h>
@@ -34,7 +36,6 @@ static int mass_relabel_errs;
 static FILE *outfile = NULL;
 static int force = 0;
 #define STAT_BLOCK_SIZE 1
-static int pipe_fds[2] = { -1, -1 };
 static int progress = 0;
 static unsigned long long count = 0;
 
@@ -73,7 +74,7 @@ static int iamrestorecon;
 static int expand_realpath;  /* Expand paths via realpath. */
 static int abort_on_error; /* Abort the file tree walk upon an error. */
 static int add_assoc; /* Track inode associations for conflict detection. */
-static int nftw_flags; /* Flags to nftw, e.g. follow links, follow mounts */
+static int fts_flags; /* Flags to fts, e.g. follow links, follow mounts */
 static int ctx_validate; /* Validate contexts */
 static const char *altpath; /* Alternate path to file_contexts */
 
@@ -292,7 +293,6 @@ static int exclude(const char *file)
 
 int match(const char *name, struct stat *sb, char **con)
 {
-	int ret;
 	char path[PATH_MAX + 1];
 
 	if (excludeCtr > 0) {
@@ -300,14 +300,7 @@ int match(const char *name, struct stat 
 			return -1;
 		}
 	}
-	ret = lstat(name, sb);
-	if (ret) {
-		if (ignore_enoent && errno == ENOENT)
-			return 0;
-		fprintf(stderr, "%s:  unable to stat file %s: %s\n", progname,
-			name, strerror(errno));
-		return -1;
-	}
+	
 
 	if (expand_realpath) {
 		if (S_ISLNK(sb->st_mode)) {
@@ -425,10 +418,10 @@ static int only_changed_user(const char 
 	return (strcmp(rest_a, rest_b) == 0);
 }
 
-static int restore(const char *file)
+static int restore(const char *file, struct stat *sb)
 {
 	char *my_file = strdupa(file);
-	struct stat my_sb;
+	struct stat my_sb =  *sb;
 	int ret;
 	char *context, *newcon;
 	int user_only_changed = 0;
@@ -549,42 +542,38 @@ static int restore(const char *file)
 	if (ret) {
 		fprintf(stderr, "%s set context %s->%s failed:'%s'\n",
 			progname, my_file, newcon, strerror(errno));
-		goto out;
+		goto skip;
 	}
+      skip:
+	freecon(newcon);
+	return SKIP; 
       out:
 	freecon(newcon);
 	return 0;
       err:
 	freecon(newcon);
-	return -1;
+	return ERR;
 }
 
 /*
  * Apply the last matching specification to a file.
- * This function is called by nftw on each file during
+ * This function is called by fts on each file during
  * the directory traversal.
  */
-static int apply_spec(const char *file,
-		      const struct stat *sb_unused __attribute__ ((unused)),
-		      int flag, struct FTW *s_unused __attribute__ ((unused)))
-{
-	char buf[STAT_BLOCK_SIZE];
-	if (pipe_fds[0] != -1
-	    && read(pipe_fds[0], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
-		fprintf(stderr, "Read error on pipe.\n");
-		pipe_fds[0] = -1;
-	}
-
-	if (flag == FTW_DNR) {
+static int apply_spec(const char *file, struct stat *sb, unsigned short flag)
+{
+	if (flag == FTS_DNR) {
 		fprintf(stderr, "%s:  unable to read directory %s\n",
 			progname, file);
-		return 0;
+		return SKIP;
 	}
 
-	errors |= restore(file);
-	if (abort_on_error && errors)
-		return -1;
-	return 0;
+	int rc = restore(file, sb);
+	if (rc == ERR) {
+		if(!abort_on_error) 
+			return SKIP;
+	}		
+	return rc;
 }
 
 void set_rootpath(const char *arg)
@@ -626,67 +615,35 @@ int canoncon(char **contextp)
 	return rc;
 }
 
-static int pre_stat(const char *file_unused __attribute__ ((unused)),
-		    const struct stat *sb_unused __attribute__ ((unused)),
-		    int flag_unused __attribute__ ((unused)),
-		    struct FTW *s_unused __attribute__ ((unused)))
-{
-	char buf[STAT_BLOCK_SIZE];
-	if (write(pipe_fds[1], buf, STAT_BLOCK_SIZE) != STAT_BLOCK_SIZE) {
-		fprintf(stderr, "Error writing to stat pipe, child exiting.\n");
-		exit(1);
-	}
-	return 0;
-}
-
 static int process_one(char *name)
 {
-	struct stat sb;
-	int rc;
-
+	int rc = 0;	
+	FTS *fts_handle = NULL;
+	const char * namelist[2] = {NULL, NULL}; 
+	namelist[0] = name;
 	if (!strcmp(name, "/"))
 		mass_relabel = 1;
 
-	rc = lstat(name, &sb);
-	if (rc < 0) {
-		if (ignore_enoent && errno == ENOENT)
-			return 0;
-		fprintf(stderr, "%s:  stat error on %s:  %s\n",
-			progname, name, strerror(errno));
+	if ((fts_handle = fts_open((char **)namelist, fts_flags, NULL)) == NULL) { 
+		fprintf(stderr,
+			"%s: error while labeling %s:  %s\n",
+			progname, namelist[0], strerror(errno));
 		goto err;
 	}
 
-	if (S_ISDIR(sb.st_mode) && recurse) {
-		if (pipe(pipe_fds) < 0) {
-			fprintf(stderr, "%s:  pipe error on %s:  %s\n",
-				progname, name, strerror(errno));
-			goto err;
-		}
-		rc = fork();
-		if (rc < 0) {
-			fprintf(stderr, "%s:  fork error on %s:  %s\n",
-				progname, name, strerror(errno));
-			goto err;
-		}
-		if (rc == 0) {
-			/* Child:  pre-stat the files. */
-			close(pipe_fds[0]);
-			nftw(name, pre_stat, 1024, nftw_flags);
-			exit(0);
-		}
-		/* Parent:  Check and label the files. */
-		rc = 0;
-		close(pipe_fds[1]);
-		if (nftw(name, apply_spec, 1024, nftw_flags)) {
-			fprintf(stderr,
-				"%s:  error while labeling %s:  %s\n",
-				progname, name, strerror(errno));
-			goto err;
+	FTSENT *file_info;
+	while ((file_info = fts_read(fts_handle)) != NULL){
+		if (file_info->fts_number)
+			continue;	
+		int rc = apply_spec(file_info->fts_path, file_info->fts_statp, file_info->fts_info);
+		file_info->fts_number = 1;
+		if (rc == SKIP){
+			fts_set(fts_handle, file_info, FTS_SKIP);
 		}
-	} else {
-		rc = restore(name);
-		if (rc)
+		if (rc == ERR)
 			goto err;
+		if (!recurse)
+			break;
 	}
 
 	if (!strcmp(name, "/"))
@@ -698,8 +655,9 @@ out:
 			filespec_eval();
 		filespec_destroy();
 	}
-
-	return rc;
+	if (fts_handle)
+		fts_close(fts_handle);
+	return rc; 
 
 err:
 	if (!strcmp(name, "/"))
@@ -777,7 +735,7 @@ int main(int argc, char **argv)
 		expand_realpath = 0;
 		abort_on_error = 1;
 		add_assoc = 1;
-		nftw_flags = FTW_PHYS | FTW_MOUNT;
+		fts_flags = FTS_PHYSICAL | FTS_XDEV;
 		ctx_validate = 1;
 	} else {
 		/*
@@ -796,7 +754,7 @@ int main(int argc, char **argv)
 		expand_realpath = 1;
 		abort_on_error = 0;
 		add_assoc = 0;
-		nftw_flags = FTW_PHYS;
+		fts_flags = FTS_PHYSICAL;
 		ctx_validate = 0;
 
 		/* restorecon only:  silent exit if no SELinux.

--=-0RVQ9G78aV/z6ncqGl+2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
