Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7Fm7F2031798
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 10:48:07 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 0/2] Fix pp2cil bugs associated with optionals
Date: Fri, 7 Nov 2014 10:47:26 -0500
Message-ID: <1415375248-29632-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Two patches to fix bugs related to optionals:

The first patch fixes the issue where optionals were not correctly disabled
because CIL handles optionals differently from policy packages, as reported by
Sven Vermeulen [1].

The second patch fixes a bug that appeared after fixing the optional bug, in
which type aliases were not properly scoped when converted to CIL. This could
result in type aliases that referenced types that did not exist due to a
disabled optional.

[1] http://marc.info/?l=selinux&m=141494169024285&w=2

Steve Lawrence (2):
  policycoreutils: pp: mimic require block support in CIL
  policycoreutils: pp: define type aliases in the correct scope

 policycoreutils/hll/pp/pp.c | 219 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 183 insertions(+), 36 deletions(-)

-- 
1.9.3
