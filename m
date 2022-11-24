Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E28C433FE
	for <selinux@archiver.kernel.org>; Thu, 24 Nov 2022 16:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKXQdR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Nov 2022 11:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKXQdN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Nov 2022 11:33:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D40B16FB29
        for <selinux@vger.kernel.org>; Thu, 24 Nov 2022 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669307535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxzsuraTLvoJ/8JNrAHlQzWOzvCPjiZlNMZ9V/cmzic=;
        b=ZrN2ZFGFVBdVAkJa28/ODcxwuVCVQEtB9CKdn7LhJdrccFyD/SFArHxLyTG87ImZ49IWhU
        iX6Mc1+TVz+4Lr+LiNqDE40cTE8UChJ8Zu/Lu8Becyo5nnxRU+uJA+i/CFZzMagT16hdMF
        l0nSEX7C5HKQfCGslYKky+srxfAvsVw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-rgcSmXcNMVaWiPHUKcpJFw-1; Thu, 24 Nov 2022 11:32:12 -0500
X-MC-Unique: rgcSmXcNMVaWiPHUKcpJFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EB4129AB3F1
        for <selinux@vger.kernel.org>; Thu, 24 Nov 2022 16:32:12 +0000 (UTC)
Received: from ovpn-194-85.brq.redhat.com (ovpn-194-85.brq.redhat.com [10.40.194.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8194C819
        for <selinux@vger.kernel.org>; Thu, 24 Nov 2022 16:32:12 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsemanage: Use more conscious language
Date:   Thu, 24 Nov 2022 17:31:53 +0100
Message-Id: <20221124163153.500945-2-vmojzis@redhat.com>
In-Reply-To: <20221124163153.500945-1-vmojzis@redhat.com>
References: <20221124163153.500945-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

https://inclusivenaming.org/word-lists/tier-1/

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/semanage_store.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 14a0957a..27c5d349 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -2400,7 +2400,7 @@ static semanage_file_context_node_t
 
 /* Sorts file contexts from least specific to most specific.
  * A bucket linked list is passed in.  Upon completion,
- * there is only one bucket (pointed to by master) that 
+ * there is only one bucket (pointed to by "main") that
  * contains a linked list of all the file contexts in sorted order.
  * Explanation of the algorithm:
  *  This is a stable implementation of an iterative merge sort.
@@ -2411,15 +2411,15 @@ static semanage_file_context_node_t
  *  Buckets are merged until there is only one bucket left, 
  *   containing the list of file contexts, sorted.
  */
-static void semanage_fc_merge_sort(semanage_file_context_bucket_t * master)
+static void semanage_fc_merge_sort(semanage_file_context_bucket_t * main)
 {
 	semanage_file_context_bucket_t *current;
 	semanage_file_context_bucket_t *temp;
 
-	/* Loop until master is the only bucket left.
-	 * When we stop master contains the sorted list. */
-	while (master->next) {
-		current = master;
+	/* Loop until "main" is the only bucket left.
+	 * When we stop "main" contains the sorted list. */
+	while (main->next) {
+		current = main;
 
 		/* Merge buckets two-by-two. 
 		 * If there is an odd number of buckets, the last 
@@ -2547,7 +2547,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 	semanage_file_context_node_t *temp;
 	semanage_file_context_node_t *head;
 	semanage_file_context_node_t *current;
-	semanage_file_context_bucket_t *master;
+	semanage_file_context_bucket_t *main;
 	semanage_file_context_bucket_t *bcurrent;
 
 	i = 0;
@@ -2746,9 +2746,9 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 	/* Create the bucket linked list from the node linked list. */
 	current = head->next;
-	bcurrent = master = (semanage_file_context_bucket_t *)
+	bcurrent = main = (semanage_file_context_bucket_t *)
 	    calloc(1, sizeof(semanage_file_context_bucket_t));
-	if (!master) {
+	if (!main) {
 		ERR(sh, "Failure allocating memory.");
 		semanage_fc_node_list_destroy(head);
 		return -1;
@@ -2772,7 +2772,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 			    calloc(1, sizeof(semanage_file_context_bucket_t));
 			if (!(bcurrent->next)) {
 				ERR(sh, "Failure allocating memory.");
-				semanage_fc_bucket_list_destroy(master);
+				semanage_fc_bucket_list_destroy(main);
 				return -1;
 			}
 
@@ -2781,14 +2781,14 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 	}
 
 	/* Sort the bucket list. */
-	semanage_fc_merge_sort(master);
+	semanage_fc_merge_sort(main);
 
 	/* First, calculate how much space we'll need for 
 	 * the newly sorted block of data.  (We don't just
 	 * use buf_len for this because we have extracted
 	 * comments and whitespace.) */
 	i = 0;
-	current = master->data;
+	current = main->data;
 	while (current) {
 		i += current->path_len + 1;	/* +1 for a tab */
 		if (current->file_type) {
@@ -2803,14 +2803,14 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 	*sorted_buf = calloc(i, sizeof(char));
 	if (!*sorted_buf) {
 		ERR(sh, "Failure allocating memory.");
-		semanage_fc_bucket_list_destroy(master);
+		semanage_fc_bucket_list_destroy(main);
 		return -1;
 	}
 	*sorted_buf_len = i;
 
 	/* Output the sorted semanage_file_context linked list to the char buffer. */
 	sorted_buf_pos = *sorted_buf;
-	current = master->data;
+	current = main->data;
 	while (current) {
 		/* Output the path. */
 		i = current->path_len + 1;	/* +1 for tab */
@@ -2834,7 +2834,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 	}
 
 	/* Clean up. */
-	semanage_fc_bucket_list_destroy(master);
+	semanage_fc_bucket_list_destroy(main);
 
 	/* Sanity check. */
 	sorted_buf_pos++;
-- 
2.37.3

