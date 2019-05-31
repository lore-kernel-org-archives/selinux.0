Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9417C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51AF26BFD
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 16:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="nFB/BEEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfEaQ0b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 12:26:31 -0400
Received: from rgout0805.bt.lon5.cpcloud.co.uk ([65.20.0.152]:25973 "EHLO
        rgout0805.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbfEaQ0b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 12:26:31 -0400
X-OWM-Source-IP: 86.147.204.249 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtgedrvdegleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtgedrvdegledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtgedrvdegleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtgedrvdegledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddgledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtgedrvdegleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtgedrvdegledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddgleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtgedrvdegleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtgedrvdegledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtgedrvdegleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtgedrvdegledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudefuddguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddugeejrddvtdegrddvgeelnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtdegrddvgeelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
Received: from localhost.localdomain (86.147.204.249) by rgout08.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5BC47A8714D9D51F; Fri, 31 May 2019 16:16:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1559319988; 
        bh=lgnvoOMDaewpFvrKY1DePQekMyfffuUViBQtVIr5z8Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=nFB/BEEadIGiIj0x3k35+qGMPUPYDbn0zdVsHfNkQ73jEudVRMLzNgvNHvWy/m0lWMcEjapJRbd+UvIVrdK0oJg1sQrO68fA/FEk50CR78qNddXAImW1D7jQ78iLIjAGXxs/jmgn8z3k8Z0y7luKYVxwF4ptagZCF2AD6svrq6c=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux: Fix strncpy in libselinux and libsepol
Date:   Fri, 31 May 2019 16:16:09 +0100
Message-Id: <20190531151609.16873-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When building with gcc9, get build errors such as:

genbools.c:24:2: error: ‘strncpy’ output may be truncated copying 8191
bytes from a string of length 8191 [-Werror=stringop-truncation]
   24 |  strncpy(dest, ptr, size);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/booleans.c |  4 ++--
 libsepol/src/genbools.c   | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index ab1e0754..cdc03517 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -539,7 +539,7 @@ int security_load_booleans(char *path)
 
 	__fsetlocking(boolf, FSETLOCKING_BYCALLER);
 	while (getline(&inbuf, &len, boolf) > 0) {
-		int ret = process_boolean(inbuf, name, sizeof(name), &val);
+		int ret = process_boolean(inbuf, name, len, &val);
 		if (ret == -1)
 			errors++;
 		if (ret == 1)
@@ -557,7 +557,7 @@ int security_load_booleans(char *path)
 		int ret;
 		__fsetlocking(boolf, FSETLOCKING_BYCALLER);
 		while (getline(&inbuf, &len, boolf) > 0) {
-			ret = process_boolean(inbuf, name, sizeof(name), &val);
+			ret = process_boolean(inbuf, name, len, &val);
 			if (ret == -1)
 				errors++;
 			if (ret == 1)
diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
index d4a2df62..ad194ca6 100644
--- a/libsepol/src/genbools.c
+++ b/libsepol/src/genbools.c
@@ -10,6 +10,8 @@
 #include "private.h"
 #include "dso.h"
 
+#define FGET_BUFSIZ 255
+
 /* -- Deprecated -- */
 
 static char *strtrim(char *dest, char *source, int size)
@@ -32,7 +34,7 @@ static char *strtrim(char *dest, char *source, int size)
 
 static int process_boolean(char *buffer, char *name, int namesize, int *val)
 {
-	char name1[BUFSIZ];
+	char name1[FGET_BUFSIZ];
 	char *ptr = NULL;
 	char *tok;
 
@@ -48,7 +50,7 @@ static int process_boolean(char *buffer, char *name, int namesize, int *val)
 		ERR(NULL, "illegal boolean definition %s", buffer);
 		return -1;
 	}
-	strncpy(name1, tok, BUFSIZ - 1);
+	strncpy(name1, tok, FGET_BUFSIZ - 1);
 	strtrim(name, name1, namesize - 1);
 
 	tok = strtok_r(NULL, "\0", &ptr);
@@ -79,8 +81,8 @@ static int load_booleans(struct policydb *policydb, const char *path,
 {
 	FILE *boolf;
 	char *buffer = NULL;
-	char localbools[BUFSIZ];
-	char name[BUFSIZ];
+	char localbools[FGET_BUFSIZ];
+	char name[FGET_BUFSIZ + 1];
 	int val;
 	int errors = 0, changes = 0;
 	struct cond_bool_datum *datum;
@@ -90,12 +92,12 @@ static int load_booleans(struct policydb *policydb, const char *path,
 		goto localbool;
 
 #ifdef __APPLE__
-        if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
-          ERR(NULL, "out of memory");
-	  return -1;
+	if ((buffer = (char *)malloc(FGET_BUFSIZ * sizeof(char))) == NULL) {
+		ERR(NULL, "out of memory");
+		return -1;
 	}
 
-        while(fgets(buffer, 255, boolf) != NULL) {
+	while (fgets(buffer, FGET_BUFSIZ, boolf) != NULL) {
 #else
 	size_t size = 0;
 	while (getline(&buffer, &size, boolf) > 0) {
@@ -124,7 +126,7 @@ static int load_booleans(struct policydb *policydb, const char *path,
 
 #ifdef __APPLE__
 
-	  while(fgets(buffer, 255, boolf) != NULL) {
+	while (fgets(buffer, FGET_BUFSIZ, boolf) != NULL) {
 #else
 
 	    while (getline(&buffer, &size, boolf) > 0) {
-- 
2.21.0

