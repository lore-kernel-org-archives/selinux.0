Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u86Dmi9H006426
 for <selinux@tycho.nsa.gov>; Tue, 6 Sep 2016 09:48:44 -0400
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] remove system_u and s0 hardcoded strings
Date: Tue,  6 Sep 2016 14:48:20 +0100
Message-Id: <1473169701-9179-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch removes the search and replacement for "system_u" and "s0" by instead
looking for a valid context and replacing the user and MLS/MCS range where
appropriate.  This allows using genhomedircon with alternative policies that
don't name the system seuser "system_u" or declare users in a CIL namespace /
container.

This is also a slight behavior change, but should be functionally equivalent to
before for existing policies. In refpolicy we have no homedir contexts without
system_u as the user or s0 as the level:

> $ find . -name '*.fc' | xargs grep -h 'HOME_DIR' | grep -v 's0' | grep -Evc '^#'
0
> $ find . -name '*.fc' | xargs grep -h 'HOME_DIR' | grep -v 'system_u' | grep -Evc '^#'
0

Gary Tierney (1):
  genhomedircon: remove hardcoded refpolicy strings

 libsemanage/src/genhomedircon.c | 79 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 13 deletions(-)

-- 
2.7.4
