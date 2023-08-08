Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74023C04A6A
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 18:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjHHSU1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjHHSUB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 14:20:01 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0677A20D35
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 10:28:43 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bca38a6618so5071605a34.3
        for <selinux@vger.kernel.org>; Tue, 08 Aug 2023 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691515722; x=1692120522;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLAH5u1UKFtPG+pw7/wQvaqQnBo57wIc9zaPM3qytYA=;
        b=Wif2ASPOkXISAQFN7RDejwtdGvqwbE1yXodpzOqZpMknQ+9yN4bZj2oezpE3TnFEKW
         1hWVrk2XZsPgM+Jc8GOm9uSXzBrQgabCyWK4tZReUX44kdQibGEQHa1qx2CDigE+DjmJ
         1qGm9Gf6AsG682XF4XEh2H+KgAK5GB1rRgvZ/SpneIBrca3d2LFhLxCnHE4zaVZ8jfHv
         D0/gsWWnF+QrJQLXkopEwiaaPDD6uFqR+AvbuL0ukgI8NKlG54JIRh9bLSz+Yrj8zSVj
         JD0xLxcV/BlV91Sca1AiKpQrZ5SuixhJHFs6q1wT3Xtggg8klCRswQBzqq+ZpRtj/aGg
         mFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515722; x=1692120522;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLAH5u1UKFtPG+pw7/wQvaqQnBo57wIc9zaPM3qytYA=;
        b=WG1E02ZA5uoEgiw/M/Cvsw3dv2BurTecp1lNkcy3+GyT/fWiyKhIULokbCM1opA4cs
         JoSBFCSMse9imcgjP59Ov+Uxdvhh/RUjSAc5Eor64WwYWx0S+JEXHxVhaALjJL9Js2GG
         zCmlbN5yv6qbXElx+UVlyU27DGKvdb5dtY8simxUzDvHdxPz9+fEOVZ1ziovvug5nipB
         uREGAwg70sMQ3uGdf7S811o5aUaCilMuinD8tPWUiL1VlwCTn/nk39Xc01sZjSmNe7zx
         tbmRa3uKUesA+RD9fs24wJ8BDKJHGhWxNGpBE0DLLE+QVXgSuWQwP+AhUV/scwgOPjvA
         kmVg==
X-Gm-Message-State: AOJu0YyB2jpODMW9xiFhyjGH92/NcxSwAF9pb6ln+XT9nIU83Gsrj+4k
        NpbMFix1sUepR/EnCEYpdrkf
X-Google-Smtp-Source: AGHT+IHho+obFD1QpSYx31flRhv4Hrx7Tpub2h06vX4z16f8/dqCLZRQI/jzOnrRZ1rgomiTplHMIw==
X-Received: by 2002:a05:6358:9041:b0:123:5664:e493 with SMTP id f1-20020a056358904100b001235664e493mr43825rwf.27.1691515722205;
        Tue, 08 Aug 2023 10:28:42 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j2-20020ac84c82000000b003f3937c16c4sm3510658qtv.5.2023.08.08.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 10:28:41 -0700 (PDT)
Date:   Tue, 08 Aug 2023 13:28:41 -0400
Message-ID: <41668501b8413023d5ed79d60233a6fa.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     selinux@vger.kernel.org, xiujianfeng@huawei.com
Subject: Re: [PATCH] selinux: update comment on selinux_hooks[]
References: <20230804034652.281266-1-xiujianfeng@huaweicloud.com>
In-Reply-To: <20230804034652.281266-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Aug  3, 2023 Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:
> 
> After commit f22f9aaf6c3d ("selinux: remove the runtime disable
> functionality"), the comment on selinux_hooks[] is out-of-date,
> remove the last paragraph about runtime disable functionality.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/hooks.c | 4 ----
>  1 file changed, 4 deletions(-)

Merged into selinux/next, thanks!

--
paul-moore.com
