Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BEBC76196
	for <selinux@archiver.kernel.org>; Mon,  3 Apr 2023 16:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjDCQie (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjDCQiT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Apr 2023 12:38:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBAD2699
        for <selinux@vger.kernel.org>; Mon,  3 Apr 2023 09:38:12 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id cu4so21567001qvb.3
        for <selinux@vger.kernel.org>; Mon, 03 Apr 2023 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680539891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8RIwowHYI+9tpcqfBRyl1Kvs1ZZFdi5VbFWzhT6N+H8=;
        b=RxFZvADUupiUG7Mb5HERQMaeM0NM7pHb7eZUkngNXflk+UxyTLHcAUysSjwTi8giv6
         ewO6kSET6qT3s/9lylHNnqexa317nI8KGmagHyQvXTJOgWuCYv6fzGVggXI6C+JJWmb7
         tuPXqDzmoFEuMeXvZuVzNfyx8e28DOjPmugROq9cjUF/aFtjk1TFLh2FJ+ECYboxB38E
         yRneu1hjzTUe3ZTsJeEdp/0Ue0QjOe1/thgW5imVmxcOtxd13IrO/3BVfAg18S2D+bb9
         ybRkUy42LnJPKlYqTe/wQQsaiD5v14HKFqoSUuFqgxeZs31gWn+b53rNfrSUNI59CjGa
         djkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RIwowHYI+9tpcqfBRyl1Kvs1ZZFdi5VbFWzhT6N+H8=;
        b=55mv08UhkHTtKF/4dYEpwK5ELN4MYMW0If+2UgJgNkMNH9ZtgVu9wmqzFpTajqa5eF
         veCCpWwiAcDjeh+TNA5OdTQl8IBZlSgdJDN+bNjEV9nVSsbi3LL02hEJDXbL4aZHeVkZ
         xlYGBdfs+raIWHnnKle7H5Ngt5x2ZCbIcmAMyg9jBc0wluuwVOvU422QwtB95Kez0lrU
         Vz+9HopJoVPGm9niy4MVMq46rPryfCgXSi2XBTnlEekO7k8YiuhENn1BU2XzGEu5GFM4
         qzbo0zsKt/Ezfzjjne+NaFlA3sQHIU45ZaLhQwMoeZZLg/JpFqU5sgUmIYZ/UMLPKJ9R
         iUJQ==
X-Gm-Message-State: AAQBX9dZrTLlIJ2n5Q1S9ce4xd2BEkmWSeIYGgf8G7H2U6NCFIehGDQ1
        IvQqNfkG7pMMS5wL6qVevzxICGTy4qM=
X-Google-Smtp-Source: AKy350aSkQ8ej2OIz6/T10zXb0Jjrn10JDtn00NAxnde3IlToxwER52PXqFn7nVVTFwCNmSp+Z7LSg==
X-Received: by 2002:a05:6214:5298:b0:5b5:99b6:f0d0 with SMTP id kj24-20020a056214529800b005b599b6f0d0mr62246443qvb.32.1680539891164;
        Mon, 03 Apr 2023 09:38:11 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id eh6-20020a056214186600b005e3c303863csm1061128qvb.8.2023.04.03.09.38.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2023 09:38:10 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: stop returning node from avc_insert
Date:   Mon,  3 Apr 2023 12:37:53 -0400
Message-Id: <20230403163753.30196-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The callers haven't used the returned node since
commit 21193dcd1f3570dd ("SELinux: more careful use of avd in
avc_has_perm_noaudit") and the return value assignments were removed in
commit 0a9876f36b08706d ("selinux: Remove redundant assignments"). Stop
returning the node altogether and make the functions return void.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/avc.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index c162e51fb43c..ad2afc17b633 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -603,12 +603,11 @@ static int avc_latest_notif_update(int seqno, int is_insert)
  * response to a security_compute_av() call.  If the
  * sequence number @avd->seqno is not less than the latest
  * revocation notification, then the function copies
- * the access vectors into a cache entry, returns
- * avc_node inserted. Otherwise, this function returns NULL.
+ * the access vectors into a cache entry.
  */
-static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass,
-				   struct av_decision *avd,
-				   struct avc_xperms_node *xp_node)
+static void avc_insert(u32 ssid, u32 tsid, u16 tclass,
+		struct av_decision *avd,
+		struct avc_xperms_node *xp_node)
 {
 	struct avc_node *pos, *node = NULL;
 	int hvalue;
@@ -617,16 +616,16 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass,
 	struct hlist_head *head;
 
 	if (avc_latest_notif_update(avd->seqno, 1))
-		return NULL;
+		return;
 
 	node = avc_alloc_node();
 	if (!node)
-		return NULL;
+		return;
 
 	avc_node_populate(node, ssid, tsid, tclass, avd);
 	if (avc_xperms_populate(node, xp_node)) {
 		avc_node_kill(node);
-		return NULL;
+		return;
 	}
 
 	hvalue = avc_hash(ssid, tsid, tclass);
@@ -644,7 +643,7 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass,
 	hlist_add_head_rcu(&node->list, head);
 found:
 	spin_unlock_irqrestore(lock, flag);
-	return node;
+	return;
 }
 
 /**
@@ -984,13 +983,13 @@ int avc_ss_reset(u32 seqno)
  * fails.  Don't inline this, since it's the slow-path and just results in a
  * bigger stack frame.
  */
-static noinline struct avc_node *avc_compute_av(u32 ssid, u32 tsid, u16 tclass,
-						struct av_decision *avd,
-						struct avc_xperms_node *xp_node)
+static noinline void avc_compute_av(u32 ssid, u32 tsid, u16 tclass,
+				struct av_decision *avd,
+				struct avc_xperms_node *xp_node)
 {
 	INIT_LIST_HEAD(&xp_node->xpd_head);
 	security_compute_av(ssid, tsid, tclass, avd, &xp_node->xp);
-	return avc_insert(ssid, tsid, tclass, avd, xp_node);
+	avc_insert(ssid, tsid, tclass, avd, xp_node);
 }
 
 static noinline int avc_denied(u32 ssid, u32 tsid,
-- 
2.39.2

