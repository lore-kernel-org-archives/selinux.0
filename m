Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699DACCA480
	for <selinux@archiver.kernel.org>; Tue, 28 Jun 2022 10:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344161AbiF1KCn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiF1KCR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jun 2022 06:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 066672E9E9
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656410505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dkd7HB4hJtSJXVlgSe2DlvFGS/OohLPF5PUjBFKT4e0=;
        b=H+4x6W1hRvAQXmGNqGnKxxVgMUAsbOY24FWerQMFdrgI3fcPua+KNyYjbBOmveSbnhWvSw
        5/8wDfArHIW0uZ8/EQ/ddDJz1gJZmEU0mozA7ownnhRsmj4bf9MTiHnQqdoGYJH9vyJeNZ
        cinL2bQFINbrbGLTXjVyl6rePZ5ALLs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-bdYtpMEPN_ykmoCiu0M-qA-1; Tue, 28 Jun 2022 06:01:43 -0400
X-MC-Unique: bdYtpMEPN_ykmoCiu0M-qA-1
Received: by mail-ej1-f70.google.com with SMTP id sg40-20020a170907a42800b00722faf0aacbso3420558ejc.3
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 03:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkd7HB4hJtSJXVlgSe2DlvFGS/OohLPF5PUjBFKT4e0=;
        b=DdKCIL1Il3RfKgyKtb2DD9j2nCLTHXWID1/WqqS9y+hhSf2pED2wnUKT1QuYw3mAeN
         m8UXLeGUo6SATfRA+zoEdFFD6qgVcl7jt3TQbx8WG7hrHq9WyToZyGfQ6aktjNmMudkV
         tL6/cJy+QF7eJGkA5kwymNI0xKyPWQyMKw7BjTxjCSJUGMP5vOawV6kj3O/pL2H2fDRZ
         eAd7RKpGgjA3RIJ8Jhju65qJ+0rhNcuHRGOpYdUdNHrxxVKvL+lu6mh+BgDKxaYmHSj1
         Ay4vDSOuDuC68Ya4/PTHhn2Hxb75vEhLAyEUJzPkPd97FXdS8QYLRd0dmebtdj7jdVaz
         8eWQ==
X-Gm-Message-State: AJIora+3DDHGAZ0KN3Q5+ttCExPb8PcLkmN2gCgoslc9QNM6RoEY2kt0
        +2BuJM78u5K4G6jAKow+/bnthx0vEUlNp/Q6ys2H+GMKSbk88B/nfwZorlcOmEMQpnj3GDqBG1A
        vQ1JRrQRhY74XmMPK8sQ6Qgy14RwmDMja2zbQzXGMmGjk0XQdr+C9QSit/PvEQfgge1/yAw==
X-Received: by 2002:a17:907:e93:b0:722:e082:2787 with SMTP id ho19-20020a1709070e9300b00722e0822787mr17678692ejc.618.1656410501973;
        Tue, 28 Jun 2022 03:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1veh+Ga7bPD7EsrwpPHHZfB21sJ75lEJa/AeW7pz5zqEZb15LReXaxEkfZZA1nEJcLQbmAdiw==
X-Received: by 2002:a17:907:e93:b0:722:e082:2787 with SMTP id ho19-20020a1709070e9300b00722e0822787mr17678679ejc.618.1656410501717;
        Tue, 28 Jun 2022 03:01:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7dc4a000000b0043567edac3csm9243873edu.61.2022.06.28.03.01.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:01:41 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/2] Make the keys test pass in FIPS mode
Date:   Tue, 28 Jun 2022 12:01:36 +0200
Message-Id: <20220628100138.297047-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

...and also fix Makefile deps for this subtest while there.

Ondrej Mosnacek (2):
  tests/keys: use a longer prime in DH params
  tests/keys: fix Makefile dependencies

 tests/keys/Makefile      |  2 ++
 tests/keys/keys_common.h | 48 ++++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.36.1

