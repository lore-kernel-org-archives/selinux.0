Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CF379EC1
	for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202749; cv=none; b=V3U5QkhnKlnqXMycOIyUvJnl/hyOMwY4/v1MhsYmBtwwD1NZw56GGFSTxQNq/f/ftuLNj1yCIQom1iEMrLLIAZdAtXxij+slQWE+hQSVqtDQtZKHVaXFpw3cX/CcSm8hG8bbKhFWeKV068V8pESnzyHG/8a9lJhg5LuuScMmRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202749; c=relaxed/simple;
	bh=4iXZ99jUjj1KGky7k956RJEzlz1T9aKAugfqlt7ldEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZPmc4pv6dh6q3eTZAQ+m4zUIPW5ym4E7uTrsUOvjxdrmMyx4MOphwUrP3kP06qoQ3KfZ4siEAJJfl9gu4zkGqBfz6rrDpBHDfeeMF0bMPgXz3bRwGg9L11oVikdM/9lPngMqqOjo07My8omDm7+rz6SF/A3uH65s//axL5ZhApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Buj1h9jF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Buj1h9jF"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93900ed2925so290819085a.0
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2026 11:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788202747; x=1788807547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Famc6K5c6ZCVb/3JY9hyDzwr+s2NYVWAALCo5N21E8=;
        b=Buj1h9jF1sxzqKzudY17RgRDl1wFuMBfHO4TPQzR5OwM8DW+NQfRTrj+zr9q8uG8Bc
         LNJtJZDwvjm8PK4prG2kYbV/SE57XJbrcvWGNU6Eir7vwLbAgYYYyfIeB1u0k7WzTqDj
         6s40bveyQ7lKr+JwD88Bw6ggbCXtS1UvIcWtPC2sCGcqFAuEm/e85AeeG/yhpyMK77Q6
         Go53AP0dJmysW0NwZI4tzGU/Gm1ZxFnXw6oDHazsaGNpR636kWMpGc9NSsxQYQHRb0i3
         gebR0Sz4fNuvzzwZ65KnaTWAtJeCXjNN2aBjWjrEf2OcrdWBqUzUGEHsUVnT3Cz33/0W
         +UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202747; x=1788807547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Famc6K5c6ZCVb/3JY9hyDzwr+s2NYVWAALCo5N21E8=;
        b=Z9TAWMleUPL6sh44ZC1LIh+dFHdfofJYfG+ldfgfC4Rl1wEJOlWAMPwDeVSInwVbAy
         8PhIyFeebCNA4ZRlbRfizr3gkSmZn2kSdD7C9NGwNNYABVvJO9EM6Aj6+l8+AddSu/GR
         L8mn43+RcRrWi8u7yf0xb27B0n94NXpnSgJ6z0PSmeiV1QQzMPHT/a2X9Ap9YmjWQ52T
         vsmkUZd3G7g+mIxKo25kETL1fPK3QSiDOvoilcjAmEy9wTUm6zacTE3rETb+kFKYu215
         pWzTPwfhBQh/qj0yarOlflSlPDIZN2YHcvWkgSD7gD2SuJg1y8I6pRNm43810/nJbjyt
         Jg4A==
X-Gm-Message-State: AFuF++mlt4urLcAg8tvszEc2PIcOMxV83OW4jRJKlQeuj1EAc8mHvrAz
	2RWqYK5PlSrgQwv0z46aoU05M1rQCQ6YXoy4wte/Ww00C1sindV2TVaUowWqPg==
X-Gm-Gg: AR+sD12Mbs4POoTJ27wcS/ga3aTDR7DJNeaAaQpkAxvqyqFcDaXRZCYiY5KAJYLAi3O
	y7K7s1vsZrYeF/noOnVLyo/zC56c1oYa+D8VGhpBuxlzPVlLFs5fqmL2Xhr4sTr62pQWq5NEP7U
	X14iCPTebZz4oDUXYsaSCHIU9I3Irm78+kH8bIu1z50ofDEffwewlE/3k2e9SU5M0YdWfh0rxA5
	RdkPb/CvuhslVYqd21demU3MfsxmJhObQmJYqCQMviOWk43Z4yzzqV+egejg0RwltBCmLa2uyNb
	p+Akfdoiq4vGHQhWSxwZ7awJlyaoy5cla8K4woIkiagj/PLKsm0sGuoN2gAKZyFOEyJ2HbsIOGK
	rQ3OcF2T7eebq72c1jaBZFxFRMsHfMqiWXoGMlNF+Z0aN6OKM+O1tdT95GWLpepwDEAlC7F6w/B
	yxuXbpfAbowkfhQUMNRiwyv2adSWXC55XcP9xybpt8rPAPnzg6ww7iHGlYbcsj3ZvJqkauIsQcP
	7HGNNE82sU=
X-Received: by 2002:a05:620a:4086:b0:936:d360:2eb7 with SMTP id af79cd13be357-939480e7077mr385054285a.20.1788202746520;
        Mon, 31 Aug 2026 11:59:06 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9391740bb62sm862219185a.43.2026.08.31.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:59:06 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol/tests: Remove non-MLS downgrade test
Date: Mon, 31 Aug 2026 14:58:50 -0400
Message-ID: <20260831185851.80078-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The non-MLS downgrade tests are done by reading in an MLS policy
and then just setting the "mls" field to 0. This results in a policy
that could never be created by checkpolicy or secilc. Changing the
mls field does not change the fact that the policy has sensitivities,
categories, levels, and mls constraint expressions. This has limited
the checks that can be done during policy validation.

Remove the downgrade test for the non-mls policy (that is really an
mls policy) and just do it for the mls policy.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/tests/test-downgrade.c | 26 ++++++++------------------
 libsepol/tests/test-downgrade.h |  9 +++------
 2 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/libsepol/tests/test-downgrade.c b/libsepol/tests/test-downgrade.c
index 5f879b39..82af6f39 100644
--- a/libsepol/tests/test-downgrade.c
+++ b/libsepol/tests/test-downgrade.c
@@ -97,15 +97,11 @@ int downgrade_add_tests(CU_pSuite suite)
  * Output: None
  *
  * Description:
- * Tests the backward compatibility of MLS and Non-MLS binary policy versions.
+ * Tests the backward compatibility of MLS binary policy versions.
  */
 void test_downgrade(void)
 {
-	if (do_downgrade_test(0) < 0)
-		fprintf(stderr,
-			"\nError during downgrade testing of Non-MLS policy\n");
-
-	if (do_downgrade_test(1) < 0)
+	if (do_downgrade_test() < 0)
 		fprintf(stderr,
 			"\nError during downgrade testing of MLS policy\n");
 }
@@ -113,8 +109,6 @@ void test_downgrade(void)
 /*
  * Function Name:  do_downgrade_test
  *
- * Input: 0 for Non-MLS policy and 1 for MLS policy downgrade testing
- *
  * Output: 0 on success, negative number upon failure
  *
  * Description: This function handles the downgrade testing.
@@ -123,7 +117,7 @@ void test_downgrade(void)
  *              back out and then read back in again.  The process is
  *              repeated until the minimum policy version is reached.
  */
-int do_downgrade_test(int mls)
+int do_downgrade_test(void)
 {
 	policydb_t policydb_tmp;
 	int hi, lo, version;
@@ -134,15 +128,11 @@ int do_downgrade_test(int mls)
 
 	/* Read in the hi policy from file */
 	if (read_binary_policy(POLICY_BIN_HI, &policydb) != 0) {
-		fprintf(stderr, "error reading %spolicy binary\n",
-			mls ? "mls " : "");
+		fprintf(stderr, "error reading policy binary\n");
 		CU_FAIL("Unable to read the binary policy");
 		return -1;
 	}
 
-	/* Change MLS value based on parameter */
-	policydb.mls = mls ? 1 : 0;
-
 	for (hi = policydb.policyvers; hi >= POLICYDB_VERSION_MIN; hi--) {
 		/* Stash old version number */
 		version = policydb.policyvers;
@@ -156,8 +146,8 @@ int do_downgrade_test(int mls)
 			if (write_binary_policy(POLICY_BIN_LO, &policydb) !=
 			    0) {
 				fprintf(stderr,
-					"error writing %spolicy binary, version %d (downgraded from %d)\n",
-					mls ? "mls " : "", lo, hi);
+					"error writing policy binary, version %d (downgraded from %d)\n",
+					lo, hi);
 				CU_FAIL("Failed to write downgraded binary policy");
 				return -1;
 			}
@@ -171,8 +161,8 @@ int do_downgrade_test(int mls)
 			if (read_binary_policy(POLICY_BIN_LO, &policydb_tmp) !=
 			    0) {
 				fprintf(stderr,
-					"error reading %spolicy binary, version %d (downgraded from %d)\n",
-					mls ? "mls " : "", lo, hi);
+					"error reading policy binary, version %d (downgraded from %d)\n",
+					lo, hi);
 				CU_FAIL("Unable to read downgraded binary policy");
 				return -1;
 			}
diff --git a/libsepol/tests/test-downgrade.h b/libsepol/tests/test-downgrade.h
index 4105defa..ea51c7d9 100644
--- a/libsepol/tests/test-downgrade.h
+++ b/libsepol/tests/test-downgrade.h
@@ -65,17 +65,14 @@ int downgrade_add_tests(CU_pSuite suite);
  * 
  * Output: None
  * 
- * Description: Tests the backward compatibility of MLS and Non-MLS binary
- *		policy versions. 
+ * Description: Tests the backward compatibility of MLS binary policy
+ * versions. 
  */
 void test_downgrade(void);
 
 /*
  * Function Name:  do_downgrade_test
  * 
- * Input: int that represents a 0 for Non-MLS policy and a 
- * 		 1 for MLS policy downgrade testing
- * 
  * Output: (int) 0 on success, negative number upon failure
  * 
  * Description: This function handles the downgrade testing.  A binary policy
@@ -84,7 +81,7 @@ void test_downgrade(void);
  *		back in again. The process is iterative until the minimum
  *		policy version is reached. 
  */
-int do_downgrade_test(int mls);
+int do_downgrade_test(void);
 
 /*
  * Function Name: read_binary_policy
-- 
2.55.0

