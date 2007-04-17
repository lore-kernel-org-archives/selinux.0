Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HF63iT007437
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 11:06:03 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3HF62pd022213
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 15:06:03 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 17 Apr 2007 11:07:16 -0400
Message-Id: <1176822437.11059.3.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the
Tresys OSS site, http://oss.tresys.com.  The primary change in this
release is the addition of support for Booleans and tunables in modules.
For proper use of modules with Booleans, libsepol 1.16.2 or newer is
required.  Smaller changes include the merging of ls_exec_t and sbin_t
into bin_t, and the removal of disable_trans Booleans in the targeted
policy.  The complete change log for this release follows at the bottom
of the email.

For those that are interested in contributing, right now the best help
would be to test the strict policy.

* Tue Apr 17 2007 Chris PeBenito <selinux@tresys.com> - 20070417
- Patch for sasl's use of kerberos from Dan Walsh.
- Patches to confine ldconfig, udev, and insmod in the targeted policy from Dan Walsh.
- Man page updates from Dan Walsh.
- Two patches from Paul Moore to for ipsec to remove redundant rules and
  have setkey read the config file.
- Move booleans and tunables to modules when it is only used in a single
  module.
- Add support for tunables and booleans local to a module.
- Merge sbin_t and ls_exec_t into bin_t.
- Remove disable_trans booleans.
- Output different header sets for kernel and userland from flask headers.
- Marked the pax class as deprecated, changed it to userland so
  it will be removed from the kernel.
- Stop including netfilter contexts by default.
- Add dontaudits for init fds and console to init_daemon_domain().
- Patch to allow gpg to create user keys dir.
- Patch to support kvmfs from Dan Walsh.
- Patch for misc fixes in sudo from Dan Walsh.
- Patch to fix netlabel recvfrom MLS constraint from Paul Moore.
- Patch for handling restart of nscd when ran from useradd, groupadd, and
  admin passwd, from Dan Walsh.
- Patch for procmail, spamassassin, and pyzor updates from Dan Walsh.
- Patch for setroubleshoot for validating file contexts from Dan Walsh.
- Patch for gssd fixes from Dan Walsh.
- Patch for lvm fixes from Dan Walsh.
- Patch for ricci fixes from Dan Walsh.
- Patch for postfix lmtp labeling and pickup rule fix from Dan Walsh.
- Patch for kerberized telnet fixes from Dan Walsh.
- Patch for kerberized ftp and other ftp fixes from Dan Walsh.
- Patch for an additional wine executable from Dan Walsh.
- Eight patches for file contexts in games, wine, networkmanager, miscfiles,
  corecommands, devices, and java from Dan Walsh.
- Add support for libselinux 2.0.5 init_selinuxmnt() changes.
- Patch for misc fixes to bluetooth from Dan Walsh.
- Patch for misc fixes to kerberos from Dan Walsh.
- Patch to start deprecating usercanread attribute from Ryan Bradetich.
- Add dccp_socket object class which was added in kernel 2.6.20.
- Patch for prelink relabefrom it's temp files from Dan Walsh.
- Patch for capability fix for auditd and networking fix for syslogd from
  Dan Walsh.
- Patch to remove redundant mls_trusted_object() call from Dan Walsh.
- Patch for misc fixes to nis ypxfr policy from Dan Walsh.
- Patch to allow apmd to telinit from Dan Walsh.
- Patch for additional labeling of samba files from Stefan Schulze
  Frielinghaus.
- Patch to remove incorrect cron labeling in apache.fc from Ryan Bradetich.
- Fix ptys and ttys to be device nodes.
- Fix explicit use of httpd_t in openca_domtrans().
- Clean up file context regexes in apache and java, from Eamon Walsh.
- Patches from Dan Walsh:
        Thu, 25 Jan 2007
- Added modules:
        consolekit (Dan Walsh)
        fail2ban (Dan Walsh)
        zabbix (Dan Walsh)


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
