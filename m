Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03095C433F5
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 12:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhLHMUm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:20:42 -0500
Received: from mailomta10-sa.btinternet.com ([213.120.69.16]:30173 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233189AbhLHMUk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 07:20:40 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20211208121706.DGXF30965.sa-prd-fep-041.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 8 Dec 2021 12:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638965826; 
        bh=W7dvuQBGveBXMyrEhX/osg05mmZywTyB4Vwf/3RluVQ=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=WuXE4frAaqzI1lFaf+/PQ/OhVrVeDUSaTOmGg2hyFuIfkkL10Sn6AhwwWBHbf14rA2d31KJH3Q4Byj1n9U+opSCW3wCeGlx91KVNc9STaK5XStEnprKnNoa17rfH63eUM5zgLjevsaTuwdmRojC2x3Icpqz6ytkJ/a7NHE8FaPLMxcYYJz/9EArvKWbX7WMKSzE8U8RQA0cchlmc/wcN8DZjEMFPWkrrnXfHBxOc/FHvurfWhjiGCNC63KO6TNoI5NBMNNKzc6xhnPz7lUNsOpUWj7jdm3aeOsZRoicwbB+EHJ/NYnx0JmVkUWMI7dpIuvDNGd2I4eNAekhUR+1ViA==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C0D2162C5
X-Originating-IP: [109.150.61.81]
X-OWM-Source-IP: 109.150.61.81 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppedutdelrdduhedtrdeiuddrkedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrdduhedtrdeiuddrkedupdhmrghilhhfrhhomheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehprghulhesphgruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtoheprhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.150.61.81) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139417C0D2162C5; Wed, 8 Dec 2021 12:17:06 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 6/7] policy_config_files.md: Update snapperd_contexts contents
Date:   Wed,  8 Dec 2021 12:16:53 +0000
Message-Id: <20211208121654.7591-7-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208121654.7591-1-richard_c_haines@btinternet.com>
References: <20211208121654.7591-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Used by snapper(8) for filesystem snapshot management.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/policy_config_files.md | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/policy_config_files.md b/src/policy_config_files.md
index 0db80b4..c87cdfd 100644
--- a/src/policy_config_files.md
+++ b/src/policy_config_files.md
@@ -816,10 +816,26 @@ db_schema         *.*       system_u:object_r:sepgsql_schema_t:s0
 
 ## *contexts/snapperd_contexts*
 
-**To be determined**
+Used by ***snapper**(8)* for filesystem snapshot management to set an SELinux
+context on ***btrfs**(8)* subvolumes. This is a Red Hat specific policy
+configuration file.
 
 **The file format is as follows:**
 
+```
+snapperd_data = user:role:type[:range]
+```
+
+**Where:**
+
+*snapperd_data*
+
+- The keyword *snapperd_data*
+
+*user:role:type[:range]*
+
+- The security context including the MLS / MCS *level* or *range* if applicable.
+
 **Example file contents:**
 
 ```
-- 
2.33.1

