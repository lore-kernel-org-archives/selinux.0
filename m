Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03A5CCA479
	for <selinux@archiver.kernel.org>; Tue, 28 Jun 2022 10:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbiF1KCn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbiF1KCR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jun 2022 06:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A0B72F3A8
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656410507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nh2SFajP8MBBhUcc6X52pNjEEek+u0YDiGxENyNkEc=;
        b=RPDhg5K5QRK5SC0A6kYewLhw40lWulvICHZR+e5+3vVjbqajkIulNDZpnr2757ZAwONkRh
        lPZ/BDO1Xw0RtIioSuGKi2D/ZngvDLGKx4UsePjJI8NwBTkgW+kgYxZqhxonEgDPDweAA+
        jyQm3Jwtq4v3QuOqRUyStQpoX5rpGPE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-_w6WxgeaOv6vrOAf8R02Wg-1; Tue, 28 Jun 2022 06:01:45 -0400
X-MC-Unique: _w6WxgeaOv6vrOAf8R02Wg-1
Received: by mail-ej1-f69.google.com with SMTP id go10-20020a1709070d8a00b00722e8ee15b4so3445047ejc.22
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 03:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6nh2SFajP8MBBhUcc6X52pNjEEek+u0YDiGxENyNkEc=;
        b=gTnVzw7tJFY2UC6yx1ODh6TE8OkQl89BgQ0qwWXMtHaZA0Q/NTsAnyBxjzXAPZ370+
         y0i6hkM/7OF0DGf3U5wXEGuYcTr+HZQrwFRa0HDbb0sXbBox9cJij3whiMYqrz4DhQkw
         ChOtm4OMvgZH49PJoa0jQFJEgQeEekgj3T2nacMHIGcANB2ff/WSr8viRxx3SeJBjZ34
         vrXN89Wrs176CN9BnB1qPohamkE5Oz41UEihyRHUOiFWtQgvGvROvfvuFB0IS+b25met
         vzSC0rFXhMWWDBVUbyC2clHjUEiaGa94cHopIf+lFDvNnoZwEPLKwOUNdjcF4YXX/5fp
         oOBg==
X-Gm-Message-State: AJIora9y8as2lrziyxcdBD75szohmVu5/ZI8ADqYYAYieDwaJ1VjEByP
        f8cul/4BcRd5RDOhc2l4frWehNgi0Q7kCwO/XnDa7cQxyumRNqSGcPTCDs+VUnwD7KiYnnvFy4D
        2SlVN6cJAEAPNYMKEh75sIUuiA2zjm5qMBgfN9MwVcQ99ryC12ZSmklQWpnk0xuSFun64gw==
X-Received: by 2002:a17:907:3a11:b0:726:4573:1b6 with SMTP id fb17-20020a1709073a1100b00726457301b6mr15937057ejc.672.1656410504162;
        Tue, 28 Jun 2022 03:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vox0RNL89YEh65rdfINsSs1PO1+lFteqjHGhHAjiD0OIIcOjc4aHmUjus2VqFEM1JDQ+N5BA==
X-Received: by 2002:a17:907:3a11:b0:726:4573:1b6 with SMTP id fb17-20020a1709073a1100b00726457301b6mr15937035ejc.672.1656410503912;
        Tue, 28 Jun 2022 03:01:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7dc4a000000b0043567edac3csm9243873edu.61.2022.06.28.03.01.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:01:43 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/2] tests/keys: fix Makefile dependencies
Date:   Tue, 28 Jun 2022 12:01:38 +0200
Message-Id: <20220628100138.297047-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628100138.297047-1-omosnace@redhat.com>
References: <20220628100138.297047-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The tools need to be rebuild when the common header file changes.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/keys/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/keys/Makefile b/tests/keys/Makefile
index d3793db..d9f36ff 100644
--- a/tests/keys/Makefile
+++ b/tests/keys/Makefile
@@ -1,6 +1,8 @@
 TARGETS = keyctl keyctl_relabel keyring_service request_keys
 LDLIBS += -lselinux -lkeyutils
 
+$(TARGETS): keys_common.h
+
 all: $(TARGETS)
 
 clean:
-- 
2.36.1

