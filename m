Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C989C43334
	for <selinux@archiver.kernel.org>; Thu,  2 Jun 2022 14:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiFBOxT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiFBOxT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jun 2022 10:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53EEB22075F
        for <selinux@vger.kernel.org>; Thu,  2 Jun 2022 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654181597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IOP1rbPaimwp+c3pjP1YVst9GLx/iXFu4wAAxv7TX6Q=;
        b=FPg9qVKtnwaScknI7y6cCkcPh6iXlsrKG9JeIWWE51e3Yw6GukKXEAfIB3Jy7GlWhXXhuG
        9JWb3qku7R7Gi+3/sDhIV4s3NLJBbJClo9n+9GBrigKyJHW/L8GBkCF953SE/qH4Lo+NiP
        1EdfFZINN85Js/UonahFdyCEh02F4jg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-cKH8iDHSMiqCaDJx-54hig-1; Thu, 02 Jun 2022 10:53:16 -0400
X-MC-Unique: cKH8iDHSMiqCaDJx-54hig-1
Received: by mail-wr1-f69.google.com with SMTP id n3-20020a5d5983000000b0021021e3036eso783348wri.19
        for <selinux@vger.kernel.org>; Thu, 02 Jun 2022 07:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOP1rbPaimwp+c3pjP1YVst9GLx/iXFu4wAAxv7TX6Q=;
        b=prXWSsehKFM2qmSiL6o31Ylaa0efSxjlFiKS6hxmiDQzvB8tDa0fitQ/Eh35EZ66m6
         yVfGbkZxnd102TxQqmYttCyGn9amaOV0PjeH4S6BGyKOaKcT6EW783kAs1XSszt+mNLe
         GFtbVAL7ovWRXHWsIloMpIYSKAIReIq3GQPdu3/SV/Dba8oYxiz7v4yi5L3ekrXbf/Gi
         YH+N55zwfbCXQvistZns9YiG5CsvVJy3E/QKk5TKk4SuVn4FFvn9XO8nMVOG8XO/55S5
         NQvsmuymr1/r/cwxP4RoZP/KLEpgOw5LFUozeKYzMnMxRSZrMpR5YF3jqKViwl+w+ZXT
         vpeA==
X-Gm-Message-State: AOAM532XnwqcBHlELboRM5JsiYO6f+1mJh1bFqiQt+S5keGIkjsVaUQK
        wwmsg9WcxkzubeJBiIDBGRVAKZSQhV02Mnl9hl1re7VfmbSm2qnusr4ccppcWNHTErj5KrkOAz5
        Uv81H55+LGgC4vUWsC0rtn6x8ufu325XHKOnGkNuF/OZhgzHiG5738crqTTZmh4DHDAC6qQ==
X-Received: by 2002:a5d:5847:0:b0:20f:dc2d:d6c8 with SMTP id i7-20020a5d5847000000b0020fdc2dd6c8mr3949931wrf.644.1654181594262;
        Thu, 02 Jun 2022 07:53:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv3kP9BNo6591Gk62uUJs18o9Vk+XPvO6jxMZf9A9V7qyxsfNuVT+JHd4jTWJrfROk9MK1BQ==
X-Received: by 2002:a5d:5847:0:b0:20f:dc2d:d6c8 with SMTP id i7-20020a5d5847000000b0020fdc2dd6c8mr3949914wrf.644.1654181594030;
        Thu, 02 Jun 2022 07:53:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id w25-20020a1cf619000000b003976fbfbf00sm5533575wmc.30.2022.06.02.07.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:53:13 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH testsuite] tests/sctp: temporarily disable ASCONF tests
Date:   Thu,  2 Jun 2022 16:53:12 +0200
Message-Id: <20220602145312.888125-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The implementation is buggy and can't be reliably tested right now, so
disable the tests until the kernel is fixed and tests updated.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/sctp/test | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/sctp/test b/tests/sctp/test
index 7e84ab0..e28d214 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -57,8 +57,11 @@ BEGIN {
         }
 
         if ( $ipaddress[1] ne 0 and $ipaddress[0] ne $ipaddress[1] ) {
-            $test_count += 3;
-            $test_asconf = 1;
+
+# Disable ASCONF tests for now due to a known issue:
+# https://lore.kernel.org/selinux/CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com/T/
+#$test_count += 3;
+#$test_asconf = 1;
         }
 
         # SCTP client peeloff has been fixed in kernel 5.18+
-- 
2.36.1

