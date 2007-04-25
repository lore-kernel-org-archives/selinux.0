Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PLuaTi021397
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:56:36 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3PLuZIr015059
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 21:56:35 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l3PLuZnY010289
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:56:35 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3PLuZtq008607
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:56:35 -0400
Received: from localhost.localdomain (vpn-14-34.rdu.redhat.com [10.11.14.34])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l3PLuYlh014701
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:56:34 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [POLICYREP PATCH] Fix 64bit compilation issue (and remove
	questionably casting of void* to
To: selinux@tycho.nsa.gov
Date: Wed, 25 Apr 2007 17:56:35 -0400
Message-ID: <20070425215634.15998.22854.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

int).

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
---

 libsepol/tests/test-hashtab.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/libsepol/tests/test-hashtab.c b/libsepol/tests/test-hashtab.c
index 0082036..a614e70 100644
--- a/libsepol/tests/test-hashtab.c
+++ b/libsepol/tests/test-hashtab.c
@@ -42,13 +42,14 @@ static void test_hashtab_iter(void)
 	struct sepol_iter *iter;
 	int ret, i;
 	char *strings[] = {"foo", "bar", "baz"};
+	int ints[] = {0, 1, 2};
 
 	h = hashtab_create(sepol_symhash, sepol_symcmp, 64);
 	CU_ASSERT(h != NULL);
 	
-	ret = hashtab_insert(h, strings[0], (void *)0);
-	ret = hashtab_insert(h, strings[1], (void *)1);
-	ret = hashtab_insert(h, strings[2], (void *)2);
+	ret = hashtab_insert(h, strings[0], &ints[0]);
+	ret = hashtab_insert(h, strings[1], &ints[1]);
+	ret = hashtab_insert(h, strings[2], &ints[2]);
 
 	ret = sepol_iter_create(NULL, &iter);
 	CU_ASSERT(ret == SEPOL_OK);
@@ -57,7 +58,7 @@ static void test_hashtab_iter(void)
 	while (ret == SEPOL_OK) {
 		cur = (hashtab_ptr_t)sepol_iter_get_data(NULL, iter);
 		CU_ASSERT(cur != NULL);
-		i = (int)cur->datum;
+		i = *(int*)cur->datum;
 		CU_ASSERT(i < 3);
 		CU_ASSERT(strcmp(strings[i], (char *)cur->key) == 0);
 		ret = sepol_iter_next(NULL, iter);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
