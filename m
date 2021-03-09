Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44EAC433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 16:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FC965237
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhCIQq1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 11:46:27 -0500
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:24475 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230473AbhCIQqL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 11:46:11 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20210309164609.DYXH18585.re-prd-fep-042.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 9 Mar 2021 16:46:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1615308369; 
        bh=NNJaCK2FJ+BCPIiU1EcLyaOeCJikodWByHRNpeDo93k=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=YE6ETj8z3BWCMglpkGCZHdJNQCddCeFhQrn1AcyXg6Hnj1zXoRouOpEnB28WD9AhafFGKs4XOwXbo7wp1Liy1MF210xdLKT9HLPbW1/SncBsnnirvITSWD58P/3VYbsLJFRxqjlhHbp0G+4nFKyTzon+0Q0J3EBD7O1fkbyWhJ64zsBXuQdIVQftRCVjfu/PZWAanwE9JfCM+QaykGGko2ZdVfEeaVP58S7EWIwPpZ38e2CEdYDjxeca/+Pys9Vk7c6d+ML5EE65KyibaNhQtqHVu8m4E4vj4dbKJ6LHdp9I/wEHbSe52Vib/CWiauSlJgoIa97JpDJOHIu3XQpcug==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C50629DE61A8
X-Originating-IP: [86.133.207.84]
X-OWM-Source-IP: 86.133.207.84 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudduiedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeufeefudfffeetjeevheetvdekueeuvefftdfgkefgtefgkeegieehveeuhedvffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekiedrudeffedrvddtjedrkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudeffedrvddtjedrkeegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhn
        vghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.133.207.84) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C50629DE61A8; Tue, 9 Mar 2021 16:46:09 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] object_classes_permissions.md: Add anon_inode class
Date:   Tue,  9 Mar 2021 16:46:02 +0000
Message-Id: <20210309164602.145140-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add anon_inode class and permissions with example rules. The kernel
currently only supports userfaultfd(2) services.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 src/object_classes_permissions.md | 28 ++++++++++++++++++++++++++++
 src/type_statements.md            |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/src/object_classes_permissions.md b/src/object_classes_permissions.md
index fa16024..bbc703d 100644
--- a/src/object_classes_permissions.md
+++ b/src/object_classes_permissions.md
@@ -20,6 +20,7 @@
     - [*blk_file*](#blk_file)
     - [*sock_file*](#sock_file)
     - [*fifo_file*](#fifo_file)
+    - [*anon_inode*](#anon_inode)
     - [*fd*](#fd)
   - [Network Object Classes](#network-object-classes)
     - [*node*](#node)
@@ -953,6 +954,33 @@ Named pipes
 **Permissions** - Inherit 25
 [**Common File Permissions**](#common-file-permissions):
 
+- *append*, *audit_access*, *create*, *execute*, *execmod*, *getattr*, *ioctl*,
+  *link*, *lock*, *map*, *mounton*, *open*, *quotaon*, *read*, *relabelfrom*,
+  *relabelto*, *rename*, *setattr*, *unlink*, *watch*, *watch_mount*,
+  *watch_sb*, *watch_with_perm*, *watch_reads*, *write*
+
+### *anon_inode*
+
+Control anonymous-inode files via the kernel *anon_inode_getfd_secure()*
+function. Policy controls anonymous inodes by adding a name-based
+[***type_transition***](type_statements.md#type_transition) rule that assigns
+a *type* to anonymous-inode files created in a domain. The *name* used for the
+name-based transition is the name associated with the anonymous inode for file
+listings, for example:
+
+```
+type uffd_t;
+type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
+allow sysadm_t uffd_t:anon_inode { create };
+```
+
+Currently only ***userfaultfd**(2)* makes use of this service (from kernel 5.12)
+as described in the patch series
+<https://lore.kernel.org/selinux/20210108222223.952458-1-lokeshgidra@google.com/>
+
+**Permissions** - Inherit 25
+[**Common File Permissions**](#common-file-permissions):
+
 - *append*, *audit_access*, *create*, *execute*, *execmod*, *getattr*, *ioctl*,
   *link*, *lock*, *map*, *mounton*, *open*, *quotaon*, *read*, *relabelfrom*,
   *relabelto*, *rename*, *setattr*, *unlink*, *watch*, *watch_mount*,
diff --git a/src/type_statements.md b/src/type_statements.md
index 0d7f137..572c540 100644
--- a/src/type_statements.md
+++ b/src/type_statements.md
@@ -471,6 +471,10 @@ however, this is only appropriate for the file classes:
 type_transition source_type target_type : class default_type object_name;
 ```
 
+Kernel 5.12 introduced the 'name transition' rule for anonymous inodes that is
+described with an example in the
+[**anon_inode Object Class**](object_classes_permissions.md#anon_inode) section.
+
 **Where:**
 
 *type_transition*
-- 
2.29.2

