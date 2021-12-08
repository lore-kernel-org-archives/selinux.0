Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F9C43217
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 12:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhLHMUr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:20:47 -0500
Received: from mailomta4-sa.btinternet.com ([213.120.69.10]:44257 "EHLO
        sa-prd-fep-045.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233203AbhLHMUm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 07:20:42 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20211208121706.USZQ20692.sa-prd-fep-045.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 8 Dec 2021 12:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638965826; 
        bh=osbaEYGeLWZxTuqrjCvqNRcjm39GtPNgL8FD5yRdk2Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Kz09WvjMLc3yYVYBJOWp3LJ13i/3vL0O7GNa8yv4PHbyKO3AagGzCxBRun96DTvMRL2+uoL/XM4aTMEEoaVxXNGvevV8n3Tc5nBeiARsy+xlipNuC95CFk16iMVA4PVRB2PFnWbOKDMLB9xuKQ3GbHxzZIuSIP0y6hgnVijTKvhU+rst6CCTAbmIcrA4AHcQId8z+YtnN9lVgXlAoFSYCuprVEImg4jv0DuseLo+uMQwa7AGo5w/vkSWujxGoaTmSlzkqCK/utvBWpkoTbNr7TSG17RkcjfAQoIrlpp/PLGD4Doo6c1g6l8ng42hLuhJZFuwrfuudY0S5NfAYmNDDw==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C0D2162C0
X-Originating-IP: [109.150.61.81]
X-OWM-Source-IP: 109.150.61.81 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppedutdelrdduhedtrdeiuddrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduhedtrdeiuddrkedupdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.150.61.81) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139417C0D2162C0; Wed, 8 Dec 2021 12:17:06 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 5/7] policy_config_files.md: Update openssh_contexts contents
Date:   Wed,  8 Dec 2021 12:16:52 +0000
Message-Id: <20211208121654.7591-6-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208121654.7591-1-richard_c_haines@btinternet.com>
References: <20211208121654.7591-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Used by openssh for privilege separated processes in the
preauthentication phase.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_config_files.md | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index 4b2c091..0db80b4 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -715,10 +715,26 @@ run_init=run_init_t
 
 ## *contexts/openssh_contexts*
 
-**To be determined**
+Used by *openssh* (***ssh**(1)*) for privilege separated processes in the
+preauthentication phase. This is a Red Hat specific policy configuration file.
 
 **The file format is as follows:**
 
+```
+privsep_preauth=[domain]
+```
+
+**Where:**
+
+*privsep_preauth*
+
+- The keyword *privsep_preauth*
+
+*domain*
+
+- The domain type for the privilege separated processes in the
+  preauthentication phase.
+
 **Example file contents:**
 
 ```
-- 
2.33.1

