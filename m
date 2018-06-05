Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w55EZ4mj026501
 for <selinux@tycho.nsa.gov>; Tue, 5 Jun 2018 10:35:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 410Z7x6Ptczg47P
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:37 +0000 (UTC)
Received: from UPBD19PA05.eemsg.mil (unknown [192.168.18.6])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 410Z7w6zDvzg47h
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:36 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5AD9B4075387
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-229.brq.redhat.com
 [10.40.204.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5D2463531
 for <selinux@tycho.nsa.gov>; Tue,  5 Jun 2018 14:34:30 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue,  5 Jun 2018 16:34:02 +0200
Message-Id: <20180605143405.4491-1-jzarsky@redhat.com>
Subject: [PATCH 0/3] xperms support in audit2allow
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,
this patchset is the result of my bachelor's thesis. First two patches
fix bugs in sepolgen and are not related to the third patch. The third
patch provides xperms support to audit2allow.

Jan Zarsky (3):
  python/sepolgen: print all AV rules correctly
  python/sepolgen: fix access vector initialization
  python: add xperms support to audit2allow

 python/audit2allow/audit2allow            |   6 +
 python/audit2allow/audit2allow.1          |   3 +
 python/audit2allow/test.log               |   1 +
 python/audit2allow/test_audit2allow.py    |   9 ++
 python/sepolgen/src/sepolgen/access.py    |  54 +++++----
 python/sepolgen/src/sepolgen/audit.py     |  28 +++--
 python/sepolgen/src/sepolgen/policygen.py | 125 +++++++++++--------
 python/sepolgen/src/sepolgen/refpolicy.py | 125 ++++++++++++++++++-
 python/sepolgen/tests/test_access.py      | 129 ++++++++++++++++++++
 python/sepolgen/tests/test_audit.py       |  50 ++++++++
 python/sepolgen/tests/test_policygen.py   | 112 ++++++++++++++++-
 python/sepolgen/tests/test_refpolicy.py   | 139 ++++++++++++++++++++++
 12 files changed, 700 insertions(+), 81 deletions(-)
