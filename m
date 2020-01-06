Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD31C33C8C
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 19:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FDE2072E
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 19:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lEzKvhIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgAFTHV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:07:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46565 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgAFTHV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 14:07:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id q3so4393019otr.13
        for <selinux@vger.kernel.org>; Mon, 06 Jan 2020 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QFRvuleA9WtpvsAtXWm6tkQLzlSUPGr6FWwLguS1UA=;
        b=lEzKvhIXr91MXTb56cIlkCFdxIGfn1wb+leI7kAlqh505eQx4XIbbW3iXFDoCWKoxX
         mOs1RmmfTFgYe4yHHfYD5LFqNTnqFql2Z9xfShofUFB100OyFvlTyOnBVi0isgY42np+
         I3KRUr9CUlqMKEZfB4ML2hRvz09e1OWKb1IzXOYymrl1YuuK/orPoMuD8SspO5epfeNV
         jZiQOnOgEnzTDomie/0DSDsRM0aJGsNUjl+VGRcXFqGdOStmsEpbRjhkBlTbui3BZaX2
         OECTnWMxW+b6CIJIjP4wlg1tmyxD8AEwVuUKTOl6RPucnbR2nAVWVQpY6PMrHcwpMUw0
         Bpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QFRvuleA9WtpvsAtXWm6tkQLzlSUPGr6FWwLguS1UA=;
        b=sYHfCwFwkEYrBL2hxAJqNoOKVmIOiC3NpbIzgeJYb5JYi4oZ4D0crFmnu5COrw99Of
         +uBVwNf6BtOlBHqUAeMjK/cNcc3vHLOOy5zZKAZ1oWAbFNjKVLu1oa6ICLrL71dIyaaa
         fHR4CMZyVofL4sldu7yoTRcjwjwClLySHZJi7e2FTpl78s51fwWHuQhmfdsBjQq5Wqqe
         LS10yYi/Zw/7nz1ACT90oKm0C3Ub+1Vboj8H4h8In06JQYsWB0pqS9Lj9Yk2q+2xxkjT
         4dct8JgRGFVTfe0T2tCg3m7rS9ZnB6isxbPsEXEYzIhZzXL+DGdzkOnrAt1Lp/TPsVux
         xS8w==
X-Gm-Message-State: APjAAAVH/VD7pGYmaehWpiPUZfhezaprnWnNg1uNhXszC7brT6eoA7ki
        6r8NPqH84nGnKs0rUxQtnBRyiLhSi3iITY16RYLmYA==
X-Google-Smtp-Source: APXvYqw+VRmSCUpEIds5QED+DtM1KS2+eRws83HzlBVSSAISOci0Vwz/L50SKSyiLGt26WLuz7avtPw7YloHNkrxRHM=
X-Received: by 2002:a9d:3676:: with SMTP id w109mr100975180otb.35.1578337640469;
 Mon, 06 Jan 2020 11:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20200106181329.167322-1-hridya@google.com> <d78e4db4-5847-082c-189a-f13d7d6a6c7a@tycho.nsa.gov>
In-Reply-To: <d78e4db4-5847-082c-189a-f13d7d6a6c7a@tycho.nsa.gov>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Mon, 6 Jan 2020 11:06:44 -0800
Message-ID: <CA+wgaPMHWOVYo_pVeYuvj6CrQOgy9=vQco+tnGHjPX3=CLh5wA@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labelling for binderfs
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 6, 2020 at 10:33 AM 'Stephen Smalley' via kernel-team
<kernel-team@android.com> wrote:
>
> On 1/6/20 1:13 PM, Hridya Valsaraju wrote:
> > This patch allows genfscon per-file labeling for binderfs.
> > This is required to have separate permissions to allow
> > access to binder, hwbinder and vndbinder devices which are
> > relocating to binderfs.
> >
> > Acked-by: Jeff Vander Stoep <jeffv@google.com>
> > Acked-by: Mark Salyzyn <salyzyn@android.com>
> > Signed-off-by: Hridya Valsaraju <hridya@google.com>
>
> Do you want binderfs to also support userspace labeling of files via
> setxattr()?  If so, you'll want to also add it to
> selinux_is_genfs_special_handling() as well.

Thank you for the quick response Stephen :) I cannot think of a
use-case for the userspace labelling of files in binderfs via
setxattr() as of now. I
will make the change if one comes up!

Thanks,
Hridya


>
> > ---
> >   security/selinux/hooks.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 116b4d644f68..3f0669a708e9 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -752,6 +752,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
> >
> >       if (!strcmp(sb->s_type->name, "debugfs") ||
> >           !strcmp(sb->s_type->name, "tracefs") ||
> > +         !strcmp(sb->s_type->name, "binderfs") ||
> >           !strcmp(sb->s_type->name, "pstore"))
> >               sbsec->flags |= SE_SBGENFS;
> >
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
