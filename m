Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D06C77B73
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjDTPFz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjDTPFy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:05:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E076558E
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b16so7155082ejz.3
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682003151; x=1684595151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5a5OHVelsIRUN/Fw4kYGHYHUK5S0uRDFkWh1RP0Pvg=;
        b=Up1fWl/uhqiaXxJd3E8I0CPM40U4Y495CgDsbUoxzjBQD3uej7cbarVOdBJ0IYfbfS
         duXua3aZAspGgMLHpYdETmNBLAIPIZdM8TvDrNfNsVXXfh9NOdARSiu32MVQOJkMiBGW
         zyvPkiKnKnme4Mcy/bXCBKJolBJ1fymqYhS7V3ptupmPjs1FqhYfoaLLj4BVOSWXv3KM
         H7IrmzpWMG7JLZaXWB1aEcmIvClEzEQA/dlCexMy3ks1AnyYePT3dm0TugyhYHglVoaU
         7UU7F0nhDeQ1j7ZRw2lYH03s1vYy1dvH4hgj84E5tF0KDcWt/MJ+Yvpfy17J4ke1Ln3M
         G39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682003151; x=1684595151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5a5OHVelsIRUN/Fw4kYGHYHUK5S0uRDFkWh1RP0Pvg=;
        b=bFmshPjbhFcsZIW9Zm12Xu0+fJhKQa/l/Epg0+oqU2UAaKb3iAHy98esv/dfu5rXdS
         e+goNEg8dt2j8fa28QdmUHDEXlHCOgd4u9IKppU2gHlVPESg8eNE0wrO8QnckMxO+FDh
         c4RpDG1LIPhyBwbIU+2ieEc0z9QM+hw6mVFEgTA4eIKYGBNsS+rR+ou/PfPIfuAuhjMp
         gYn/JzXWaiDdhA6QzM0Kdizg38U4fwyZSr1yQSPQ1SIhGlMLB89tqTlr0fM6RmkKDeeY
         Gb5fdR99GpxZqG+odP/T2w6j8udMW5UcAkfm1wSVCwDvrA98NpibRnhdBA0Q704ADv+L
         ua2Q==
X-Gm-Message-State: AAQBX9fRWPEMX4Vih+SfkMn3vox/jZp6Ly1DnzR4pi+PYxTnKQHEGzz4
        W4+F9nM7LDYbOGkTNhIXb5AaQYE6vTQ=
X-Google-Smtp-Source: AKy350aDd79X3u404tkMePw/pJJKAdwQi8sot85CU2xWASz9s1al8BJP574a/EfStIArVdIOdBKw6w==
X-Received: by 2002:a17:906:2d6:b0:94f:3045:2255 with SMTP id 22-20020a17090602d600b0094f30452255mr1723303ejk.50.1682003151602;
        Thu, 20 Apr 2023 08:05:51 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm827430ejb.56.2023.04.20.08.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:05:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: [PATCH 3/6] selinux: avc: drop unused function avc_disable()
Date:   Thu, 20 Apr 2023 17:05:00 +0200
Message-Id: <20230420150503.22227-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420150503.22227-1-cgzones@googlemail.com>
References: <20230420150503.22227-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since commit f22f9aaf6c3d ("selinux: remove the runtime disable
functionality") the function avc_disable() is no longer used.

Improves: f22f9aaf6c3d ("selinux: remove the runtime disable functionality")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/avc.c         | 19 -------------------
 security/selinux/include/avc.h |  3 ---
 2 files changed, 22 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index eaed5c2da02b..6bc65830e1a9 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1203,22 +1203,3 @@ u32 avc_policy_seqno(void)
 {
 	return selinux_avc.avc_cache.latest_notif;
 }
-
-void avc_disable(void)
-{
-	/*
-	 * If you are looking at this because you have realized that we are
-	 * not destroying the avc_node_cachep it might be easy to fix, but
-	 * I don't know the memory barrier semantics well enough to know.  It's
-	 * possible that some other task dereferenced security_ops when
-	 * it still pointed to selinux operations.  If that is the case it's
-	 * possible that it is about to use the avc and is about to need the
-	 * avc_node_cachep.  I know I could wrap the security.c security_ops call
-	 * in an rcu_lock, but seriously, it's not worth it.  Instead I just flush
-	 * the cache and get that memory back.
-	 */
-	if (avc_node_cachep) {
-		avc_flush();
-		/* kmem_cache_destroy(avc_node_cachep); */
-	}
-}
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 9301222c8e55..9e055f74daf6 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -168,9 +168,6 @@ int avc_get_hash_stats(char *page);
 unsigned int avc_get_cache_threshold(void);
 void avc_set_cache_threshold(unsigned int cache_threshold);
 
-/* Attempt to free avc node cache */
-void avc_disable(void);
-
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 DECLARE_PER_CPU(struct avc_cache_stats, avc_cache_stats);
 #endif
-- 
2.40.0

