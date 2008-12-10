Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBAKOaGj028433
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 15:24:36 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id mBAKMNFH020960
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2008 20:22:23 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 10 Dec 2008 15:24:29 -0500
Message-Id: <1228940671.7040.38.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new, major release of the SELinux Reference Policy is now available on
the Tresys OSS site, http://oss.tresys.com.  In this release, the type
enforcement-based role separation was replaced with SELinux user-based
access control (UBAC) role separation.  This support deprecates the
per-role templates and rolemap support of the policy.  It also breaks
some compatibility in the interfaces API; however, the compatibility for
types and other policy symbols has been preserved.

Due to the magnitude of this change, the Reference Policy version scheme
has slightly changed, by adding a major number (2) to the version.
Previous versions are considered 1.yyyymmdd releases.

The The complete change log for this release follows at the end of the
email.

For people interested in helping Reference Policy development, the X
desktop and role separation needs testing.

* Wed Dec 10 2008 Chris PeBenito <selinux@tresys.com> - 2.20081210
- Fix consistency of audioentropy and iscsi module naming.
- Debian file context fix for xen from Russell Coker.
- Xserver MLS fix from Eamon Walsh.
- Add omapi port for dhcpcd.
- Deprecate per-role templates and rolemap support.
- Implement user-based access control for use as role separations.
- Move shared library calls from individual modules to the domain module.
- Enable open permission checks policy capability.
- Remove hierarchy from portage module as it is not a good example of
  hierarchy.
- Remove enableaudit target from modular build as semodule -DB supplants it.
- Added modules:
        milter (Paul Howarth)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
