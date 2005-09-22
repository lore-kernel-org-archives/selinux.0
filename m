Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8MKukNs023577
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 16:56:46 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8MKqCNV000175
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 20:52:13 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 22 Sep 2005 16:56:42 -0400
Message-Id: <1127422602.9788.25.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
Sourceforge from http://serefpolicy.sourceforge.net.  This release
includes the changes in the NSA CVS policy made since the previous
1.23.2 baseline policy.  In addition, several modules were added, and
many problems with compiling loadable modules have been fixed.  However,
not all modules can be compiled as loadable modules yet, due to a few
compiler issues that are being worked on now.  Initial support for MCS
was also added; the policy compiles, but it is untested.  The change log
follows at the bottom of the email.

Again, for those that are interesting in contributing, right now the
best help would be to convert existing policies over to reference
policy; there is a list of modules on the reference policy status page
on Sourceforge.  We are now using the NSA example policy in the
SourceForge CVS (http://selinux.sf.net) as a baseline for the policies.

* Thu Sep 22 2005 Chris PeBenito <selinux@tresys.com> - 20050922
- Make logrotate, sendmail, sshd, and rpm policies
  unconfined in the targeted policy so no special
  modules.conf is required.
- Add experimental MCS support.
- Add appconfig for MLS.
- Add equivalents for old can_resolve(), can_ldap(), and
  can_portmap() to sysnetwork.
- Fix base module compile issues.
- Added policies:
        cpucontrol
        cvs
        ktalk
        portmap
        postgresql
        rlogin
        samba
        snmp
        stunnel
        telnet
        tftp
        uucp
        vpn
        zebra

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
