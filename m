Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5NKVwTZ012395
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:31:58 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5NKVv0d018440
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 20:31:57 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5NKVvWB017055
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:31:57 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5NKVq7p015160
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:31:52 -0400
Received: from vpn50-149.rdu.redhat.com (vpn50-149.rdu.redhat.com [172.16.50.149])
	by pobox.corp.redhat.com (8.12.8/8.12.8) with ESMTP id k5NKVps3003499
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:31:51 -0400
Subject: [PATCH] libselinux: 2/2 Convert functions to use new get,set
	procattrcon
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 16:32:51 -0400
Message-Id: <1151094771.21012.94.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The below patch will convert

-{get,set}fscreatecon()
-{get,set}execcon()
-{get,set}con()
-getpidcon()
-getprevcon()

to use the new {get,set}procattrcon() generic functions.  The only two
caveats are

both getprevcon_raw() and getcon_raw() had callers elsewhere in
libselinux.  So the raw version of these functions were left and now
call directly into the raw version of the generic functions.

setcon() had a special check if the context to be written was null and
returned -1 since you are not supposed to be able to set your own
context to null.  My testing showed that the special case was not needed
as the null context would be rejected anyway with -1; 

 include/selinux/selinux.h |    6 ----
 src/getcon.c              |   56 +++---------------------------------------
 src/getexeccon.c          |   61 +---------------------------------------------
 src/getfscreatecon.c      |   61 +---------------------------------------------
 src/getpidcon.c           |   58 +------------------------------------------
 src/getprevcon.c          |   53 +++------------------------------------
 src/selinux_internal.h    |    6 ----
 src/setcon.c              |   36 +--------------------------
 src/setexeccon.c          |   35 +-------------------------
 src/setfscreatecon.c      |   36 +--------------------------
 10 files changed, 20 insertions(+), 388 deletions(-)

--- libselinux-1.30.15/src/getfscreatecon.c.p2	2006-06-23 15:05:25.000000000 -0400
+++ libselinux-1.30.15/src/getfscreatecon.c	2006-06-23 15:18:06.000000000 -0400
@@ -1,64 +1,7 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
 #include "selinux_internal.h"
-#include "policy.h"
-
-int getfscreatecon_raw(security_context_t *context)
-{
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
-}
-hidden_def(getfscreatecon_raw)
 
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
+	char *fscreate_proc_entry = "/proc/self/attr/fscreate";
+	return getprocattrcon(context, fscreate_proc_entry);
 }
--- libselinux-1.30.15/src/getexeccon.c.p2	2006-06-23 15:05:25.000000000 -0400
+++ libselinux-1.30.15/src/getexeccon.c	2006-06-23 15:18:06.000000000 -0400
@@ -1,64 +1,7 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <stdlib.h>
-#include <errno.h>
 #include "selinux_internal.h"
-#include "policy.h"
-
-int getexeccon_raw(security_context_t *context)
-{
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
-}
-hidden_def(getexeccon_raw)
 
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
+	char *exec_proc_entry = "/proc/self/attr/exec";
+	return getprocattrcon(context, exec_proc_entry);
 }
--- libselinux-1.30.15/src/setfscreatecon.c.p2	2006-06-23 15:05:25.000000000 -0400
+++ libselinux-1.30.15/src/setfscreatecon.c	2006-06-23 15:18:06.000000000 -0400
@@ -1,39 +1,7 @@
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
 #include "selinux_internal.h"
 
-int setfscreatecon_raw(char *context)
-{
-	int fd;
-	ssize_t ret;
-
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
-}
-hidden_def(setfscreatecon_raw)
-
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
+	char *fscreate_proc_entry = "/proc/self/attr/fscreate";
+ 	return setprocattrcon(context, fscreate_proc_entry);
 }
--- libselinux-1.30.15/src/selinux_internal.h.p2	2006-06-23 15:10:05.000000000 -0400
+++ libselinux-1.30.15/src/selinux_internal.h	2006-06-23 15:18:06.000000000 -0400
@@ -34,10 +34,7 @@ hidden_proto(getprevcon)
 hidden_proto(getprevcon_raw)
 hidden_proto(getcon)
 hidden_proto(getcon_raw)
-hidden_proto(setcon_raw)
 hidden_proto(getpeercon_raw)
-hidden_proto(getpidcon_raw)
-hidden_proto(getexeccon_raw)
 hidden_proto(getfilecon)
 hidden_proto(getfilecon_raw)
 hidden_proto(lgetfilecon_raw)
@@ -46,9 +43,6 @@ hidden_proto(setfilecon_raw)
 hidden_proto(lsetfilecon_raw)
 hidden_proto(fsetfilecon_raw)
 hidden_proto(setexeccon)
-hidden_proto(setexeccon_raw)
-hidden_proto(getfscreatecon_raw)
-hidden_proto(setfscreatecon_raw)
 hidden_proto(security_getenforce)
 hidden_proto(security_setenforce)
 hidden_proto(selinux_binary_policy_path)
--- libselinux-1.30.15/src/getpidcon.c.p2	2006-06-23 15:05:25.000000000 -0400
+++ libselinux-1.30.15/src/getpidcon.c	2006-06-23 15:18:06.000000000 -0400
@@ -1,63 +1,9 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
 #include "selinux_internal.h"
-#include "policy.h"
 
-int getpidcon_raw(pid_t pid, security_context_t *context)
+int getpidcon(pid_t pid, security_context_t *context)
 {
 	char path[40];
-	char *buf;
-	size_t size;
-	int fd;
-	ssize_t ret;
-
 	snprintf(path, sizeof path, "/proc/%d/attr/current", pid);
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
-}
-hidden_def(getpidcon_raw)
-
-int getpidcon(pid_t pid, security_context_t *context)
-{
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
+ 	return getprocattrcon(context, path);
 }
--- libselinux-1.30.15/src/getcon.c.p2	2006-06-23 15:05:25.000000000 -0400
+++ libselinux-1.30.15/src/getcon.c	2006-06-23 15:18:06.000000000 -0400
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
--- libselinux-1.30.15/src/setexeccon.c.p2	2006-06-23 15:05:25.000000000 -0400
+++ libselinux-1.30.15/src/setexeccon.c	2006-06-23 15:18:06.000000000 -0400
@@ -1,40 +1,9 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include "selinux_internal.h"
 
-int setexeccon_raw(security_context_t context)
-{
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
-}
-hidden_def(setexeccon_raw)
 
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
+	char *exec_proc_entry = "/proc/self/attr/exec";
+ 	return setprocattrcon(context, exec_proc_entry);
 }
 hidden_def(setexeccon)
--- libselinux-1.30.15/src/setcon.c.p2	2006-06-23 15:05:25.000000000 -0400
+++ libselinux-1.30.15/src/setcon.c	2006-06-23 15:18:06.000000000 -0400
@@ -2,42 +2,10 @@
  * Author: Trusted Computer Solutions, Inc. <chanson@trustedcs.com>
  */
 
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include "selinux_internal.h"
 
-int setcon_raw(security_context_t context)
-{
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
-}
-hidden_def(setcon_raw)
-
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
+	char *current_pid_proc_entry = "/proc/self/attr/current";
+	return setprocattrcon(context, current_pid_proc_entry);
 }
--- libselinux-1.30.15/src/getprevcon.c.p2	2006-06-23 15:05:25.000000000 -0400
+++ libselinux-1.30.15/src/getprevcon.c	2006-06-23 15:18:06.000000000 -0400
@@ -1,60 +1,15 @@
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
 #include "selinux_internal.h"
-#include <stdlib.h>
-#include <errno.h>
-#include "policy.h"
 
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
+	char *prev_proc_entry = "/proc/self/attr/prev";
+ 	return getprocattrcon_raw(context, prev_proc_entry);
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
+	char *prev_proc_entry = "/proc/self/attr/prev";
+ 	return getprocattrcon(context, prev_proc_entry);
 }
 hidden_def(getprevcon)
--- libselinux-1.30.15/include/selinux/selinux.h.p2	2006-06-23 15:10:05.000000000 -0400
+++ libselinux-1.30.15/include/selinux/selinux.h	2006-06-23 15:18:06.000000000 -0400
@@ -46,12 +46,10 @@ extern int getcon_raw(security_context_t
    as a result of a setcon() unless policy allows it to use descriptors opened
    by the old context. */
 extern int setcon(security_context_t con);
-extern int setcon_raw(security_context_t con);
 
 /* Get context of process identified by pid, and 
    set *con to refer to it.  Caller must free via freecon. */
 extern int getpidcon(pid_t pid, security_context_t *con);
-extern int getpidcon_raw(pid_t pid, security_context_t *con);
 
 /* Get previous context (prior to last exec), and set *con to refer to it.
    Caller must free via freecon. */
@@ -62,23 +60,19 @@ extern int getprevcon_raw(security_conte
    Sets *con to NULL if no exec context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
 extern int getexeccon(security_context_t *con);
-extern int getexeccon_raw(security_context_t *con);
 
 /* Set exec security context for the next execve. 
    Call with NULL if you want to reset to the default. */
 extern int setexeccon(security_context_t con);
-extern int setexeccon_raw(security_context_t con);
 
 /* Get fscreate context, and set *con to refer to it.
    Sets *con to NULL if no fs create context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
 extern int getfscreatecon(security_context_t *con);
-extern int getfscreatecon_raw(security_context_t *con);
 
 /* Set the fscreate security context for subsequent file creations.
    Call with NULL if you want to reset to the default. */
 extern int setfscreatecon(security_context_t context);
-extern int setfscreatecon_raw(security_context_t context);
 

 /* Wrappers for the xattr API. */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
