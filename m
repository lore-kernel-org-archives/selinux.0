Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB43C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8E6610A7
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhEJLWU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhEJLGH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 07:06:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC99C061760
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:56:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so23760114ejo.13
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Vuq1hJW/CgCs2Iyd3GifxWbjxDnT2DYZYPgLqiUFbi4=;
        b=CcQPO1bHyBbD1kql0tfSUy01N8/OKKaPOIa5fWj89sMuTud5Yxb7FV2JmeAHwtLNAl
         OBIq94qQX6ZXxUfxsHQlovpcfzAvdESsv698lAhplV0k7nhw8OISmNdmEzP4dXyfCymR
         jz8u+J6HNZaeBDJ71pc6sAaW7EEsYcSPtG4An+9HvGZwGkIugtS0B9DMBBIebb47OfLM
         TiILmLf92vw0H7RAdGmMbjaoisw7XYCq1IsJYE2gvjkdxxy4IDiONrSAF9Rds8707DKe
         wULT5d9Hb45LTC0sAj6E8JJ2V/OuLIe3O6cgdyPIBgHSIJIhC0AhxBwlhgykG7TIYhDC
         SF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vuq1hJW/CgCs2Iyd3GifxWbjxDnT2DYZYPgLqiUFbi4=;
        b=VoSFendQNVJoFTr9NtsEt/bMkSVV6zkoFIIFaS1/xhgL+CSbdm9AaOmFa1qCak+4Yn
         +n45GZL20KlxIOYm2MMfwWvU1AmEQH5D4h3rtaP61h3lRNxe0DYNMMmUIJG4t1rKo9Wm
         9dfZ5vcLf3aDwP3B0E44nykBOIFH2KuNo6X0J0ktWdm0aUCM4+MYDuyh4YJPUcT/9LTg
         rkba54Q4WoZdYV23BztzTee8EgJ+dqLT/q4FyvM7COydINiFICl330+bsQGjcL0malYv
         Xp0H2ss4LOWfPmdngjqf7CWUnHrvF97EbDbN1EUp9JZaC2/c4Pb6WWDJyDQRlQ6FdPN/
         F91w==
X-Gm-Message-State: AOAM531YiC5ZUXV+3a/xjHlJTzEAsyrkEsgSSkRcXbBR7u2losE9tqE2
        yFXBBlsJ6djS0+wxlAJHw8Y99K0ZWzpuZCaa
X-Google-Smtp-Source: ABdhPJw2XMJl01BOUMffbp8CPMimUYJZssKDIm/G9DC37g35hpCYYgYZulmupr73JCNAwttm42Fuxw==
X-Received: by 2002:a17:907:294f:: with SMTP id et15mr25506762ejc.324.1620644210494;
        Mon, 10 May 2021 03:56:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-162-005.77.3.pool.telefonica.de. [77.3.162.5])
        by smtp.gmail.com with ESMTPSA id z17sm8884162eju.65.2021.05.10.03.56.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:56:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libselinux: avc_destroy(3) closes status page
Date:   Mon, 10 May 2021 12:56:46 +0200
Message-Id: <20210510105648.14635-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510105648.14635-1-cgzones@googlemail.com>
References: <20210510105648.14635-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Mention in the manpage of avc_destroy(3) that it does close the SELinux
status page, which might have been opened manually by the client
application.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/avc_open.3 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/man/man3/avc_open.3 b/libselinux/man/man3/avc_open.3
index 3090dd50..55683bb6 100644
--- a/libselinux/man/man3/avc_open.3
+++ b/libselinux/man/man3/avc_open.3
@@ -26,6 +26,9 @@ initializes the userspace AVC and must be called before any other AVC operation
 destroys the userspace AVC, freeing all internal memory structures.  After this call has been made, 
 .BR avc_open ()
 must be called again before any AVC operations can be performed.
+.BR avc_destroy ()
+also closes the SELinux status page, which might have been opened manually by
+.BR selinux_status_open (3).
 
 .BR avc_reset ()
 flushes the userspace AVC, causing it to forget any cached access decisions.  The userspace AVC normally calls this function automatically when needed, see
-- 
2.31.1

