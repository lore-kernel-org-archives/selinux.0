Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45Co21N012107
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 08:50:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5813A7AEA5
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 12:49:59 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.40.3.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC73288F0A
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 12:49:58 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: libsemanage: remove/replace access() checks to make setuid programs
 work
Date: Fri,  5 May 2017 14:49:44 +0200
Message-Id: <20170505124947.21392-1-vmojzis@redhat.com>
In-Reply-To: <1488219577.19819.19.camel@tycho.nsa.gov>
References: <1488219577.19819.19.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

access() uses real UID instead of effective UID which causes false
negative checks in setuid programs.

Following patches remove redundant access checks (where the access check was
followed by open, write,etc. call and the return value is checked), and replace
necessary "access(, F_OK)" checks by "stats()" (e.g. in case where existence of
a file determines if hll module compilation is necessary, or represents some
setting - such as preserve_tunables).

RHBZ #1186431

libsemanage/src/direct_api.c     | 79 ++++++++++++++++++++++++++++++++++++-------------------------------------------
libsemanage/src/semanage_store.c | 17 ++++++++---------
2 files changed, 44 insertions(+), 52 deletions(-)
