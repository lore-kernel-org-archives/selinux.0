Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n62FUBXO001799
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 11:30:11 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n62FUlih004295
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 15:30:48 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n62FU9D0022133
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 11:30:09 -0400
Subject: [PATCH v3] setfiles converted to fts
From: Thomas Liu <tliu@redhat.com>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1246536793.13464.251.camel@moss-pluto.epoch.ncsc.mil>
References: <1246480778.2771.0.camel@Ares>
	 <1246536793.13464.251.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 11:30:07 -0400
Message-Id: <1246548607.2480.3.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First email didn't go out to the list, sorry.

Here is version 3 of the setfiles to fts patch.

It turns out setting the FTS_XDEV flag tells fts not to descend into 
directories with different device numbers, but fts will still give back the
actual directory.  I think nftw would completely avoid the directories as well
as their contents.

This patch fixed this issue by saving the device number of the directory
that was passed to setfiles and then skipping all action on any directories
with a different device number when the FTS_XDEV flag is set.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---
diff -up setfiles/Makefile.old setfiles/Makefile
--- setfiles/Makefile.old	2009-06-30 15:28:17.031437301 -0400
+++ setfiles/Makefile	2009-06-30 15:08:11.057436336 -0400
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
diff -up setfiles/setfiles.c.old setfiles/setfiles.c
--- setfiles/setfiles.c.old	2009-06-30 15:28:24.899436710 -0400
+++ setfiles/setfiles.c	2009-07-02 11:23:19.805525618 -0400
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
 
@@ -292,22 +293,10 @@ static int exclude(const char *file)
 
 int match(const char *name, struct stat *sb, char **con)
 {
-	int ret;
 	char path[PATH_MAX + 1];
 
-	if (excludeCtr > 0) {
-		if (exclude(name)) {
-			return -1;
-		}
-	}
-	ret = lstat(name, sb);
-	if (ret) {
-		if (ignore_enoent && errno == ENOENT)
-			return 0;
-		fprintf(stderr, "%s:  unable to stat file %s: %s\n", progname,
-			name, strerror(errno));
-		return -1;
-	}
+
+	
 
 	if (expand_realpath) {
 		if (S_ISLNK(sb->st_mode)) {
@@ -425,22 +414,14 @@ static int only_changed_user(const char 
 	return (strcmp(rest_a, rest_b) == 0);
 }
 
-static int restore(const char *file)
+static int restore(FTSENT *ftsent)
 {
-	char *my_file = strdupa(file);
-	struct stat my_sb;
+	char *my_file = strdupa(ftsent->fts_path);
 	int ret;
 	char *context, *newcon;
 	int user_only_changed = 0;
-	size_t len = strlen(my_file);
-
-	/* Skip the extra slashes at the beginning and end, if present. */
-	if (file[0] == '/' && file[1] == '/')
-		my_file++;
-	if (len > 1 && my_file[len - 1] == '/')
-		my_file[len - 1] = 0;
 
-	if (match(my_file, &my_sb, &newcon) < 0)
+	if (match(my_file, ftsent->fts_statp, &newcon) < 0)
 		/* Check for no matching specification. */
 		return (errno == ENOENT) ? 0 : -1;
 
@@ -463,7 +444,9 @@ static int restore(const char *file)
 	 * then use the last matching specification.
 	 */
 	if (add_assoc) {
-		ret = filespec_add(my_sb.st_ino, newcon, my_file);
+
+//		printf("file: %s, ino: %d\n", my_file, (int)ftsent->fts_statp->st_ino);
+		ret = filespec_add(ftsent->fts_statp->st_ino, newcon, my_file);
 		if (ret < 0)
 			goto err;
 
@@ -477,7 +460,7 @@ static int restore(const char *file)
 	}
 
 	/* Get the current context of the file. */
-	ret = lgetfilecon_raw(my_file, &context);
+	ret = lgetfilecon_raw(ftsent->fts_accpath, &context);
 	if (ret < 0) {
 		if (errno == ENODATA) {
 			context = NULL;
@@ -545,46 +528,43 @@ static int restore(const char *file)
 	/*
 	 * Relabel the file to the specified context.
 	 */
-	ret = lsetfilecon(my_file, newcon);
+	ret = lsetfilecon(ftsent->fts_accpath, newcon);
 	if (ret) {
 		fprintf(stderr, "%s set context %s->%s failed:'%s'\n",
 			progname, my_file, newcon, strerror(errno));
-		goto out;
+		goto skip;
 	}
       out:
 	freecon(newcon);
 	return 0;
+      skip:
+	freecon(newcon);
+	return SKIP; 
+
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
+static int apply_spec(FTSENT *ftsent)
+{
+	if (ftsent->fts_info == FTS_DNR) {
 		fprintf(stderr, "%s:  unable to read directory %s\n",
-			progname, file);
-		return 0;
+			progname, ftsent->fts_path);
+		return SKIP;
 	}
 
-	errors |= restore(file);
-	if (abort_on_error && errors)
-		return -1;
-	return 0;
+	int rc = restore(ftsent);
+	if (rc == ERR) {
+		if(!abort_on_error) 
+			return SKIP;
+	}		
+	return rc;
 }
 
 void set_rootpath(const char *arg)
@@ -626,68 +606,51 @@ int canoncon(char **contextp)
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
-
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
-		}
-	} else {
-		rc = restore(name);
-		if (rc)
+	
+	dev_t dev_ino = 0;
+	FTSENT *ftsent;
+	// Read the first one
+	if ((ftsent = fts_read(fts_handle)) != NULL){
+		// Keep the inode of the first one.
+		dev_ino = ftsent->fts_statp->st_dev;
+	}
+
+	do {
+		// Skip the post order nodes.
+		if (ftsent->fts_info == FTS_DP)
+			continue;
+		// If the XDEV flag is set and the inode is different from the top directory
+		if (ftsent->fts_statp->st_dev != dev_ino && FTS_XDEV == (fts_flags & FTS_XDEV))
+			continue;
+		if (excludeCtr > 0) {
+			if (exclude(ftsent->fts_path)) {
+				fts_set(fts_handle, ftsent, FTS_SKIP);
+				continue;
+			}
+		}
+		int rc = apply_spec(ftsent);
+		if (rc == SKIP)
+			fts_set(fts_handle, ftsent, FTS_SKIP);
+		if (rc == ERR)
 			goto err;
-	}
+		if (!recurse)
+			break;
+	} while ((ftsent = fts_read(fts_handle)) != NULL);
 
 	if (!strcmp(name, "/"))
 		mass_relabel_errs = 0;
@@ -698,8 +661,9 @@ out:
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
@@ -777,7 +741,7 @@ int main(int argc, char **argv)
 		expand_realpath = 0;
 		abort_on_error = 1;
 		add_assoc = 1;
-		nftw_flags = FTW_PHYS | FTW_MOUNT;
+		fts_flags = FTS_PHYSICAL | FTS_XDEV;
 		ctx_validate = 1;
 	} else {
 		/*
@@ -796,7 +760,7 @@ int main(int argc, char **argv)
 		expand_realpath = 1;
 		abort_on_error = 0;
 		add_assoc = 0;
-		nftw_flags = FTW_PHYS;
+		fts_flags = FTS_PHYSICAL;
 		ctx_validate = 0;
 
 		/* restorecon only:  silent exit if no SELinux.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
