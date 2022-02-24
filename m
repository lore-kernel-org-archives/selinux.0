Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1397BC433EF
	for <selinux@archiver.kernel.org>; Thu, 24 Feb 2022 12:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiBXMmT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 07:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiBXMmS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 07:42:18 -0500
Received: from sa-prd-fep-042.btinternet.com (mailomta2-sa.btinternet.com [213.120.69.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978A05DA54
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 04:41:47 -0800 (PST)
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20220224124144.ZDPF30440.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Thu, 24 Feb 2022 12:41:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645706504; 
        bh=QozOIA+VY1g0UjgjMe5srnWUpzSH/Hlo3jrE74tCIqs=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=KpLUYDBYqPYh+gnDKWbkmZoHjpJIG/TNPZ2Wi794s5pyxg80RVjW4zOUY2qQcV6KB768i5CmJi14hhIgeY58eqqmC8yBaFBH9Rvh5x9tERGT+WwYg/oBa95i3KiJK4mIQRM41FZBbwqoTYOB/OW5DoazxAGjrOoc3nulpx2eqKf57ij+Azd/rww7OovojQsA1TkJRdxRujiwEVlRI8QQwNgYcgp+wjuCGnykZxnLabLM2/pPce6DY0wpYCwZFwjbFBV+LHXGzggoUJoChCPsn2mTlan8i2DaSsZUCkMJb9bW3POAl9QB9M3RcCbbLw9WQ9AUp1C6QG3Eq5kHkVZJ1w==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139429016D8724E
X-Originating-IP: [109.158.127.121]
X-OWM-Source-IP: 109.158.127.121 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrledvgdegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedutdelrdduheekrdduvdejrdduvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheekrdduvdejrdduvddupdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.121) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139429016D8724E; Thu, 24 Feb 2022 12:41:44 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, demiobenour@gmail.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] libsepol: Add 'ioctl_skip_cloexec' policy capability
Date:   Thu, 24 Feb 2022 12:41:31 +0000
Message-Id: <20220224124131.44094-1-richard_c_haines@btinternet.com>
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
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 40669fb5..05326f5a 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -14,6 +14,7 @@ enum {
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
 	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAPABILITY_IOCTL_CLOEXEC,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 6a74ec7d..218df65e 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -13,6 +13,7 @@ static const char * const polcap_names[] = {
 	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
 	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
 	"genfs_seclabel_symlinks",	/* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
+	"ioctl_skip_cloexec",		/* POLICYDB_CAPABILITY_IOCTL_CLOEXEC */
 	NULL
 };
 
-- 
2.35.1

