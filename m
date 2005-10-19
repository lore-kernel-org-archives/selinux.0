Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9JLqHNs025432
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 17:52:17 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9JLnTjJ009873
	for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2005 21:49:29 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 17:50:10 -0400
Message-Id: <1129758610.10739.23.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
Sourceforge from http://serefpolicy.sourceforge.net.  All loadable
modules can now be compiled with a compiler that has the
require-in-conditional, declare-then-require, and stack-overflow patches
applied; however, the linked policy has not been thoroughly tested.  We
attempted to load the policy once, but the kernel oopsed; we will try to
reproduce this and investigate it.  The change log follows at the bottom
of the email.

Again, for those that are interesting in contributing, right now the
best help would be to convert existing policies over to reference
policy; there is a list of modules on the reference policy status page
on Sourceforge.  We are now using the Dan Walsh's Rawhide policy
(ftp://people.redhat.com/dwalsh/SELinux/Fedora/) as a baseline for the
policies.

* Wed Oct 19 2005 Chris PeBenito <selinux@tresys.com> - 20051019
- Many fixes to make loadable modules build.
- Add targets for sechecker.
- Updated to sedoctool to read bool files and tunable
  files separately.
- Changed the xml tag of <boolean> to <bool> to be consistent
  with gen_bool().
- Modified the implementation of segenxml to use regular
  expressions.
- Rename context_template() to gen_context() to clarify
  that its not a Reference Policy template, but a support
  macro.
- Add disable_*_trans bool support for targeted policy.
- Add MLS module to handle MLS constraint exceptions,
  such as reading up and writing down.
- Fix errors uncovered by sediff and sechecker.
- Added policies:
        anaconda
        apache
        apm
        arpwatch
        bluetooth
        dmidecode
        finger
        ftp
        kudzu
        mailman
        ppp
        radvd
        radius
        sasl
        webalizer

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
