Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B72AC433EF
	for <selinux@archiver.kernel.org>; Mon,  7 Mar 2022 11:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbiCGLY7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242035AbiCGLYs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Mar 2022 06:24:48 -0500
Received: from re-prd-fep-047.btinternet.com (mailomta10-re.btinternet.com [213.120.69.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E666F490
        for <selinux@vger.kernel.org>; Mon,  7 Mar 2022 02:54:33 -0800 (PST)
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20220307105431.NUQF23513.re-prd-fep-047.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Mon, 7 Mar 2022 10:54:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1646650471; 
        bh=jqdp3sHOrVQ8lHbwCVeKIDG5g17KE9JbIg5brht4lpQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=X+IUU/1Rhy8hKS2JKcAUx4vltql/ZlUJB6QtEw1Nl5NEE6pE+fNjSLq0OKFu359YFrRIHOQRhgqxBQBn97uXdsp2AdIKFdU5HfbXsoH6Ztbthssm/+By3NDumw2FB3ii9omweZ5xKqLZkkdlAAbSBecATxq6ieZLGyeTt6MYpp+OTKieR6Q8EMAgsjPuRsaBOmY08ADXe30uKNxqB+hmc+WdZ/G+ok2QoyLwzToL5lvv9nh29l+X7I/IcKHByS5CcBTmkCyhPnRkK5W/0tjhU6lz5zL17U804YgVGkL7Q/65gygf4cjVPggrHS/1X1XLcqu3u6Eem56MRFDYlE7ksw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A901C17B585F4
X-Originating-IP: [86.183.71.89]
X-OWM-Source-IP: 86.183.71.89 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddruddugedgvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeelteffgeevveejheevhfetgfeuveduteetuddtffdvjeekieetgeehveefjedtfeenucfkphepkeeirddukeefrdejuddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudekfedrjedurdekledpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.183.71.89) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A901C17B585F4; Mon, 7 Mar 2022 10:54:31 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] libsepol: Shorten the policy capability enum names
Date:   Mon,  7 Mar 2022 10:54:17 +0000
Message-Id: <20220307105417.11913-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Shorten "CAPABILITY" to "CAP" following the kernel naming convention.

The SELinux policy capability enum names should now follow the
"POLICYDB_CAP_XXX" format.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 20 ++++++++++----------
 libsepol/src/polcaps.c                    | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 39c99839..f5e32e60 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -7,17 +7,17 @@ extern "C" {
 
 /* Policy capabilities */
 enum {
-	POLICYDB_CAPABILITY_NETPEER,
-	POLICYDB_CAPABILITY_OPENPERM,
-	POLICYDB_CAPABILITY_EXTSOCKCLASS,
-	POLICYDB_CAPABILITY_ALWAYSNETWORK,
-	POLICYDB_CAPABILITY_CGROUPSECLABEL,
-	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
-	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
-	POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC,
-	__POLICYDB_CAPABILITY_MAX
+	POLICYDB_CAP_NETPEER,
+	POLICYDB_CAP_OPENPERM,
+	POLICYDB_CAP_EXTSOCKCLASS,
+	POLICYDB_CAP_ALWAYSNETWORK,
+	POLICYDB_CAP_CGROUPSECLABEL,
+	POLICYDB_CAP_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS,
+	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
+	__POLICYDB_CAP_MAX
 };
-#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
+#define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
 
 /* Convert a capability name to number. */
 extern int sepol_polcap_getnum(const char *name);
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index a5e515f2..687e971c 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -6,14 +6,14 @@
 #include <sepol/policydb/polcaps.h>
 
 static const char * const polcap_names[] = {
-	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
-	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
-	"extended_socket_class",	/* POLICYDB_CAPABILITY_EXTSOCKCLASS */
-	"always_check_network",		/* POLICYDB_CAPABILITY_ALWAYSNETWORK */
-	"cgroup_seclabel",		/* POLICYDB_CAPABILITY_SECLABEL */
-	"nnp_nosuid_transition",	/* POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION */
-	"genfs_seclabel_symlinks",	/* POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS */
-	"ioctl_skip_cloexec",		/* POLICYDB_CAPABILITY_IOCTL_SKIP_CLOEXEC */
+	"network_peer_controls",	/* POLICYDB_CAP_NETPEER */
+	"open_perms",			/* POLICYDB_CAP_OPENPERM */
+	"extended_socket_class",	/* POLICYDB_CAP_EXTSOCKCLASS */
+	"always_check_network",		/* POLICYDB_CAP_ALWAYSNETWORK */
+	"cgroup_seclabel",		/* POLICYDB_CAP_SECLABEL */
+	"nnp_nosuid_transition",	/* POLICYDB_CAP_NNP_NOSUID_TRANSITION */
+	"genfs_seclabel_symlinks",	/* POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS */
+	"ioctl_skip_cloexec",		/* POLICYDB_CAP_IOCTL_SKIP_CLOEXEC */
 	NULL
 };
 
@@ -21,7 +21,7 @@ int sepol_polcap_getnum(const char *name)
 {
 	int capnum;
 
-	for (capnum = 0; capnum <= POLICYDB_CAPABILITY_MAX; capnum++) {
+	for (capnum = 0; capnum <= POLICYDB_CAP_MAX; capnum++) {
 		if (polcap_names[capnum] == NULL)
 			continue;
 		if (strcasecmp(polcap_names[capnum], name) == 0)
@@ -32,7 +32,7 @@ int sepol_polcap_getnum(const char *name)
 
 const char *sepol_polcap_getname(unsigned int capnum)
 {
-	if (capnum > POLICYDB_CAPABILITY_MAX)
+	if (capnum > POLICYDB_CAP_MAX)
 		return NULL;
 
 	return polcap_names[capnum];
-- 
2.35.1

