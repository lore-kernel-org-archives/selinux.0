Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4829CC433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260382078C
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 14:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="k38ZcOtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgFJOkU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJOkU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 10:40:20 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35106C03E96B
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 07:40:20 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m21so1552067eds.13
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cl4c39Fo+VrDOXUwA6DCS3yFEgGqXeTzRXvhX8rY82g=;
        b=k38ZcOttmNX/jpXTa58Sz1TLYloOeZmk2oTZ+eZnHvSBPyKDM+CYDhNjaIWstTu+Ur
         wNLxcaz1ra0Ej23spa/qR2ZXmZgchjCoL9fsu+e1lCjTDKhHDDYa+pJ8GVtsCHch7VJL
         FVb7C9zmrnDHAxDNzYV/cthax8YCS4EOruKVKIVOXimKl/tS/j9gxbtmqusSWYHvZPb0
         V6QaQWAyCF3cD9cTgxHQ/K2/Pq1e6zG9r+x67LbMIsnCCx7aCeVAFhaSemQsY1HL7SuD
         ogGhWjWj63j4oFTN1H9bp43456fro6zOf6nudaEcCydlc1ImIrcqrMSt6HOj8ckDg4CE
         OCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cl4c39Fo+VrDOXUwA6DCS3yFEgGqXeTzRXvhX8rY82g=;
        b=BKp8i3FQUoR5glAV0PBNAenEN2fn31UuVNxxgvvfjidxZfuWDiDCnsPIFpVmP4Sn8a
         LFRIx1TNWEnvymtD1c5AEzD3egPpgEG7yBilpdIv6LePm42JvBkdBmw8pL1n9cDbF0dO
         2bcJif+whrotaQzRvfBK6Js0a0qgb1RwTQK+Cg6oNLFvo+29UBlWiG5GPv26Y2V3C775
         whkTdN7/ZgnqNociucmti61zpjkap1Qt/nEMd47isbi8sd3FRLvAvd/7ZTC51Ensk+E9
         LkNZWIAcmNNDkgKPS2mXGuxWY646siXpnDKQlN9a4etBLmaJMY3GG9Lu0CbdNnKFifBv
         L6uQ==
X-Gm-Message-State: AOAM5314A8d44B+zc9KIxgTILWXz/TsGgPCj0t88KZmUO0mVCGjSeXLG
        zDuTx099bEbRxTXxg26c3AtvqcCh4AynoNHLrUvh
X-Google-Smtp-Source: ABdhPJxvUUnlq1bNX8kCNPgbAB9fz48VOM3JzqUMlHuzWbJQ1unZ/qDoo/RF620A7otLTLglhxxY9cR1YXjVojNaLJg=
X-Received: by 2002:aa7:cb8d:: with SMTP id r13mr2667368edt.12.1591800018687;
 Wed, 10 Jun 2020 07:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200609151833.43523-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200609151833.43523-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Jun 2020 10:40:07 -0400
Message-ID: <CAHC9VhTo-B5PVsvsgvRamv8+j=owvfGHAcZaCBy1_yuEbBmgRQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] defconfig: add NETFILTER_XT_MATCH_STATE and NFS_V4_1
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 9, 2020 at 11:18 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> When generating a kernel config for testing per the README.md instructions
> based on localmodconfig followed by merge_config.sh with this defconfig
> fragment, I found that certain tests were failing due to missing options.
> We need NETFILTER_XT_MATCH_STATE for some of the tests/inet_socket tests
> and NFS_V4_1 as a dependency for enabling NFS_V4_2 for the labeled nfs
> tests.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/defconfig b/defconfig
> index 00bf9f3..0c96408 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -21,6 +21,7 @@ CONFIG_NETWORK_SECMARK=y
>  CONFIG_NF_CONNTRACK_SECMARK=y
>  CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
>  CONFIG_NETFILTER_XT_TARGET_SECMARK=m
> +CONFIG_NETFILTER_XT_MATCH_STATE=m
>  CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m # used for testing sctp
>
>  # Filesystem security labeling support.
> @@ -99,6 +100,7 @@ CONFIG_QFMT_V2=y
>  # This is not required for SELinux operation itself.
>  CONFIG_NFS_FS=m
>  CONFIG_NFS_V4=m
> +CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
>  CONFIG_NFS_V4_SECURITY_LABEL=y
>  CONFIG_NFSD=m
> --
> 2.25.1
>


-- 
paul moore
www.paul-moore.com
