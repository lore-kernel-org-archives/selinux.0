Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tANFZ9Tm004236
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 10:35:10 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 10B3D1A1D8
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 16:34:56 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Sex4mjMIlsLL for <selinux@tycho.nsa.gov>;
 Mon, 23 Nov 2015 16:34:50 +0100 (CET)
Received: from [IPv6:2a02:578:85fc:1:c84e:489:bf64:5e4f] (unknown
 [IPv6:2a02:578:85fc:1:c84e:489:bf64:5e4f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id B46031A070
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 16:34:50 +0100 (CET)
Subject: Re: (Userspace) AVC denial generated even if allowed by the policy?
To: selinux@tycho.nsa.gov
References: <5652636F.2060609@debian.org>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <56533218.7090601@debian.org>
Date: Mon, 23 Nov 2015 16:34:48 +0100
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Boundary-11444-1448292963-0001-2"
In-Reply-To: <5652636F.2060609@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-11444-1448292963-0001-2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

Le 23/11/15 01:53, Laurent Bigonville a =C3=A9crit :
> Hi,
>
> I'm still looking at adding SELinux support in the "at" daemon and I 
> now have the following patch[0].
>
> With this patch, at seems to behave like the cron daemon, as explained=
 
> in the commit log:
>
>     - When cron_userdomain_transition is set to off, a process for an
>       unconfined user will transition to unconfined_cronjob_t. For 
> confined
>       user, the job is run as cronjob_t.
>
>     - When cron_userdomain_transition is set to on, the processes are =
run
>       under the user default context.
>
> But every time an AVC denial is generated (with 
> cron_userdomain_transition set to off and the user running as staff_u,=
 
> in permissive with unmodified refpolicy):
>
> avc:  denied  { entrypoint } for scontext=3Dstaff_u:staff_r:cronjob_t:=
s0 
> tcontext=3Dstaff_u:object_r:user_cron_spool_t:s0 tclass=3Dfile
>
> The job runs as (id -Z): staff_u:staff_r:cronjob_t:s0
>
> But audit2{allow,why} are saying that this is already allowed in the 
> policy
>
> Setting the cron_userdomain_transition boolean to on, I have the 
> following avc:
>
> avc:  denied  { entrypoint } for scontext=3Dstaff_u:sysadm_r:sysadm_t:=
s0 
> tcontext=3Dstaff_u:object_r:user_cron_spool_t:s0 tclass=3Dfile
>
> The job runs as (id -Z): staff_u:sysadm_r:sysadm_t:s0
>
> So as said it seems to work, but I'm not sure why this AVC denial is 
> generated.
>
> sesearch shows:
>
> $ sesearch -ATSC  -t user_cron_spool_t -c file -p entrypoint
> Found 6 semantic av rules:
>    allow files_unconfined_type file_type : file { ioctl read write 
> create getattr setattr lock relabelfrom relabelto append unlink link 
> rename execute swapon quotaon mounton execute_no_trans entrypoint open=
 
> audit_access } ;
> DT allow unconfined_t user_cron_spool_t : file entrypoint ; [ 
> cron_userdomain_transition ]
> DT allow user_t user_cron_spool_t : file entrypoint ; [ 
> cron_userdomain_transition ]
> EF allow cronjob_t user_cron_spool_t : file entrypoint ; [ 
> cron_userdomain_transition ]
> DT allow staff_t user_cron_spool_t : file entrypoint ; [ 
> cron_userdomain_transition ]
> DT allow sysadm_t user_cron_spool_t : file entrypoint ; [ 
> cron_userdomain_transition ]
>
> Did I overlooked something?
>
> Cheers,
>
> Laurent Bigonville
>
> [0] 
> https://anonscm.debian.org/cgit/users/bigon/at.git/commit/?h=3Dselinux=
&id=3D0112f006b74a36f7200e315575fd25d78e11b170

I'm attaching the patch to this mail for the people that cannot access 
the website and FTR.

Cheers,

Laurent Bigonville


--=_Boundary-11444-1448292963-0001-2
Content-Type: text/x-patch; name="0001-Allow-the-user-cronjobs-to-run-in-their-userdomain.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Allow-the-user-cronjobs-to-run-in-their-userdomain.patc";
 filename*1="h"

>From c8aa69e51d8781da782a50dbdf20b258288093d4 Mon Sep 17 00:00:00 2001
From: Laurent Bigonville <bigon@bigon.be>
Date: Mon, 23 Nov 2015 12:25:13 +0100
Subject: [PATCH] Allow the user cronjobs to run in their userdomain

When cron_userdomain_transition boolean is set to on, the user cronjobs
are supposed to run in their domains. Without this patch the default
context is not properly computed:

    $ /usr/sbin/getdefaultcon user_u system_u:system_r:crond_t:s0
    /usr/sbin/getdefaultcon: Invalid argument
    $ /usr/sbin/getdefaultcon staff_u system_u:system_r:crond_t:s0
    staff_u:sysadm_r:sysadm_t:s0

With this patch applied:

    $ /usr/sbin/getdefaultcon user_u system_u:system_r:crond_t:s0
    user_u:user_r:user_t:s0
    $ /usr/sbin/getdefaultcon staff_ system_u:system_r:crond_t:s0
    staff_u:staff_r:staff_t:s0
---
 config/appconfig-mcs/staff_u_default_contexts      | 2 +-
 config/appconfig-mcs/user_u_default_contexts       | 2 +-
 config/appconfig-mls/staff_u_default_contexts      | 2 +-
 config/appconfig-mls/user_u_default_contexts       | 2 +-
 config/appconfig-standard/staff_u_default_contexts | 2 +-
 config/appconfig-standard/user_u_default_contexts  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/config/appconfig-mcs/staff_u_default_contexts b/config/appconfig-mcs/staff_u_default_contexts
index 881a292..5606c4e 100644
--- a/config/appconfig-mcs/staff_u_default_contexts
+++ b/config/appconfig-mcs/staff_u_default_contexts
@@ -1,7 +1,7 @@
 system_r:local_login_t:s0	staff_r:staff_t:s0 sysadm_r:sysadm_t:s0
 system_r:remote_login_t:s0	staff_r:staff_t:s0
 system_r:sshd_t:s0		staff_r:staff_t:s0 sysadm_r:sysadm_t:s0
-system_r:crond_t:s0		staff_r:cronjob_t:s0
+system_r:crond_t:s0		staff_r:staff_t:s0 staff_r:cronjob_t:s0
 system_r:xdm_t:s0		staff_r:staff_t:s0
 staff_r:staff_su_t:s0		staff_r:staff_t:s0
 staff_r:staff_sudo_t:s0		staff_r:staff_t:s0
diff --git a/config/appconfig-mcs/user_u_default_contexts b/config/appconfig-mcs/user_u_default_contexts
index cacbc93..56d6071 100644
--- a/config/appconfig-mcs/user_u_default_contexts
+++ b/config/appconfig-mcs/user_u_default_contexts
@@ -1,7 +1,7 @@
 system_r:local_login_t:s0	user_r:user_t:s0
 system_r:remote_login_t:s0	user_r:user_t:s0
 system_r:sshd_t:s0		user_r:user_t:s0
-system_r:crond_t:s0		user_r:cronjob_t:s0
+system_r:crond_t:s0		user_r:user_t:s0 user_r:cronjob_t:s0
 system_r:xdm_t:s0		user_r:user_t:s0
 user_r:user_su_t:s0		user_r:user_t:s0
 user_r:user_sudo_t:s0		user_r:user_t:s0
diff --git a/config/appconfig-mls/staff_u_default_contexts b/config/appconfig-mls/staff_u_default_contexts
index 881a292..5606c4e 100644
--- a/config/appconfig-mls/staff_u_default_contexts
+++ b/config/appconfig-mls/staff_u_default_contexts
@@ -1,7 +1,7 @@
 system_r:local_login_t:s0	staff_r:staff_t:s0 sysadm_r:sysadm_t:s0
 system_r:remote_login_t:s0	staff_r:staff_t:s0
 system_r:sshd_t:s0		staff_r:staff_t:s0 sysadm_r:sysadm_t:s0
-system_r:crond_t:s0		staff_r:cronjob_t:s0
+system_r:crond_t:s0		staff_r:staff_t:s0 staff_r:cronjob_t:s0
 system_r:xdm_t:s0		staff_r:staff_t:s0
 staff_r:staff_su_t:s0		staff_r:staff_t:s0
 staff_r:staff_sudo_t:s0		staff_r:staff_t:s0
diff --git a/config/appconfig-mls/user_u_default_contexts b/config/appconfig-mls/user_u_default_contexts
index cacbc93..56d6071 100644
--- a/config/appconfig-mls/user_u_default_contexts
+++ b/config/appconfig-mls/user_u_default_contexts
@@ -1,7 +1,7 @@
 system_r:local_login_t:s0	user_r:user_t:s0
 system_r:remote_login_t:s0	user_r:user_t:s0
 system_r:sshd_t:s0		user_r:user_t:s0
-system_r:crond_t:s0		user_r:cronjob_t:s0
+system_r:crond_t:s0		user_r:user_t:s0 user_r:cronjob_t:s0
 system_r:xdm_t:s0		user_r:user_t:s0
 user_r:user_su_t:s0		user_r:user_t:s0
 user_r:user_sudo_t:s0		user_r:user_t:s0
diff --git a/config/appconfig-standard/staff_u_default_contexts b/config/appconfig-standard/staff_u_default_contexts
index c2a5ea8..300694c 100644
--- a/config/appconfig-standard/staff_u_default_contexts
+++ b/config/appconfig-standard/staff_u_default_contexts
@@ -1,7 +1,7 @@
 system_r:local_login_t		staff_r:staff_t sysadm_r:sysadm_t
 system_r:remote_login_t		staff_r:staff_t
 system_r:sshd_t			staff_r:staff_t sysadm_r:sysadm_t
-system_r:crond_t		staff_r:cronjob_t
+system_r:crond_t		staff_r:staff_t staff_r:cronjob_t
 system_r:xdm_t			staff_r:staff_t
 staff_r:staff_su_t		staff_r:staff_t
 staff_r:staff_sudo_t		staff_r:staff_t
diff --git a/config/appconfig-standard/user_u_default_contexts b/config/appconfig-standard/user_u_default_contexts
index f5bfac3..63b7eec 100644
--- a/config/appconfig-standard/user_u_default_contexts
+++ b/config/appconfig-standard/user_u_default_contexts
@@ -1,7 +1,7 @@
 system_r:local_login_t		user_r:user_t
 system_r:remote_login_t		user_r:user_t
 system_r:sshd_t			user_r:user_t
-system_r:crond_t		user_r:cronjob_t
+system_r:crond_t		user_r:user_t user_r:cronjob_t
 system_r:xdm_t			user_r:user_t
 user_r:user_su_t		user_r:user_t
 user_r:user_sudo_t		user_r:user_t
-- 
2.6.2


--=_Boundary-11444-1448292963-0001-2--
