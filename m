Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BAAC43334
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 17:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiFHRWG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiFHRV4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 13:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67990476465
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654708197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=25JTg/nosGe2gqOZaDilJWQ+SF+g6VnDW83fvdKgXeQ=;
        b=C+t9ebF9jNWwXWEsiADcIfGyO/NBXASLYNv3AdYCaKsFPI33ZPpIKW+toja9m/0BDL6t7h
        YaxeDjuKXi5nNotVGhEihMuYs2NQrlRn/8Iej0Lzh6Qfi3Vb8qVy3HX8dUj8yPY+pqXQbd
        xHg6PjU/ZMWTg1jqoWxQS2YzwuX3U4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-w9XIpyrDM2m7fxrg1VSsMQ-1; Wed, 08 Jun 2022 13:09:56 -0400
X-MC-Unique: w9XIpyrDM2m7fxrg1VSsMQ-1
Received: by mail-wm1-f72.google.com with SMTP id k5-20020a05600c1c8500b003974c5d636dso10142428wms.1
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 10:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25JTg/nosGe2gqOZaDilJWQ+SF+g6VnDW83fvdKgXeQ=;
        b=Vv7I+xv7RkkOV585saBcwQO1X7GYcqNe4kBB3VaEZX/0i8Wlr1gNgiDQza11Dzzq4m
         Lt+CHwcRrGgHbZ+5sMA+BhtspF1DHqk5beoB+9KgtKyXlftNQgcQWtJGesB0+5x8Vjn4
         yfCbHxaIqD3BSdBlEOt8LlwrfcyWcVnuiduebRwXLoAWhbJtFYoRgA9ZbUblG47ghG/H
         y9n5Qs6o8ukoJh4bj5E8rRN0LUDYdBUa0MtNs45GYUFFxfF3TgTDwO+0QKwWpq6MwlaY
         wvr/g0bn0f8GLwyZR4p6l1xT1E4W8TIaeMiuOiZcuhpyG4Otiwl/7kkjT10GzOCtbAi/
         pi2Q==
X-Gm-Message-State: AOAM531WrnTB4a5QLkuQgbhc8Bh4S6c9ACx/yNU242EvPfJW3LHdS7KU
        lvjmj/ZCg1sUYbue7YSBCu0oVxyJ3MdQEvDZWcTxsDN65aNVZ0hRpWlK8ASyiYZjPKL+0rvdYYS
        8J/w6/ocGcY/kpbTyJ55yqSoOaSK9t3jh5qE+iHITK3fWa43kI3GzQkmie8ljgdZvD0UeYw==
X-Received: by 2002:a5d:5c07:0:b0:218:544d:4347 with SMTP id cc7-20020a5d5c07000000b00218544d4347mr8174586wrb.107.1654708194906;
        Wed, 08 Jun 2022 10:09:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM6QExF485LVWbEo5415V+BR390+BQF2nayJ9M9JJ9XJzjCLjufEQGxvtlDzU+nPHkU3w/vQ==
X-Received: by 2002:a5d:5c07:0:b0:218:544d:4347 with SMTP id cc7-20020a5d5c07000000b00218544d4347mr8174570wrb.107.1654708194602;
        Wed, 08 Jun 2022 10:09:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id m2-20020adfe942000000b0020fcaba73bcsm22176194wrn.104.2022.06.08.10.09.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 10:09:53 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 0/2] Refine semantics of libsemanage's check_ext_changes
Date:   Wed,  8 Jun 2022 19:09:52 +0200
Message-Id: <20220608170954.114668-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it always do the "do_write_kernel" step so that the semantic is
essentially "--build but with the module content checksum optimization",
as otherwise the final policy doesn't get updated when there are no
changes in modules, but other customizations are applied.

Since the name --rebuild-if-modules-changed no longer matches the
semantics, also change that to just --refresh, which fits better.

Also update man pages and code comments.

Ondrej Mosnacek (2):
  libsemanage: always write kernel policy when check_ext_changes is
    specified
  semodule: rename --rebuild-if-modules-changed to --refresh

 libsemanage/include/semanage/handle.h |  2 +-
 libsemanage/src/direct_api.c          |  8 +++++---
 policycoreutils/semodule/semodule.8   | 12 ++++++------
 policycoreutils/semodule/semodule.c   | 13 ++++++++++---
 4 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.36.1

