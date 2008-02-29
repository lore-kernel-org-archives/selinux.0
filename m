Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1TFTGee010406
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 10:29:16 -0500
Received: from ppsw-6.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1TFTDQO007637
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 15:29:14 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:52958)
	by ppsw-6.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.136]:25)
	with esmtp id 1JV7AZ-0001xT-L1 (Exim 4.67) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Fri, 29 Feb 2008 15:29:07 +0000
Message-ID: <47C824BE.5040001@martinorr.name>
Date: Fri, 29 Feb 2008 15:29:02 +0000
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_caligula-4875-1204298947-0001-2"
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: [DSE-Dev] refpolicy: patch for ldconfig from glibc 2.7,	new patch
References: <20080222152703.GA4163@bobek.pm.i.cz>	<1203703539.32061.22.camel@gorn> <20080229072116.GA13364@bobek.pm.i.cz> <1204292761.32061.230.camel@gorn>
In-Reply-To: <1204292761.32061.230.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-4875-1204298947-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by courier 0.58.0.20080127

On 29/02/08 13:46, Christopher J. PeBenito wrote:
> On Fri, 2008-02-29 at 08:21 +0100, V=E1clav Ovs=EDk wrote:
>> When se_aptitude or se_apt is ran on Debian (apt or aptitude execution =
wrapped
>> with run_init), then the ldconfig called from a postinst and/or a post=
rm
>> scripts of shared libs brings following denials:
>>
>> Feb 28 12:24:59 sid kernel: audit(1204197899.429:13): avc:  denied  { =
read write } for  pid=3D3209 comm=3D"ldconfig" name=3D"2" dev=3Ddevpts in=
o=3D4 scontext=3Dsystem_u:system_r:ldconfig_t:s0 tcontext=3Dsystem_u:obje=
ct_r:devpts_t:s0 tclass=3Dchr_file
>> Feb 28 12:24:59 sid kernel: audit(1204197899.429:14): avc:  denied  { =
use } for  pid=3D3209 comm=3D"ldconfig" name=3D"2" dev=3Ddevpts ino=3D4 s=
context=3Dsystem_u:system_r:ldconfig_t:s0 tcontext=3Dsystem_u:system_r:ap=
t_t:s0 tclass=3Dfd
>> Feb 28 12:24:59 sid kernel: audit(1204197899.429:15): avc:  denied  { =
write } for  pid=3D3209 comm=3D"ldconfig" name=3D"[23124]" dev=3Dpipefs i=
no=3D23124 scontext=3Dsystem_u:system_r:ldconfig_t:s0 tcontext=3Dsystem_u=
:system_r:apt_t:s0 tclass=3Dfifo_file
>>
>> The attached patch (wich replaces my previos patch) suppresses these m=
essages.
>> Maybe this could be solved also by adding unconfined_domain(ldconfig_t=
) like
>> Fedora or Ubuntu solves this. (This could be added to.)
>=20
> The apt rules are fine, but there shouldn't be any more generic pty
> usage anymore.  Are you using an older policy that doesn't have strict
> and targeted merged (and unconfined_r)?

It's because apt creates a pty of its own to run dpkg on, so it can log t=
he
output.  (This is fairly recent - it has been in apt trunk since October.=
)

The attached patch is what I am using to deal with this.  (I'm not sure i=
f
it should be apt_dontaudit_use_fds(ldconfig_t) or apt_use_fds(ldconfig_t)
but dontaudit is what the Debian policy package uses.)

Best wishes,

--=20
Martin Orr

--=_caligula-4875-1204298947-0001-2
Content-Type: text/plain; name="101_apt_dpkg_log"; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="101_apt_dpkg_log"

Written by: Martin Orr
with bits from:
srivasta@debian.org--lenny/refpolicy--debian--0.0--patch-12
srivasta@debian.org--lenny/refpolicy--debian--0.0--patch-13

Combines 501_apt_create_pty with bits from 365_apt_fixes

Cope with apt creating a new pty to run dpkg

Index: policy/modules/admin/apt.fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/admin/apt.fc.orig	2008-02-29 14:55:59.000000000 +0000
+++ policy/modules/admin/apt.fc	2008-02-29 14:56:46.000000000 +0000
@@ -11,3 +11,6 @@
 # package list repository
 /var/lib/apt(/.*)?			gen_context(system_u:object_r:apt_var_lib_t,s0)
 /var/lib/aptitude(/.*)?		gen_context(system_u:object_r:apt_var_lib_t,s0)=

+
+# dpkg terminal log
+/var/log/apt(/.*)?			gen_context(system_u:object_r:apt_var_log_t,s0)
Index: policy/modules/admin/apt.if
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/admin/apt.if.orig	2008-02-29 14:55:59.000000000 +0000
+++ policy/modules/admin/apt.if	2008-02-29 14:56:46.000000000 +0000
@@ -92,6 +92,25 @@
=20
 ########################################
 ## <summary>
+##     Do not audit attempts to use file descriptors from apt.
+## </summary>
+## <param name=3D"domain">
+##     <summary>
+##     The type of the process attempting performing this action
+##      which should not be audited.
+##     </summary>
+## </param>
+#
+interface(`apt_dontaudit_use_fds',`
+	gen_require(`
+		type apt_t;
+	')
+
+	dontaudit $1 apt_t:fd use;
+')
+
+########################################
+## <summary>
 ##	Read and write an unnamed apt pipe.
 ## </summary>
 ## <param name=3D"domain">
@@ -111,6 +130,24 @@
=20
 ########################################
 ## <summary>
+##	Read from and write to apt ptys.
+## </summary>
+## <param name=3D"domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apt_use_ptys',`
+	gen_require(`
+		type apt_devpts_t;
+	')
+
+	allow $1 apt_devpts_t:chr_file rw_term_perms;
+')
+
+########################################
+## <summary>
 ##	Read the apt package database.
 ## </summary>
 ## <param name=3D"domain">
Index: policy/modules/admin/apt.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/admin/apt.te.orig	2008-02-29 14:55:59.000000000 +0000
+++ policy/modules/admin/apt.te	2008-02-29 14:57:02.000000000 +0000
@@ -1,5 +1,5 @@
=20
-policy_module(apt,1.3.0)
+policy_module(apt,1.3.1)
=20
 ########################################
 #
@@ -26,6 +26,13 @@
 type apt_var_cache_t alias var_cache_apt_t;
 files_type(apt_var_cache_t)
=20
+type apt_var_log_t alias var_log_apt_t;
+logging_log_file(apt_var_log_t)
+
+# pseudo terminal for running dpkg
+type apt_devpts_t;
+term_pty(apt_devpts_t)
+
 ########################################
 #
 # apt Local policy
@@ -97,6 +104,7 @@
=20
 fs_getattr_all_fs(apt_t)
=20
+term_create_pty(apt_t, apt_devpts_t)
 term_list_ptys(apt_t)
 term_use_all_terms(apt_t)
=20
Index: policy/modules/admin/dpkg.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/admin/dpkg.te.orig	2008-02-29 14:55:59.000000000 +0000=

+++ policy/modules/admin/dpkg.te	2008-02-29 14:56:46.000000000 +0000
@@ -172,6 +172,10 @@
 # since the scripts aren't labeled correctly yet...
 allow dpkg_t dpkg_var_lib_t:file execute;
=20
+optional_policy(`
+	apt_use_ptys(dpkg_t)
+')
+
 # TODO: allow?
 #optional_policy(`
 #	cron_system_entry(dpkg_t,dpkg_exec_t)
Index: policy/modules/system/libraries.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- policy/modules/system/libraries.te.orig	2008-02-29 14:55:59.000000000=
 +0000
+++ policy/modules/system/libraries.te	2008-02-29 14:56:46.000000000 +000=
0
@@ -98,6 +98,11 @@
 ')
=20
 optional_policy(`
+	apt_dontaudit_use_fds(ldconfig_t)
+	apt_use_ptys(ldconfig_t)
+')
+
+optional_policy(`
 	# When you install a kernel the postinstall builds a initrd image in tm=
p=20
 	# and executes ldconfig on it.  If you dont allow this kernel installs =

 	# blow up.

--=_caligula-4875-1204298947-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
