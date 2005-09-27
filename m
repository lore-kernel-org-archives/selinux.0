Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RAwJNs019600
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 06:58:19 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RAqscJ016390
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 10:52:55 GMT
Received: from lkcl.net (unknown [87.82.24.192])
	by free.hands.com (Postfix) with ESMTP id 0A3C5C005
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 11:18:55 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1EKCXw-00062o-7W
	for selinux@tycho.nsa.gov; Tue, 27 Sep 2005 11:18:48 +0100
Date: Tue, 27 Sep 2005 11:18:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [owner@bugs.debian.org: Bug#249499 acknowledged by developer (Bug#249499: fixed in pam 0.79-1)]
Message-ID: <20050927101848.GF11050@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

heya folks,

is this the right thing to have been done?

----- Forwarded message from Debian Bug Tracking System <owner@bugs.debian.org> -----

From: Debian Bug Tracking System <owner@bugs.debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>

This is an automatic notification regarding your Bug report
#249499: pam: [patch] - SElinux (security enhanced linux),
which was filed against the pam package.

It has been closed by one of the developers, namely
Steve Langasek <vorlon@debian.org>.

Source: pam
Source-Version: 0.79-1

We believe that the bug you reported is fixed in the latest version of
pam, which is due to be installed in the Debian FTP archive:

libpam-cracklib_0.79-1_i386.deb
  to pool/main/p/pam/libpam-cracklib_0.79-1_i386.deb
libpam-doc_0.79-1_all.deb
  to pool/main/p/pam/libpam-doc_0.79-1_all.deb
libpam-modules_0.79-1_i386.deb
  to pool/main/p/pam/libpam-modules_0.79-1_i386.deb
libpam-runtime_0.79-1_all.deb
  to pool/main/p/pam/libpam-runtime_0.79-1_all.deb
libpam0g-dev_0.79-1_i386.deb
  to pool/main/p/pam/libpam0g-dev_0.79-1_i386.deb
libpam0g_0.79-1_i386.deb
  to pool/main/p/pam/libpam0g_0.79-1_i386.deb
pam_0.79-1.diff.gz
  to pool/main/p/pam/pam_0.79-1.diff.gz
pam_0.79-1.dsc
  to pool/main/p/pam/pam_0.79-1.dsc
pam_0.79.orig.tar.gz
  to pool/main/p/pam/pam_0.79.orig.tar.gz


   * New upstream version (closes: #284954, #300775).
     - includes some fixes for typos (closes: #319026).
     - pam_unix should now be LSB 3.0-compliant (closes: #323982).
     - fixes segfaults in libpam on config file syntax errors
       (closes: #330097).
   * Drop patches 000_bootstrap, 004_libpam_makefile_static_works,
     011_pam_access, 013_pam_filter_termio_to_termios, 017_misc_fixes,
     025_pam_group_conffile_name, 028_pam_mail_delete_only_when_set,
     033_use_gcc_not_ld, 034_pam_dispatch_ignore_PAM_IGNORE,
     035_pam_unix_security, 039_pam_mkhomedir_no_maxpathlen_required,
     041_call_bootstrap, 042_pam_mkhomedir_dest_not_source_for_errors,
     051_32_bit_pam_lastlog_ll_time, and
     053_pam_unix_user_known_returns_user_unknown which have been
     integrated upstream.
   * Merge one last bit of patch 053 into patch 043, where it should have
     been in the first place
   * Patch 057: SELinux support:
     - add support to pam_unix for copying SELinux security contexts when
       writing out new passwd/shadow files and creating lockfiles
     - support calling unix_chkpwd if opening /etc/shadow fails due to
       SELinux permissions
     - allow unix_chkpwd to authenticate for any user when in an SELinux
       context (hurray!); we depend on SELinux policies to prevent the
       helper's use as a brute force tool
     - also support querying user expiration info via unix_chkpwd
     - misc cleanup: clean up file descriptors when invoking unix_chkpwd
       (closes: #248310)
     - make pam_rootok check the SELinux passwd class permissions, not just
       the uid
     - add new pam_selinux module (closes: #249499)
   * Build-depend on libselinux1-dev.
   * Fix pam_getenv, so that it can read the actual format of /etc/environment
     instead of trying to read it using the syntax of
     /etc/security/pam_env.conf; thanks to Colin Watson for the patch.
     Closes: #327876.
   * Set LC_COLLATE=C when using alphabetic range expressions in
     debian/rules; bah, so *that's* what kept happening to my README file
     when trying to build out of svn!  Closes: #295296.
   * Add a reference to the text of the GPL to debian/copyright.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
