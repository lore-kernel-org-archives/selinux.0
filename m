Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBDEQVkk019648
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 09:26:31 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBDEQU1s004804
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2007 14:26:30 GMT
Message-ID: <47614114.5090703@redhat.com>
Date: Thu, 13 Dec 2007 09:26:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Patches to files in the kernel policy directory
Content-Type: multipart/mixed;
 boundary="------------070408000601030405090809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070408000601030405090809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Added capabilicy to corecmd_exec_chroot

Added pgpkeyserver port definition

- -	Included squid patch to show use of pgpkeyserver

Addition of /dev/kvm

Add the ability to relabel from lnk_files labeled device_t

Add an interface to manage directories in /dev.  This is used by xserver.

dev_dontaudit_getattr_all_blk_files
	Should include blk_files labeled device_t

dev_dontaudit_getattr_all_chr_files
	Should include chr_files labeled device_t

Added interface
dev_rw_generic_usb_pipes
used by xserver


Added a hole bunch of dontaudit domain statements to remove tons of bug
reports.   These interfaces remove avc's genererated by the redirection
of stdout/stderr in tools like userhelper, and yum-updatesd or other rpm
daemons.  Also rhgb resets output on services when they start, you can
ifdef Redhat, but I think all distributions could use these or similar
rules.

Remove mount_domtrans from polyinstatiation macro since
auth_login_pgm_domain needs mount_domtrans for pam_mount so needs to be
outside of polyinstatiation.  Included authlogin_patch.

Added fs_manage_dos_dirs to be used by confined users that need to
manage a usb stick.

Add fs_use_xattr for ext4

add definition for vmblock

fix definition of kernel_rw_afs_state

Dontaudit proc_type and sysctl_type file getattr

Add getattr and dontaudit getattr when using security_t

When using telnetd, it creates a server_ptynode that the login sessions
need to access,  this needs to use added to generic_ptys handling.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHYUD/rlYvE4MpobMRAuHRAKDBt0mGqWC/Yc/1DxpWYcc/oPEItwCeNVCL
au6825mNvZQNRfOj3D7+93o=
=5BLE
-----END PGP SIGNATURE-----

--------------070408000601030405090809
Content-Type: application/x-gzip;
 name="kernel.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="kernel.patch.gz"

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
+H92ukr9C9yJBYpHUgAA
--------------070408000601030405090809
Content-Type: application/octet-stream;
 name="kernel.patch.gz.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="kernel.patch.gz.sig"

iD8DBQBHYUEArlYvE4MpobMRApeNAKCirSsSxYdfwNswiKqB/SIrtjkKRQCgwBwyeygIqJtl
Ft9g4aTWQtSg/+0=
--------------070408000601030405090809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
