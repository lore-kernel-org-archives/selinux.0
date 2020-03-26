Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335E1C43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2562076A
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 15:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgwNMI1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgCZPqv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:46:51 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:34139 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCZPqv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 11:46:51 -0400
Received: by mail-pl1-f170.google.com with SMTP id a23so2292824plm.1
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H20FyjJxhPkJkHC+Fs6tfpfKAaqzp0thZS/saM45AiI=;
        b=CgwNMI1yRTEoqL+ApQ9seRfKTtoXXrB7zuYylALa5YiHN8HLxxku6QReh7zedlnbNE
         nI6efYnpCraJGXY79WGLKtoalMobnxVV3HGAnGy/EKM7R7G6Q2+EnnSjr3qUuXhGNqYc
         x5oJVCG16ltq4CLu+C0rgzfpoA/Ey/8ujya8zlFcuJrDaQunTiYJHdJS4dIQKTemL2sm
         P5swiB8GirT4jlBffqEI8ZjED8iKFKa9VDkvE1YUuCQVd5hfBZa4oivCKbkR/fQfiqP2
         /9WNjLNmBZiPx55AwHgriZqhrJqDfKNaPRHI2cZc/2rO37urHv7d163N9mrHS+GDxhWb
         qlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H20FyjJxhPkJkHC+Fs6tfpfKAaqzp0thZS/saM45AiI=;
        b=abllY7ekimIOU45b+b/Y349Nxuy4L67WBVfhWMhb/NziYazDfWMkywLSPUgIrBaNGm
         X0aZq+g4AGSXwiD1ShSRuKkb2zUSTibWVdZNCyFLfKDebcyj3lUCiB/bn2VMjtTRo8ok
         iKNqiztEFaZRVblTAyggJ0UIUBpYKVyS0wmrFjYJbyaPcSqysfTbt+vkKedZt92cGDQ8
         tg92/jMpYQEBMSEclOgzzrJJgSWC5RwlVdpgcyXJMXypN23H850qwkIm11MO+R3teyxN
         M/NeUF2pLfmYiYDzrmcajNmjYltSACacXWuw5DBz/xSXGQpwu9VPcPoW94jebG6j5cAM
         sCvw==
X-Gm-Message-State: ANhLgQ1kS95PUYSTdhrSEKdjZIp0zRFB2yx/caMWSECeRQvf08ay/Vgq
        UwrdAS/dSChqGIMtD6eHr6A=
X-Google-Smtp-Source: ADFU+vthe5Gw9uB6sYjV8JzxhMtrLis/lZROqaLfO8WsPnP6JGWuu2ZCYnhvHeDZDZ1khTDt4TIgJg==
X-Received: by 2002:a17:90a:26e1:: with SMTP id m88mr676574pje.60.1585237608882;
        Thu, 26 Mar 2020 08:46:48 -0700 (PDT)
Received: from localhost.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id s62sm934359pgb.94.2020.03.26.08.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:46:48 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     joshua.brindle@crunchydata.com
Cc:     bill.c.roberts@gmail.com, omosnace@redhat.com,
        selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        william.c.roberts@intel.com
Subject: cil: Fix DISABLE_SYMVER support and drop last dso.h
Date:   Thu, 26 Mar 2020 10:46:39 -0500
Message-Id: <20200326154641.7253-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
References: <CAGB+Vh7VOy_y2W7rxmaWAOyBQxQz5foFNL1T2hog0er4mnEQ4g@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I missed a dso.h file in cil code, and broke the DISABLE_SYMVER support.
this deletes that file and restores DISABLE_SYMVER support.

Sorry... 

[PATCH 1/2] cil: rm dead dso.h file
[PATCH 2/2] cil: re-enable DISABLE_SYMVER define

