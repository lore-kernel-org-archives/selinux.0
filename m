Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B9CC433F5
	for <selinux@archiver.kernel.org>; Thu, 24 Feb 2022 12:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiBXMnM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 07:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiBXMnL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 07:43:11 -0500
Received: from re-prd-fep-046.btinternet.com (mailomta2-re.btinternet.com [213.120.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A9124C23
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 04:42:41 -0800 (PST)
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20220224124239.ZOHT23644.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 24 Feb 2022 12:42:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1645706559; 
        bh=2wv6UjkwoylhlMg78WJJJ0sejuLEZyGp9V4aPAgQpLg=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=HQ69ReymcT2uY9q8d0g9wvTpjZJy96vxL1XIU5JEkwp2aubYOgj3SE39/1ua96GVjVF0AJ84Jvv+qd7+dJ+YadJDA90WQBe+zVaRIWLG9Fa85ygf/AoSdJxelw1C6wJfzykSAfxc8GO2VHViadCxDDxp1RmVnWwMyD4xZZXcB95xMMcPHBvjQ3sZxwwn7y1kZYiJzOtF7xbNHtYwLCpQ2N11oRmMyfWl1SP25qghY3wSygKotsQDoARSDJrwECI4ak98hTmSpKN7LQ5OF+b87f4Ot8fyAGLAlhM6H/f3rNUWH9fFh/o8TChYccId9KTbsGx8ugFRDjja61q65JF0HA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A8DE8160413B0
X-Originating-IP: [109.158.127.121]
X-OWM-Source-IP: 109.158.127.121 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrledvgdegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepleetffegveevjeehvefhtefgueevudettedutdffvdejkeeiteegheevfeejtdefnecukfhppedutdelrdduheekrdduvdejrdduvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduheekrdduvdejrdduvddupdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopeguvghmihhosggvnhhouhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.158.127.121) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613A8DE8160413B0; Thu, 24 Feb 2022 12:42:39 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, demiobenour@gmail.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH testsuite] tests/ioctl: Update ioctl tests
Date:   Thu, 24 Feb 2022 12:42:27 +0000
Message-Id: <20220224124227.44146-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This change replaces the ioctl check FIOCLEX with FIOQSIZE as the
kernel will always allow FIOCLEX if policy capability 'ioctl_skip_cloexec'
is set true.

Also updated policy to test xperm ioctl FIOQSIZE.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/test_ioctl_xperms.te | 7 ++++---
 tests/ioctl/test_ioctl.c    | 4 ++--
 tests/ioctl/test_noioctl.c  | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/policy/test_ioctl_xperms.te b/policy/test_ioctl_xperms.te
index f9bc8d5..5f570c3 100644
--- a/policy/test_ioctl_xperms.te
+++ b/policy/test_ioctl_xperms.te
@@ -1,4 +1,4 @@
-define(`FIOCLEX', `{ 0x00006601 0x00005451 }')
+define(`FIOQSIZE', `{ 0x00005460 }')
 
 # Domain for process that is allowed the required ioctl xperms.
 type test_ioctl_xperm_t;
@@ -7,7 +7,7 @@ unconfined_runs_test(test_ioctl_xperm_t)
 typeattribute test_ioctl_xperm_t ioctldomain;
 typeattribute test_ioctl_xperm_t testdomain;
 allow test_ioctl_xperm_t test_ioctl_file_t:file { open read write ioctl getattr setattr };
-allowxperm test_ioctl_xperm_t test_ioctl_file_t:file ioctl FIOCLEX;
+allowxperm test_ioctl_xperm_t test_ioctl_file_t:file ioctl FIOQSIZE;
 
 # Domain for process that is not allowed the required ioctl xperms.
 type test_ioctl_noxperm_t;
@@ -15,4 +15,5 @@ domain_type(test_ioctl_noxperm_t)
 unconfined_runs_test(test_ioctl_noxperm_t)
 typeattribute test_ioctl_noxperm_t ioctldomain;
 typeattribute test_ioctl_noxperm_t testdomain;
-allowxperm test_ioctl_noxperm_t test_ioctl_file_t:file ioctl ~FIOCLEX;
+allow test_ioctl_noxperm_t test_ioctl_file_t:file { open read getattr setattr ioctl };
+allowxperm test_ioctl_noxperm_t test_ioctl_file_t:file ioctl ~FIOQSIZE;
diff --git a/tests/ioctl/test_ioctl.c b/tests/ioctl/test_ioctl.c
index 366d09c..6fff2d0 100644
--- a/tests/ioctl/test_ioctl.c
+++ b/tests/ioctl/test_ioctl.c
@@ -35,9 +35,9 @@ int main(int argc, char **argv)
 	}
 
 	/* This one should hit the FILE__IOCTL test */
-	rc = ioctl(fd, FIOCLEX);
+	rc = ioctl(fd, FIOQSIZE, &val);
 	if( rc < 0 ) {
-		perror("test_ioctl:FIOCLEX");
+		perror("test_ioctl:FIOQSIZE");
 		exit(1);
 	}
 
diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
index ddce457..4b67e9a 100644
--- a/tests/ioctl/test_noioctl.c
+++ b/tests/ioctl/test_noioctl.c
@@ -51,9 +51,9 @@ int main(int argc, char **argv)
 	}
 
 	/* This one should hit the FILE__IOCTL test and fail. */
-	rc = ioctl(fd, FIOCLEX);
+	rc = ioctl(fd, FIOQSIZE, &val);
 	if( rc == 0 ) {
-		printf("test_noioctl:FIOCLEX");
+		printf("test_noioctl:FIOQSIZE");
 		exit(1);
 	}
 
-- 
2.35.1

