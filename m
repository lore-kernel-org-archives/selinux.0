Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l2MKA18S030019
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 16:10:01 -0400
Subject: ANN:  Updated SELinux core userland release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 22 Mar 2007 16:04:56 -0400
Message-Id: <1174593896.31436.158.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An updated release of the SELinux core userland code is available from
the NSA web site, see:
http://www.nsa.gov/selinux/news.cfm#R070322

This is the first release to include the new development series along
with the stable series.  The most significant change so far in the
development series is the introduction of the sepolgen python module for
policy generation and the rewrite of audit2allow to use it.  Note that
the sepolgen interfaces are still subject to change.  A number of bug
fixes and code cleanups have also been applied to both the development
and the stable series since the last release.

Papers and presentations by NSA employees from the 2007 SELinux
Symposium last week have been added to the documentation page on the NSA
site; these should also appear on the SELinux Symposium site in the
future along with the other talks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
