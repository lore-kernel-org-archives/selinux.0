Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08BCC35280
	for <selinux@archiver.kernel.org>; Tue,  5 Apr 2022 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbiDEVmC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389250AbiDEPVM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Apr 2022 11:21:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A1D0803
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 06:35:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id p15so26731858ejc.7
        for <selinux@vger.kernel.org>; Tue, 05 Apr 2022 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=i0cgS0FbDn4/xdmDmKmJ0vA5phS4qMhOq2NbGUueCr4=;
        b=D9ed6hNK2iqjmgh9IrWaR+TyximOwAyOkyChKStIzZ/A3sZk8y1GbPXcPB0NHB0tim
         LTdDH5oAgcyyMuyW5buVf0rziioHiCOjgC1IegSmIIaCjEh65EluAGHg8gz58RhWxHvT
         eBSyx70NyQkPUIxOMATosaA16hZiFA3WlOiwfvEqoXCe7e9Gx+PX0rqOTNqU77TxAney
         U9DtJ2yQitBtiAJADEN/vaXcfSld+lY3T15rHEeXdT0gYNwwTveKfbyOBfHl629gX4+M
         k+n7Cc/5dNXznOfZOnjWEkdVdtHVtkJ3X6pJYXyZAFga2NBsAH/KlRwiZ6cRU6kmKwxj
         so6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0cgS0FbDn4/xdmDmKmJ0vA5phS4qMhOq2NbGUueCr4=;
        b=OAvfp8YMJaVHd5saMF1LvMCGEIP5QvypalmaUvxq/oubTcP3vBc6LLk93hcsY+7F58
         wRwq+Z5r2lSI2IcBLdrJBrRvR6uDGvpvQJC2URGNTNYzjGImCBQVngqeSGQGTn+QE9ff
         kf0jmaGJf8BBtnyCqEIuLlzpoHcd8B+06D4FZn05S8QxRQq9svT7xCH/O/vSgwWdny7z
         bY+oyc7eP1lx6z/TKWTWEzo7WEKCU0Eu+rUPYQNCv8Y2YTeUKWsGDJd6p4ZzfGXB3Q3T
         OPSZZ76Nkxzn45lkgGom40FdKdisuQHEgqmbZEX2fUmkq3tm1/QMfWL7kmzgTbLJoJdi
         zyIw==
X-Gm-Message-State: AOAM532bqcJpltcvw8OS3knFD2vthLWO4xwL/ThjYKVxxwAyM/YOPyVC
        MA8JW4rs2EGSgc5UNYxEQ9xIG50K4EA=
X-Google-Smtp-Source: ABdhPJzP5gykhqlD4EdiuVhOlq8+ZVEDtShwLReu3wqpY2yb5IedanEOx5J81BdDcAaZb+fOwZqrZQ==
X-Received: by 2002:a17:907:6e89:b0:6df:d819:dc9c with SMTP id sh9-20020a1709076e8900b006dfd819dc9cmr3862970ejc.158.1649165757252;
        Tue, 05 Apr 2022 06:35:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-134-094.77.8.pool.telefonica.de. [77.8.134.94])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709060e1900b006e7fe06664esm1620627eji.106.2022.04.05.06.35.56
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:35:56 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 6/6] Enable missing prototypes
Date:   Tue,  5 Apr 2022 15:35:48 +0200
Message-Id: <20220405133548.51598-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405133548.51598-1-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check for missing prototypes like file local functions not declared
static or external functions not being declared to avoid declaration/
definition desynchronizations.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 215e313e..2ffba8e9 100644
--- a/Makefile
+++ b/Makefile
@@ -14,6 +14,7 @@ else
 		-Winit-self \
 		-Wmissing-format-attribute \
 		-Wmissing-noreturn \
+		-Wmissing-prototypes \
 		-Wnull-dereference \
 		-Wpointer-arith \
 		-Wshadow \
-- 
2.35.1

