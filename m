Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E14C7EE23
	for <selinux@archiver.kernel.org>; Mon,  5 Jun 2023 21:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjFEVEU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Jun 2023 17:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFEVET (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Jun 2023 17:04:19 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA503ED
        for <selinux@vger.kernel.org>; Mon,  5 Jun 2023 14:04:18 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75d57fdb014so201548985a.0
        for <selinux@vger.kernel.org>; Mon, 05 Jun 2023 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685999058; x=1688591058;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8tLbIUuv5lgaEeoqnLtnBMIzF9WaGkUC0lTRYTnhjLY=;
        b=CURFfuND+w9EpS4CBMuYDAtf4AQRaiKtH+aPQKwanjanSK4cJJrzSVZansct4nIFtb
         JVtVZvgcQB35AZZNRCyC7KO7K7TCdLQMEVtiSBOWcueMna25en8AxctGxR+eDDM4omgC
         zBuAU0nZlJAVRMIEsPXU/eVBrHj43nMWJiZhJxxxntOeEQpfEoBGQLffNNIo4FXTb9sI
         gz33U0mStlUVRZ41MrmVSvoE+NnwZEbjguMXmCmME+p/MxLtGzlGJ4oLn7GiK9YPfZue
         2+p0jYeRPD6sBhsQHIIr1j67OOLvBRlpQz4bhklTtLXLVVdPPpMkqpyk2hDFfjdtS5cY
         /Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685999058; x=1688591058;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tLbIUuv5lgaEeoqnLtnBMIzF9WaGkUC0lTRYTnhjLY=;
        b=H0f6EybgqR04eCihqPrb0/sHcKWas5KxTIrC5mVYux+cLq5u8CIhMqdgDPAIJdrLI6
         RvG83L6v59m1GFjk2JRIJ4pcHATtM+Grmuuz6Q/fU8SqYWtOQaBokpfdHA/SQbBIUWC6
         0kA/Twk2eL2JbWIPnlK5I2bgvH7wglIpDhgra081NHORrabIGiYtJayoidDgt9XrFVBM
         6IY2w6nniR46bLg53qypHkkr0zjDn8YUs/R7ONrEts2Md7lDlBzJ7KsyuIOgDuX8MmZn
         UI4PV1mCvVB3enA6DOtneEplsZTh+ALHUKRA8KxgCgObBFnQ12wYs0PVrfjSvVrNVhwU
         7P0Q==
X-Gm-Message-State: AC+VfDy5KNic+EcyHcz+JSlbmOO/9Tc2QZloxnx+XX3YGHOLUSM5vCOk
        aQC8g9gRQ3Pz/EbfUSRv3tA5
X-Google-Smtp-Source: ACHHUZ6DNQxwPJvuRFMN55TajOTfrEzsxKPLCwOnacjxiCw/Lil/yh4+xY7MA2kgUc5OPfmmAnS93g==
X-Received: by 2002:a37:64c4:0:b0:75b:23a0:d9c1 with SMTP id y187-20020a3764c4000000b0075b23a0d9c1mr943116qkb.23.1685999057142;
        Mon, 05 Jun 2023 14:04:17 -0700 (PDT)
Received: from localhost (static-96-237-115-254.bstnma.fios.verizon.net. [96.237.115.254])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a16af00b00746b2ca65edsm4453045qkj.75.2023.06.05.14.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 14:04:16 -0700 (PDT)
Date:   Mon, 05 Jun 2023 17:04:15 -0400
Message-ID: <0be47690050b0d5aa3eaf2422d4feac2.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: avoid bool as identifier name
References: <20230602133511.30239-1-cgzones@googlemail.com>
In-Reply-To: <20230602133511.30239-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jun  2, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Avoid using the identifier `bool` to improve support with future C
> standards.  C23 is about to make `bool` a predefined macro (see N2654).
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/conditional.c | 8 ++++----
>  security/selinux/ss/conditional.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
