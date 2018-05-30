Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4UEodmM014523
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 10:50:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID07.oob.disa.mil (Postfix) with SMTP id 40wtnB1Jt7z17xpj
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 14:50:38 +0000 (UTC)
Received: from USFB19PA10.eemsg.mil (unknown [192.168.16.7])
 by USFBF3ID07.oob.disa.mil (Postfix) with ESMTP id 40wtn81LzHz17xpp
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 14:50:36 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF4595BCBE
 for <selinux@tycho.nsa.gov>; Wed, 30 May 2018 14:50:22 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 30 May 2018 10:50:22 -0400
Message-ID: <152769182197.21147.5215288736203882423.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux-testsuite: fix some style problems in the binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Fixes done by 'tools/check-syntax -f'.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/binder/test_binder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/binder/test_binder.c b/tests/binder/test_binder.c
index 0d10a58..11fa358 100644
--- a/tests/binder/test_binder.c
+++ b/tests/binder/test_binder.c
@@ -632,7 +632,7 @@ int main(int argc, char **argv)
 
 		writebuf.txn.data.ptr.buffer = (uintptr_t)&obj;
 		writebuf.txn.data.ptr.offsets = (uintptr_t)&obj +
-					sizeof(struct flat_binder_object);
+						sizeof(struct flat_binder_object);
 
 		bwr.write_buffer = (uintptr_t)&writebuf;
 		bwr.write_size = sizeof(writebuf);
