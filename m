Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22944C433EF
	for <selinux@archiver.kernel.org>; Tue,  1 Feb 2022 21:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiBAVos (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiBAVor (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 16:44:47 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48415C06173D
        for <selinux@vger.kernel.org>; Tue,  1 Feb 2022 13:44:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p15so58353254ejc.7
        for <selinux@vger.kernel.org>; Tue, 01 Feb 2022 13:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yesm+gpXef/eaQ4MHLV9cZEc+Dgod1yjSaH4OtP/5ko=;
        b=l/Uet5oa6hms67OUa3Vukk9Sc1DR7G166JQ0KwWLwALgXOkCcTTMUacYBhcEDNwQF6
         rNHqf6efJyMXc3PO2lcBNFyCDWTyfKx11CHkHYKm1AsZLqZpBbRuNIVfi5YXCQl5mWXs
         rHMv6VTXVJ77myLzMQ8ARRHb+kzI0S7oRyVhXj8kbAHoK8cIet7Xr2YdxPZ1qMpZNpNK
         Egw4Na7rvIH159ck9kMDh0aQHEmW1hZ03Cbpy/BmQsS6nkAvj/phYFNa4JK2xDjee0sY
         vuGEwSiAvp8vEp95hBu7QWje4ESnS11ShUPqHytYShLSMXqwIlsUpl6c56cH2KbxbiPw
         OvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yesm+gpXef/eaQ4MHLV9cZEc+Dgod1yjSaH4OtP/5ko=;
        b=U3ZEZB5o3Y4ioLIhKaCveIMTUDvvPUO9ZlJqWqkoTc2nJcc+ikec5W/sD+sAQCiT/0
         QKyP7TSJcQgcLZaURPFNlJD/nIeV9s04EVvfd/wBYgtO8fi6eWWQ82g/rtpiKcr6AZM6
         UMtPeobaiZfHi4gC0o3MUpffPuxVpJQoT/4/EzUXo1GRtJln5P644GKtzW09a+gdkS5u
         2DvSXvEwzNNFXLX9y3+4z+elzBpU7QNJ3FjHN50Iwm2GL+nav79X1/xAo2kaP0RPCPZd
         A9yZ36OrmFOJHvq/N2CLRWGow3JgDD+0r4NbMHvEvFM1Isq/SdA+/HCvKMmr5t8rlxm3
         xoag==
X-Gm-Message-State: AOAM532JwaA36wwHNYGd3g+uDQdyMIkT+C/F/ce/VFpBYR2cCHEayG2m
        S6c/I3nCUxPozoGk+lnBSzsdtWZeiQb2/A7o+X/3AfkLHQ==
X-Google-Smtp-Source: ABdhPJwv1wOD13WlIKKXXU/u3rrX7ixmf3pNogGirJHF+p9a8Zbzkrps+SYfblp6TN/B//b3vqn1MlBpgsuseTXnRJA=
X-Received: by 2002:a17:907:3e1d:: with SMTP id hp29mr22354191ejc.701.1643751885760;
 Tue, 01 Feb 2022 13:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20220131185737.1640824-1-smayhew@redhat.com>
In-Reply-To: <20220131185737.1640824-1-smayhew@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 16:44:34 -0500
Message-ID: <CAHC9VhSZy-tN8Rx0K7K0uj1R__W_a_Fkp8s_Etvk8hJbC-T6CA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] selinux: parse sids earlier to avoid doing memory
 allocations under spinlock
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     selinux@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 31, 2022 at 1:57 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> shouldn't be performing any memory allocations.
>
> The first patch fixes this by parsing the sids at the same time the
> context mount options are being parsed from the mount options string
> and storing the parsed sids in the selinux_mnt_opts struct.
>
> The second patch adds logic to selinux_set_mnt_opts() and
> selinux_sb_remount() that checks to see if a sid has already been
> parsed before calling parse_sid(), and adds the parsed sids to the
> data being copied in selinux_fs_context_dup().
>
> Scott Mayhew (2):
>   selinux: Fix selinux_sb_mnt_opts_compat()
>   selinux: try to use preparsed sid before calling parse_sid()
>
>  security/selinux/hooks.c | 147 ++++++++++++++++++++++++---------------
>  1 file changed, 92 insertions(+), 55 deletions(-)

Merged both into selinux/next, thanks Scott.

-- 
paul-moore.com
