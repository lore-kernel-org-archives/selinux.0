Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBCMZD5Z009874
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 17:35:13 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kBCMZh8p027780
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 22:35:44 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 17:35:42 -0500
Message-Id: <1165962942.11553.46.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the
Tresys OSS site, http://oss.tresys.com.  The primary change in this
release is the addition of support macros for common policy patterns.
These support macros create a blueprint of rules for a more abstract
access (for example, manage_files_pattern), and are similar to the old
rw_dir_create_file() and r_dir_file() macros of the example policy.
Policy patterns and new permission sets have been created for each
filesystem-based object class individually (file, lnk_file, dir, etc.),
so if a permission set change is needed for a particular class it will
not affect other classes.  As a result, the old permission sets
create_dir_perms and create_file_perms have changed; manage_dir_perms
and manage_file_perms should be used instead.  The complete change log
for this release follows at the bottom of the email.

For those that are interested in contributing, right now the best help
would be to test the strict policy.

* Tue Dec 12 2006 Chris PeBenito <selinux@tresys.com> - 20061212
- Add policy patterns support macros.  This changes the behavior of
  the create_dir_perms and create_file_perms permission sets.
- Association polmatch MLS constraint making unlabeled_t an exception
  is no longer needed, patch from Venkat Yekkirala.
- Context contains checking for PAM and cron from James Antill.
- Add a reload target to Modules.devel and change the load
  target to only insert modules that were changed.
- Allow semanage to read from /root on strict non-MLS for
  local policy modules.
- Gentoo init script fixes for udev.
- Allow udev to read kernel modules.inputmap.
- Dnsmasq fixes from testing.
- Allow kernel NFS server to getattr filesystems so df can work
  on clients.
- Patch from Matt Anderson for a MLS constraint exemption on a
  file that can be written to from a subject whose range is
  within the object's range.
- Enhanced setransd support from Darrel Goeddel.
- Patches from Dan Walsh:
        Tue, 24 Oct 2006
        Wed, 29 Nov 2006
- Added modules:
        aide (Matt Anderson)
        ccs (Dan Walsh)
        iscsi (Dan Walsh)
        ricci (Dan Walsh)


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
