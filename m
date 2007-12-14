Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBEIvHcG005519
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 13:57:17 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lBEIvH0k026523
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2007 18:57:17 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 13:56:48 -0500
Message-Id: <1197658608.12626.216.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the
Tresys OSS site, http://oss.tresys.com.  In this release, the strict and
targeted policies were merged.  If the unconfined module is present, the
policy will act similar to the old targeted policy.  The difference is
that the roles that are available in the old strict policy continue to
be available, allowing a mix of confined and unconfined users.  If the
unconfined module is not present, the policy will act like the old
strict policy.  The merge also eases the transition from a targeted
policy to a strict policy, as the policy does not need to be replaced.
The complete change log for this release follows.

* Fri Dec 14 2007 Chris PeBenito <selinux@tresys.com> - 20071214
- Patch for debian logrotate to handle syslogd-listfiles, from Vaclav Ovsik.
- Improve several tunables descriptions from Dan Walsh.
- Patch to clean up ns switch usage in the policy from Dan Walsh.
- More complete labeled networking infrastructure from KaiGai Kohei.
- Add interface for libselinux constructor, for libselinux-linked
  SELinux-enabled programs.
- Patch to restructure user role templates to create restricted user roles
  from Dan Walsh.
- Russian man page translations from Andrey Markelov.
- Remove unused types from dbus.
- Add infrastructure for managing all user web content.
- Deprecate some old file and dir permission set macros in favor of the
  newer, more consistently-named macros.
- Patch to clean up unescaped periods in several file context entries from
  Jan-Frode Myklebust.
- Merge shlib_t into lib_t.
- Merge strict and targeted policies.  The policy will now behave like the
  strict policy if the unconfined module is not present.  If it is, it will
  behave like the targeted policy.  Added an unconfined role to have a mix
  of confined and unconfined users.
- Added modules:
        exim (Dan Walsh)
        postfixpolicyd (Jan-Frode Myklebust)


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
