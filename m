Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89Gr9rT013058
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 12:53:09 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89GqBo5015973
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 16:52:16 GMT
Message-ID: <41408A5E.8090001@redhat.com>
Date: Thu, 09 Sep 2004 12:52:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Proposed Hardware File Context file.
References: <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil> <41377DD5.8010500@redhat.com> <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil> <41377F4B.3010608@redhat.com> <1094167821.24091.25.camel@nexus.verbum.private> <1094210883.19206.2.camel@moss-spartans.epoch.ncsc.mil> <20040903131751.GC30562@lkcl.net> <1094218416.19206.116.camel@moss-spartans.epoch.ncsc.mil> <20040903143808.GA26568@lkcl.net> <1094228921.19206.228.camel@moss-spartans.epoch.ncsc.mil> <20040903170348.GA1116@lkcl.net>
In-Reply-To: <20040903170348.GA1116@lkcl.net>
Content-Type: multipart/mixed;
 boundary="------------000003090603070201060808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000003090603070201060808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

First pass at patches.

libselinux-mediacon.patch adds matchmediapath function to libselinux.
udev-selinux.patch adds selinux support including matchmediapath to udev.

cat /etc/selinux/strict/contexts/files/media
cdrom system_u:object_r:removable_device_t
floppy system_u:object_r:removable_device_t




--------------000003090603070201060808
Content-Type: text/plain;
 name="libselinux-mediacon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-mediacon.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.17.9/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2004-09-02 08:48:12.000000000 -0400
+++ libselinux-1.17.9/include/selinux/selinux.h	2004-09-09 11:56:46.282856298 -0400
@@ -173,6 +173,13 @@
 		 mode_t mode,
 		 security_context_t *con);
 
+/* Match the specified media and against the media contexts 
+   /proc/ide/hdc/media
+   configuration and set *con to refer to the resulting context.
+   Caller must free con via freecon. */
+extern int matchmediacon(const char *path,
+		 security_context_t *con);
+
 /*
   selinux_getenforcemode reads the /etc/selinux/config file and determines 
   whether the machine should be started in enforcing (1), permissive (0) or 
@@ -194,6 +201,7 @@
 extern const char *selinux_default_context_path(void);
 extern const char *selinux_user_contexts_path(void);
 extern const char *selinux_file_context_path(void);
+extern const char *selinux_media_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_booleans_path(void);
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compat_file_path.h libselinux-1.17.9/src/compat_file_path.h
--- nsalibselinux/src/compat_file_path.h	2004-08-30 11:46:49.000000000 -0400
+++ libselinux-1.17.9/src/compat_file_path.h	2004-09-09 11:50:20.280015702 -0400
@@ -7,3 +7,4 @@
 S_(FAILSAFE_CONTEXT, SECURITYDIR "/failsafe_context")
 S_(DEFAULT_TYPE, SECURITYDIR "/default_type")
 S_(BOOLEANS, SECURITYDIR "/booleans")
+S_(MEDIA_CONTEXTS, SECURITYDIR "/default_media")
diff --exclude-from=exclude -N -u -r nsalibselinux/src/file_path_suffixes.h libselinux-1.17.9/src/file_path_suffixes.h
--- nsalibselinux/src/file_path_suffixes.h	2004-08-30 11:46:50.000000000 -0400
+++ libselinux-1.17.9/src/file_path_suffixes.h	2004-09-09 12:07:15.500872651 -0400
@@ -7,3 +7,4 @@
 S_(FAILSAFE_CONTEXT, "/contexts/failsafe_context")
 S_(DEFAULT_TYPE, "/contexts/default_type")
 S_(BOOLEANS, "/booleans")
+S_(MEDIA_CONTEXTS, "/contexts/files/media")
Binary files nsalibselinux/src/matchmediacon and libselinux-1.17.9/src/matchmediacon differ
diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchmediacon.c libselinux-1.17.9/src/matchmediacon.c
--- nsalibselinux/src/matchmediacon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.17.9/src/matchmediacon.c	2004-09-09 12:15:34.782753926 -0400
@@ -0,0 +1,65 @@
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <string.h>
+#include "selinux_internal.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <errno.h>
+#include <limits.h>
+#include <regex.h>
+#include <stdarg.h>
+
+int matchmediacon(const char *media, 
+		 security_context_t *con)
+{
+	const char *path = selinux_media_context_path();
+	FILE *infile;
+	char *ptr, *ptr2;
+	char *target;
+	int found=-1;
+	char current_line[PATH_MAX];
+	if ((infile = fopen(path, "r")) == NULL)
+		return -1;
+	while (!feof_unlocked (infile)) {
+		if (!fgets_unlocked(current_line, sizeof(current_line), infile)) {
+			return -1;
+		}
+		if (current_line[strlen(current_line) - 1])
+			current_line[strlen(current_line) - 1] = 0;
+		/* Skip leading whitespace before the partial context. */
+		ptr = current_line;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+		
+		if (!(*ptr))
+			continue;
+
+
+		/* Find the end of the media context. */
+		ptr2 = ptr;
+		while (*ptr2 && !isspace(*ptr2))
+			ptr2++;
+		if (!(*ptr2))
+			continue;
+		
+		*ptr2++=NULL;
+		if (strcmp (media, ptr) == 0) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) 
+		return -1;
+
+	/* Skip whitespace. */
+	while (*ptr2 && isspace(*ptr2))
+		ptr2++;
+	if (!(*ptr2)) {
+		return -1;
+	}
+	
+	*con = strdup(ptr2);
+	return 0;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.17.9/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2004-09-01 09:20:42.000000000 -0400
+++ libselinux-1.17.9/src/selinux_config.c	2004-09-09 11:51:09.481386978 -0400
@@ -24,7 +24,8 @@
 #define FAILSAFE_CONTEXT  5
 #define DEFAULT_TYPE      6
 #define BOOLEANS          7
-#define NEL               8
+#define MEDIA_CONTEXTS    8
+#define NEL               9
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -200,6 +201,10 @@
 }
 hidden_def(selinux_file_context_path)
 
+const char *selinux_media_context_path() {
+  return get_path(MEDIA_CONTEXTS);
+}
+
 const char *selinux_contexts_path() {
   return get_path(CONTEXTS_DIR);
 }
Binary files nsalibselinux/utils/a.out and libselinux-1.17.9/utils/a.out differ
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/matchmediacon.c libselinux-1.17.9/utils/matchmediacon.c
--- nsalibselinux/utils/matchmediacon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.17.9/utils/matchmediacon.c	2004-09-09 12:16:05.921191634 -0400
@@ -0,0 +1,28 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+#include <errno.h>
+#include <string.h>
+
+int main(int argc, char **argv) 
+{
+	char *buf;
+	int rc, i;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s media...\n", argv[0]);
+		exit(1);
+	}
+
+	for (i = 1; i < argc; i++) {
+		rc = matchmediacon(argv[i], &buf);
+		if (rc < 0) {
+			fprintf(stderr, "%s:dan  matchmediacon(%s) failed: %s\n", argv[0], argv[i]);
+			exit(2);
+		}
+		printf("%s\t%s\n", argv[i], buf);
+		freecon(buf);
+	}
+	exit(0);
+}

--------------000003090603070201060808
Content-Type: text/plain;
 name="udev-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="udev-selinux.patch"

--- udev-030/Makefile.selinux	2004-07-09 13:59:09.000000000 -0400
+++ udev-030/Makefile	2004-09-09 10:04:38.768495769 -0400
@@ -25,6 +25,8 @@
 # Leave this set to `false' for production use.
 DEBUG = false
 
+# Set this to compile with Security-Enhanced Linux support.
+USE_SELINUX = true
 
 ROOT =		udev
 DAEMON =	udevd
@@ -172,6 +174,11 @@
 
 CFLAGS += -I$(PWD)/libsysfs
 
+ifeq ($(strip $(USE_SELINUX)),true)
+	CFLAGS += -DUSE_SELINUX
+	LIB_OBJS += -lselinux
+endif
+
 all: $(ROOT) $(SENDER) $(DAEMON) $(INFO) $(TESTER) $(STARTER)
 	@extras="$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
@@ -216,6 +223,7 @@
 		udevdb.h	\
 		klibc_fixups.h	\
 		logging.h	\
+		selinux.h	\
 		list.h
 
 ifeq ($(strip $(USE_KLIBC)),true)
--- /dev/null	2004-09-08 12:05:11.032823824 -0400
+++ udev-030/selinux.h	2004-09-09 12:50:53.526365931 -0400
@@ -0,0 +1,119 @@
+#ifndef SELINUX_H
+#define SELINUX_H
+
+#ifndef USE_SELINUX
+
+static inline void selinux_setfilecon(char *file, unsigned int mode) { }
+static inline void selinux_setfscreatecon(char *file, unsigned int mode) {}
+static inline void selinux_init(void) {}
+static inline void selinux_restore(void) {}
+
+#else
+
+#include <selinux/selinux.h>
+#include <stdio.h>
+#include <limits.h>
+
+
+static int selinux_enabled=-1;
+static security_context_t prev_scontext=NULL;
+
+static inline int is_selinux_running(void) {
+	if ( selinux_enabled==-1 ) 
+		return selinux_enabled=is_selinux_enabled()>0;
+	return selinux_enabled;
+}
+
+static inline int selinux_get_media(char *path, int mode, char **media)
+{
+  FILE *fp;
+  char buf[PATH_MAX];
+  char mediabuf[PATH_MAX];
+  *media=NULL;
+  if (!( mode && S_IFBLK )) {
+	  return -1;
+  }
+  snprintf(buf,sizeof(buf), "/proc/ide/%s/media", basename(path));
+  fp=fopen(buf,"r");
+  if (fp) {
+    if (fgets(mediabuf,sizeof(mediabuf), fp)) 
+      *media=strdup(mediabuf);
+    fclose(fp);
+    return 0;
+  } else {
+    return -1;
+  }
+}
+
+static inline void selinux_setfilecon(char *file, unsigned int mode) { 
+	if (is_selinux_running()) {
+		security_context_t scontext=NULL;
+		char *media;
+		int ret=-1;
+		if (selinux_get_media(file, mode, &media) == 0) {
+			ret = matchmediacon(media, &scontext);
+			free(media);
+		} 
+		if (ret==-1) 
+			if (matchpathcon(file, mode, &scontext) < 0) {
+				dbg("matchpathcon(%s) failed\n", file);
+				return;
+			} 
+		if (setfilecon(file, scontext) < 0)
+			dbg("setfiles %s failed with error '%s'",
+			    file, strerror(errno));
+		freecon(scontext);
+	}
+}
+
+static inline void selinux_setfscreatecon(char *file, unsigned int mode) {
+	int retval = 0;
+	security_context_t scontext=NULL;
+
+	if (is_selinux_running()) {
+		char *media;
+		int ret=-1;
+		if (selinux_get_media(file, mode, &media) == 0) {
+			ret = matchmediacon(media, &scontext);
+			free(media);
+		} 
+		if (ret==-1) 
+			if (matchpathcon(file, mode, &scontext) < 0) {
+				dbg("matchpathcon(%s) failed\n", file);
+				return;
+			} 
+
+		retval=setfscreatecon(scontext);
+		if (retval < 0)
+			dbg("setfiles %s failed with error '%s'",
+			    file, strerror(errno));
+		freecon(scontext);
+	}
+}
+static inline void selinux_init(void) {
+	/* record the present security context, for file-creation
+	 * restoration creation purposes.
+	 *
+	 */
+
+	if (is_selinux_running())
+	{
+		if (getfscreatecon(&prev_scontext) < 0) {
+			dbg("getfscreatecon failed\n");
+		}
+		prev_scontext=NULL;
+	}
+}
+static inline void selinux_restore(void) {
+	if (is_selinux_running()) {
+		/* reset the file create context to its former glory */
+		if ( setfscreatecon(prev_scontext) < 0 )
+			dbg("setfscreatecon failed\n");
+		if (prev_scontext) {
+			freecon(prev_scontext);
+			prev_scontext=NULL;
+		}
+	}
+}
+#endif /* USE_SELINUX */
+#endif /* SELINUX_H */
--- udev-030/udev-add.c.selinux	2004-09-09 10:04:38.000000000 -0400
+++ udev-030/udev-add.c	2004-09-09 10:04:38.771495426 -0400
@@ -50,6 +50,8 @@
 
 #define LOCAL_USER "$local"
 
+#include "selinux.h"
+
 /* 
  * Right now the major/minor of a device is stored in a file called
  * "dev" in sysfs.
@@ -92,6 +94,7 @@
 			break;
 		*pos = 0x00;
 		if (stat(p, &stats)) {
+			selinux_setfscreatecon(p, S_IFDIR);
 			retval = mkdir(p, 0755);
 			if (retval != 0) {
 				dbg("mkdir(%s) failed with error '%s'",
@@ -99,6 +102,8 @@
 				return retval;
 			}
 			dbg("created '%s'", p);
+		} else {
+			selinux_setfilecon(p, S_IFDIR);
 		}
 		*pos = '/';
 	}
@@ -117,6 +122,7 @@
 	if (((stats.st_mode & S_IFMT) == S_IFBLK || (stats.st_mode & S_IFMT) == S_IFCHR) &&
 	    (stats.st_rdev == makedev(major, minor))) {
 		dbg("preserve file '%s', cause it has correct dev_t", file);
+		selinux_setfilecon(file,stats.st_mode);
 		if (udev_preserve_owner)
 		  goto exit;
 		else
@@ -129,6 +135,7 @@
 		dbg("already present file '%s' unlinked", file);
 
 create:
+	selinux_setfscreatecon(file, mode);
 	retval = mknod(file, mode, makedev(major, minor));
 	if (retval != 0) {
 		dbg("mknod(%s, %#o, %u, %u) failed with error '%s'",
@@ -307,6 +314,7 @@
 
 		dbg("symlink(%s, %s)", linktarget, filename);
 		if (!fake) {
+			selinux_setfscreatecon(filename, S_IFLNK);
 			unlink(filename);
 			if (symlink(linktarget, filename) != 0)
 				dbg("symlink(%s, %s) failed with error '%s'",
@@ -441,6 +449,7 @@
 
 	dbg("name='%s'", dev.name);
 
+	selinux_init();
 	switch (dev.type) {
 	case 'b':
 	case 'c':
@@ -478,6 +487,7 @@
 	}
 
 exit:
+	selinux_restore();
 	sysfs_close_class_device(class_dev);
 
 	return retval;

--------------000003090603070201060808--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
