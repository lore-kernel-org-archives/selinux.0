Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACD5C282CD
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 23:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FBD2148E
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 23:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OoWq9ZHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfA1XNB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:13:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46352 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfA1XNB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 18:13:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id f5so13156252lfc.13
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 15:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UtGJY8u32VByfuS892DodQCACLsimAhL6VVNr+s2w0=;
        b=OoWq9ZHgbsotb9HrbMBBzrE7d0QIQbBKezxwX8YGypcB0DQl+LwlaiOiumn2C0BHKO
         PZOMDY3r2uI+QyDGNRVnb77PqZ7NQVR3COgqSqm3tDOs1yKfWeRbm0ODNoLQxhl11/Eh
         AghX8oqAU8kS2umMLILhdGrlaTc2z+aKJJfdS+q9dTl4UGE11K+bjKENLTF/37tW/jC6
         lHXh5if3FMRAM/z0GaP13JAuPkL0FAquywOciyX8TjS02jHT2R1Nv5fPcmZw4Po0Xi/b
         XAEm5RfR6s3zC5wrVCYRGWq4WLEAWlqW+YOKQNwfY36PBevbUG5RJbWupxF9FEV5lbQl
         xiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UtGJY8u32VByfuS892DodQCACLsimAhL6VVNr+s2w0=;
        b=NYwWGziP0WkqplwJ7BAjC1TMs8vnuXjkb9E37DR5v5z7IAnDS+nnTP0GBPKDJKAd8B
         8iuovRnbUxLx3W74A5orlpnL4qF5hLwGA7ej93ak6Qg6g1JHHwERnacDTzNyJj8jvgJe
         mowcjhwR+gPJ//QqZ4kKlUFNhVMB1FgK7r9OB5N7OCyJU60YwLqKon1Opsrnv/70hksV
         zVwZPKZQfbiGOeMfgViUMduAaEIobeliiq7JSxPZGFQYsRrEYzi3EcNLpoY8LUy5D5/j
         L58deBPO4sjKwOyoQBI4PE7uYSTBFGDtnm8ouXa07s+wy7nVWPheJyUJ3fl7YWcmQolz
         2wjQ==
X-Gm-Message-State: AJcUukcfyfnpepINRryXFQRlIEI6xwZPDnMon3XGCq+HTL+GtsGKdfgm
        GI0n1eiCVP7g0h+sPffsKWjy+nX6Tfctgsb/YVnE
X-Google-Smtp-Source: ALg8bN7iYZYI3+X3P1tvTtCWkDo2QyqeY0QQ3OVDuM+K8d2eCcqRy2yIH9x+HPvF+bLGQDy3JbLbImL8sRvdiId2TC0=
X-Received: by 2002:a19:db54:: with SMTP id s81mr19049774lfg.102.1548717179295;
 Mon, 28 Jan 2019 15:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20190128154333.31279-1-omosnace@redhat.com>
In-Reply-To: <20190128154333.31279-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 18:12:48 -0500
Message-ID: <CAHC9VhQEHoeBUF92raSFLN27yGhczcZssFAEeXwWS4ibnWtKUw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: replace BUG_ONs with WARN_ONs in avc.c
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 28, 2019 at 10:43 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> These checks are only guarding against programming errors that could
> silently grant too many permissions. These cases are better handled with
> WARN_ON(), since it doesn't really help much to crash the machine in
> this case.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/avc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 3a27418b20d7..33863298a9b5 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1059,7 +1059,8 @@ int avc_has_extended_perms(struct selinux_state *state,
>         int rc = 0, rc2;
>
>         xp_node = &local_xp_node;
> -       BUG_ON(!requested);
> +       if (WARN_ON(!requested))
> +               return -EACCES;
>
>         rcu_read_lock();
>
> @@ -1149,7 +1150,8 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
>         int rc = 0;
>         u32 denied;
>
> -       BUG_ON(!requested);
> +       if (WARN_ON(!requested))
> +               return -EACCES;
>
>         rcu_read_lock();
>
> --
> 2.20.1
>


-- 
paul moore
www.paul-moore.com
