Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96AsgrT003318
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 06:54:42 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96AseKB003978
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 10:54:41 GMT
Message-ID: <4163CF0D.4070201@gentoo.org>
Date: Wed, 06 Oct 2004 13:55:09 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Erich Schubert <erich@debian.org>
CC: selinux@tycho.nsa.gov
Subject: Re: gentoo diff for mysqld
References: <41625B74.2090503@gentoo.org> <1097001016.15549.4.camel@wintermute.xmldesign.de>
In-Reply-To: <1097001016.15549.4.camel@wintermute.xmldesign.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCEF598F086BCDC02E4BBDA3C"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCEF598F086BCDC02E4BBDA3C
Content-Type: multipart/mixed;
 boundary="------------030907060205090507040407"

This is a multi-part message in MIME format.
--------------030907060205090507040407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

Erich Schubert wrote:
> Hi,
> 
> 
>>+# if controled by daemontools
>>+ifdef(`daemontools.te', `
>>+domain_auto_trans( svc_run_t, mysqld_exec_t, mysqld_t)
>>+allow svc_start_t mysqld_t:process signal;
>>+svc_ipc_domain(mysqld_t)
>>+')dnl end ifdef daemontools
> 
> 
> I think the "deamontools.te" ifdef is enough, why put this into the
> "gentoo" ifdef, too?
> Please don't use distro-ifdefs unneccessarily. Basically anything being
> in {FHS,upstream,best-practice} should be outside of such ifdefs.
> Only things dependant on non-generic domains or non-standard behaviour -
> for example the gentoo init - should be wrapped IMHO.

I'm glad you think this way.
Here is a new patch with no distro_gentoo ifdefs.
Also can someone please tell me when is that 'allow mysqld_t sysadm_home_t:file { read getattr };' needed?
I have never felt the need for that rule and I'd be happy to see it go.

> Greetings,
> Erich Schubert

thanks,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------030907060205090507040407
Content-Type: text/plain;
 name="mysql.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mysql.diff"

--- /root/public_html/policy/nsa/domains/program/unused/mysqld.te	2004-08-30 23:35:32.000000000 +0300
+++ /etc/security/selinux/src/policy/domains/program/mysqld.te	2004-10-06 04:36:23.704673096 +0300
@@ -23,7 +23,8 @@
 
 log_domain(mysqld)
 
-allow mysqld_t tmp_t:dir { getattr read };
+# for temporary tables
+tmp_domain(mysqld)
 
 allow mysqld_t usr_t:file { getattr read };
 
@@ -57,10 +58,6 @@
 
 can_unix_connect(sysadm_t, mysqld_t)
 
-# for /root/.my.cnf - should not be needed
-allow mysqld_t sysadm_home_dir_t:dir search;
-allow mysqld_t sysadm_home_t:file { read getattr };
-
 ifdef(`logrotate.te', `
 r_dir_file(logrotate_t, mysqld_etc_t)
 allow logrotate_t mysqld_db_t:dir search;
@@ -74,6 +71,12 @@
 allow userdomain mysqld_var_run_t:sock_file write;
 ')
 
+ifdef(`daemontools.te', `
+domain_auto_trans( svc_run_t, mysqld_exec_t, mysqld_t)
+allow svc_start_t mysqld_t:process signal;
+svc_ipc_domain(mysqld_t)
+')dnl end ifdef daemontools
+
 ifdef(`distro_redhat', `
 allow initrc_t mysqld_db_t:dir create_dir_perms;
 

--------------030907060205090507040407--

--------------enigCEF598F086BCDC02E4BBDA3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBY88NGSBEIeh4AEYRAmcSAJ48Pzux5cENTvUJp9OVp1sGgKRGxACfT8Jp
RNHfkXbcNxFDhuquN/kA9jM=
=knVc
-----END PGP SIGNATURE-----

--------------enigCEF598F086BCDC02E4BBDA3C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
