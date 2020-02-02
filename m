Return-Path: <SRS0=qlmh=3W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FEBC35249
	for <selinux@archiver.kernel.org>; Sun,  2 Feb 2020 19:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C2320658
	for <selinux@archiver.kernel.org>; Sun,  2 Feb 2020 19:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Jx+Jtgme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgBBTgi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Feb 2020 14:36:38 -0500
Received: from mailomta8-sa.btinternet.com ([213.120.69.14]:23093 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726955AbgBBTgh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Feb 2020 14:36:37 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20200202193635.PIYI7916.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Sun, 2 Feb 2020 19:36:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580672195; 
        bh=d1fgbUCbWDYRO5rOg48kiTNG8vjyLAKYarl3MqwZn38=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Jx+JtgmeFLo4F75WNtSfTpBTUThEn7XNfHKfVCXcNN5karvIA7aRVHRku9S9OUCE33GqKlYAm39gK+JtgVSFOb1sXsvH1Qkb4zDmKDUsth6bTnZKPzCBXG5IIho9nCvIAoeHIPx+zHUjWzOwCQiE5SVNfDxWqxnqqE4gZxAoteCzONIb7i62d5IPe32FmyEbwZBY1c7lfVHmcWZwnUaDK/uqQOgS+1HMfB0oeCklj7NmTUhN3uZ57TvImRoibqBOezgIDfCobC6HohD0dYgYRWjeRatHmkQil6cMTbCdlyAdHi25Hg5KkgRPisDJyqCxpo4X47V6IiiBmUeQStMe5Q==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.56.38]
X-OWM-Source-IP: 31.49.56.38 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgeehgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheeirdefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheeirdefkedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.56.38) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DF93CE107979582; Sun, 2 Feb 2020 19:36:35 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     dhowells@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH] libsepol: Add 'key_perms' policy capability
Date:   Sun,  2 Feb 2020 19:36:32 +0000
Message-Id: <20200202193632.15205-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Allow the new key class permissions 'inval, revoke, join and clear' to be
handled.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index dc9356a6..de0c67b6 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -13,6 +13,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_KEYPERMS,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index b9dc3526..48213c54 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -12,6 +12,7 @@ static const char *polcap_names[] = {
 	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
 	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
 	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
+	"key_perms",			/* POLICYDB_CAPABILITY_KEYPERMS */
 	NULL
 };
 
-- 
2.24.1

