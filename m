Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FAC433F5
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CFA60F44
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbhI1Psr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1Psq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:48:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07BCC06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y35so33884280ede.3
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gm5KFpAo0Qlw5HKXLvQfzh0SG1kzoZzUw+QJtG6jHuk=;
        b=YKaXbIhC/J85BGczlZdW9ODqSedWl1HkKVqtO3CjRL/euv8URSz63hSzxbx12zCbg4
         IMsBYHXe9E/PSBOLdq9N/wYlVIjlGqFlMO6heZFUjsD4UNOhU5bC/AwFKnCYW568x77N
         pl57RAurZub73Jh8JO6rka5D1ALpQjh4kCJIXM0up1IpkDmkQERFervf9jFU46wJA5jN
         +FphCrxAWRL/yamwZII7qUWMtF6fhcCwUjuonHuboaJe2aUqv1DC5Q3XmH48LdKt6q4Q
         SQBxdsXrKUn5mgUllr/ITJv6tZuJG5B3O2JW5iXT2ODw0PlWQspGWlo+H1ySn4ygpEUD
         x4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gm5KFpAo0Qlw5HKXLvQfzh0SG1kzoZzUw+QJtG6jHuk=;
        b=EqTjL8jCNm+8li7w6m05UYFR9BzpQkO7yz5iayagnfc1bVkPd/E42EbmD6bMaRyUCf
         GowAywA+ZznCU8sf+V89kvLNg0YKtNBS1yprC343pH/EE5a1gxXAMXk79jLf6Mip8TqY
         RucCE8TPXSDzVn/9N1yavBKMLFmZ5WARyXHywVm5K78qw+kRJEFLeVD5VoRkWfOESg3T
         d5fwjl500vF0O6753m71GRutaP9Xv5ez1+y7blXHUE/sXziOuiuCA5qzRIvZIDBt4Q0A
         eSM/xmwoKhB43/6C98zF40b6KhYK2Ga8HawBO4KkWlgh/Hvz1YlRJoiaGS/16fw6Hocf
         Irxw==
X-Gm-Message-State: AOAM530thFL9ooUdfxsBLgV+F4mMKMRhTxl/iXjjo6k3pOjxtLv6Bi21
        NFF5WyrJOJTIL7T9DT4l97Wdt00xoh4=
X-Google-Smtp-Source: ABdhPJxh8a6zrmLAqQ5qoiMo6wHKzAVAGfKzIwHk74AWJeBA8qjEXfDnzfV4u47AbNadYJhNelqzBA==
X-Received: by 2002:a17:906:8152:: with SMTP id z18mr7616867ejw.153.1632843983954;
        Tue, 28 Sep 2021 08:46:23 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.23
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:23 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/9] libsepol: use correct cast
Date:   Tue, 28 Sep 2021 17:46:13 +0200
Message-Id: <20210928154620.11181-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
References: <20210928154620.11181-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function hashtab_insert takes the type hashtab_datum_t (alias void*)
as third argument. Do not cast to hashtab_datum_t* alias void**. The
casts could be dropped, as explicit casting to void* is unnecessary, but
to fit the overall style of this file keep the casts.

    expand.c:246:41: error: cast from 'perm_datum_t *' (aka 'struct perm_datum *') to 'hashtab_datum_t *' (aka 'void **') increases required alignment from 4 to 8 [-Werror,-Wcast-align]
            ret = hashtab_insert(s->table, new_id, (hashtab_datum_t *) new_perm);
                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/expand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index aac5b35f..a6a466f7 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -243,7 +243,7 @@ static int perm_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	new_perm->s.value = perm->s.value;
 	s->nprim++;
 
-	ret = hashtab_insert(s->table, new_id, (hashtab_datum_t *) new_perm);
+	ret = hashtab_insert(s->table, new_id, (hashtab_datum_t) new_perm);
 	if (ret) {
 		free(new_id);
 		free(new_perm);
@@ -294,7 +294,7 @@ static int common_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 
 	ret =
 	    hashtab_insert(state->out->p_commons.table, new_id,
-			   (hashtab_datum_t *) new_common);
+			   (hashtab_datum_t) new_common);
 	if (ret) {
 		ERR(state->handle, "hashtab overflow");
 		free(new_common);
@@ -492,7 +492,7 @@ static int class_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 
 	ret =
 	    hashtab_insert(state->out->p_classes.table, new_id,
-			   (hashtab_datum_t *) new_class);
+			   (hashtab_datum_t) new_class);
 	if (ret) {
 		ERR(state->handle, "hashtab overflow");
 		free(new_class);
-- 
2.33.0

