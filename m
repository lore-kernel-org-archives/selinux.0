Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD92C433E2
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF45F619AD
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 19:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhCVTAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbhCVTAV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Mar 2021 15:00:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E4C061762
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 12:00:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq27so23053192ejc.9
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DY+ADK98r/lYBrg2oozDga4hZ5La4ibn89mMMa32APM=;
        b=BXYAJLxcuRH5oRxtxWbWiwktazlO44A9TZdXp1vfkDadW39IR7NVnIrDUnd6T0Qaji
         EtwUiSq2UG16VbRUQ0XTNgDUAacWsdIEnqm+XH5AFtEHAoOVuEi2tT21lsrvlfCFxZR/
         qesIrifile3JvJuxIPu0B6x18zI/590KMOT2p2/gbXI2gJose0KUowKt1m7SLHtldSid
         n8j43mDxdjsaun5LdVJ3BhKptlOb+vxL+2CtFCMp4G0kIUK/6KoIMlP72x+d+qs3I/p9
         p2GGj2MC0Id3zKXhkLqe7fa6zORB6MuoYV7Oe5odCKdP6AR0H1BAOn7OaI7cpFzzrOPy
         QFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DY+ADK98r/lYBrg2oozDga4hZ5La4ibn89mMMa32APM=;
        b=S+tv1OoDt7A0M+jYaj0x1nu3wyCfVh0lSHMvkfAnNwNrI6ni1ZMkXNtNNG7GbA6d3P
         iqwgqQ9n1NlS199mJJul3JiQEGPnHR0MomOQqCKjvVMwbi/d3PRin02l8cVYt4gg6RAl
         RMNv+Gb3oKK0kMykFWkNbw/4jclkLYLVNZ3TVY9GKtjbiseIPEiYXRCm0fzSrvyBddbP
         hIUMihKcbl5oIzTfnZN3dgpAZEYrXQ54WVGJDP1hzJVWgwuAv4XSmTkecJbMtolUbV2j
         S1JIV0TJJW0VeP19Przs/BMnOs+vNs8+LFblx7J36Axm/CJDf2bkSv6AeC0+q3HTUkCG
         JM9A==
X-Gm-Message-State: AOAM530U/Xxdq33YMPxO2Q072ZCGK1V4Imx6ZpzDuy9u4Bie+yt6VppL
        xy9wcpt2Zie1IstB7CM4AIcF81DVcO3hmZIpm9iq
X-Google-Smtp-Source: ABdhPJxBI9nbqYYbiPbcQlRK4x4a8SAUrhThaao+Dq6D5/vgzjJrsU2iVFjFs3ELvrxMxHUuvdn/YbbxerWQ9SLaIYI=
X-Received: by 2002:a17:906:b846:: with SMTP id ga6mr1221686ejb.542.1616439619771;
 Mon, 22 Mar 2021 12:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210219222233.20748-1-olga.kornievskaia@gmail.com> <20210219222233.20748-2-olga.kornievskaia@gmail.com>
In-Reply-To: <20210219222233.20748-2-olga.kornievskaia@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Mar 2021 15:00:09 -0400
Message-ID: <CAHC9VhRFSZyKcT8XxW00QwFvbeC8iB7PpaDifrenuZk2wdAqfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] [NFS] cleanup: remove unneeded null check in nfs_fill_super()
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 19, 2021 at 5:24 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> In nfs_fill_super() passed in nfs_fs_context can never be NULL.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
