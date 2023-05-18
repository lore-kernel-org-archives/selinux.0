Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD2FC7EE23
	for <selinux@archiver.kernel.org>; Thu, 18 May 2023 17:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjERRj1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 May 2023 13:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjERRj0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 May 2023 13:39:26 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9198A2
        for <selinux@vger.kernel.org>; Thu, 18 May 2023 10:39:24 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-623836551f5so10673736d6.1
        for <selinux@vger.kernel.org>; Thu, 18 May 2023 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684431564; x=1687023564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ym80F6m3sCSA9zVZmaKKkeHjU+KvLOxFrDGkEBGtXJY=;
        b=QNCUvTgtS7EnY4NPHxD+TL2v/vt5PkkUOf23yqFrvfWWMDQcKqTm7ycFuYg039uriV
         aZRjBtnCo82xFmPPnAOpf8iCwb7z+xR9b1nY+4N7/HwVUYZgsnhOnYM3raaYXo5WyVAX
         Hr/3Unj4CCHa//RyN+F7tgNCpxpiGbCmGOekLAYp+/rbq1k8fpwgh9UM0/MEaFzE42E7
         8sR6NR01FP9MMWR/afrNOwXbJK/cR9DeYeXl3lvIz3O9Cg9//s1GIsiTsTX+I+A025gs
         02bR161mpl2Xp59IIQReOl+8Ua7pP2p2jwFSU/ipFFcmg4V/yMlvyuS41Umvey6cioJ7
         PhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684431564; x=1687023564;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ym80F6m3sCSA9zVZmaKKkeHjU+KvLOxFrDGkEBGtXJY=;
        b=H2xYxQtJLvWb3zYSn9BWe9UvpT6djoJK1ICgCkuvM0zrb0C+e6/0kbhEGrKk+eZRYX
         scYIwJstHKERX35a5fvYP5YyQI9yfk5UH1LNnFC7RIMnz/TXG4KtL8Y2VLB1j1Izfalb
         fAnHPDX6OrSADDe+gLWpLoN0yvHoimm0OCPRFkGZzEyTkxy41NasDo30MwV1DusRgW9F
         n3nOpoK15oiKSaLgopkMfJJiMnQI6p8QL651JatTAGBZMpAisUNcAU5Ocv43gjrBWMcl
         6hcEeSMm9ff3rWc8LOynejmDgG6qH/Xi5SbOLra0xl4nlgAOZJxcSxQHzJVcOuVGauSM
         RrEg==
X-Gm-Message-State: AC+VfDxQC9W3+PWXs5BmDcNn4t9Ol1k1wweNwikova6tlpJG+aGSP6kF
        DSock+QbD4iVVoYDvsjtQlwU
X-Google-Smtp-Source: ACHHUZ4+WSpE0ffoG+ndbrGnpfTrq/93DWzMQ6pF5Iq2vQKe/z7VXKOBYVf4kpsCXn2l36cwUW5sPQ==
X-Received: by 2002:a05:6214:29ca:b0:5a1:6212:93be with SMTP id gh10-20020a05621429ca00b005a1621293bemr597210qvb.29.1684431564046;
        Thu, 18 May 2023 10:39:24 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id r15-20020a0cf60f000000b005fdbcab3065sm667484qvm.72.2023.05.18.10.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:39:23 -0700 (PDT)
Date:   Thu, 18 May 2023 13:39:23 -0400
Message-ID: <cb8077678d0ff3192e273ef443e490ee.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: keep context struct members in sync
References: <20230511123148.722343-1-cgzones@googlemail.com>
In-Reply-To: <20230511123148.722343-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On May 11, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Commit 53f3517ae087 ("selinux: do not leave dangling pointer behind")
> reset the `str` field of the `context` struct in an OOM error branch.
> In this struct the fields `str` and `len` are coupled and should be kept
> in sync.  Set the length to zero according to the string be set to NULL.
> 
> Fixes: 53f3517ae087 ("selinux: do not leave dangling pointer behind")
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/context.h | 1 +
>  1 file changed, 1 insertion(+)

Merged into selinux/next, thanks.

--
paul-moore.com
