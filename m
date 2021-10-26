Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006C1C433FE
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D866260F21
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhJZLzP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235575AbhJZLzN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXmnY9Cdiw1aeGYHZg+or1G7P90i3MhaNuxQBOdufaU=;
        b=SWE9gL74Q3D5XlhH0LKy6Zi/Do9kTrKondNjUNOcOVXVTo4Su65fuwTsH7T9ZkU7f7t4BF
        ifmN8xqGqxBSEbRa14fFu/XG3lbBuADyt25IKuGhC48Il/HaFx3s7Ig8MEK8sck1XZDyJF
        6aqINvbSxTVlJK5+5Z80m/00uISCScc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-ssgwTEIhNiqJNzgTsrsPQw-1; Tue, 26 Oct 2021 07:52:48 -0400
X-MC-Unique: ssgwTEIhNiqJNzgTsrsPQw-1
Received: by mail-ed1-f69.google.com with SMTP id u17-20020a50d511000000b003daa3828c13so12787870edi.12
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXmnY9Cdiw1aeGYHZg+or1G7P90i3MhaNuxQBOdufaU=;
        b=QeNulgLlruQBhjHog6ZGN1agKukWJNTDWA3I58fqkexkkzwPa+JXyYyItAXHPox+Ky
         U/BQopjcDhzw7tMP9ECdBYYkvcEw5Uk9lNf8fQ4zy+tk2Bd9/DhSuSnsMBf3GfDT+yfJ
         CFGW+4SDFI4GKDuatzVVO7O92vCX0GWdwxdksJ3KYXIlBIsuJ/ra56UUGpRUIYgAkBiN
         IicJvwaHaPxPtF/U8itH5AjAd/AjEykaRK3HL2eH1B4DHd6+OQAcUL79AUANwpQmEkZz
         wvPzWvubl+DGrDTtNypkb+okh7XwVTtREJQGgl+9Xa/Z1mrwzjolFcQ5VR9uLNxM/OsG
         qzjg==
X-Gm-Message-State: AOAM530eLjvWj3eAIRPoN9bWWPm464PThWhKuQ5DELYPpbgv5ufN/+fN
        BThtcwRkK/ecLgCr56BGayRSO0HdBKdpmNTcDBjI7OljXYJhcToexk50N9gYtVG1CnD3di9MhaU
        4gNiALjrGti0T18dm+lgAAOhCqtY+TsOn2J+N5uoV5WU19RF+5EqVdunLfzQzJ2CKWuDl2Q==
X-Received: by 2002:a05:6402:154b:: with SMTP id p11mr36425619edx.325.1635249167100;
        Tue, 26 Oct 2021 04:52:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwemKD47eFeCKbESL6r1Y0cgIROrfAAp5J1xRBjxIZFWqmriDvE1asB0+mj4QG2HAP/rsUoSQ==
X-Received: by 2002:a05:6402:154b:: with SMTP id p11mr36425589edx.325.1635249166857;
        Tue, 26 Oct 2021 04:52:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id v15sm10658105edi.89.2021.10.26.04.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:52:46 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH userspace v4 5/8] libselinux: make is_context_customizable() thread-safe
Date:   Tue, 26 Oct 2021 13:52:36 +0200
Message-Id: <20211026115239.267449-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026115239.267449-1-omosnace@redhat.com>
References: <20211026115239.267449-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the __selinux_once() macro to ensure that threads don't race to
initialize the list of customizable types.

Reported-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/is_customizable_type.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index 1b17860c..f83e1e83 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -9,7 +9,10 @@
 #include "selinux_internal.h"
 #include "context_internal.h"
 
-static int get_customizable_type_list(char *** retlist)
+static char **customizable_list = NULL;
+static pthread_once_t customizable_once = PTHREAD_ONCE_INIT;
+
+static void customizable_init(void)
 {
 	FILE *fp;
 	char *buf;
@@ -18,12 +21,12 @@ static int get_customizable_type_list(char *** retlist)
 
 	fp = fopen(selinux_customizable_types_path(), "re");
 	if (!fp)
-		return -1;
+		return;
 
 	buf = malloc(selinux_page_size);
 	if (!buf) {
 		fclose(fp);
-		return -1;
+		return;
 	}
 	while (fgets_unlocked(buf, selinux_page_size, fp) && ctr < UINT_MAX) {
 		ctr++;
@@ -54,23 +57,19 @@ static int get_customizable_type_list(char *** retlist)
 	fclose(fp);
 	free(buf);
 	if (!list)
-		return -1;
-	*retlist = list;
-	return 0;
+		return;
+	customizable_list = list;
 }
 
-static char **customizable_list = NULL;
-
 int is_context_customizable(const char * scontext)
 {
 	int i;
 	const char *type;
 	context_t c;
 
-	if (!customizable_list) {
-		if (get_customizable_type_list(&customizable_list) != 0)
-			return -1;
-	}
+	__selinux_once(customizable_once, customizable_init);
+	if (!customizable_list)
+		return -1;
 
 	c = context_new(scontext);
 	if (!c)
-- 
2.31.1

