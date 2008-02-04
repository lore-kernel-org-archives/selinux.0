Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14F6HIB002625
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 10:06:17 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14F6Fh9009213
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 15:06:16 GMT
Subject: Re: [refpolicy] samba
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, cpebenito@tresys.com
In-Reply-To: <47A71B22.90506@redhat.com>
References: <1202029647.2674.1.camel@vogon>  <47A71B22.90506@redhat.com>
Content-Type: multipart/mixed; boundary="=-IA3XE8JX9O2+QJQdTq/F"
Date: Mon, 04 Feb 2008 16:05:22 +0100
Message-Id: <1202137522.2667.5.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IA3XE8JX9O2+QJQdTq/F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, 2008-02-04 at 09:03 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stefan Schulze Frielinghaus wrote:
> > On Debian machines smbd needs append rights for samba logfiles.
> > 
> In Fedora smbd_t needs manage_files_pattern on smbd_log_t.  Our samba
> developers informed me that this is ok, since these are not security
> relevent log files.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAkenGyIACgkQrlYvE4MpobMFSgCcCAOhKW0zrOmRyf/6zifGOBj0
> IGcAoJ4dsNctCyp4k7LdaLbu468xbiK4
> =iw9h
> -----END PGP SIGNATURE-----

OK than we can easily substitute create_files_pattern with
manage_files_pattern. Attached patch should do that.

--=-IA3XE8JX9O2+QJQdTq/F
Content-Disposition: attachment; filename=samba.te.patch
Content-Type: text/x-patch; name=samba.te.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- /usr/src/refpolicy-20071214/policy/modules/services/samba.te	2007-12-14 15:23:18.000000000 +0100
+++ policy/modules/services/samba.te	2008-02-04 15:59:56.000000000 +0100
@@ -222,7 +222,7 @@
 allow smbd_t samba_etc_t:file { rw_file_perms setattr };
 
 create_dirs_pattern(smbd_t,samba_log_t,samba_log_t)
-create_files_pattern(smbd_t,samba_log_t,samba_log_t)
+manage_files_pattern(smbd_t,samba_log_t,samba_log_t)
 allow smbd_t samba_log_t:dir setattr;
 dontaudit smbd_t samba_log_t:dir remove_name;
 

--=-IA3XE8JX9O2+QJQdTq/F--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
