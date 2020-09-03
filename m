Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EA2C433E9
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 14:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2184420716
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 14:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcLprULK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgICOrZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgICOYg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 10:24:36 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC489C06123E
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 07:22:58 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x69so303888oia.8
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyuBtrbre9FLxZEJcKX5L74bgokYux5S3K8iMb5lJ7Y=;
        b=XcLprULKumpwyJnyRcOscodCB83Vn/2ZT+gO67otxl4OdETdX3TOq27RN+pDrrhpB2
         pKEHpUZZ2jAIdG74lpSqeJxfGHBItgLHTfFUnvYHGSwkJTCqiwlUEuGtu+3Nw125rK3z
         TwlmfEeKZhRgB4gSJo3CKYj5SK2d5iaow93A0kRoWkjujKxWm0YGXQkqBa1GQlUoebJv
         g/WttEIncgZRUNnm9KR3hoTkd9B4ESjKJJc6DtAtF4+yVLknPX0+wkKXPdyuvHYQEjTd
         MNXA4BG88Q7x86HrqqyyKfaN09MWPEQOYLDPgwIr6VUFLogUffvB5N8ZIW3qx/ln9vxW
         uQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyuBtrbre9FLxZEJcKX5L74bgokYux5S3K8iMb5lJ7Y=;
        b=Bk4VflWUvqGE2PrXDtLLLmGYLwfwFDrgNQC5/ZsynsemyvDf8sIW+0oEAZ69TvMMzZ
         gTM+N2KsL6Bae/EtTSLwZboJkPfy9NlhMV15b+9Z3uQwUdsGBPAk54ctMfOCsk0GAzex
         IGPtCorNJL6e2e2EAEX0fFmFy2NLSSck/lnGoEBlw9gtuXaocUx3bLMqNfulcuI23TPl
         YLqJ/sjeEYveUMIt+0kAEQlE4/zlz52nz3x1TQQw8M/p7gRXiOTzHL2vKo7sy3NdjHbT
         AONSOkI0hM5IvXTVnlNB5vB8LEtfTfrm96E0kpfbIugjTFnJXXodMBZNh8UORVbSfU7c
         CXCg==
X-Gm-Message-State: AOAM533Lrcvx21v97NdXUpmM1ZAVDbW6mAnhfFiFk+rEiTFVNscFu/Ik
        gvCoaVZw8rAyrXgIoIrL2SpCPA6Fy3BcJPVuAshrX6nr
X-Google-Smtp-Source: ABdhPJzj+dVH8do7AR/zp+15+gQM5TJOU1X/H+yGPZJ9uulOtwx+G+swraLXJPiNqjljZ5DTyGOQapuEWJUIXYWLJtY=
X-Received: by 2002:a54:4f9b:: with SMTP id g27mr2224516oiy.140.1599142978350;
 Thu, 03 Sep 2020 07:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ73HtLW_AgRBSEUmNVer4xpotkCq1i7r=YJOF1LbixKuQ@mail.gmail.com>
 <20200901161641.431740-1-dominick.grift@defensec.nl>
In-Reply-To: <20200901161641.431740-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 3 Sep 2020 10:22:47 -0400
Message-ID: <CAEjxPJ4z6EbdP8nsSdUBKVKJkhmsOHN7U86bpne+0Hy0v=M_ow@mail.gmail.com>
Subject: Re: [PATCH] newrole: support cross-compilation with PAM and audit
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 1, 2020 at 12:17 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Compilation of newrole with PAM and audit support currently requires that you have the respective headers installed on the host. Instead make the header location customizable to accomodate cross-compilation.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
