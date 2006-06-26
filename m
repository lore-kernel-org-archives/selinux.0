Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5QGlrXV029269
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:53 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5QGlqgW000685
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 16:47:52 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5QGlpr0016507
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:51 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5QGlpls012423
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:51 -0400
Received: from vpn50-132.rdu.redhat.com (vpn50-132.rdu.redhat.com [172.16.50.132])
	by pobox.corp.redhat.com (8.12.8/8.12.8) with ESMTP id k5QGlpLp031539
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:51 -0400
Subject: [PATCH] libselinux: 2/2 Convert functions to use new get,set
	procattrcon
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 26 Jun 2006 12:48:58 -0400
Message-Id: <1151340538.21012.151.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The below patch will convert

-{get,set}fscreatecon()
-{get,set}execcon()
-{get,set}con()
-getpidcon()
-getprevcon()

to use the new {get,set}procattrcon() generic functions.  

setcon() had a special check if the context to be written was null and
returned -1 since you are not supposed to be able to set your own
context to null.  My testing showed that the special case was not needed
as the null context would be rejected anyway with -1; 

-Eric

 getcon.c         |   56 +++--------------------------------------------------
 getexeccon.c     |   58 +++----------------------------------------------------
 getfscreatecon.c |   58 +++----------------------------------------------------
 getpidcon.c      |   58 ++++++-------------------------------------------------
 getprevcon.c     |   53 +++-----------------------------------------------
 setcon.c         |   33 +++----------------------------
 setexeccon.c     |   33 +++----------------------------
 setfscreatecon.c |   35 ++++-----------------------------
 8 files changed, 36 insertions(+), 348 deletions(-)

--- libselinux-1.30.15/src/getfscreatecon.c.p2	2006-06-26 11:02:06.000000000 -0400
+++ libselinux-1.30.15/src/getfscreatecon.c	2006-06-26 11:07:49.000000000 -0400
@@ -1,64 +1,14 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
 #include "selinux_internal.h"
-#include "policy.h"
+
+#define FSCREATE_PROC_ENTRY "/proc/self/attr/fscreate"
 
 int getfscreatecon_raw(security_context_t *context)
 {
-	char *buf;
-	size_t size;
-	int fd;
-	ssize_t ret;
-
-	fd = open("/proc/self/attr/fscreate", O_RDONLY);
-	if (fd < 0)
-		return -1;
-
-	size = selinux_page_size;
-	buf = malloc(size);
-	if (!buf) {
-		ret = -1;
-		goto out;
-	}
-	memset(buf, 0, size);
-
-	ret = read(fd, buf, size-1);
-	if (ret < 0)
-		goto out2;
-
-	if (ret == 0) {
-		*context = NULL;
-		goto out2;
-	}
-
-	*context = strdup(buf);
-	if (!(*context)) {
-		ret = -1;
-		goto out2;
-	}
-	ret = 0;
-out2:			
-	free(buf);
-out:
-	close(fd);
-	return ret;
+	return getprocattrcon_raw(context, FSCREATE_PROC_ENTRY);
 }
 hidden_def(getfscreatecon_raw)
 
 int getfscreatecon(security_context_t *context)
 {
-	int ret;
-	security_context_t rcontext;
-
- 	ret = getfscreatecon_raw(&rcontext);
-
-	if (!ret) {
-		ret = selinux_raw_to_trans_context(rcontext, context);
-		freecon(rcontext);
-	} 
-
-	return ret;
+	return getprocattrcon(context, FSCREATE_PROC_ENTRY);
 }
--- libselinux-1.30.15/src/getexeccon.c.p2	2006-06-26 11:02:06.000000000 -0400
+++ libselinux-1.30.15/src/getexeccon.c	2006-06-26 11:10:37.000000000 -0400
@@ -1,64 +1,14 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
 #include "selinux_internal.h"
-#include "policy.h"
+
+#define EXEC_PROC_ENTRY "/proc/self/attr/exec"
 
 int getexeccon_raw(security_context_t *context)
 {
-	char *buf;
-	size_t size;
-	int fd;
-	ssize_t ret;
-
-	fd = open("/proc/self/attr/exec", O_RDONLY);
-	if (fd < 0)
-		return -1;
-
-	size = selinux_page_size;
-	buf = malloc(size);
-	if (!buf) {
-		ret = -1;
-		goto out;
-	}
-	memset(buf, 0, size);
-
-	ret = read(fd, buf, size-1);
-	if (ret < 0)
-		goto out2;
-
-	if (ret == 0) {
-		*context = NULL;
-		goto out2;
-	}
-
-	*context = strdup(buf);
-	if (!(*context)) {
-		ret = -1;
-		goto out2;
-	}
-	ret = 0;
-out2:			
-	free(buf);
-out:
-	close(fd);
-	return ret;
+	return getprocattrcon_raw(context, EXEC_PROC_ENTRY);
 }
 hidden_def(getexeccon_raw)
 
 int getexeccon(security_context_t *context)
 {
-	int ret;
-	security_context_t rcontext;
-
- 	ret = getexeccon_raw(&rcontext);
-
-	if (!ret) {
-		ret = selinux_raw_to_trans_context(rcontext, context);
-		freecon(rcontext);
-	} 
-
-	return ret;
+	return getprocattrcon(context, EXEC_PROC_ENTRY);
 }
--- libselinux-1.30.15/src/setfscreatecon.c.p2	2006-06-26 11:02:06.000000000 -0400
+++ libselinux-1.30.15/src/setfscreatecon.c	2006-06-26 11:49:53.000000000 -0400
@@ -1,39 +1,14 @@
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
 #include "selinux_internal.h"
 
-int setfscreatecon_raw(char *context)
-{
-	int fd;
-	ssize_t ret;
+#define FSCREATE_PROC_ENTRY "/proc/self/attr/fscreate"
 
-	fd = open("/proc/self/attr/fscreate", O_RDWR);
-	if (fd < 0)
-		return -1;
-	if (context) 
-		ret = write(fd, context, strlen(context)+1);
-	else
-		ret = write(fd, NULL, 0); /* clear */
-	close(fd);
-	if (ret < 0)
-		return -1;
-	else
-		return 0;
+int setfscreatecon_raw(security_context_t context)
+{
+	return setprocattrcon_raw(context, FSCREATE_PROC_ENTRY);
 }
 hidden_def(setfscreatecon_raw)
 
 int setfscreatecon(char *context)
 {
-	int ret;
-	security_context_t rcontext = context;
-
-	if (selinux_trans_to_raw_context(context, &rcontext))
-		return -1;
-
- 	ret = setfscreatecon_raw(rcontext);
-
-	freecon(rcontext);
-
-	return ret;
+ 	return setprocattrcon(context, FSCREATE_PROC_ENTRY);
 }
--- libselinux-1.30.15/src/getpidcon.c.p2	2006-06-26 11:02:06.000000000 -0400
+++ libselinux-1.30.15/src/getpidcon.c	2006-06-26 11:27:15.000000000 -0400
@@ -1,63 +1,19 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
 #include "selinux_internal.h"
-#include "policy.h"
+
+#define PID_CON_PROC_ENTRY "/proc/%d/attr/current"
 
 int getpidcon_raw(pid_t pid, security_context_t *context)
 {
 	char path[40];
-	char *buf;
-	size_t size;
-	int fd;
-	ssize_t ret;
-
-	snprintf(path, sizeof path, "/proc/%d/attr/current", pid);
-
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
-		return -1;
-
-	size = selinux_page_size;
-	buf = malloc(size);
-	if (!buf) {
-		ret = -1;
-		goto out;
-	}
-	memset(buf, 0, size);
-
-	ret = read(fd, buf, size-1);
-	if (ret < 0)
-		goto out2;
-
-	*context = strdup(buf);
-	if (!(*context)) {
-		ret = -1;
-		goto out2;
-	}
-	ret = 0;
-out2:			
-	free(buf);
-out:
-	close(fd);
-	return ret;
+	snprintf(path, sizeof path, PID_CON_PROC_ENTRY, pid);
+	return getprocattrcon_raw(context, path);
 }
 hidden_def(getpidcon_raw)
 
 int getpidcon(pid_t pid, security_context_t *context)
 {
-	int ret;
-	security_context_t rcontext;
-
- 	ret = getpidcon_raw(pid, &rcontext);
-
-	if (!ret) {
-		ret = selinux_raw_to_trans_context(rcontext, context);
-		freecon(rcontext);
-	} 
-
-	return ret;
+	char path[40];
+	snprintf(path, sizeof path, PID_CON_PROC_ENTRY, pid);
+ 	return getprocattrcon(context, path);
 }
--- libselinux-1.30.15/src/getcon.c.p2	2006-06-26 11:02:06.000000000 -0400
+++ libselinux-1.30.15/src/getcon.c	2006-06-26 11:04:36.000000000 -0400
@@ -1,63 +1,15 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include "selinux_internal.h"
-#include <stdlib.h>
-#include <errno.h>
-#include "policy.h"
 
 int getcon_raw(security_context_t *context)
 {
-	char *buf;
-	size_t size;
-	int fd;
-	ssize_t ret;
-
-	fd = open("/proc/self/attr/current", O_RDONLY);
-	if (fd < 0)
-		return -1;
-
-	size = selinux_page_size;
-	buf = malloc(size);
-	if (!buf) {
-		ret = -1;
-		goto out;
-	}
-	memset(buf, 0, size);
-
-	ret = read(fd, buf, size-1);
-	if (ret < 0)
-		goto out2;
-
-	*context = strdup(buf);
-	if (!(*context)) {
-		ret = -1;
-		goto out2;
-	}
-	ret = 0;
-out2:			
-	free(buf);
-out:
-	close(fd);
-	return ret;
+	char *current_pid_proc_entry = "/proc/self/attr/current";
+ 	return getprocattrcon_raw(context, current_pid_proc_entry);
 }
 hidden_def(getcon_raw)
 
 int getcon(security_context_t *context)
 {
-	int ret;
-	security_context_t rcontext;
-
- 	ret = getcon_raw(&rcontext);
-
-	if (!ret) {
-		if (selinux_raw_to_trans_context(rcontext, context)) {
-			*context = NULL;
-			ret = -1;
-		}
-		freecon(rcontext);
-	} 
-
-	return ret;
+	char *current_pid_proc_entry = "/proc/self/attr/current";
+ 	return getprocattrcon(context, current_pid_proc_entry);
 }
 hidden_def(getcon)
--- libselinux-1.30.15/src/setexeccon.c.p2	2006-06-26 11:02:06.000000000 -0400
+++ libselinux-1.30.15/src/setexeccon.c	2006-06-26 11:34:31.000000000 -0400
@@ -1,40 +1,15 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include "selinux_internal.h"
 
+#define EXEC_PROC_ENTRY "/proc/self/attr/exec"
+
 int setexeccon_raw(security_context_t context)
 {
-	int fd;
-	ssize_t ret;
-
-	fd = open("/proc/self/attr/exec", O_RDWR);
-	if (fd < 0)
-		return -1;
-	if (context) 
-		ret = write(fd, context, strlen(context)+1);
-	else
-		ret = write(fd, NULL, 0); /* clear */
-	close(fd);
-	if (ret < 0)
-		return -1;
-	else
-		return 0;
+	return setprocattrcon_raw(context, EXEC_PROC_ENTRY);
 }
 hidden_def(setexeccon_raw)
 
 int setexeccon(char *context)
 {
-	int ret;
-	security_context_t rcontext = context;
-
-	if (selinux_trans_to_raw_context(context, &rcontext))
-		return -1;
-
- 	ret = setexeccon_raw(rcontext);
-
-	freecon(rcontext);
-
-	return ret;
+ 	return setprocattrcon(context, EXEC_PROC_ENTRY);
 }
 hidden_def(setexeccon)
--- libselinux-1.30.15/src/setcon.c.p2	2006-06-26 11:02:06.000000000 -0400
+++ libselinux-1.30.15/src/setcon.c	2006-06-26 11:52:24.000000000 -0400
@@ -2,42 +2,17 @@
  * Author: Trusted Computer Solutions, Inc. <chanson@trustedcs.com>
  */
 
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include "selinux_internal.h"
 
+#define CURRENT_PROC_ENTRY "/proc/self/attr/current"
+
 int setcon_raw(security_context_t context)
 {
-	int fd;
-	ssize_t ret;
-
-	fd = open("/proc/self/attr/current", O_RDWR);
-	if (fd < 0)
-		return -1;
-	if (context) 
-		ret = write(fd, context, strlen(context)+1);
-	else
-		ret = -1; /* we can not clear this one */
-	close(fd);
-	if (ret < 0)
-		return -1;
-	else
-		return 0;
+	return setprocattrcon_raw(context, CURRENT_PROC_ENTRY);
 }
 hidden_def(setcon_raw)
 
 int setcon(char *context)
 {
-	int ret;
-	security_context_t rcontext = context;
-
-	if (selinux_trans_to_raw_context(context, &rcontext))
-		return -1;
-
- 	ret = setcon_raw(rcontext);
-
-	freecon(rcontext);
-
-	return ret;
+	return setprocattrcon(context, CURRENT_PROC_ENTRY);
 }
--- libselinux-1.30.15/src/getprevcon.c.p2	2006-06-26 11:02:06.000000000 -0400
+++ libselinux-1.30.15/src/getprevcon.c	2006-06-26 11:19:56.000000000 -0400
@@ -1,60 +1,15 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include "selinux_internal.h"
-#include <stdlib.h>
-#include <errno.h>
-#include "policy.h"
+
+#define PREV_PROC_ENTRY "/proc/self/attr/prev"
 
 int getprevcon_raw(security_context_t *context)
 {
-	char *buf;
-	size_t size;
-	int fd;
-	ssize_t ret;
-
-	fd = open("/proc/self/attr/prev", O_RDONLY);
-	if (fd < 0)
-		return -1;
-
-	size = selinux_page_size;
-	buf = malloc(size);
-	if (!buf) {
-		ret = -1;
-		goto out;
-	}
-	memset(buf, 0, size);
-
-	ret = read(fd, buf, size-1);
-	if (ret < 0)
-		goto out2;
-
-	*context = strdup(buf);
-	if (!(*context)) {
-		ret = -1;
-		goto out2;
-	}
-	ret = 0;
-out2:			
-	free(buf);
-out:
-	close(fd);
-	return ret;
+ 	return getprocattrcon_raw(context, PREV_PROC_ENTRY);
 }
 hidden_def(getprevcon_raw)
 
 int getprevcon(security_context_t *context)
 {
-	int ret;
-	security_context_t rcontext;
-
- 	ret = getprevcon_raw(&rcontext);
-
-	if (!ret) {
-		ret = selinux_raw_to_trans_context(rcontext, context);
-		freecon(rcontext);
-	} 
-
-	return ret;
+ 	return getprocattrcon(context, PREV_PROC_ENTRY);
 }
 hidden_def(getprevcon)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
