Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tANFajvo004301
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 10:36:45 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 6C5CE1A1D8
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 16:36:41 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lUOE8OAI0VtX for <selinux@tycho.nsa.gov>;
 Mon, 23 Nov 2015 16:36:32 +0100 (CET)
Received: from [IPv6:2a02:578:85fc:1:c84e:489:bf64:5e4f] (unknown
 [IPv6:2a02:578:85fc:1:c84e:489:bf64:5e4f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id EBF3B1A070
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 16:36:31 +0100 (CET)
Subject: Re: (Userspace) AVC denial generated even if allowed by the policy?
To: selinux@tycho.nsa.gov
References: <5652636F.2060609@debian.org> <56533218.7090601@debian.org>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <5653327F.9010609@debian.org>
Date: Mon, 23 Nov 2015 16:36:31 +0100
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Boundary-4920-1448292989-0001-2"
In-Reply-To: <56533218.7090601@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-4920-1448292989-0001-2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

Le 23/11/15 16:34, Laurent Bigonville a =C3=A9crit :
> Le 23/11/15 01:53, Laurent Bigonville a =C3=A9crit :
>> Hi,
>>
>> I'm still looking at adding SELinux support in the "at" daemon and I 
>> now have the following patch[0].
>>
>> With this patch, at seems to behave like the cron daemon, as 
>> explained in the commit log:
>>
>>     - When cron_userdomain_transition is set to off, a process for an
>>       unconfined user will transition to unconfined_cronjob_t. For 
>> confined
>>       user, the job is run as cronjob_t.
>>
>>     - When cron_userdomain_transition is set to on, the processes are=
 
>> run
>>       under the user default context.
>>
>> But every time an AVC denial is generated (with 
>> cron_userdomain_transition set to off and the user running as 
>> staff_u, in permissive with unmodified refpolicy):
>>
>> avc:  denied  { entrypoint } for 
>> scontext=3Dstaff_u:staff_r:cronjob_t:s0 
>> tcontext=3Dstaff_u:object_r:user_cron_spool_t:s0 tclass=3Dfile
>>
>> The job runs as (id -Z): staff_u:staff_r:cronjob_t:s0
>>
>> But audit2{allow,why} are saying that this is already allowed in the 
>> policy
>>
>> Setting the cron_userdomain_transition boolean to on, I have the 
>> following avc:
>>
>> avc:  denied  { entrypoint } for 
>> scontext=3Dstaff_u:sysadm_r:sysadm_t:s0 
>> tcontext=3Dstaff_u:object_r:user_cron_spool_t:s0 tclass=3Dfile
>>
>> The job runs as (id -Z): staff_u:sysadm_r:sysadm_t:s0
>>
>> So as said it seems to work, but I'm not sure why this AVC denial is 
>> generated.
>>
>> sesearch shows:
>>
>> $ sesearch -ATSC  -t user_cron_spool_t -c file -p entrypoint
>> Found 6 semantic av rules:
>>    allow files_unconfined_type file_type : file { ioctl read write 
>> create getattr setattr lock relabelfrom relabelto append unlink link 
>> rename execute swapon quotaon mounton execute_no_trans entrypoint 
>> open audit_access } ;
>> DT allow unconfined_t user_cron_spool_t : file entrypoint ; [ 
>> cron_userdomain_transition ]
>> DT allow user_t user_cron_spool_t : file entrypoint ; [ 
>> cron_userdomain_transition ]
>> EF allow cronjob_t user_cron_spool_t : file entrypoint ; [ 
>> cron_userdomain_transition ]
>> DT allow staff_t user_cron_spool_t : file entrypoint ; [ 
>> cron_userdomain_transition ]
>> DT allow sysadm_t user_cron_spool_t : file entrypoint ; [ 
>> cron_userdomain_transition ]
>>
>> Did I overlooked something?
>>
>> Cheers,
>>
>> Laurent Bigonville
>>
>> [0] 
>> https://anonscm.debian.org/cgit/users/bigon/at.git/commit/?h=3Dselinu=
x&id=3D0112f006b74a36f7200e315575fd25d78e11b170
>
> I'm attaching the patch to this mail for the people that cannot access=
 
> the website and FTR.
And it was of course the wrong one...


--=_Boundary-4920-1448292989-0001-2
Content-Type: text/x-patch; name="0001-Add-SELinux-support-to-run-jobs-in-the-proper-domain.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-Add-SELinux-support-to-run-jobs-in-the-proper-domain.pa";
 filename*1="tch"
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

>From 0112f006b74a36f7200e315575fd25d78e11b170 Mon Sep 17 00:00:00 2001
From: Laurent Bigonville <bigon@bigon.be>
Date: Thu, 16 Jul 2015 01:06:06 +0200
Subject: [PATCH] Add SELinux support to run jobs in the proper domain
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Currently, jobs run by at are run in the crond_t domain and not
transitioned outside of it.

With this patch, the jobs are transitioned in the same domain as the
jobs that are run by the cron daemon:

- When cron_userdomain_transition is set to off, a process for an
  unconfined user will transition to unconfined_cronjob_t. For confined
  user, the job is run as cronjob_t.

- When cron_userdomain_transition is set to on, the processes are run
  under the user default context.

This patch is based on Marcela Ma=C5=A1l=C3=A1=C5=88ov=C3=A1 <mmaslano@r=
edhat.com> work
---
 Makefile.in  |  3 ++-
 atd.c        | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 config.h.in  |  3 +++
 configure.ac |  8 ++++++
 daemon.c     | 16 +++++++++++
 daemon.h     |  3 +++
 6 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index 06544f9..dd3c2f8 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -40,6 +40,7 @@ LIBS=09=09=3D @LIBS@
 LIBOBJS=09=09=3D @LIBOBJS@
 INSTALL=09=09=3D @INSTALL@
 PAMLIB          =3D @PAMLIB@
+SELINUXLIB      =3D @SELINUXLIB@
 
 CLONES=09=09=3D atq atrm
 ATOBJECTS=09=3D at.o panic.o perm.o posixtm.o y.tab.o lex.yy.o
@@ -73,7 +74,7 @@ at: $(ATOBJECTS)
 =09$(LN_S) -f at atrm
 
 atd: $(RUNOBJECTS)
-=09$(CC) $(LDFLAGS) -o atd $(RUNOBJECTS) $(LIBS) $(PAMLIB)
+=09$(CC) $(LDFLAGS) -o atd $(RUNOBJECTS) $(LIBS) $(PAMLIB) $(SELINUXLIB=
)
 
 y.tab.c y.tab.h: parsetime.y
 =09$(YACC) -d parsetime.y
diff --git a/atd.c b/atd.c
index d0b422e..abb860e 100644
--- a/atd.c
+++ b/atd.c
@@ -83,6 +83,12 @@
 #include "getloadavg.h"
 #endif
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/get_context_list.h>
+int selinux_enabled =3D 0;
+#endif
+
 /* Macros */
 
 #define BATCH_INTERVAL_DEFAULT 60
@@ -195,6 +201,72 @@ myfork()
 #define fork myfork
 #endif
 
+#ifdef WITH_SELINUX
+static int
+set_selinux_context(const char *name, const char *filename) {
+    security_context_t user_context =3D NULL;
+    security_context_t file_context =3D NULL;
+    int retval =3D 0;
+    char *seuser =3D NULL;
+    char *level =3D NULL;
+
+    if (getseuserbyname(name, &seuser, &level) =3D=3D 0) {
+        retval =3D get_default_context_with_level(seuser, level, NULL, =
&user_context);
+        free(seuser);
+        free(level);
+        if (retval < 0) {
+            lerr("get_default_context_with_level: couldn't get security=
 context for user %s", name);
+            retval =3D -1;
+            goto err;
+        }
+    }
+
+    /*
+     * Since crontab files are not directly executed,
+     * crond must ensure that the crontab file has
+     * a context that is appropriate for the context of
+     * the user cron job.  It performs an entrypoint
+     * permission check for this purpose.
+     */
+    if (fgetfilecon(STDIN_FILENO, &file_context) < 0) {
+        lerr("fgetfilecon FAILED %s", filename);
+        retval =3D -1;
+        goto err;
+    }
+
+    retval =3D selinux_check_access(user_context, file_context, "file",=
 "entrypoint", NULL);
+    freecon(file_context);
+    if (retval < 0) {
+        lerr("Not allowed to set exec context to %s for user  %s", user=
_context, name);
+        retval =3D -1;
+        goto err;
+    }
+    if (setexeccon(user_context) < 0) {
+        lerr("Could not set exec context to %s for user  %s", user_cont=
ext, name);
+        retval =3D -1;
+        goto err;
+    }
+err:
+    if (retval < 0 && security_getenforce() !=3D 1)
+        retval =3D 0;
+    if (user_context)
+        freecon(user_context);
+    return retval;
+}
+
+static int
+selinux_log_callback (int type, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vsyslog (LOG_ERR, fmt, ap);
+    va_end(ap);
+    return 0;
+}
+
+#endif
+
 static void
 run_file(const char *filename, uid_t uid, gid_t gid)
 {
@@ -424,6 +496,13 @@ run_file(const char *filename, uid_t uid, gid_t gid=
)
 
 =09    nice((tolower((int) queue) - 'a' + 1) * 2);
 
+#ifdef WITH_SELINUX
+=09    if (selinux_enabled > 0) {
+=09        if (set_selinux_context(pentry->pw_name, filename) < 0)
+=09            perr("SELinux Failed to set context\n");
+=09    }
+#endif
+
 =09    if (initgroups(pentry->pw_name, pentry->pw_gid))
 =09=09perr("Cannot initialize the supplementary group access list");
 
@@ -707,6 +786,14 @@ main(int argc, char *argv[])
     struct passwd *pwe;
     struct group *ge;
 
+#ifdef WITH_SELINUX
+    selinux_enabled=3Dis_selinux_enabled();
+
+    if (selinux_enabled) {
+        selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) s=
elinux_log_callback);
+    }
+#endif
+
 /* We don't need root privileges all the time; running under uid and gi=
d
  * daemon is fine.
  */
diff --git a/config.h.in b/config.h.in
index 4d7dc91..681d68e 100644
--- a/config.h.in
+++ b/config.h.in
@@ -192,6 +192,9 @@
    <sys/cpustats.h>. */
 #undef UMAX4_3
 
+/* Define if you are building with_selinux */
+#undef WITH_SELINUX
+
 /* Define to 1 if `lex' declares `yytext' as a `char *' by default, not=
 a
    `char[]'. */
 #undef YYTEXT_POINTER
diff --git a/configure.ac b/configure.ac
index bcd3ec6..0321a02 100644
--- a/configure.ac
+++ b/configure.ac
@@ -239,6 +239,14 @@ AC_ARG_WITH(daemon_username,
 )
 AC_SUBST(DAEMON_USERNAME)
 
+AC_ARG_WITH(selinux,
+[ --with-selinux       Define to run with selinux],
+AC_DEFINE(WITH_SELINUX, 1, [Define if you are building with_selinux]),
+)
+AC_CHECK_LIB(selinux, is_selinux_enabled, SELINUXLIB=3D-lselinux)
+AC_SUBST(SELINUXLIB)
+AC_SUBST(WITH_SELINUX)
+
 AC_MSG_CHECKING(groupname to run under)
 AC_ARG_WITH(daemon_groupname,
 [ --with-daemon_groupname=3DDAEMON_GROUPNAME=09Groupname to run under (=
default daemon) ],
diff --git a/daemon.c b/daemon.c
index 8be40d4..f9d25e7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -83,6 +83,22 @@ perr(const char *fmt,...)
 }
 
 void
+lerr(const char *fmt,...)
+{
+    char buf[1024];
+    va_list args;
+
+    va_start(args, fmt);
+    vsnprintf(buf, sizeof(buf), fmt, args);
+    va_end(args);
+
+    if (daemon_debug) {
+=09perror(buf);
+    } else
+=09syslog(LOG_ERR, "%s: %m", buf);
+}
+
+void
 pabort(const char *fmt,...)
 {
     char buf[1024];
diff --git a/daemon.h b/daemon.h
index c4507ae..f44ccd1 100644
--- a/daemon.h
+++ b/daemon.h
@@ -13,5 +13,8 @@ __attribute__((noreturn))
 #endif
 perr (const char *fmt, ...);
 
+void
+lerr (const char *fmt, ...);
+
 extern int daemon_debug;
 extern int daemon_foreground;
-- 
2.6.2


--=_Boundary-4920-1448292989-0001-2--
