Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8LNqbVM020739
 for <selinux@tycho.nsa.gov>; Wed, 21 Sep 2016 19:52:37 -0400
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 0/1] genhomedircon: remove hardcoded refpolicy strings
Date: Thu, 22 Sep 2016 00:52:26 +0100
Message-Id: <1474501947-7314-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Second iteration of my previous genhomedircon patch.  The issue with context
specifications as "<<none>>" is fixed and libselinux calls are replaced with
their respective libsepol calls.

I've filed a new BZ for Fedora's system_u login here:
https://bugzilla.redhat.com/show_bug.cgi?id=1378204

Gary Tierney (1):
  genhomedircon: remove hardcoded refpolicy strings

 libsemanage/src/genhomedircon.c | 87 +++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)

-- 
2.7.4
