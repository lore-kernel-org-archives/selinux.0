Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBDFC4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 11:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55A36135F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 11:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbhHXL27 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235125AbhHXL25 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 07:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629804493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=csZdA38ecZk4uzGs0BOWcnl0I/SkMeploJ4X7WtB8Yg=;
        b=aztByu6WayThQN53bp0LtYjSVKzhL8s5DffGpULa8175eJT+vQFitqw9sYReGKefpKToXp
        OGga6MhKf1AsXC0Iu9wjjiFzhQ0qrj32iCnu5+Gyt2Ft9MVJNUU7tPCwUSxIc5JKPoKllF
        ifG3VG8W61MNWPvKZLFymAR9Qrq0Ud0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-7A-vuqoEOduiYa-52z_pJQ-1; Tue, 24 Aug 2021 07:28:11 -0400
X-MC-Unique: 7A-vuqoEOduiYa-52z_pJQ-1
Received: by mail-yb1-f198.google.com with SMTP id q13-20020a25820d000000b0059a84a55d89so4712522ybk.23
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 04:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csZdA38ecZk4uzGs0BOWcnl0I/SkMeploJ4X7WtB8Yg=;
        b=I1/jj+qRHYO6jI3ouNAylY0iF0Prx0sdldD/a60my0J78xNunmI2r8hPeL9Eo7Wze0
         u1gDijHQEhnkfP2KBZOv3A5hgfgTjxVqenY3qI/IuOjscCii/9mrDlxfkVAbn+jwYqhm
         gI1oD6tWpI9gT68AORB+ONddmu+jXfeV762u/y+1pc6WOj4g+SwcUJYTYk+xiT+RI5eQ
         ymDjxNhbPuxy8motvGfFg1Dt/I+3aaBafQBB3NssvULDzaK4RECuHT01XhBO4u0Mf6YR
         F0HWfvdQ+9EKwT6duvru5bmlHciDrC00tv73SHWsv98/gBUd47cl+2zlVq/oVCeyB0g1
         6aEQ==
X-Gm-Message-State: AOAM533NufXE3ZZmLI4Je3cI2gCM70WgEbdkH74BKtsBwqjD5N6k7Rsx
        MmM8a27PV0+xHS8XU336fEWYbXxJNbDXkfXb6rA9wAMtiT45fPcFfUNGN1igyEVunS3+VGXxUb+
        X7CyVhMHStRZl5RRj/HRm/uGsnZbAT5ZVpA==
X-Received: by 2002:a25:6b50:: with SMTP id o16mr24086391ybm.400.1629804491445;
        Tue, 24 Aug 2021 04:28:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhxz4MIsdc6SyQJMK3YjKVl+ABJrorZOL2PApPZT9gBrMSKrcSMF+pCYDUGd9qq3de3bXD6B1RjNxJHljcSJU=
X-Received: by 2002:a25:6b50:: with SMTP id o16mr24086370ybm.400.1629804491221;
 Tue, 24 Aug 2021 04:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210824022247.GA22908@raspberrypi>
In-Reply-To: <20210824022247.GA22908@raspberrypi>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 24 Aug 2021 13:27:59 +0200
Message-ID: <CAFqZXNuOnMpV4RJDej2tp8_2OkZLuxuC9X7jBpKGs00MAQADPQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove duplicated initialization of 'i' for clean-up
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com, austin.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Austin,

On Tue, Aug 24, 2021 at 4:23 AM Austin Kim <austindh.kim@gmail.com> wrote:
>
> From: Austin Kim <austin.kim@lge.com>
>
> The local variable 'i' is used to be incremented inside while loop
> within sidtab_convert_tree(). Before while loop, 'i' is set to 0
> inside if/else statement.
>
> Since there is no 'goto' statement within sidtab_convert_tree(),
> it had better initialize 'i' as 0 once before if/else statement.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/selinux/ss/sidtab.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 656d50b09f76..301620de63d3 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -374,7 +374,7 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>                                struct sidtab_convert_params *convert)
>  {
>         int rc;
> -       u32 i;
> +       u32 i = 0;
>
>         if (level != 0) {
>                 if (!edst->ptr_inner) {
> @@ -383,7 +383,6 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>                         if (!edst->ptr_inner)
>                                 return -ENOMEM;
>                 }
> -               i = 0;
>                 while (i < SIDTAB_INNER_ENTRIES && *pos < count) {

I must say I prefer the original version more, because it makes it
clear when you look at the loop that it starts at 0. Once you move the
initialization to the declaration section, readers will have to scan
the code upwards to find it out. As is, it's also less prone to error
if e.g. someone adds another loop before the existing ones and reuses
the variable.

In case anyone is wondering why I didn't make these for loops when I
wrote this code: Since the loop condition a little more than the usual
"for(i = 0; i < n; i++)" pattern, my intention was to emphasize that
this is not a "regular" for loop and that readers should read the loop
carefully to not miss something. But perhaps that's not a good reason
and they would look more natural as for loops. If others think a for
loop would look better here, I'd be OK with a patch that makes these
into for loops instead.

>                         rc = sidtab_convert_tree(&edst->ptr_inner->entries[i],
>                                                  &esrc->ptr_inner->entries[i],
> @@ -400,7 +399,6 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
>                         if (!edst->ptr_leaf)
>                                 return -ENOMEM;
>                 }
> -               i = 0;
>                 while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
>                         rc = convert->func(&esrc->ptr_leaf->entries[i].context,
>                                            &edst->ptr_leaf->entries[i].context,
> --
> 2.20.1
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

