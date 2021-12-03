Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57FC433FE
	for <selinux@archiver.kernel.org>; Fri,  3 Dec 2021 14:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbhLCOI6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:08:58 -0500
Received: from mailomta4-sa.btinternet.com ([213.120.69.10]:16119 "EHLO
        sa-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380315AbhLCOI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Dec 2021 09:08:58 -0500
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20211203140533.IKNZ22188.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 3 Dec 2021 14:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638540333; 
        bh=GT1htTvTTuYTOt5xrRbHoZJEI6wqyco/TELn/DQMw9Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Ok/OJrxtQi5aFUxdSrddEB/DPceY/28c9R9MuWkNU0u9+85aDBC4ueG/U2NW5uRw2V/xhcBt2MAYV6PQpqbpaT5l2N2aZzdSUJ87LU4yJGM1ahuyIu+qjbUr3rim6Wxi/VmpV82Mz2sy0WUKA6zDmY1gpRNMkDKozfXQE4Lw/VdBN8/e8u9OggIVMOaQH3O61xO1Gwv61m5pAo7i11lRf2DDC5SaB5lO/F7INXJLQQ+j3UBK46On7tISvwaxnbj6/9r7Nk03b41k/ZZNZ7m4vnrAD0ecQcl42LV6q0OeFa/kswFLY0Ms3ROlfNdI2CsEwGtcqs4QZMqyhooJ9YBUTw==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A90DA061A1
X-Originating-IP: [81.147.31.174]
X-OWM-Source-IP: 81.147.31.174 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepveekveevtdffgedvfeffieegieeijeehleelvefhudeiuefgvdehkeevvdellefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkedurddugeejrdefuddrudejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddugeejrdefuddrudejgedpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.31.174) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 613006A90DA061A1; Fri, 3 Dec 2021 14:05:33 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 3/7] object_classes_permissions.md: Deprecate lockdown class
Date:   Fri,  3 Dec 2021 14:05:15 +0000
Message-Id: <20211203140519.30930-4-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203140519.30930-1-richard_c_haines@btinternet.com>
References: <20211203140519.30930-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add text regarding the removal of lockdown hooks from kernel 5.16.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/object_classes_permissions.md | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
index b092a9b..4ad8520 100644
--- a/src/object_classes_permissions.md
+++ b/src/object_classes_permissions.md
@@ -70,7 +70,7 @@
   - [Performance Event Object Class](#performance-event-object-class)
     - [*perf_event*](#perf_event)
   - [Lockdown Object Class](#lockdown-object-class)
-    - [*lockdown*](#lockdown)
+    - [*lockdown* (Deprecated)](#lockdown-deprecated)
   - [IPC Object Classes](#ipc-object-classes)
     - [*ipc* (Deprecated)](#ipc-deprecated)
     - [*sem*](#sem)
@@ -1674,15 +1674,15 @@ Control ***perf**(1)* events
 
 ## Lockdown Object Class
 
-Note: If the *lockdown* LSM is enabled alongside SELinux, then the
-lockdown access control will take precedence over the SELinux lockdown
-implementation.
+The *lockdown* class and associated SELinux LSM hook (added in kernel 5.6),
+have been removed from kernel 5.16 for the reasons discussed in
+<https://lore.kernel.org/selinux/163292547664.17566.8479687865641275719.stgit@olly/>.
 
-### *lockdown*
+### *lockdown* (Deprecated)
 
 Stop userspace extracting/modify kernel data.
 
-**Permissions** - 6 unique permissions:
+**Permissions** - 2 unique permissions:
 
 *confidentiality*
 
-- 
2.33.1

