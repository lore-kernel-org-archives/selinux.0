Subject: Re: checking user status
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry Ross <selinux.larry@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1250597961.3629.209.camel@moss-pluto.epoch.ncsc.mil>
References: <81092d890908161153h38ae37fdx9123ecea3adb6d51@mail.gmail.com>
	 <1250512198.3629.110.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170747s305cf9f2uc734f5a3fefd4efc@mail.gmail.com>
	 <1250521053.3629.117.camel@moss-pluto.epoch.ncsc.mil>
	 <81092d890908170755n2f5df6c2h3ca57faff998e6d6@mail.gmail.com>
	 <81092d890908171338j36a27012h3b87c5828f1d24ab@mail.gmail.com>
	 <1250597961.3629.209.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 18 Aug 2009 08:39:57 -0400
Message-Id: <1250599197.3629.210.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-08-18 at 08:19 -0400, Stephen Smalley wrote:
> If this is another manifestation of the same problem, then the easiest
> approach would be to grab the libselinux .src.rpm, patch
> libselinux/src/checkAccess.c to syslog() a message whenever there is a
> denial, build and install your patched libselinux, and then retry and
> look for the log message.

Something like this patch (un-tested, against the current upstream
libselinux):

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index c1982c7..cae1626 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -2,6 +2,7 @@
 #include <sys/types.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <syslog.h>
 #include "selinux_internal.h"
 #include <selinux/flask.h>
 #include <selinux/av_permissions.h>
@@ -29,7 +30,15 @@ int selinux_check_passwd_access(access_vector_t requested)
 
 		if ((retval == 0) && ((requested & avd.allowed) == requested)) {
 			status = 0;
+		} else {
+			syslog(LOG_ERR, 
+			       "avc:  denied { %s } for scontext=%s "
+			       "tcontext=%s tclass=passwd\n",
+			       security_av_perm_to_string(passwd_class,
+							  requested),
+			       user_context, user_context);
 		}
+
 		freecon(user_context);
 	}
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
