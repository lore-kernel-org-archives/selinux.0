Message-ID: <430C75B4.3020008@redhat.com>
Date: Wed, 24 Aug 2005 09:27:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com>	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>	 <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil> <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010905070602040702050307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010905070602040702050307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I still want at least the set_comp diff to allow me to set level to 
NULL, so it does not show up.



-- 



--------------010905070602040702050307
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_relabel.c libselinux-1.25.3/src/compute_relabel.c
--- nsalibselinux/src/compute_relabel.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/compute_relabel.c	2005-08-24 09:13:57.000000000 -0400
@@ -20,6 +20,7 @@
 	size_t size;
 	int fd, ret;
 
+	*newcon=NULL;
 	snprintf(path, sizeof path, "%s/relabel", selinux_mnt);
 	fd = open(path, O_RDWR);
 	if (fd < 0)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_user.c libselinux-1.25.3/src/compute_user.c
--- nsalibselinux/src/compute_user.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/compute_user.c	2005-08-24 09:13:57.000000000 -0400
@@ -21,6 +21,7 @@
 	int fd, ret;
 	unsigned int i, nel;
 
+	*con = NULL;
 	snprintf(path, sizeof path, "%s/user", selinux_mnt);
 	fd = open(path, O_RDWR);
 	if (fd < 0)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/context.c libselinux-1.25.3/src/context.c
--- nsalibselinux/src/context.c	2005-08-22 16:37:00.000000000 -0400
+++ libselinux-1.25.3/src/context.c	2005-08-24 09:13:57.000000000 -0400
@@ -137,19 +137,23 @@
 
 static int set_comp(context_private_t* n,int index, const char *str)
 {
-        char *t = (char*) malloc(strlen(str)+1);
+        char *t = NULL;
         const char *p;
-        if ( !t ) { return 1; }
-        for ( p = str; *p; p++ ) {
-                if ( *p == '\t' || *p == ' ' || *p == '\n' || *p == '\r' ||
-                     (*p == ':' && index != COMP_RANGE) ) {
-                        free(t);
-                        return 1;
-                }
-        }
-        conditional_free(&n->component[index]);
+	if (str) {
+		t=(char*) malloc(strlen(str)+1);
+		if ( !t ) { return 1; }
+		for ( p = str; *p; p++ ) {
+			if ( *p == '\t' || *p == '\n' || *p == '\r' ||
+			     ((*p == ':' || *p == ' ') && index != COMP_RANGE) ) {
+				free(t);
+				return 1;
+			}
+		}
+	}
+	conditional_free(&n->component[index]);
+	if (str)
+		strcpy(t,str);
         n->component[index] = t;
-        strcpy(t,str);
         return 0;
 }
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/fgetfilecon.c libselinux-1.25.3/src/fgetfilecon.c
--- nsalibselinux/src/fgetfilecon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/fgetfilecon.c	2005-08-24 09:13:57.000000000 -0400
@@ -13,6 +13,7 @@
 	ssize_t size;
 	ssize_t ret;
 
+	*context = NULL;
 	size = INITCONTEXTLEN+1;
 	buf = malloc(size);
 	if (!buf) 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getcon.c libselinux-1.25.3/src/getcon.c
--- nsalibselinux/src/getcon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/getcon.c	2005-08-24 09:13:57.000000000 -0400
@@ -14,6 +14,7 @@
 	int fd;
 	ssize_t ret;
 
+	*context=NULL;
 	fd = open("/proc/self/attr/current", O_RDONLY);
 	if (fd < 0)
 		return -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getexeccon.c libselinux-1.25.3/src/getexeccon.c
--- nsalibselinux/src/getexeccon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/getexeccon.c	2005-08-24 09:13:57.000000000 -0400
@@ -14,6 +14,7 @@
 	int fd;
 	ssize_t ret;
 
+	*context = NULL;
 	fd = open("/proc/self/attr/exec", O_RDONLY);
 	if (fd < 0)
 		return -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c libselinux-1.25.3/src/getfilecon.c
--- nsalibselinux/src/getfilecon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/getfilecon.c	2005-08-24 09:15:03.000000000 -0400
@@ -13,6 +13,7 @@
 	ssize_t size;
 	ssize_t ret;
 
+ 	*context = NULL;
 	size = INITCONTEXTLEN+1;
 	buf = malloc(size);
 	if (!buf) 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfscreatecon.c libselinux-1.25.3/src/getfscreatecon.c
--- nsalibselinux/src/getfscreatecon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/getfscreatecon.c	2005-08-24 09:13:57.000000000 -0400
@@ -14,6 +14,7 @@
 	int fd;
 	ssize_t ret;
 
+	*context = NULL;
 	fd = open("/proc/self/attr/fscreate", O_RDONLY);
 	if (fd < 0)
 		return -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getpeercon.c libselinux-1.25.3/src/getpeercon.c
--- nsalibselinux/src/getpeercon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/getpeercon.c	2005-08-24 09:13:57.000000000 -0400
@@ -17,6 +17,7 @@
 	socklen_t size;
 	ssize_t ret;
 
+	*context = NULL;
 	size = INITCONTEXTLEN+1;
 	buf = malloc(size);
 	if (!buf) 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getpidcon.c libselinux-1.25.3/src/getpidcon.c
--- nsalibselinux/src/getpidcon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/getpidcon.c	2005-08-24 09:13:57.000000000 -0400
@@ -16,6 +16,7 @@
 	int fd;
 	ssize_t ret;
 
+	*context = NULL;
 	snprintf(path, sizeof path, "/proc/%d/attr/current", pid);
 
 	fd = open(path, O_RDONLY);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getprevcon.c libselinux-1.25.3/src/getprevcon.c
--- nsalibselinux/src/getprevcon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/getprevcon.c	2005-08-24 09:13:57.000000000 -0400
@@ -14,6 +14,7 @@
 	int fd;
 	ssize_t ret;
 
+	*context = NULL;
 	fd = open("/proc/self/attr/prev", O_RDONLY);
 	if (fd < 0)
 		return -1;
diff --exclude-from=exclude -N -u -r nsalibselinux/src/lgetfilecon.c libselinux-1.25.3/src/lgetfilecon.c
--- nsalibselinux/src/lgetfilecon.c	2005-08-24 09:07:11.000000000 -0400
+++ libselinux-1.25.3/src/lgetfilecon.c	2005-08-24 09:13:57.000000000 -0400
@@ -13,6 +13,7 @@
 	ssize_t size;
 	ssize_t ret;
 
+	*context = NULL;
 	size = INITCONTEXTLEN+1;
 	buf = malloc(size);
 	if (!buf) 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/trans.c libselinux-1.25.3/src/trans.c
--- nsalibselinux/src/trans.c	2005-08-23 13:34:34.000000000 -0400
+++ libselinux-1.25.3/src/trans.c	2005-08-24 09:13:57.000000000 -0400
@@ -6,8 +6,8 @@
 
 int trans_to_raw_context(char *raw, char **transp)
 {
+	*transp = NULL;
 	if (!raw) {
-		*transp = NULL;
 		return 0;
 	}
 
@@ -19,8 +19,8 @@
 
 int raw_to_trans_context(char *trans, char **rawp)
 {
+	*rawp = NULL;
 	if (!trans) {
-		*rawp = NULL;
 		return 0;
 	}
 
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getfilecon.c libselinux-1.25.3/utils/getfilecon.c
--- nsalibselinux/utils/getfilecon.c	2005-01-20 16:05:24.000000000 -0500
+++ libselinux-1.25.3/utils/getfilecon.c	2005-08-24 09:13:57.000000000 -0400
@@ -21,6 +21,9 @@
 		}
 		printf("%s\t%s\n", argv[i], buf);
 		freecon(buf);
+		rc = getfilecon_raw(argv[i], &buf);
+		printf("%s\t%s\n", argv[i], buf);
+		freecon(buf);
 	}
 	exit(0);
 }

--------------010905070602040702050307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
