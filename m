Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC5BC32796
	for <selinux@archiver.kernel.org>; Wed, 24 Aug 2022 11:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbiHXLTp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Aug 2022 07:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiHXLTp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Aug 2022 07:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318DD22C
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661339983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YkqXuTwMh4ziz9oalU7wvCwOmLrUSKIGKcf/Uc478xk=;
        b=by2I8gNGpijHkVPNWFx6uZwVB8OK1uDuiKlngT7mLnA5rWi7NTYR84ujdnEBFZb5ER62JB
        JyZq1znAHr/GkMbnyvRXc7ojVSV22PEr11uaQj2WzsCH4ETp5VIo/wjztJcYB/Wjw1/k97
        fDNdFezM4Zc8ODNsNMAH2ABwcHpwtxg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-lAyMh1JqMLmre0SuQKrc_Q-1; Wed, 24 Aug 2022 07:19:41 -0400
X-MC-Unique: lAyMh1JqMLmre0SuQKrc_Q-1
Received: by mail-ej1-f70.google.com with SMTP id hq37-20020a1709073f2500b0073d8e17f434so2736408ejc.2
        for <selinux@vger.kernel.org>; Wed, 24 Aug 2022 04:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=YkqXuTwMh4ziz9oalU7wvCwOmLrUSKIGKcf/Uc478xk=;
        b=4EO7Gr1z9H89wgsy07dTfR/LCdc+Lr5MGbMeuYKKIjC12oWH2RKg1d9s8PLnvaU+SH
         3bp9GYE5JUNJoKeTf4jbKzbbAsQeqfeROmwnxzRX9R1T/lTVdzaO/vxkjogOPzmxmZhZ
         3wqb6BAYq3kPpbx2zf9o0wwlCJsu87Rh4Jrb60etSNrhZZMlrDZvqeAfv5bOSO0CQNvV
         LQ99AsD87NnUoPvtsIraoxf7KZ95ImCbc5TFAMKJkHbZk4FdGb5a1pqser3nX1knRf2Y
         THus9aQsMmJve9muZJsP5dbSIgVxa3KjE1Zo+wlS3pfS2A2aesIu3K/DrhrZ9dg1X8Dl
         gWuQ==
X-Gm-Message-State: ACgBeo3xgHeVFthAN3jVX5uf5u2dv7SC77NXb1qacsmuGlxj3Wt/iJya
        prZuxx6v0osgevBoLT9eRfhPJ5zm3fkKtg+C4smky74y+HR0oKSY5DWm6FcBnz7zXLLSvfa+fV3
        oJYgtrrqxTwd9vqPX9WObuWKEjXj4r7zUcniVnXKm4eo/Ss5huwEu+PQ8+GB/j7SA0RZ/nA==
X-Received: by 2002:a05:6402:34ca:b0:446:d718:58be with SMTP id w10-20020a05640234ca00b00446d71858bemr7105275edc.40.1661339980714;
        Wed, 24 Aug 2022 04:19:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR41f+M5Tf3OxKyf6B/Xrm6P03n51GfWdJhxuE6pfgzqscsvPMN+goNBeu5/b7ciYGaEklrJRQ==
X-Received: by 2002:a05:6402:34ca:b0:446:d718:58be with SMTP id w10-20020a05640234ca00b00446d71858bemr7105261edc.40.1661339980499;
        Wed, 24 Aug 2022 04:19:40 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090665c600b0073d6d1990e2sm1016047ejn.140.2022.08.24.04.19.39
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 04:19:39 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/2] Prepare userfaultfd policy for Fedora policy changes
Date:   Wed, 24 Aug 2022 13:19:36 +0200
Message-Id: <20220824111938.567993-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

See the description of the second patch for explanation. While there,
the first patch cleans up the userfaultfd policy to be in just one
file, since the CIL workaround is no longer needed.

Ondrej Mosnacek (2):
  policy: remove CIL workarounds for missing anon_inode class
  test_userfaultfd.te: adapt to upcoming Fedora policy changes

 policy/Makefile                  | 15 +++----
 policy/test_anon_inode_class.cil |  4 --
 policy/test_userfaultfd.cil      | 47 --------------------
 policy/test_userfaultfd.te       | 74 +++++++++++++++++++++++++-------
 4 files changed, 65 insertions(+), 75 deletions(-)
 delete mode 100644 policy/test_anon_inode_class.cil
 delete mode 100644 policy/test_userfaultfd.cil

-- 
2.37.2

