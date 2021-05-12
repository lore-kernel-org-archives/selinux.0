Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49BFC43460
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 10:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ACB9613EE
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 10:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhELK0o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 06:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230300AbhELK0o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 06:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620815136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zxq29cxCv8QVE7RRwD6dxr+Yw8dBa4lFBBtQVxJ7Xf0=;
        b=UaUcEMGV0g6W2sULv/6pP8plvalfcZBwR4QOjgal/P8V8y3KOIYeHYWHv3j8k4AaSeO2io
        DYmVxpTRlZku/wTxM3tEytAjOarmdeqsz9TVSrpNuYB5Kw+joCBLCuYZCYZS7wkAlR1AKi
        vuVeVvWedRyMK56rYu/Jm0sM8njlL98=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-8R0D3hIRPQe28BpYXljq0Q-1; Wed, 12 May 2021 06:25:34 -0400
X-MC-Unique: 8R0D3hIRPQe28BpYXljq0Q-1
Received: by mail-ej1-f69.google.com with SMTP id nd10-20020a170907628ab02903a324b229bfso7009061ejc.7
        for <selinux@vger.kernel.org>; Wed, 12 May 2021 03:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zxq29cxCv8QVE7RRwD6dxr+Yw8dBa4lFBBtQVxJ7Xf0=;
        b=ROxZ8uzBa7tj7z7Q/nRvQEh7t9Sn1ruGZrF5LztcXPuB4fmmNL0w3xdLi0R4tWuHt4
         8AMz98MNK0dz/ppYcqh0ScFBeYmAjxGBUAILLCpErk1+AW0+2H6OBiIbP2a/I5W2uajz
         XaTeSB2pdXb0P73DkjcxWHJ1fo/RqJERGuu/ezCNPQsXSBFPX/VjEfAFerE3gt9CnTdO
         OSestXz4OhLRlN4QjfEc+Oi2chDlgOeqDCT1wtUm+p24yW9SW0q8MVqZnwsa6Rt5uz4U
         YncQoBMQb1Wrm+pXKcdiOwTKP/GfG5BO8QQZltmr+Zg8PjJCY6Mz/7vOh9XC13Zz0NeY
         JlhA==
X-Gm-Message-State: AOAM530CTQY8CZ6LEAVaNhAlf8QCKpk4MO9iOBUJuXK0s5pNXFVSSQSk
        MDKK+VnwhGZS/bt+XuBoOQ36EE0mAKmBa0Y/XkZI8c3cQhU9HOBzJ5POv1L8PWxPu8Pr9uq/Bqp
        G/XDSM0OOrjUXh+4pFGPMtnHmujEEHv2kXXTvZ4Oz6nNTJLwn0pDAup7uvATTecu8BkWjlQ==
X-Received: by 2002:aa7:c510:: with SMTP id o16mr42173082edq.310.1620815132918;
        Wed, 12 May 2021 03:25:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt3rJ7GGAxN/lxLJfqD4+kVI422z1cmPGUmZeDBGDitOyyz/N9DQ1X/KL63VFIUKw6pV/vgw==
X-Received: by 2002:aa7:c510:: with SMTP id o16mr42173055edq.310.1620815132671;
        Wed, 12 May 2021 03:25:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id cw6sm13518716ejb.32.2021.05.12.03.25.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:25:32 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 1/2] libselinux: fix invalid free in store_stem()/load_mmap()
Date:   Wed, 12 May 2021 12:25:28 +0200
Message-Id: <20210512102529.122753-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512102529.122753-1-omosnace@redhat.com>
References: <20210512102529.122753-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Building libselinux with GCC 11.1.1 produces the following warning:
```
In file included from label_file.c:24:
In function ‘store_stem’,
    inlined from ‘load_mmap’ at label_file.c:277:12,
    inlined from ‘process_file’ at label_file.c:551:5:
label_file.h:289:25: error: ‘free’ called on pointer ‘*mmap_area.next_addr’ with nonzero offset 4 [-Werror=free-nonheap-object]
  289 |                         free(buf);
      |                         ^~~~~~~~~
```

Indeed, in this case the pointer shouldn't be freed as it comes from
mmap. Fix this by adding a from_mmap parameter to store_stem() instead
of overriding the saved_data::from_mmap value in load_mmap().

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/label_file.c |  3 +--
 libselinux/src/label_file.h | 12 +++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index cfce23e0..199ae66b 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -274,12 +274,11 @@ end_arch_check:
 		/* store the mapping between old and new */
 		newid = find_stem(data, buf, stem_len);
 		if (newid < 0) {
-			newid = store_stem(data, buf, stem_len);
+			newid = store_stem(data, buf, stem_len, true);
 			if (newid < 0) {
 				rc = newid;
 				goto out;
 			}
-			data->stem_arr[newid].from_mmap = 1;
 		}
 		stem_map[i] = newid;
 	}
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index baed3341..66e5721f 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -62,7 +62,7 @@ struct spec {
 struct stem {
 	char *buf;
 	int len;
-	char from_mmap;
+	bool from_mmap;
 };
 
 /* Where we map the file in during selabel_open() */
@@ -276,7 +276,8 @@ static inline int find_stem(struct saved_data *data, const char *buf,
 }
 
 /* returns the index of the new stored object */
-static inline int store_stem(struct saved_data *data, char *buf, int stem_len)
+static inline int store_stem(struct saved_data *data, char *buf, int stem_len,
+			     bool from_mmap)
 {
 	int num = data->num_stems;
 
@@ -286,7 +287,8 @@ static inline int store_stem(struct saved_data *data, char *buf, int stem_len)
 		tmp_arr = realloc(data->stem_arr,
 				  sizeof(*tmp_arr) * alloc_stems);
 		if (!tmp_arr) {
-			free(buf);
+			if (!from_mmap)
+				free(buf);
 			return -1;
 		}
 		data->alloc_stems = alloc_stems;
@@ -294,7 +296,7 @@ static inline int store_stem(struct saved_data *data, char *buf, int stem_len)
 	}
 	data->stem_arr[num].len = stem_len;
 	data->stem_arr[num].buf = buf;
-	data->stem_arr[num].from_mmap = 0;
+	data->stem_arr[num].from_mmap = from_mmap;
 	data->num_stems++;
 
 	return num;
@@ -321,7 +323,7 @@ static inline int find_stem_from_spec(struct saved_data *data, const char *buf)
 	if (!stem)
 		return -1;
 
-	return store_stem(data, stem, stem_len);
+	return store_stem(data, stem, stem_len, false);
 }
 
 /* This will always check for buffer over-runs and either read the next entry
-- 
2.31.1

