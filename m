Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DFevRb028037
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 10:40:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1DFdTQk015895
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 15:39:29 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1DFdTYo015891
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 15:39:29 GMT
Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DFetjP000106
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 10:40:55 -0500 (EST)
Subject: Patched userland packages
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1076686854.10189.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 13 Feb 2004 10:40:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

As the SELinux userland patches have been ported to many distributions
by various people, and most of the real activity in further maintaining
and developing them has migrated to those people, we'd like to drop them
from our site in the future and drop down to only providing the latest
SELinux kernel patch and the new SELinux userland packages (e.g.
checkpolicy, libselinux, policycoreutils, policy, selinux-doc, plus the
contributed setools and slat packages and any new packages that we
develop or patch in the future that are not yet available in distro
packages or upstream).  We could then just provide pointers to the
appropriate locations for the patched userland components for various
distributions in the selinux-doc README.  Does this sound reasonable?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
