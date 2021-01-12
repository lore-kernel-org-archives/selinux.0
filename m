Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB22C433DB
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 14:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F8C420739
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 14:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbhALOxX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 09:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbhALOxX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 09:53:23 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F347C061575
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 06:52:43 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n26so3901730eju.6
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 06:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FY8CNzcLDUWw60vy/XPa3FQAtUI2tUBQlCePr+9trV0=;
        b=1tsP9JG9LMZVmmJiKCnsvGa0SdaN3QpU1o2yr5PX1IozNjK3GekqcNCTHddvQy/jIA
         jujNyfIblyC/BFI1hdKpe3fYqbuwJYNkqCMAU08ltamk5nPFMWCI8DzM/m+9sdbQEvYg
         A5MP0I6PEYas7eyy3esQyuWra2Oc8pDAzweew7G/NOLa9wIihDZkBcdqXSnVfbNFRohe
         9RV7PWV7nj3lKhANgd6N6Czz+Tt3vrk3SE/1O3pIBmVBAGWipGlXmdlKoxtFIucrL+dz
         2W63/rVkW0hpbM+OnggSPIBjY0pYhNenc2R2hU6PuLXWRNP4c6/hoFujb5JYimcpbfKg
         F68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FY8CNzcLDUWw60vy/XPa3FQAtUI2tUBQlCePr+9trV0=;
        b=Ij/gZ9BErVal7Yv9nrpKF/lLj/hRsImrMdDxFZNJchfmcmgb7Sxz+E/p2+9Ujcazzg
         cBF0evgTpiwL/CGugaTw+q0VysQwrd6S2l1TZJN19jevZ3QdS7xVcMxkzu9vqrWhblfI
         82q+QhXI5nYVUEGVxb0wd+75yVdGkbfZ7kjjWu9k9PdW52jPmCU2UZUu+qVKE1UwUM5s
         azEVzaPOHcIIVfDluo+PHOxhRyzYukpM+jRVRTd7SCJ5pKaQy7i0Hnn6o7vu8cIsos57
         dS9ur5iqiNEfym1IWsj3+0l6La/h2bEUWletCYt8RSFyDFLYuX4MGMi9fMx2pF2kWgiz
         4zLQ==
X-Gm-Message-State: AOAM533bNVNWdfOjqyNc3oTEku90u7UK/Aym5nd6TcvdK2iqGr+rN3m1
        /uDXofazfqrjIA+XvejwU9s413oKXuadAyf/aRfU
X-Google-Smtp-Source: ABdhPJyKVIwMDbdSZRl+p+cBitj74nxcSqdWeohF0y01pEMGzhW990RqWiiBJ6Vfr1lbz3I8Xx+v55a0Zq3kwLCQnwI=
X-Received: by 2002:a17:906:1393:: with SMTP id f19mr3431312ejc.431.1610463161986;
 Tue, 12 Jan 2021 06:52:41 -0800 (PST)
MIME-Version: 1.0
References: <20210106132622.1122033-1-omosnace@redhat.com> <20210106132622.1122033-2-omosnace@redhat.com>
In-Reply-To: <20210106132622.1122033-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 09:52:31 -0500
Message-ID: <CAHC9VhTwdbSXPPHc0RkrUJUHOaJGLBu6zFAom9tyRBn17tnCmA@mail.gmail.com>
Subject: Re: [PATCH 1/5] selinux: remove unused global variables
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 8:26 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> All of sel_ib_pkey_list, sel_netif_list, sel_netnode_list, and
> sel_netport_list are declared but never used. Remove them.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ibpkey.c  | 1 -
>  security/selinux/netif.c   | 1 -
>  security/selinux/netnode.c | 1 -
>  security/selinux/netport.c | 1 -
>  4 files changed, 4 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
