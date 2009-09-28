Subject: Re: [RFC][PATCH v2 2/2] selinux:  generate flask headers during
 kernel build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4AC02871.9060608@ak.jp.nec.com>
References: <1253833647.2452.4.camel@moss-aggies>
	 <4AC02871.9060608@ak.jp.nec.com>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 09:51:54 -0400
Message-Id: <1254145914.14478.2.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-09-28 at 12:07 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> > Add a simple utility (scripts/selinux/genheaders) and invoke it to
> > generate the kernel-private class and permission indices in flask.h
> > and av_permissions.h automatically during the kernel build from the
> > security class mapping definitions in classmap.h.  Adding new kernel
> > classes and permissions can then be done just by adding them to classmap.h.
> > 
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> > ---
> >  scripts/selinux/Makefile                  |    4 +-
> >  scripts/selinux/genheaders/Makefile       |    5 +
> >  scripts/selinux/genheaders/genheaders.c   |  118 ++++
> >  security/selinux/Makefile                 |    3 +
> >  security/selinux/include/av_permissions.h |  870 -----------------------------
> >  security/selinux/include/flask.h          |   91 ---
> >  6 files changed, 128 insertions(+), 963 deletions(-)
> >  create mode 100644 scripts/selinux/genheaders/Makefile
> >  create mode 100644 scripts/selinux/genheaders/genheaders.c
> >  delete mode 100644 security/selinux/include/av_permissions.h
> >  delete mode 100644 security/selinux/include/flask.h
> 
> It seems to me flask.h and av_permissions.h are not generated prior to
> compile source files, such as avc.c.
> 
> [kaigai@saba selinux-2.6]$ make
>   CHK     include/linux/version.h
>    :
>   CC      security/selinux/avc.o
> In file included from security/selinux/avc.c:32:
> security/selinux/include/avc.h:20:19: error: flask.h: No such file or directory
> security/selinux/include/avc.h:21:28: error: av_permissions.h: No such file or directory
> make[2]: *** [security/selinux/avc.o] Error 1
> make[1]: *** [security/selinux] Error 2
> make: *** [security] Error 2
> 
> BTW, it needs to be built prior to the building mdp.c?
> 
>   HOSTCC  scripts/selinux/mdp/mdp
> scripts/selinux/mdp/mdp.c:32:19: error: flask.h: No such file or directory
> make[3]: *** [scripts/selinux/mdp/mdp] Error 1
> make[2]: *** [scripts/selinux/mdp] Error 2
> make[1]: *** [scripts/selinux] Error 2
> make: *** [scripts] Error 2

Ah, thanks - I apparently hadn't tried rebuilding after a make clean.

Below is a patch on top of these two patches that should resolve the
auditdeny issue and the header generation issue.  I'll split and fold
them into the corresponding patches for the next round of submission.

diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
index 894872f..4052873 100644
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -29,8 +29,6 @@
 #include <unistd.h>
 #include <string.h>
 
-#include "flask.h"
-
 void usage(char *name)
 {
 	printf("usage: %s [-m] policy_file context_file\n", name);
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 30fbdbf..92760b3 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -20,6 +20,9 @@ selinux-$(CONFIG_NETLABEL) += netlabel.o
 
 EXTRA_CFLAGS += -Isecurity/selinux/include
 
-security/selinux/include/flask.h: security/selinux/include/classmap.h
-	scripts/selinux/genheaders/genheaders security/selinux/include/flask.h security/selinux/include/av_permissions.h
+$(obj)/avc.o: $(obj)/include/flask.h
 
+cmd_flask = scripts/selinux/genheaders/genheaders $(obj)/include/flask.h $(obj)/include/av_permissions.h
+targets += include/flask.h
+$(obj)/include/flask.h: $(src)/include/classmap.h FORCE
+	$(call if_changed,flask)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7ccd022..f0522aa 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -272,9 +272,12 @@ map_decision(u16 tclass, struct av_decision *avd, int allow_unknown)
 				result |= 1<<i;
 		avd->auditallow = result;
 
-		for (i = 0, result = 0; i < n; i++)
+		for (i = 0, result = 0; i < n; i++) {
 			if (avd->auditdeny & current_mapping[tclass].perms[i])
 				result |= 1<<i;
+			if (!allow_unknown && !current_mapping[tclass].perms[i])
+				result |= 1<<i;
+		}
 		avd->auditdeny = result;
 	}
 }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
