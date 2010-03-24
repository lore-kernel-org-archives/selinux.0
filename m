Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2OIBr7d000567
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 14:11:53 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o2OICWoH020864
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2010 18:12:32 GMT
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH] reactivate attribute mapping unit test
Date: Wed, 24 Mar 2010 14:12:06 -0400
Message-Id: <1269454326-21043-1-git-send-email-jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This test must have been disabled a very long time ago, before attributes were present in the kernel policy. Since the attributes are now present this unit test should be turned back on, unless I'm missing something pretty major (it looks reasonable and is successful when run).

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 libsepol/tests/test-expander.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/libsepol/tests/test-expander.c b/libsepol/tests/test-expander.c
index 8294308..ded1d9d 100644
--- a/libsepol/tests/test-expander.c
+++ b/libsepol/tests/test-expander.c
@@ -196,14 +196,12 @@ int expander_add_tests(CU_pSuite suite)
 		CU_cleanup_registry();
 		return CU_get_error();
 	}
-#if 0
-	/* this is a very useful test and in fact has caught some bugs but cannot be used
-	 * currently because of the way the expander removes attributes, please FIXME :) */
+
 	if (NULL == CU_add_test(suite, "expander_attr_mapping", test_expander_attr_mapping)) {
 		CU_cleanup_registry();
 		return CU_get_error();
 	}
-#endif
+
 	if (NULL == CU_add_test(suite, "expander_role_mapping", test_expander_role_mapping)) {
 		CU_cleanup_registry();
 		return CU_get_error();
-- 
1.7.0.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
