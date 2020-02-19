Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB88C34047
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D970020801
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 13:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKTJxMvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBSNpc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:45:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726622AbgBSNpc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 08:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582119931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eme0H3g7355A6BXxdMbiHTAf7hUx3WPYUkWPBTmXjoo=;
        b=LKTJxMvSeYW15GQdVciybQii6aTV2maCk4lOgMGz8ut7bVV0M/tzqdCcP/3tjHuPyK8gdA
        aDEYQYZKBXY+fxy/gqGaeRDYhw9I3fv3c+sPeLSNNSKz1B8c3wU3BIHYyg1q3MPqJdbNZb
        qqkiKAcC2BOQtzsGbw4Em20DCk5eUCU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-srOZgpNfPGStBtR-ymIiSQ-1; Wed, 19 Feb 2020 08:45:27 -0500
X-MC-Unique: srOZgpNfPGStBtR-ymIiSQ-1
Received: by mail-wr1-f70.google.com with SMTP id d8so66637wrq.12
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 05:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eme0H3g7355A6BXxdMbiHTAf7hUx3WPYUkWPBTmXjoo=;
        b=HO2aldbOXJtgUV3WVFCU0K+TNF4h/luIFJPyYL24nfFTMcmabGRz8oT003HfvajMsE
         eaTBI39pJVra3OA9JPs+8sofax6wqoIxUD/LzMLnxU3zKiJYqskIBkJ0AjmpLsCakdbp
         JaJrYKaFu3IUFOV4A/jZ0LK/YKem2HstZ7IUZjd99XYtLIcv/OF5C63Aufubvse6LE0A
         1BSwTPlqT9rgnlPSjHnw56TioHu8Be/OrGoBwOeGqyt2xjl0l5MWgqWnYQGMZChoD+Vm
         7F/uNuGLHUiuEC8Nz1QwnT/zjSfWwYZCMHiIThFqz8u6c+bpAr/VWIdMpo34uzlc1dCF
         Y1JA==
X-Gm-Message-State: APjAAAXFpSRppOJnozd5Erl34c4iH+zTltn0RrKTL+pEChK40LxsJPLc
        QN6VrH8qnMzZ+wL8B8wd4jrOgTvt++RGIx9sUjNm8PuKyl5qqCwLTPA5ESGU+IfaTzubV+bGiPd
        wonyfEpWLqFDvKVrElQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr37928344wrr.226.1582119926291;
        Wed, 19 Feb 2020 05:45:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8yBH1p96+ImZ1RO+xBN2Ox2BkP2B7ije7KXDpaY//qZAQO74ZBvPYid+WfZAxdkkcK8kOjg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr37928324wrr.226.1582119926053;
        Wed, 19 Feb 2020 05:45:26 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f11sm3036558wml.3.2020.02.19.05.45.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 05:45:25 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libsepol: grow hashtab dynamically
Date:   Wed, 19 Feb 2020 14:45:22 +0100
Message-Id: <20200219134522.230822-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219134522.230822-1-omosnace@redhat.com>
References: <20200219134522.230822-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Detect when the hashtab's load factor gets too high and try to grow it
and rehash it in such case. If the reallocation fails, just keep the
hashtab at its current size, since this is not a fatal error (it will
just be slower).

This speeds up semodule -BN on Fedora from ~8.9s to ~7.2s (1.7 seconds
saved).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/src/hashtab.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 9590b359..fe9c55b8 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -63,6 +63,46 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 	return p;
 }
 
+static void hashtab_check_resize(hashtab_t h)
+{
+	unsigned int hvalue, i, old_size, new_size = h->size;
+	hashtab_ptr_t *new_htable, *dst, cur, next, tmp;
+
+	while (new_size <= h->nel && new_size * 2 != 0)
+		new_size *= 2;
+
+	if (h->size == new_size)
+		return;
+
+	new_htable = calloc(new_size, sizeof(*new_htable));
+	if (!new_htable)
+		return;
+
+	old_size = h->size;
+	h->size = new_size;
+
+	/* Move all elements to the new htable */
+	for (i = 0; i < old_size; i++) {
+		cur = h->htable[i];
+		while (cur != NULL) {
+			next = cur->next;
+
+			hvalue = h->hash_value(h, cur->key);
+			dst = &new_htable[hvalue];
+			while (*dst && h->keycmp(h, cur->key, (*dst)->key) > 0)
+				dst = &(*dst)->next;
+
+			tmp = *dst;
+			*dst = cur;
+			cur->next = tmp;
+
+			cur = next;
+		}
+	}
+	free(h->htable);
+	h->htable = new_htable;
+}
+
 int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
 {
 	int hvalue;
@@ -71,6 +111,8 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
 	if (!h)
 		return SEPOL_ENOMEM;
 
+	hashtab_check_resize(h);
+
 	hvalue = h->hash_value(h, key);
 	prev = NULL;
 	cur = h->htable[hvalue];
-- 
2.24.1

