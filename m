Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8NETFb4027846
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 10:29:17 -0400
Received: from workstation.fluency.net.uk ([185.34.9.224]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0Lxt3Q-1arISz00Oa-015Gi8 for
 <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 16:29:05 +0200
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/1] supporting RBACSEP in genhomedircon
Date: Fri, 23 Sep 2016 15:28:43 +0100
Message-Id: <cover.1474639773.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch implements support for policies using RBACSEP in genhomedircon.  It
works by using an SELinux users "prefix" as the role in their homedir contexts.
It seems that genhomedircon has previously supported something similar, as it'll
currently replace the string "ROLE" with whatever a users prefix is.  However,
if using CIL we can't leverage this, since secilc will complain about the
semantics of an invalid role named "ROLE" in a filecon statement.

Since there's no way for a CIL policy to tell genhomedircon whether a role should
be replaced or not, a new "genhomedircon-rbacsep" option was added to
/etc/selinux/semanage.conf.

I'm not convinced that this is the best way to go about this.  Maybe an initial
role can be implicitly figured out using libsepol's API? Anyway, I've submitted
this to see if there's any better options for supporting RBACSEP in home dir
context generation.

There was some previous discussion about this here for reference:
http://oss.tresys.com/pipermail/refpolicy/2011-August/004417.html

Gary Tierney (1):
  genhomedircon: support policies using RBACSEP

 libsemanage/src/conf-parse.y    | 14 +++++++++++++-
 libsemanage/src/conf-scan.l     |  1 +
 libsemanage/src/genhomedircon.c | 30 +++++++++++++++++++++++++++++-
 libsemanage/src/semanage_conf.h |  1 +
 4 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.4.11
