Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKKOgA017534
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:20:24 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JKGDDf025833
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 20:16:13 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKGqRH016647
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:16:52 -0400 (EDT)
Subject: Re: [RFC]{Patch 1/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1115825393.28084.28.camel@moss-huskies.epoch.ncsc.mil>
References: <1115825393.28084.28.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-5sDN7Atpp6xFDkhDiIxA"
Date: Thu, 19 May 2005 16:17:39 -0400
Message-Id: <1116533859.22044.16.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-5sDN7Atpp6xFDkhDiIxA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New patch for per-user support.

http://www.flux.utah.edu/~sds/libselinux-1.23.10-1.poly.1.src.rpm
> 

On Wed, 2005-05-11 at 11:29 -0400, Chad Sellers wrote:
> Attached is the patch to libselinux, as well as the diff of the rawhide
> spec file for the SRPM.  If you want to download a patched SRPM, it is
> available here:
> 
> http://www.flux.utah.edu/~sds/libselinux-1.23.10-1.poly.0.src.rpm
> 
> 
-- 
Chad Sellers
cdselle@tycho.nsa.gov

--=-5sDN7Atpp6xFDkhDiIxA
Content-Disposition: attachment; filename=libselinux-1.23.10-poly.patch
Content-Type: text/x-patch; name=libselinux-1.23.10-poly.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN libselinux-1.23.10.orig/include/selinux/selinux.h libselinux-1.23.10/include/selinux/selinux.h
--- libselinux-1.23.10.orig/include/selinux/selinux.h	2005-03-29 10:02:24.000000000 -0500
+++ libselinux-1.23.10/include/selinux/selinux.h	2005-05-18 13:27:03.000000000 -0400
@@ -307,6 +307,16 @@
    be relabeled . */
 extern int is_context_customizable (security_context_t scontext);
 
+/* Setup up namespace for polyinstatiated directory
+   If commit=0, just check to see if a new namespace
+   is necessary, returning 0 if not and greater if so.
+   If commit=1, modify the namespace. */
+extern int security_setupns(int commit, uid_t uid);
+
+/* set the printf function to be used for logging 
+   in security_setupns */
+extern void security_set_setupns_printf(void (*f)(const char *fmt, ...));
+
 #ifdef __cplusplus
 }
 #endif
diff -urN libselinux-1.23.10.orig/src/Makefile libselinux-1.23.10/src/Makefile
--- libselinux-1.23.10.orig/src/Makefile	2005-02-09 16:58:16.000000000 -0500
+++ libselinux-1.23.10/src/Makefile	2005-05-11 09:57:39.000000000 -0400
@@ -22,7 +22,7 @@
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -Wl,-soname,$(LIBSO),-z,defs
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -Wl,-soname,$(LIBSO),-z,defs
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h
diff -urN libselinux-1.23.10.orig/src/setupns.c libselinux-1.23.10/src/setupns.c
--- libselinux-1.23.10.orig/src/setupns.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.23.10/src/setupns.c	2005-05-19 15:30:42.000000000 -0400
@@ -0,0 +1,715 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <selinux/selinux.h>
+#include <limits.h>
+#include <dlfcn.h>
+#include <stdarg.h>
+#include <pwd.h>
+
+#define CONFIG_FILE "/etc/selinux/polydirs"
+#define SELINUX_KIND "selinux"
+#define USER_KIND "user"
+#define BOTH_KIND "both"
+#define MD5_DIGEST_LENGTH 16
+
+static void
+#ifdef __GNUC__
+__attribute__ ((format (printf, 1, 2)))
+#endif
+default_printf(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+}
+
+static void (*myprintf)(const char *fmt, ...) = &default_printf;
+
+void security_set_setupns_printf(void (*f)(const char *fmt, ...))
+{
+	myprintf = f;
+}
+
+/* Very simple linked list */
+struct myll {
+	struct myll *next;
+	char *this;
+};
+
+
+static int process_member(char *fname, char* kind, char* default_context, char* member_mode, int commit, uid_t uid, struct myll *exemptlist);
+
+static int do_mount(char* fname, security_context_t newcon, char* default_context, char* member_mode, char* kind, uid_t uid, struct myll *exemptlist);
+
+static int check_mounts(struct myll *conflist, int commit);
+
+/* Primary function to setup polyinstantiated namespace
+   If commit=0, just check to see if new namespace is
+   needed.  If commit=1, do it.  Returns 0 if no namespace
+   is necessary, and greater if it is. */
+int security_setupns(int commit, uid_t uid) {
+	char *buf[2], *myhome, *temp;
+	int ret, modified, token=0;
+	unsigned int i;
+	FILE *conf_file;
+	struct myll conflist;
+	struct myll *currnode, *oldnode;
+	struct myll exemptlist;
+	struct myll *currexempt;
+	size_t mylen=0, mylen2;
+	char* default_context = NULL;
+	char* member_mode = NULL;
+
+	buf[0] = NULL;
+	buf[1] = NULL;
+	if ((conf_file=fopen(CONFIG_FILE, "r")) == NULL) {
+		if (errno != ENOENT) {
+			myprintf("Error opening config file %s: %s\n",CONFIG_FILE,strerror(errno));
+			return -1;
+		}
+		return 0;
+	}
+	ret = 0;
+	currnode = &conflist;
+	currnode->this = NULL;
+	currexempt = &exemptlist;
+	currexempt->this = NULL;
+	currexempt->next = NULL;
+	while (getline(&buf[0], &mylen, conf_file) > 0) {
+		if (strlen(buf[0]) <= 0)
+			continue;
+		if (buf[0][strlen(buf[0])-1] == '\n')
+			buf[0][strlen(buf[0])-1] = '\0';
+		temp = buf[0];
+		mylen2 = strlen(buf[0])+1;
+		buf[1] = realloc(buf[1],mylen2);
+		if (!buf[1]) {
+			ret = -1;
+			goto out;
+		}
+		*buf[1] = '\0';
+		token=0;
+		for (i=0;i<mylen2;i++) {
+			if (*(buf[0]+i) == '\t' || *(buf[0]+i) == ' ') {
+				if (token%2 == 0)
+					continue;
+				*temp='\0';
+				temp = buf[1];
+				token=2;
+				continue;
+			}
+			if (*(buf[0]+i) == '#') {
+				*temp = '\0';
+				break;
+			}
+			if (token == 0)
+				token=1;
+			*temp = *(buf[0]+i);
+			temp++;
+		}
+		if (strlen(buf[0]) < 1 || strlen(buf[1]) < 1)
+			continue;
+		if (strcmp(buf[0],"default_context") == 0) {
+			default_context = strdup(buf[1]);
+			if (default_context == NULL) {
+				ret = -1;
+				goto out;
+			}
+			continue;
+		}
+		if (strcmp(buf[0],"member_mode") == 0) {
+			member_mode = strdup(buf[1]);
+			if (member_mode == NULL) {
+				ret = -1;
+				goto out;
+			}
+			continue;
+		}
+		if (strcmp(buf[0],"exempt_user") == 0) {
+			if (currexempt->this != NULL) {
+				currexempt->next = malloc(sizeof(struct myll));
+				if (!(currexempt->next)) {
+					ret = -1;
+					goto out;
+				}
+				currexempt = currexempt->next;
+				currexempt->this = NULL;
+				currexempt->next = NULL;
+			}
+			currexempt->this = malloc(strlen(buf[1])+2);
+			if (!(currexempt->this)) {
+				ret = -1;
+				goto out;
+			}
+			strncpy(currexempt->this,buf[1],strlen(buf[1])+2);
+			continue;
+		}
+		if (strcmp(buf[0], "$HOME") == 0) {
+			myhome = getenv("HOME");
+			if (myhome == NULL)
+				continue;
+			if ((strlen(myhome)+1) > mylen) {
+				mylen = strlen(myhome)+1;
+				buf[0] = realloc(buf[0],mylen);
+				if (!buf[0]) {
+					ret = -1;
+					goto out;
+				}
+			}
+			strncpy(buf[0],myhome,mylen);
+		}
+		if (currnode->this != NULL) {
+			currnode->next = malloc(sizeof(struct myll));
+			if (!(currnode->next)) {
+				ret = -1;
+				goto out;
+			}
+			currnode = currnode->next;
+			currnode->this = NULL;
+			currnode->next = NULL;
+		}
+		currnode->this = malloc(strlen(buf[0])+2);
+		if (!(currnode->this)) {
+			ret = -1;
+			goto out;
+		}
+		strncpy(currnode->this,buf[0],strlen(buf[0])+2);
+		modified = process_member(buf[0], buf[1], default_context, member_mode, commit, uid, &exemptlist);
+		if (modified < 0) {
+			myprintf("Failed to process config file entry: %s\n",buf[0]);
+		}
+		else {
+			ret += modified;
+		}
+	}
+	currnode->next = NULL;
+	currexempt->next = NULL;
+	modified = check_mounts(&conflist, commit);
+	if (modified < 0)  {
+		myprintf("Failed to clean up previous namespace\n");
+	}
+	else {
+		ret += modified;
+	}
+out:
+	free(buf[0]);
+	free(buf[1]);
+	free(default_context);
+	free(member_mode);
+	fclose(conf_file);
+	free((&conflist)->this);
+	currnode = (&conflist)->next;
+	while (currnode != NULL) {
+		oldnode = currnode;
+		currnode = currnode->next;
+		free(oldnode->this);
+		free(oldnode);
+	}
+	free((&exemptlist)->this);
+	currnode = (&exemptlist)->next;
+	while (currnode != NULL) {
+		oldnode = currnode;
+		currnode = currnode->next;
+		free(oldnode->this);
+		free(oldnode);
+	}
+	return ret;
+}
+
+/* Find out what polyinstantiated subdirectory is in use
+   polydir should be a buffer of size PATH_MAX that will
+   	contain the path of the subdirectory
+   fname should be the path of the directory that is 
+   	being polyinstantiated
+   newcon should be the context that should be used
+   This returns 0 if successful, -1 if not */
+static int get_polydir(char *polydir, char *fname, security_context_t newcon, char *kind, uid_t uid) {
+	unsigned char digest[MD5_DIGEST_LENGTH], *temp=NULL, *temp2;
+	char *subdir=NULL, *origdir=NULL, *c=NULL, *to, *myfname=NULL, *error;
+	int i, ret=0;
+	void *handle;
+	unsigned char* (*MD5) (const unsigned char *, unsigned long, unsigned char *);
+
+	origdir = malloc(PATH_MAX);
+	if (!origdir) {
+		ret = -1;
+		goto out;
+	}
+	myfname = strdup(fname);
+	if (!myfname) {
+		ret = -1;
+		goto out;
+	}
+	c = strrchr(myfname, '/');
+	if ( !c) {
+		myprintf("Error: Directory entry %s in config file is not a full path\n", fname);
+		ret = -1;
+		goto out;
+	}
+	*c = '\0';
+	snprintf(origdir,PATH_MAX,"%s/.%s-poly-orig",myfname,(c+1));
+	*c = '/';
+	handle = dlopen("libssl.so",RTLD_LAZY);
+	if (!handle) {
+		myprintf("Error opening libssl: %s\n", dlerror());
+		ret = -1;
+		goto out;
+	}
+	dlerror();
+	*(void **) (&MD5) = dlsym(handle, "MD5");
+	if ((error = dlerror()) != NULL) {
+		myprintf("Error in libssl MD5: %s\n", error);
+		ret = -1;
+		goto out;
+	}
+	if (strcmp(kind,SELINUX_KIND) == 0) {
+		(*MD5)((unsigned char*)newcon,strlen((char*)newcon),digest);
+	}
+	else if (strcmp(kind,USER_KIND) == 0) {
+		(*MD5)((unsigned char*)&uid,sizeof(uid),digest);
+	}
+	else if (strcmp(kind,BOTH_KIND) == 0) {
+		temp = malloc(strlen((char*)newcon)+sizeof(uid));
+		if (!temp) {
+			ret = -1;
+			goto out;
+		}
+		temp2 = (unsigned char*) stpcpy((char*)temp,(char*)newcon);
+		memcpy(temp2,&uid,sizeof(uid));
+		(*MD5)(temp,strlen((char*)newcon)+sizeof(uid),digest);
+	}
+	else {
+		myprintf("Error, kind of %s must be %s, %s, or %s\n", fname, SELINUX_KIND, USER_KIND, BOTH_KIND);
+		ret = -1;
+		goto out;
+	}
+	dlclose(handle);
+	subdir = malloc(MD5_DIGEST_LENGTH*2+1);
+	if (!subdir) {
+		ret = -1;
+		goto out;
+	}
+	memset(subdir,0,MD5_DIGEST_LENGTH*2+1);
+	c = malloc(3);
+	if (!c) {
+		ret = -1;
+		goto out;
+	}
+	to = subdir;
+	for (i=0;i<MD5_DIGEST_LENGTH;i++) {
+		snprintf(c,3,"%02x",(unsigned int)digest[i]);
+		to = stpcpy(to,c);
+	}
+	snprintf(polydir, PATH_MAX, "%s/.poly-%s",origdir,subdir);
+out:
+	free(temp);
+	free(c);
+	free(subdir);
+	free(myfname);
+	free(origdir);
+	return ret;
+}
+
+static int getorigcon(char *fname, char* kind, security_context_t *filecon);
+
+/* Processes an individual entry from the config file */
+static int process_member(char *fname, char* kind, char* default_context, char* member_mode, int commit, uid_t uid, struct myll *exemptlist) {
+	int ret;
+	security_context_t scon=NULL, tcon=NULL, origcon=NULL, newcon=NULL;
+	security_class_t tclass;
+	
+	ret = 0;
+	if (*fname != '/') {
+		myprintf("Directory %s is not fully qualified\n",fname);
+		ret = -1;
+		goto out;
+	}
+	if (strcmp(kind,SELINUX_KIND) == 0 || (strcmp(kind,BOTH_KIND) == 0)) {
+		ret = getorigcon(fname, kind, &origcon);
+		if (ret<0)
+			goto out;
+		tclass = string_to_security_class("dir");
+		getexeccon(&scon);
+		if (scon == NULL) {
+			ret = -1;
+			goto out;
+		}
+		if (getfilecon(fname, &tcon) < 0) {
+			ret = -1;;
+			goto out;
+		}
+		if (security_compute_member(scon, origcon, tclass, &newcon) < 0) {
+			myprintf("Error computing member for %s\n",fname);
+			ret = -1;
+			goto out;
+		}
+		if (strcmp(tcon, newcon) != 0) {
+			ret = 1;
+		}
+	}
+	if ((strcmp(kind,USER_KIND) == 0) || (strcmp(kind,BOTH_KIND) == 0)) {
+		ret = 1;
+	}
+	else if (strcmp(kind,SELINUX_KIND) != 0) {
+		myprintf("Error, kind of %s must be %s, %s, or %s\n", fname, SELINUX_KIND, USER_KIND, BOTH_KIND);
+		ret = -1;
+		goto out;
+	}
+	if (ret>0 && commit) {
+		if (do_mount(fname, newcon, default_context, member_mode, kind, uid, exemptlist) < 0)
+			ret = -1;
+	}
+out:
+	freecon(newcon);
+	freecon(tcon);
+	freecon(scon);
+	freecon(origcon);
+	return ret;
+}
+
+static int check_path(char *fname, char *newfile, char *origdir, security_context_t newcon, char *member_mode, char *kind, uid_t uid);
+
+/* Mount the polyinstantiated directory, and mount the original
+   under ../.<name>-poly-orig for security aware (and allowed) apps */
+static int do_mount(char *fname, security_context_t newcon, char* default_context, char* member_mode, char* kind, uid_t uid, struct myll *exemptlist) {
+	char *polydir=NULL, *origdir=NULL, *myfname=NULL;
+	char *c;
+	int ret;
+	security_context_t origcon=NULL, polycon=NULL, tempcon=NULL;
+	struct myll *currnode;
+	struct passwd mypwd;
+	struct passwd *pwd=&mypwd, *temppwd;
+	char *pwdbuf=NULL;
+	int pwdbuflen=500;
+
+	origdir = malloc(PATH_MAX);
+	if (!origdir) {
+		ret = -1;
+		goto out;
+	}
+	myfname = strdup(fname);
+	if (!myfname) {
+		ret = -1;
+		goto out;
+	}
+	c = strrchr(myfname, '/');
+	if ( !c) {
+		myprintf("Error: Directory entry %s in config file is not a full path\n", fname);
+		ret = -1;
+		goto out;
+	}
+	*c = '\0';
+	snprintf(origdir,PATH_MAX,"%s/.%s-poly-orig",myfname,(c+1));
+	*c = '/';
+	if (strcmp(kind,USER_KIND) != 0) {
+		if (getfscreatecon(&tempcon) < 0) {
+			ret = -1;
+			goto out;
+		}
+	}
+	ret = getorigcon(fname, kind, &origcon);
+	if (ret < 0)
+		goto out;
+	else if (ret == 0) {
+		if (strcmp(kind,USER_KIND) != 0) {
+			if (setfscreatecon((security_context_t) default_context) != 0)
+				myprintf("Couldn't setfscreatecon %s, continuing anyway\n", default_context);
+		}
+		if (mkdir(origdir, 000) < 0) {
+			if (errno != EEXIST) {
+				myprintf("Error making directory %s: %s\n",origdir,strerror(errno));
+				ret = -1;
+				if (strcmp(kind,USER_KIND) != 0)
+					setfscreatecon(tempcon);
+				goto out;
+			}
+		}
+		if (strcmp(kind,USER_KIND) != 0)
+			setfscreatecon(tempcon);
+		if (mount(fname, origdir, NULL, MS_BIND, NULL) < 0) {
+			myprintf("%s bind mount failed: %s\n", origdir, strerror(errno));
+			ret = -1;
+			goto out;
+		}
+	}
+	polydir = malloc(PATH_MAX);
+	if (!polydir) {
+		ret = -1;
+		goto out;
+	}
+	if (strcmp(kind,SELINUX_KIND) != 0) {
+		pwdbuflen = (int) sysconf(_SC_GETPW_R_SIZE_MAX);
+		pwdbuf = malloc(pwdbuflen);
+		if (!pwdbuf) {
+			ret = -1;
+			goto out;
+		}
+		currnode = exemptlist;
+		if (currnode->this) {
+			while (currnode != NULL) {
+				if (getpwnam_r(currnode->this,pwd,pwdbuf,pwdbuflen,&temppwd) != 0)
+					break;
+				currnode = currnode->next;
+				if (!pwd)
+					continue;
+				if (pwd->pw_uid == uid) {
+					if ((strcmp(kind,USER_KIND) == 0) || (strcmp(kind,BOTH_KIND)==0 && strcmp(newcon,origcon) == 0) ) {
+						ret = 2;
+					}
+					break;
+				}
+			}
+		}
+	}
+	else if (strcmp(newcon,origcon) == 0) {
+		ret = 2;
+	}
+	if (ret == 2) {
+		strncpy(polydir,origdir,PATH_MAX);
+		ret = 0;
+	}
+	else {
+		if (get_polydir(polydir, fname, newcon, kind, uid) < 0) {
+			ret = -1;
+			goto out;
+		}
+		ret = check_path(fname, polydir, origdir, newcon, member_mode, kind, uid);
+	}
+	if (strcmp(kind,USER_KIND)!=0) {
+		if (getfilecon(polydir, &polycon) < 0) {
+			ret = -1;
+			goto out;
+		}
+		else if (strcmp(newcon,polycon) != 0) {
+			myprintf("SECURITY ALERT: polyinstantiated directory for %s should \
+			be of type %s, but is of type %s.\n",fname,(char*)newcon,(char*)polycon);
+			ret = -1;
+			goto out;
+		}
+	}
+	if (ret == 0) {
+		if (mount(polydir, fname, NULL, MS_BIND, NULL) < 0) {
+			myprintf("%s bind mount failed: %s\n", polydir, strerror(errno));
+			ret = -1;
+		}
+	}
+out:
+	free(pwdbuf);
+	freecon(origcon);
+	free(polydir);
+	freecon(polycon);
+	free(origdir);
+	freecon(tempcon);
+	free(myfname);
+	return ret;
+}
+
+/* Make sure a polyinstantiated path is valid, create it if not */
+static int check_path(char *fname, char *newfile, char *origdir, security_context_t newcon, char *member_mode, char *kind, uid_t uid) {
+	int ret;
+	struct stat mystat;
+	security_context_t tempcon;
+	
+	ret = stat(newfile, &mystat);
+	if (ret < 0 && errno == ENOENT) {
+		ret = stat(fname, &mystat);
+		if (ret < 0) {
+			myprintf("Error: Directory %s inaccessible: %s\n", fname, strerror(errno));
+			return -1;
+		}
+		ret = stat(origdir, &mystat);
+		if (ret < 0) {
+			myprintf("Error: Directory %s inaccessible: %s\n", origdir, strerror(errno));
+			return -1;
+		}
+		if (strcmp(kind,USER_KIND) != 0) {
+			if (getfscreatecon(&tempcon) < 0)
+				return -1;
+			setfscreatecon(newcon);
+		}
+		if (member_mode)
+			mystat.st_mode = (mode_t)strtol(member_mode, (char**)NULL, 8);
+		if (uid)
+			mystat.st_uid = uid;
+		ret = mkdir(newfile, mystat.st_mode);
+		if (strcmp(kind,USER_KIND) != 0)
+			setfscreatecon(tempcon);
+		chmod(newfile, mystat.st_mode);
+		chown(newfile, mystat.st_uid, mystat.st_gid);
+		if (strcmp(kind,USER_KIND) != 0)
+			freecon(tempcon);
+	}
+	return ret;
+}
+
+/* set filecon to context of original directory
+   return negative if error,
+   0 if original directory has not been bind mounted yet,
+   and 1 if original directory is already bind mounted
+*/
+static int getorigcon(char *fname, char* kind, security_context_t *filecon) {
+	char *buf=NULL, *origdir=NULL, *c, *myfname=NULL;
+	FILE *procmounts;
+	int ret=0;
+	size_t mylen=0;
+
+	if ((procmounts=fopen("/proc/mounts", "r")) == NULL)
+		return -1;
+	origdir = malloc(PATH_MAX);
+	if (!origdir) {
+		ret = -1;
+		goto out;
+	}
+	myfname = strdup(fname);
+	if (!myfname) {
+		ret = -1;
+		goto out;
+	}
+	c = strrchr(myfname, '/');
+	if ( !c) {
+		myprintf("Error: Directory entry %s in config file is not a full path\n", fname);
+		ret = -1;
+		goto out;
+	}
+	*c = '\0';
+	snprintf(origdir,PATH_MAX,"%s/.%s-poly-orig",myfname,(c+1));
+	*c = '/';
+	while (getline(&buf, &mylen, procmounts) > 0) {
+		if (strstr(buf, origdir) != NULL)
+			ret=1;
+		buf[0] = '\0';
+	}
+	if (strcmp(kind, USER_KIND) != 0) {
+		if (ret) {
+			if (getfilecon(origdir, filecon) < 0)
+				ret = -1;;
+		}
+		else {
+			if (getfilecon(fname, filecon) < 0)
+				ret = -1;
+		}
+	}
+out:
+	free(buf);
+	fclose(procmounts);
+	free(myfname);
+	free(origdir);
+	return ret;
+}
+
+static int check_mounts(struct myll *conflist, int commit) {
+	char *buf=NULL, *origdir=NULL, *prevmnt=NULL, *tempstr=NULL, *c, *d, *workingdir=NULL;
+	FILE *procmounts;
+	int myint;
+	int ret=0;
+	struct myll *currnode;
+	size_t mylen=0;
+
+	if ((procmounts=fopen("/proc/mounts", "r")) == NULL) {
+		myprintf("Failed to open /proc/mounts\n");
+		return -1;
+	}
+	origdir=malloc(PATH_MAX);
+	if (!origdir) {
+		ret = -1;
+		goto out;
+	}
+	prevmnt = malloc(PATH_MAX+2);
+	if (!prevmnt) {
+		ret = -1;
+		goto out;
+	}
+	prevmnt[0] = '\0';
+	tempstr = malloc(PATH_MAX+2);
+	if (!tempstr) {
+		ret = -1;
+		goto out;
+	}
+	tempstr[0] = '\0';
+	workingdir = malloc(PATH_MAX);
+	if (!workingdir) {
+		ret = -1;
+		goto out;
+	}
+	while (getline(&buf, &mylen, procmounts) > 0) {
+		currnode = conflist;
+		d = strstr(buf, "-poly-orig");
+		if (d != NULL) {
+			myint=0;
+			while (currnode != NULL) {
+				c = strrchr(currnode->this, '/');
+				if ( !c) {
+					myprintf("Error: Directory entry %s in config file is not a full path\n", currnode->this);
+					ret = -1;
+					goto out;
+				}
+				*c = '\0';
+				snprintf(origdir,PATH_MAX,"%s/.%s-poly-orig",currnode->this,(c+1));
+				*c = '/';
+				if (strstr(buf, origdir) != NULL) {
+					myint+=1;
+				}
+				currnode = currnode->next;
+			}
+			if (myint == 0) { /* Previously polyinstantiated directory not covered */
+				ret++;
+				if (commit) {
+					*d = '\0';
+					c = strrchr(buf,'/') + 2;
+					if ( !c) {
+						myprintf("Error: /proc/mounts doesn't look like it should, bailing\n");
+						ret = -1;
+						goto out;
+					}
+					strncpy(origdir, c, PATH_MAX);
+					*d = '-';
+					c-=2;
+					*c = '\0';
+					d = strrchr(buf, ' ') + 1;
+					if ( !d) {
+						myprintf("Error: /proc/mounts doesn't look like it should, bailing\n");
+						ret = -1;
+						goto out;
+					}
+					strncpy(tempstr, d, PATH_MAX);
+					*c = '/';
+					c = strchr(d, ' ');
+					*c = '\0';
+					snprintf(prevmnt, PATH_MAX+2, "%s/%s",tempstr,origdir);
+					if (getcwd(workingdir, PATH_MAX) == NULL) {
+						strcpy(workingdir, "/");
+					}
+					chdir("/");
+					if (umount(prevmnt) < 0) {
+					 	myprintf("Failed to umount %s: %s\n",prevmnt, errno);
+						ret = -1;
+						goto out;
+					}
+					if (umount(d) < 0) {
+					 	myprintf("Failed to umount %s: %s\n",d, errno);
+						ret = -1;
+						goto out;
+					}
+					*c = ' ';
+					chdir(workingdir);
+				}
+			}
+		}
+	}
+out:
+	fclose(procmounts);
+	free(origdir);
+	free(buf);
+	free(prevmnt);
+	free(tempstr);
+	free(workingdir);
+	return ret;
+}
+
diff -urN libselinux-1.23.10.orig/utils/setupns.c libselinux-1.23.10/utils/setupns.c
--- libselinux-1.23.10.orig/utils/setupns.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.23.10/utils/setupns.c	2005-05-18 13:40:18.000000000 -0400
@@ -0,0 +1,134 @@
+#include <unistd.h>
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include <sys/wait.h>
+#include <selinux/selinux.h>
+#include <string.h>
+#include <limits.h>
+
+#include <linux/unistd.h>
+#define CLONE_NEWNS 0x00020000 /* Flag to create new namespace */
+static inline _syscall2 (int, clone, int, flags, int, arg)
+
+char *progname;
+
+void usage(int rc) 
+{
+	fprintf(stderr, "usage:  %s [-X] unixuser context\n", progname);
+	exit(rc);
+}
+
+int main(int argc, char **argv)
+{
+	struct passwd *pwd;
+	int rc, pid, setup_x11 = 0;
+
+	progname = argv[0];
+
+	while ((rc = getopt(argc, argv, "X?h")) != -1) {
+		switch (rc) {
+		case 'X':
+			setup_x11 = 1;
+			break;
+		default:
+			usage(0);
+		}
+	}
+
+	if (optind != (argc - 2))
+		usage(1);
+
+	pwd = getpwnam(argv[optind]);
+	if (!pwd) {
+		fprintf(stderr, "%s is not defined in passwd.\n", argv[optind]);
+		exit(1);
+	}
+	
+	rc = setenv("HOME", pwd->pw_dir, 1);
+	if (rc < 0) {
+		fprintf(stderr, "Unable to set $HOME for %s to %s\n", argv[optind],
+			pwd->pw_dir);
+		exit(1);
+	}
+
+	optind++;
+
+	rc = setexeccon(argv[optind]);
+	if (rc < 0) {
+		fprintf(stderr, "setexeccon(%s):  %s\n", argv[optind], strerror(errno));
+		exit(1);
+	}
+
+	rc = security_setupns(0,pwd->pw_uid);
+	if (rc < 0) {
+		perror("security_setupns");
+		exit(1);
+	}
+	if (rc == 0) {
+		printf("No polyinstantiation required.");
+		exit(0);
+	}
+	pid = clone(CLONE_NEWNS|SIGCHLD, 0);
+	if (pid < 0) {
+		perror("clone");
+		exit(1);
+	}
+	if (!pid) {
+		security_setupns(1,pwd->pw_uid);
+		if (setup_x11) {
+			/* Copy the .Xauthority file into the user's new home directory */
+			FILE *xauthfile, *newxauthfile;
+			int myrc, mywc;
+			char *c;
+			char *polyfname=NULL, *polypath=NULL, *xdirfname=NULL;
+			polyfname = malloc(PATH_MAX);
+			if (!polyfname)
+				goto polyend;
+			polypath = getenv("HOME");
+			if (!polypath)
+				goto polyend;
+			c = strrchr(polypath,'/');
+			*c = '\0';
+			snprintf(polyfname, PATH_MAX, "%s/.%s-poly-orig/.Xauthority",polypath,(c+1));
+			*c = '/';
+			xauthfile = fopen(polyfname, "r");
+			if (xauthfile != NULL) {
+				snprintf(polyfname, PATH_MAX, "%s/.Xauthority",polypath);
+				newxauthfile = fopen(polyfname, "w");
+				if (newxauthfile != NULL) {
+					while (!feof(xauthfile) && !ferror(xauthfile)) {
+						myrc=fread(polyfname, 1, PATH_MAX, xauthfile);
+						mywc=0;
+						while (myrc > mywc) {
+							mywc+=fwrite((polyfname+mywc), 1, (myrc-mywc), newxauthfile);
+							if (ferror(newxauthfile))
+								break;
+						}
+					}
+					fclose(newxauthfile);
+				}
+				fclose(xauthfile);
+			}
+			/* Link /tmp/.X11-unix to poly directory */
+			xdirfname = malloc(PATH_MAX);
+			if (!xdirfname)
+				goto polyend;
+			sprintf(xdirfname, "/tmp/.X11-unix");
+			sprintf(polyfname, "/.tmp-poly-orig/.X11-unix");
+			symlink(polyfname,xdirfname);
+polyend:
+			free(xdirfname);
+			free(polyfname);
+		}
+		execl("/bin/bash", "bash", NULL);
+		perror("execl");
+		exit(1);
+	}
+	waitpid(pid, &rc, 0);
+	exit(rc);	
+}

--=-5sDN7Atpp6xFDkhDiIxA
Content-Disposition: attachment; filename=libselinux.spec.diff
Content-Type: text/x-patch; name=libselinux.spec.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- libselinux.spec.orig	2005-05-04 11:16:57.000000000 -0400
+++ libselinux.spec	2005-05-19 15:39:26.000000000 -0400
@@ -1,10 +1,11 @@
 Summary: SELinux library and simple utilities
 Name: libselinux
 Version: 1.23.10
-Release: 1
+Release: 1.poly.1
 License: Public domain (uncopyrighted)
 Group: System Environment/Libraries
 Source: http://www.nsa.gov/selinux/archives/%{name}-%{version}.tgz
+Patch: libselinux-1.23.10-poly.patch
 BuildRoot: %{_tmppath}/%{name}-%{version}-buildroot
 
 %description
@@ -33,6 +34,7 @@
 
 %prep
 %setup -q
+%patch -p1
 
 %build
 make CFLAGS="%{optflags}"

--=-5sDN7Atpp6xFDkhDiIxA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
