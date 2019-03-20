Return-Path: <SRS0=9nrh=RX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7421DC43381
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 22:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E13220830
	for <selinux@archiver.kernel.org>; Wed, 20 Mar 2019 22:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="mSpljsz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfCTWgB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:36:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39214 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfCTWgA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Mar 2019 18:36:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so2819454pgp.6
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2019 15:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Fl/xNSWTIJeMsmOtW6Tu5PeoqpdSpGPlZf7MP2fGJQ=;
        b=mSpljsz8UoqV1EPK9xZRHsn1xqd3trxsG628iroARf1poXY2+QXPR6/GUX3qpAlviB
         yuKqPaYESLsC8++rDnh0IIFNwLG2lBI2PgtFsNhOZKEqEiDuhw6ZspVOYZmkinPLnmjL
         E/UoeqvfN22ndl0rD9ejl16g83liDJUJldbDOHGN9pSEP5les5BU0bavMPQLYBsxCdbh
         KtcIhfY2QNZTtJEibl/NDikVtwuPe3t+tQQBqaOVuzf9uZsT6yMS/8uq0BLwc4LY5sTV
         iYtkU1fPVN3AlBF5lDSXDvl+Q2VLbjUz2qunmxcjAZeTe6IbXA3wAFBvUenc88a3bIdG
         cVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Fl/xNSWTIJeMsmOtW6Tu5PeoqpdSpGPlZf7MP2fGJQ=;
        b=mQkdfLwfMutb4mN2GKEouVsWq8uHtodebs14Oc/S6/UdlH8+hTC36QG3jzJL7npwpx
         ZA8QQZdSCoi2LrHLsHMXbbDx93A8zaokBzLvUpAzcjcEXZgGVpUL7dTpAqaCvyYGELZI
         jDL5ZGhjTOFXyvNwWFvP3Z3MJBb9LHi1iUCY372Bldqs/HH4fHlsAktE3gnI9Pmph2at
         86sH2MqSb5zdUcibb5gu7ugF0zH2kEWvcK7hlmNvo7QdA/yOyRDNeApiYP/ziWjtEAvm
         DOYu/nL6t7KHGUTpTxJbgNtDJbR6q2GHJwXldUkAI8F2gvP0eht9NrGtwDjlfD5YrKyY
         hsrg==
X-Gm-Message-State: APjAAAVL/bPOA2AhMdMfshjl+HKGHO2BRDq8f+GMsfzh8GBvdpxKrQR4
        xxaAVPaZXfveayxg4zOYjuoZgw==
X-Google-Smtp-Source: APXvYqwvK4BlyGrA2CYHolF2TbuA0YjC6SdM0/jTRkLoJR/hEB7ABt94dSBmy8Wze33MImYMkZKXUg==
X-Received: by 2002:a63:4962:: with SMTP id y34mr329558pgk.425.1553121360139;
        Wed, 20 Mar 2019 15:36:00 -0700 (PDT)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id j8sm3675025pff.183.2019.03.20.15.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 15:35:59 -0700 (PDT)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        paul@paul-moore.com, selinux@vger.kernel.org
Subject: [PATCH] binder: fix BUG_ON found by selinux-testsuite
Date:   Wed, 20 Mar 2019 15:35:45 -0700
Message-Id: <20190320223545.35785-1-tkjos@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The selinux-testsuite found an issue resulting in a BUG_ON()
where a conditional relied on a size_t going negative when
checking the validity of a buffer offset.

Fixes: 7a67a39320df ("binder: add function to copy binder object from buffer")
Reported-by: Paul Moore <paul@paul-moore.com>
Tested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
Please add to 5.1 (fixes problem introduced in 5.1-rc1)

 drivers/android/binder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8685882da64cd..4b9c7ca492e6d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2057,7 +2057,8 @@ static size_t binder_get_object(struct binder_proc *proc,
 	size_t object_size = 0;
 
 	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-	if (read_size < sizeof(*hdr) || !IS_ALIGNED(offset, sizeof(u32)))
+	if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
+	    !IS_ALIGNED(offset, sizeof(u32)))
 		return 0;
 	binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
 				      offset, read_size);
-- 
2.21.0.225.g810b269d1ac-goog

