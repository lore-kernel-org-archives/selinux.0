Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1MGigaw003067
	for <selinux@tycho.nsa.gov>; Thu, 22 Feb 2007 11:44:42 -0500
Subject: [RFC] Drop setlocaldefs support from trunk (2.x series)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 22 Feb 2007 11:41:42 -0500
Message-Id: <1172162502.14363.446.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

With the migration to libsemanage and managed policy, the setlocaldefs
support in libselinux and underlying support in libsepol for parsing
local booleans and users files is obsolete in modern SELinux
distributions.  Ideally, I'd like to drop it out entirely from the trunk
(2.x series), while preserving it on the stable branch (1.x series).
Specifically, this would mean:
- Removing setlocaldefs support from libselinux,
- Removing sepol_genusers and sepol_genbools and their internal logic
from libsepol, including the legacy config file parsers there.
sepol_genbools_array() would remain due to its use for preserving
actives booleans upon policy reload, but it doesn't require the config
file parser.

We have different options for handling the libsepol changes, e.g.:
- We could retain stub functions for the interfaces that call WARN() and
return an error immediately, and possibly version the map file so that
they are only exported to legacy binaries.  In this case, legacy
binaries should already have logic to fall back to the original policy
image as these calls can fail for other reasons, so you'd just end up
with the base policy without any local boolean or user definitions
applied.
- We could remove the interfaces altogether, requiring a change to the
shared library version.

This would affect e.g. the ability to install the trunk versions on an
older distribution like RHEL 4, which predates libsemanage and managed
policy support.

Thoughts?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
