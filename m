Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86754C34050
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541202464E
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 15:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qpsbne0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBSPnx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:43:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43131 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726523AbgBSPnw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 10:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582127031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpnXPPmg8Fhgl6r6Ga202wLULcGk0dX614dJhlnIBD8=;
        b=Qpsbne0/mEUvVYaI9Ck5zSm+alGX2Kyw3Vd6DH3CbV2tKOAAHFW1Vkjh+bkt7IYmQOYzrG
        hgq53toL9zCMtO/SwvsxtqyiEP6LSbvq1i0xvdXErBQM/sPDCiovkk9hWuFJ7FlbXSvMAu
        bqvCfkpXg5ec0+8+YJXFoCfOsi8Qt40=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-924X4wDkMku55lq1HHafvA-1; Wed, 19 Feb 2020 10:43:48 -0500
X-MC-Unique: 924X4wDkMku55lq1HHafvA-1
Received: by mail-wr1-f69.google.com with SMTP id w6so247069wrm.16
        for <selinux@vger.kernel.org>; Wed, 19 Feb 2020 07:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpnXPPmg8Fhgl6r6Ga202wLULcGk0dX614dJhlnIBD8=;
        b=mAVOkd8bysAmB8AxkTKlceveJI35LTtY/T7RN74yocvuXU104NlJJbJhb2f1c+XSuO
         Cnh1d1dmohMr5045emk847JgsD/fbfYxjE7CyS+yXwip9tqejS5lI0tT3RJCnd8cJGLz
         kbU55wK9TIC7i6gMsatonqIO67Vka+xJB0T8pcv+AoeFdMv0TdnvZV2EDDD2BFTVnkaC
         4n8ayNOFaDAL4II/EMrvzXhjJHofP/J+OroNKXpfwAcDxC3OudE3BK55OUqXoj1NuNZx
         R9EtcWu+Z3s87V6f3jBC1ZgzIvTq/GYgfNmVfmVjP+etBnB+1Pqn15y/b5SBsFuWdeIm
         wTAg==
X-Gm-Message-State: APjAAAUaQnVRxG8FJH8+asdwv80FP/I+FVaiC5pOfOaaDgB55rPsPTAA
        albqlo0ROGJg06b2uWX7PqTC7bjPJziaP2B7BE1dBTmosccaGxmgxvVxTk0rmSNDBwWPG9bNXAl
        x44xSiJNKd7ghiw96Og==
X-Received: by 2002:adf:90cb:: with SMTP id i69mr37581137wri.205.1582127026340;
        Wed, 19 Feb 2020 07:43:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQLQ9RfvSHFLYaKSeRmO/oFlMyzMwsqOwrUP5FZRVHRkDCSYRUBI2IhYngoNYyF+n/S5Ak3g==
X-Received: by 2002:adf:90cb:: with SMTP id i69mr37581116wri.205.1582127026076;
        Wed, 19 Feb 2020 07:43:46 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t9sm181591wrv.63.2020.02.19.07.43.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:43:45 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/2] libsepol: grow hashtab dynamically
Date:   Wed, 19 Feb 2020 16:43:42 +0100
Message-Id: <20200219154342.240852-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219154342.240852-1-omosnace@redhat.com>
References: <20200219154342.240852-1-omosnace@redhat.com>
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
 libsepol/src/hashtab.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 9590b359..21143b76 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -63,6 +63,45 @@ hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
 	return p;
 }
 
+static void hashtab_check_resize(hashtab_t h)
+{
+	unsigned int hvalue, i, old_size, new_size = h->size;
+	hashtab_ptr_t *new_htable, *dst, cur, next;
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
+			hvalue = h->hash_value(h, cur->key);
+			dst = &new_htable[hvalue];
+			while (*dst && h->keycmp(h, cur->key, (*dst)->key) > 0)
+				dst = &(*dst)->next;
+
+			next = cur->next;
+
+			cur->next = *dst;
+			*dst = cur;
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
@@ -71,6 +110,8 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
 	if (!h)
 		return SEPOL_ENOMEM;
 
+	hashtab_check_resize(h);
+
 	hvalue = h->hash_value(h, key);
 	prev = NULL;
 	cur = h->htable[hvalue];
-- 
2.24.1

