Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DDEC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC420717
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="nr5K2RtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLQNoY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:44:24 -0500
Received: from mailomta10-re.btinternet.com ([213.120.69.103]:47698 "EHLO
        re-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbfLQNoY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 08:44:24 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20191217134420.NBFX8099.re-prd-fep-047.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 17 Dec 2019 13:44:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1576590260; 
        bh=UC9xVVlVmnGAB7QOq4QJh4VOcguqoNxRhuEIDIJ9ws0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=nr5K2RtGONY0pC5GvpGw/+R2/rpIKt8uSGLpOkI2MnzkrSU9Th31qLVlk4Kd+FvuhMinwsJgEyACFBKY48nYKQjNm1+53Im9lKrIS2vVK2x6nGNDz0X9jsayZ/zckB/Y0r29mxiG3389hegtNWaydrOse3Rfx8IoTasQxTJuSsFcu6EKjYo6tJ8p0vgFvs0qMtpbmr2ejoMpcClrA01hjfLnu2ijMUpmPX3QbUGsttCkioII0x1ShhxInVmwE6tFB5qCRYD9eHcXINoiUH55EqWCcJWtLitp8JtzVBGGBTq3oWZw5y+OOyOGeyKjraVp6KmMaSsLlwMi5dk9fByCvQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.214]
X-OWM-Source-IP: 86.134.6.214 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvddtjedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdeirddvudegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeegrdeirddvudegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.214) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DEE078D015A1A6B; Tue, 17 Dec 2019 13:44:20 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux-testsuite: Fix policy to allow process { setfscreate } testing
Date:   Tue, 17 Dec 2019 13:44:14 +0000
Message-Id: <20191217134414.25746-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The global test policy allows process { setfscreate } for all tests.
To specifically test this, need to remove it globally and update test
policy that rely on it (mkdir & mac_admin).

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/test_global.te    | 1 -
 policy/test_mac_admin.te | 2 ++
 policy/test_mkdir.te     | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index 90f9b65..97f51e4 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -38,7 +38,6 @@ allow testdomain self:process setcurrent;
 #domain_dyntrans_type(testdomain)
 #selinux_get_fs_mount(testdomain)
 allow testdomain self:process setexec;
-allow testdomain self:process setfscreate;
 
 # General permissions commonly required for test operation.
 # general_domain_access
diff --git a/policy/test_mac_admin.te b/policy/test_mac_admin.te
index 579a017..790a731 100644
--- a/policy/test_mac_admin.te
+++ b/policy/test_mac_admin.te
@@ -10,6 +10,7 @@ domain_type(test_mac_admin_t)
 unconfined_runs_test(test_mac_admin_t)
 typeattribute test_mac_admin_t mac_admintestdomain;
 typeattribute test_mac_admin_t testdomain;
+allow test_mac_admin_t self:process { setfscreate };
 
 # Relabeling a file to an undefined label remaps it to the unlabeled context,
 # which may have a different SELinux user identity (e.g. system_u).
@@ -26,6 +27,7 @@ domain_type(test_no_mac_admin_t)
 unconfined_runs_test(test_no_mac_admin_t)
 typeattribute test_no_mac_admin_t mac_admintestdomain;
 typeattribute test_no_mac_admin_t testdomain;
+allow test_no_mac_admin_t self:process { setfscreate };
 
 # See above.
 domain_obj_id_change_exemption(test_no_mac_admin_t)
diff --git a/policy/test_mkdir.te b/policy/test_mkdir.te
index 1410a96..a5ba9b1 100644
--- a/policy/test_mkdir.te
+++ b/policy/test_mkdir.te
@@ -45,6 +45,7 @@ unconfined_runs_test(test_create_t)
 typeattribute test_create_t test_mkdir_domain;
 typeattribute test_create_t testdomain;
 domain_obj_id_change_exemption(test_create_t)
+allow test_create_t self:process { setfscreate };
 allow test_create_t test_mkdir_dir_t:dir { search getattr write add_name };
 allow test_create_t test_create_dir_t:dir { search getattr write create };
 
@@ -56,6 +57,7 @@ unconfined_runs_test(test_nocreate_t)
 typeattribute test_nocreate_t test_mkdir_domain;
 typeattribute test_nocreate_t testdomain;
 domain_obj_id_change_exemption(test_nocreate_t)
+allow test_nocreate_t self:process { setfscreate };
 allow test_nocreate_t test_mkdir_dir_t:dir { search getattr write add_name };
 allow test_nocreate_t test_create_dir_t:dir { search getattr };
 
-- 
2.23.0

