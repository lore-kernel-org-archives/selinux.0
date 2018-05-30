Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4UEodmN014523
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 10:50:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 40wtn23J71z2Vp8k
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 14:50:30 +0000 (UTC)
Received: from UPBD19PA12.eemsg.mil (unknown [192.168.18.16])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 40wtn21q77z2Vp8T
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 14:50:30 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A4FA818BAED
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 14:50:28 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 30 May 2018 10:50:28 -0400
Message-ID: <152769182801.21147.2435198402463646912.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux-testsuite: fix the mode bits for the binder
 tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/binder/test |    0 
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/binder/test

diff --git a/tests/binder/test b/tests/binder/test
old mode 100644
new mode 100755
