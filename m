Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BHr9T4031356
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 13:53:09 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] libsepol and checkpolicy: Add ability to expand some
 attributes in binary policy
Date: Tue, 11 Apr 2017 13:53:41 -0400
Message-Id: <1491933223-18277-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The number of type attributes included in the binary policy is becomming a performance issue in some cases.

This patch set more aggressives removes attributes and gives the options to expand and remove all auto-generated attributes and all attributes with fewer than a given amount of attributes assigned.

Comparison of the number of attributes remaining in the binary policy
     mls   normal  android
org  310     286     255
old  268     251     130 
max  154      20      17
min  226     173     119
def  224     170      80
gen  221     170      46
u5   191     112      59 

Org - Number of attributes in the CIL policy 
Old - Results without this patch set
Max - Remove the maximum number of attributes: "-G -X 9999"
Min - Remove the minimum number of attributes: "-X 0"
Def - The new defaults for CIL
Gen - Just removing auto-generated attributes: "-G"
U5  - Remove attributes with less than five members: "-X 5"


James Carter (2):
  libsepol/cil: Add ability to expand some attributes in binary policy
  secilc: Add options to control the expansion of attributes

 libsepol/cil/include/cil/cil.h     |   2 +
 libsepol/cil/src/cil.c             |  12 ++
 libsepol/cil/src/cil_binary.c      | 253 +++++++++++++++++++++++++++----------
 libsepol/cil/src/cil_internal.h    |   7 +-
 libsepol/cil/src/cil_post.c        |  32 +++--
 libsepol/cil/src/cil_resolve_ast.c |  25 ++--
 libsepol/src/libsepol.map.in       |   2 +
 secilc/secil2conf.c                |   2 +
 secilc/secilc.8.xml                |  10 ++
 secilc/secilc.c                    |  31 ++++-
 10 files changed, 275 insertions(+), 101 deletions(-)

-- 
2.7.4
