Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7ML42Bk020138
 for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2016 17:04:02 -0400
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v3 0/2] genhomedircon: add support for %group syntax 
Date: Mon, 22 Aug 2016 22:03:03 +0100
Message-Id: <1471899785-22194-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Re-spin of my original patch that adds support for logins mapped using the
%group syntax to genhomedircon.  This version includes fixes for the issues
raised by Jason and splits the bugfix into a separate commit.

There was a bit of confusion about the MLS level, I think, since semanage-user
supports a default MLS level and not semanage-login.  So it wouldn't be possible
for a login to have a more specific level than the fallback login in that case.
Though the bugfix still addresses an issue with home directories outside of
/home / LU_HOMEDIRCETORY and is required for the second commit.

Gary Tierney (2):
  genhomedircon: generate contexts for logins mapped to the default user
  genhomedircon: add support for %group syntax

 libsemanage/src/genhomedircon.c | 314 +++++++++++++++++++++++++++++++---------
 1 file changed, 243 insertions(+), 71 deletions(-)

-- 
2.7.4
