Message-ID: <53BC32B5.8020902@tycho.nsa.gov>
Date: Tue, 08 Jul 2014 14:04:37 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: selinux_check_access() and unknown classes/perms
References: <CACLa4pvP9mjjGvQ+SkyoorYZAAdxAHMy3maK8rmkbJRMa6JQPA@mail.gmail.com>
 <CAB9W1A0RHSS3VJcbvCtMDULm6zi3xiuN9eBpS49cR6CEoBw0jQ@mail.gmail.com>
 <5360F37F.2050908@redhat.com> <20140705140839.721e7abd@fornost.bigon.be>
 <1404564176.9852.44.camel@x220.localdomain>
In-Reply-To: <1404564176.9852.44.camel@x220.localdomain>
Content-Type: multipart/mixed; boundary="------------070301070501060707050509"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------070301070501060707050509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07/05/2014 08:42 AM, Dominick Grift wrote:
> For reference:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1095354

Will this suffice?




--------------070301070501060707050509
Content-Type: text/x-patch;
 name="0001-Log-an-error-on-unknown-classes-and-permissions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Log-an-error-on-unknown-classes-and-permissions.patch"

>From 7bdc38ccb21133155658279895b10ceb347b0b5a Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 8 Jul 2014 14:03:39 -0400
Subject: [PATCH] Log an error on unknown classes and permissions.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libselinux/src/checkAccess.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 4d70ebe..cd2a817 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -7,6 +7,7 @@
 #include <selinux/flask.h>
 #include <selinux/avc.h>
 #include <selinux/av_permissions.h>
+#include "avc_internal.h"
 
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 
@@ -38,6 +39,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
        sclass = string_to_security_class(class);
        if (sclass == 0) {
 	       rc = errno;
+	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
 	       if (security_deny_unknown() == 0)
 		       return 0;
 	       errno = rc;
@@ -47,6 +49,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
        av = string_to_av_perm(sclass, perm);
        if (av == 0) {
 	       rc = errno;
+	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
 	       if (security_deny_unknown() == 0)
 		       return 0;
 	       errno = rc;
-- 
1.8.3.1


--------------070301070501060707050509--
