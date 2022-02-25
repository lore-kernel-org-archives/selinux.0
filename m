Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FE9C433EF
	for <selinux@archiver.kernel.org>; Fri, 25 Feb 2022 17:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiBYR4f (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiBYR4e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Feb 2022 12:56:34 -0500
Received: from re-prd-fep-044.btinternet.com (mailomta23-re.btinternet.com [213.120.69.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404A2399F6
        for <selinux@vger.kernel.org>; Fri, 25 Feb 2022 09:56:01 -0800 (PST)
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20220225175559.MJFC28912.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 25 Feb 2022 17:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645811759; 
        bh=uvSKK/1IIrbqLzJUkazOV/DUxR8phk3HnpRHAATfy4M=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=hNN9DP1Y9EQL8vVTiHif9N2cpT9XswWBmzWVb21FSnn8jAs6UQSVZSFlpzCf5l/xJLfycZySmo0JYfcRZjuNn5gDFkGBfIaMgkzZXDLXuPnVODyUeOk283GkKnRTAN6/ZylDfbChM/6B5qA7NxuGmMEfky367xWla/m6ZsQ3Wvc/EkBHY1CVLYvLOhuD0F3HjYUzAba16DYtF5LnQdWkd3RYcHnCHqWa2v7Gmu/IOnN14C7zDmLvN8QGSG/SjiiLzuTxKxHCY3ktGAnLPK2iACv+XOA6r4sJWooC4NmOgQOhUbAGby2pBSmcU6reIKaBeA6kTguFLNOLiskbKJhrIg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 61A69BAC0A949196
X-Originating-IP: [217.43.180.152]
X-OWM-Source-IP: 217.43.180.152 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrleeggddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepvddujedrgeefrddukedtrdduhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedvudejrdegfedrudektddrudehvddpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepuggvmhhiohgsvghnohhurhesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (217.43.180.152) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 61A69BAC0A949196; Fri, 25 Feb 2022 17:55:59 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, demiobenour@gmail.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2] libsepol: Add 'ioctl_skip_cloexec' policy capability
Date:   Fri, 25 Feb 2022 17:55:49 +0000
Message-Id: <20220225175549.302386-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If 'ioctl_skip_cloexec' set, kernel will always allow FIOCLEX and FIONCLEX
ioctls.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change: Use POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC

 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 40669fb5..39c99839 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -14,6 +14,7 @@ enum {
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 6a74ec7d..a5e515f2 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -13,6 +13,7 @@ static const char * const polcap_names[] = {
 	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
 	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
 	"genfs_seclabel_symlinks",	/* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
+	"ioctl_skip_cloexec",		/* POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC */
 	NULL
 };
 
-- 
2.35.1

