Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m32IGT3S021286
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2008 14:16:29 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m32IGQo9016244
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2008 18:16:27 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: ANN: Reference Policy Release
Date: Wed, 2 Apr 2008 14:14:40 -0400
Message-ID: <1207160080.21840.45.camel@gorn>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "SELinux Mail List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the
Tresys OSS site, http://oss.tresys.com.  In this release, core
infrastructure for the X Windows userspace object manager (aka XSELinux
or Security Enhanced X Windows) was added.  This release focused on the
structure of the X policy and thus is not complete (it won't run in
enforcing).  Inter-domain accesses, for example, copying from evolution
and pasting to firefox, have not yet been added to the policy.  The
complete change log for this release follows at the end of the email.

For people interested in helping develop the X policy, the
xserver_object_manager tunable should be enabled, along with the object
manager support in Xorg.

* Wed Apr 02 2008 Chris PeBenito <selinux@tresys.com> - 20080402
- Add core Security Enhanced X Windows support.
- Fix winbind socket connection interface for default location of the
  sock_file.
- Add wireshark module based on ethereal module.
- Revise upstart support in init module to use a tunable, as upstart is now
  used in Fedora too.
- Add iferror.m4 rather generate it out of the Makefiles.
- Definitions for open permisson on file and similar objects from Eric
  Paris.
- Apt updates for ptys and logs, from Martin Orr.
- RPC update from Vaclav Ovsik.
- Exim updates on Debian from Devin Carrawy.
- Pam and samba updates from Stefan Schulze Frielinghaus.
- Backup update on Debian from Vaclav Ovsik.
- Cracklib update on Debian from Vaclav Ovsik.
- Label /proc/kallsyms with system_map_t.
- 64-bit capabilities from Stephen Smalley.
- Labeled networking peer object class updates.


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
