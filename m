Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92BEC433EF
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 09:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbiA0Jyy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:54:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232109AbiA0Jyy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 04:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643277293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDdQPcDy/BXM/pP3P0TjV4ib8OmOcmrz0QfWKeXF3XU=;
        b=K0YroP/mRfDYFSt7rbYoHydoDTh/pSHL4OW5NOo1+hmYzeAWDtPOo+PSKK9TJT1LxBDLzR
        GoZeTd2IFLzOM331iZV1SGgIuKwvLjSPKo+nuuAIFQ7QxlHy93mF1GH141U2ih2mmstUya
        K6knec7dT57eKOxJHVSHnIPGOWW6mgw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-dLPDPnOLO5iGp2HcYwC-Eg-1; Thu, 27 Jan 2022 04:54:52 -0500
X-MC-Unique: dLPDPnOLO5iGp2HcYwC-Eg-1
Received: by mail-yb1-f200.google.com with SMTP id a88-20020a25a1e1000000b00615c588ab22so5091930ybi.3
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 01:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDdQPcDy/BXM/pP3P0TjV4ib8OmOcmrz0QfWKeXF3XU=;
        b=nZpj+vXv0GHFPRQn2voT2LJl3f+qzi7DVqfz+UdwpNe5aJVUQ4gee/KJiTjm34iEDP
         P22vCe0Dz9czj+GmhByetl/3HWW4ei8ViqdO2KQczIsIWS05WItIYM5chXnfP5EQbSd5
         v6+kDJ7H3RrRidOlXscJYgvcQwS/Sw8OmZE2KPQGxk+5V/xQNsLX3CzaFxiq1m+2kXFI
         pbCYsFWqnuXNNY1UtvhEB4WHAlc09WA6ec4dsao0buVAeigXP8ULKv9qDiWM9eJDWqH/
         gSR7Wrdng7od6ff3KryMB2/3eILiRMOJvqS1QCFErflBlNeGDxrbmxrX9Qz1ScN9BXfe
         hn7A==
X-Gm-Message-State: AOAM5311twuYn8wC1/DX28JPVEKNglscSypXC/1jk/VmVGpvkBeWOBJE
        DPysx6IEg/KcnfJjKU4C5uAkg+FrvObqJ24pVQHj4hZVB4fuvEjClUkDccYW48+e77CY7T+gY/Y
        tgLftaDhoq2EFU4OGXBoWxVSWD12BK0x6Nw==
X-Received: by 2002:a25:b003:: with SMTP id q3mr4101553ybf.767.1643277291803;
        Thu, 27 Jan 2022 01:54:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIUAhfn61houAngphIKxZWb+8qIDFd2Y+AxEj9EvOc+Kbl9jUki4ydOR8JkmOT4urcd1J7Cnw9TB1/ZvP+Wqg=
X-Received: by 2002:a25:b003:: with SMTP id q3mr4101543ybf.767.1643277291583;
 Thu, 27 Jan 2022 01:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20220120214948.3637895-1-smayhew@redhat.com> <20220120214948.3637895-2-smayhew@redhat.com>
In-Reply-To: <20220120214948.3637895-2-smayhew@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 27 Jan 2022 10:54:35 +0100
Message-ID: <CAFqZXNv7=ROfyzZGojy2DQvY0xp4Dd5oHW_0KG6BLiD7A8zeKQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] selinux: Fix selinux_sb_mnt_opts_compat()
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 20, 2022 at 10:50 PM Scott Mayhew <smayhew@redhat.com> wrote:
> selinux_sb_mnt_opts_compat() is called under the sb_lock spinlock and
> shouldn't be performing any memory allocations.  Fix this by parsing the
> sids at the same time we're chopping up the security mount options
> string and then using the pre-parsed sids when doing the comparison.
>
> Fixes: cc274ae7763d ("selinux: fix sleeping function called from invalid context")
> Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  security/selinux/hooks.c | 112 ++++++++++++++++++++++++++-------------
>  1 file changed, 76 insertions(+), 36 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5b6895e4fc29..f27ca9e870c0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -342,6 +342,11 @@ static void inode_free_security(struct inode *inode)
>
>  struct selinux_mnt_opts {
>         const char *fscontext, *context, *rootcontext, *defcontext;
> +       u32 fscontext_sid;
> +       u32 context_sid;
> +       u32 rootcontext_sid;
> +       u32 defcontext_sid;
> +       unsigned short preparsed;
>  };
>
>  static void selinux_free_mnt_opts(void *mnt_opts)
> @@ -598,12 +603,11 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
>         return 0;
>  }
>
> -static int parse_sid(struct super_block *sb, const char *s, u32 *sid,
> -                    gfp_t gfp)
> +static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
>  {
>         int rc = security_context_str_to_sid(&selinux_state, s,
> -                                            sid, gfp);
> -       if (rc)
> +                                            sid, GFP_KERNEL);
> +       if (rc && sb != NULL)
>                 pr_warn("SELinux: security_context_str_to_sid"
>                        "(%s) failed for (dev %s, type %s) errno=%d\n",
>                        s, sb->s_id, sb->s_type->name, rc);
> @@ -673,8 +677,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>          */
>         if (opts) {
>                 if (opts->fscontext) {
> -                       rc = parse_sid(sb, opts->fscontext, &fscontext_sid,
> -                                       GFP_KERNEL);
> +                       rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
>                         if (rc)
>                                 goto out;
>                         if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
> @@ -683,8 +686,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                         sbsec->flags |= FSCONTEXT_MNT;
>                 }
>                 if (opts->context) {
> -                       rc = parse_sid(sb, opts->context, &context_sid,
> -                                       GFP_KERNEL);
> +                       rc = parse_sid(sb, opts->context, &context_sid);
>                         if (rc)
>                                 goto out;
>                         if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
> @@ -693,8 +695,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                         sbsec->flags |= CONTEXT_MNT;
>                 }
>                 if (opts->rootcontext) {
> -                       rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid,
> -                                       GFP_KERNEL);
> +                       rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
>                         if (rc)
>                                 goto out;
>                         if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
> @@ -703,8 +704,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>                         sbsec->flags |= ROOTCONTEXT_MNT;
>                 }
>                 if (opts->defcontext) {
> -                       rc = parse_sid(sb, opts->defcontext, &defcontext_sid,
> -                                       GFP_KERNEL);
> +                       rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
>                         if (rc)
>                                 goto out;
>                         if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
> @@ -976,6 +976,9 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>  {
>         struct selinux_mnt_opts *opts = *mnt_opts;
>         bool is_alloc_opts = false;
> +       bool preparse_sid = false;
> +       u32 sid;
> +       int rc;
>
>         if (token == Opt_seclabel)
>                 /* eaten and completely ignored */
> @@ -991,26 +994,57 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
>                 is_alloc_opts = true;
>         }
>
> +       if (selinux_initialized(&selinux_state))
> +               preparse_sid = true;
> +

I wonder if we could make this all much simpler by *always* doing the
label parsing in selinux_add_opt() and just returning an error when
!selinux_initialized(&selinux_state). Before the new mount API, mount
options were always passed directly to the mount(2) syscall, so it
wasn't possible to pass any SELinux mount options before the SELinux
policy was loaded. I don't see why we need to jump through hoops here
just to support this pseudo-feature of stashing an unparsed label into
an fs_context before policy is loaded... Userspace should never need
to do that.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

