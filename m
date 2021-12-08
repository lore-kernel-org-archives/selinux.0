Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C36C433F5
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 12:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhLHMUq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:20:46 -0500
Received: from mailomta11-sa.btinternet.com ([213.120.69.17]:27925 "EHLO
        sa-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233197AbhLHMUm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 07:20:42 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20211208121705.DGXD30965.sa-prd-fep-041.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 8 Dec 2021 12:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1638965825; 
        bh=GT1htTvTTuYTOt5xrRbHoZJEI6wqyco/TELn/DQMw9Q=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Q6fmWLlLKdND+RGLeMKE+HsshyiaVybwWUXA2wBisaXhGBoy+lM83Bae1LPDO8M9yBuO1NJXx0ozYvAH9pOwBi096cCYetSAf5Wa7j+PiIHX/V1vnBbAQNvfXFmwCojhErNnT1cfXFhJqLyBlBT+qMLnwSGmTVet4+b7Mnzi4IoIp/397z53OX13pTLRAZd9mL9D3d2belJflve1ruQf9gSjdbAykUccHFq6gCE8PTaDO+0t2KFKdv+6didXtQ8CiV4u1jRN8CJKnuO1nVN0CzDcn2UJ0kNIq+G6OwNon9MEhXRQ1QFhEmHZgwgUNOSvcAL93eTkCZ5lD7J4xr3cJw==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C0D2162B3
X-Originating-IP: [109.150.61.81]
X-OWM-Source-IP: 109.150.61.81 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepveekveevtdffgedvfeffieegieeijeehleelvefhudeiuefgvdehkeevvdellefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddtledrudehtddriedurdekudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepuddtledrudehtddriedurdekuddpmhgrihhlfhhrohhmpehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtghomhdprhgtphhtthhopehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (109.150.61.81) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as richard_c_haines@btinternet.com)
        id 6139417C0D2162B3; Wed, 8 Dec 2021 12:17:05 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 3/7] object_classes_permissions.md: Deprecate lockdown class
Date:   Wed,  8 Dec 2021 12:16:50 +0000
Message-Id: <20211208121654.7591-4-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208121654.7591-1-richard_c_haines@btinternet.com>
References: <20211208121654.7591-1-richard_c_haines@btinternet.com>
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

