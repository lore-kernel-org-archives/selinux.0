Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0QDcjsj011415
	for <selinux@tycho.nsa.gov>; Wed, 26 Jan 2005 08:38:45 -0500 (EST)
Subject: Re: libselinux rpm_execon should not fail in permissive mode.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41F55E02.6090302@redhat.com>
References: <41F03552.90806@redhat.com>
	 <1106596929.3298.9.camel@moss-lions.epoch.ncsc.mil>
	 <41F55E02.6090302@redhat.com>
Content-Type: multipart/mixed; boundary="=-VD0kxfTE6vX9j7bDvGdt"
Message-Id: <1106746348.23386.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Jan 2005 08:32:28 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VD0kxfTE6vX9j7bDvGdt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-01-24 at 15:43, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsalibselinux/src/rpm.c libselinux-1.21.1/src/rpm.c
> --- nsalibselinux/src/rpm.c	2004-11-09 09:13:54.000000000 -0500
> +++ libselinux-1.21.1/src/rpm.c	2005-01-24 15:24:33.000000000 -0500
> @@ -41,8 +41,10 @@
>  	rc = setexeccon(newcon);
>  	if (rc < 0) 
>  		goto out;
> -	rc = execve(filename, argv, envp);
>  out:
> +	if ( ( rc == 0 ) || 
> +	     (security_getenforce() == 0 ))
> +	  rc = execve(filename, argv, envp);
>  	context_free(con);
>  	freecon(newcon);
>  	freecon(fcon);

I don't see how this fixes the rpm --root issue, as
security_getenforce() cannot succeed either if /selinux is not mounted,
as it attempts to read /selinux/enforce.  What about the attached patch
instead, which causes rpm_execcon() to simply call execve() if
is_selinux_enabled() returns < 1?  is_selinux_enabled() will return -1
if /proc isn't mounted, so this would cause it to fallback to a regular
exec in the chroot'd environment.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-VD0kxfTE6vX9j7bDvGdt
Content-Disposition: attachment; filename=libselinux-rpm.patch
Content-Type: text/x-patch; name=libselinux-rpm.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/compute_create.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/compute_create.c,v
retrieving revision 1.10
diff -u -p -r1.10 compute_create.c
--- libselinux/src/compute_create.c	18 Dec 2003 17:33:47 -0000	1.10
+++ libselinux/src/compute_create.c	26 Jan 2005 13:21:28 -0000
@@ -6,7 +6,7 @@
 #include <errno.h>
 #include <string.h>
 #include <asm/page.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
 
@@ -54,3 +54,4 @@ out:
 	close(fd);
 	return ret;
 }
+hidden_def(security_compute_create)
Index: libselinux/src/getfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getfilecon.c,v
retrieving revision 1.6
diff -u -p -r1.6 getfilecon.c
--- libselinux/src/getfilecon.c	9 Oct 2003 20:21:06 -0000	1.6
+++ libselinux/src/getfilecon.c	26 Jan 2005 13:21:32 -0000
@@ -1,7 +1,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
@@ -43,3 +43,4 @@ out:			
 		*context = buf;
 	return ret;
 }
+hidden_def(getfilecon)
Index: libselinux/src/rpm.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/rpm.c,v
retrieving revision 1.2
diff -u -p -r1.2 rpm.c
--- libselinux/src/rpm.c	4 Nov 2004 19:08:13 -0000	1.2
+++ libselinux/src/rpm.c	26 Jan 2005 13:20:34 -0000
@@ -1,9 +1,9 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <selinux/flask.h>
-#include <selinux/context.h>
+#include "selinux_internal.h"
+#include "context_internal.h"
 
 int rpm_execcon(unsigned int verified __attribute__((unused)), 
 		const char *filename, 
@@ -13,6 +13,9 @@ int rpm_execcon(unsigned int verified __
 	context_t con = NULL;
 	int rc;
 
+	if (is_selinux_enabled() < 1)
+		return execve(filename, argv, envp);
+
 	rc = getcon(&mycon);
 	if (rc < 0)
 		goto out;
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.3
diff -u -p -r1.3 selinux_internal.h
--- libselinux/src/selinux_internal.h	19 Jan 2005 16:40:50 -0000	1.3
+++ libselinux/src/selinux_internal.h	26 Jan 2005 13:19:39 -0000
@@ -6,6 +6,7 @@ hidden_proto(security_commit_booleans)
 hidden_proto(security_check_context)
 hidden_proto(security_compute_av)
 hidden_proto(security_compute_user)
+hidden_proto(security_compute_create)
 hidden_proto(is_selinux_enabled)
 hidden_proto(is_selinux_mls_enabled)
 hidden_proto(security_check_context)
@@ -13,6 +14,8 @@ hidden_proto(freecon)
 hidden_proto(freeconary)
 hidden_proto(getprevcon)
 hidden_proto(getcon)
+hidden_proto(getfilecon)
+hidden_proto(setexeccon)
 hidden_proto(security_getenforce)
 hidden_proto(selinux_default_context_path)
 hidden_proto(selinux_failsafe_context_path)
Index: libselinux/src/setexeccon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/setexeccon.c,v
retrieving revision 1.3
diff -u -p -r1.3 setexeccon.c
--- libselinux/src/setexeccon.c	25 Apr 2003 20:31:49 -0000	1.3
+++ libselinux/src/setexeccon.c	26 Jan 2005 13:21:50 -0000
@@ -1,7 +1,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 
 int setexeccon(security_context_t context)
 {
@@ -21,3 +21,4 @@ int setexeccon(security_context_t contex
 	else
 		return 0;
 }
+hidden_def(setexeccon)

--=-VD0kxfTE6vX9j7bDvGdt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
