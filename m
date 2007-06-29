Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5THW2ie003310
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 13:32:02 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5THW2Ht003057
	for <selinux@tycho.nsa.gov>; Fri, 29 Jun 2007 17:32:02 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 13:30:08 -0400
Message-Id: <1183138208.25710.7.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the
Tresys OSS site, http://oss.tresys.com.  In this release, the restorecon
and setfiles policies were merged, and unified labeled networking
support for IPSEC and NetLabel implementations was added.  The complete
change log for this release follows.

* Fri Jun 29 2007 Chris PeBenito <selinux@tresys.com> - 20070629
- Fix incorrectly named files_lib_filetrans_shared_lib() interface in the
  libraries module.
- Unified labeled networking policy from Paul Moore.
- Use netmsg initial SID for MLS-only Netlabel packets, from Paul Moore.
- Xen updates from Dan Walsh.
- Filesystem updates from Dan Walsh.
- Large samba update from Dan Walsh.
- Drop snmpd_etc_t.
- Confine sendmail and logrotate on targeted.
- Tunable connection to postgresql for users from KaiGai Kohei.
- Memprotect support patch from Stephen Smalley.
- Add logging_send_audit_msgs() interface and deprecate
  send_audit_msgs_pattern().
- Openct updates patch from Dan Walsh.
- Merge restorecon into setfiles.
- Patch to begin separating out hald helper programs from Dan Walsh.
- Fixes for squid, dovecot, and snmp from Dan Walsh.
- Miscellaneous consolekit fixes from Dan Walsh.
- Patch to have avahi use the nsswitch interface rather than individual
  permissions from Dan Walsh.
- Patch to dontaudit logrotate searching avahi pid directory from Dan Walsh.
- Patch to allow insmod to mount kvmfs and dontaudit rw unconfined_t pipes
  to handle usage from userhelper from Dan Walsh.
- Patch to allow amavis to read spamassassin libraries from Dan Walsh.
- Patch to allow slocate to getattr other filesystems and directories on those
  filesystems from Dan Walsh.
- Fixes for RHEL4 from the CLIP project.
- Replace the old lrrd fc entries with munin ones.
- Move program admin template usage out of userdom_admin_user_template() to
  sysadm policy in userdomain.te to fix usage of the template for third
  parties.
- Fix clockspeed_run_cli() declaration, it was incorrectly defined as a
  template instead of an interface.
- Added modules:
        amtu (Dan Walsh)
        apcupsd (Dan Walsh)
        rpcbind (Dan Walsh)
        rwho (Nalin Dahyabhai)


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
