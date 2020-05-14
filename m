Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B61C433E0
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 16:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE186206DC
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 16:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN7714xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENQgo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 12:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgENQgo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 12:36:44 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DFCC061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 09:36:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id a2so24880073oia.11
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2+RcUXymnoY7T7A56Sw6sq3CfPYLARR8OkKyfk6quyI=;
        b=UN7714xmgWyC12GZnHZQHCu9bwjsChNUBCDQwDR40d2DUy3ac405j76qI51NCQp4RG
         xRojXAYy6Zy0/0M+rpapFUIIZYWePPNIpMCXyHE3Ov4Ve2dl6aHj0e8fsahQxZSx2BzM
         g7Prj6sluXhsR5G4vS+9vHBNR416AEkEFphr4GwskSuaKjd3cAXQEqzNwphuaO+y4XZg
         XBGPpLOMlGqmw2Kl6YceNaajj3M9GMgvjc34TGAjrMjkDyrKoP5/KpQIMTbayCIImCic
         Akbl1HGWR9L2BKf3kkPgaX4eWkDxSTkKVH9hUHMzLK99m1ztp3aa2LYT1ieHWo+b76sZ
         zC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2+RcUXymnoY7T7A56Sw6sq3CfPYLARR8OkKyfk6quyI=;
        b=gkJtGK6NFRG1YfXX/P0VU/PGq//89/kWv+hlb94FBEeE7rTpm5RTg5ASrF9Uu9LGlL
         Wlg1lgBDE+Z3O5xM5P5v7a0bBSDUgaBkvPk6Rm/HcpGio8zn6X1A5vAGGQ9Ny1QLIFeB
         SqwnDD/vdSeyjrvx8syhtp4CYzfcgC9DGcAsO0fTY3s+mRNBc451q8579hHisdYb7bS9
         VqBIHDQRMx6o9Aze1iDCQMzoieDHwTEi5j9nXWj0+CUxZfMjJ3yNvLlltMZxm5o95G+m
         QXAghPes7JUVa2hfcbiT7vNl4GD3yX+1BeyGsfvbD5xBmGn5bxxxBCdyWbqE2iVcbyWP
         3xKQ==
X-Gm-Message-State: AOAM5336UsT71xwwutI883BhnQ+CTknpXvMKP5g8dPI9St8PUz9dGPBA
        n6mjZ4I0jROq/b7goTFSmdgHlLYmXLoOAZUVXbwHg84W
X-Google-Smtp-Source: ABdhPJyEx2ILuD7KaJI3qQbFlPhqE5pGs+dY98Y6WiFp/joQboBtR8V2YfbSkkq8w/jgd1vKzNp1lXMOw+3jIbq2t5E=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr3300778oif.140.1589474203611;
 Thu, 14 May 2020 09:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200514160922.37513-1-cgzones@googlemail.com>
In-Reply-To: <20200514160922.37513-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 14 May 2020 12:36:32 -0400
Message-ID: <CAEjxPJ45DbP_JmJO72s76TEuzvSA7E3qzaW9A=HwuaS+nU9ckA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add note to avoid permissions with _perms suffix
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 12:09 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The suffix "_perms" is used in Referency Policy style policies for
> permission macros, bundling several single raw permissions.
>
> Add a note to not confuse policy writers/readers.

I don't really see a valid justification and I wouldn't recommend
doing this via a comment alone if it were justified.
The kernel shouldn't be tied to refpolicy since refpolicy is merely
one SELinux policy configuration albeit widely used as the base for
most Linux distros (but not Android). If we were going to enforce a
naming convention on the classes/permissions, we should do it via a
build-time check using the existing scripts/selinux/genheaders program
that generates the symbols from classmap.h that are used by the kernel
code.  And this particular case seems highly improbable - who would
name a permission with a "_perms" (plural) suffix especially since no
other kernel permission has been so named to date.  The comment is
also a bit confusing since it occurs immediately before a macro that
ends in _PERMS is defined, but that macro presents no problem since it
is purely kernel-internal.  Absent some motivating example of where we
have broken refpolicy in the past, I can't see why we need this.

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/classmap.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 986f3ac14282..b06ea7b23760 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -2,6 +2,11 @@
>  #include <linux/capability.h>
>  #include <linux/socket.h>
>
> +/*
> + * Note: The name for a permission should not end with the suffix "_perm=
s",
> + *       to prevent confusion with Refpolicy style permission macros.
> + */
> +
>  #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
>      "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", =
"map"
>
> --
> 2.26.2
>
