Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63881C433EF
	for <selinux@archiver.kernel.org>; Fri, 28 Jan 2022 01:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbiA1Bow (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345146AbiA1Bov (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 20:44:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B566C061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 17:44:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l5so6620373edv.3
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 17:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYXIIUyrLfzJaPeKZf3W/sgGrDvN0wMAV7bAC7WPD3M=;
        b=1KTeQNu1m8qReF3FsqMysxKY1VxJzC4sYVTjAyHhsq+a1vlVLpM2YLsiNMZS0x3wXm
         Y0VJVuyXs9YWnnBcgzbPTYFgF617dw+mg/0Eb3g9Wmao8ObSTU2P1ITppGOx1iXWCCpw
         0DSwoAM6EKzCh3OJQA0PwxS1xJElPjgoBpclzHHZokRNXUmNdMN6JkPqR/Nala+VLtYB
         suqI6XxfkTZARJ+9S/b/C7d0dRPHa6UJ5D2iXTSQBpTd0NDRsxKzGiVG4SZaeKbEonVc
         Phanfy++vHctLte9yA7dBz+90Od82cx10pUo7k7Rz6AUjPn1YAIe5KVF5O17qkw0J7FX
         xj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYXIIUyrLfzJaPeKZf3W/sgGrDvN0wMAV7bAC7WPD3M=;
        b=ZZQ2OGVGBV8yJHYDBDMwo0Lgvj8H4q2Xag9MC6ITongVYuk5tFpbMw+q1zQHfJ7DzX
         3TifwgnS0gbAHZz1+2ygyBDL5qpZsc1TmnLWdR42/+Lo8+p3MQEEAm+DjxHuTZCI1j9O
         HLrZJOPZePufKMAwfBZiD6wphskmUmF4K1c3nbKswxujcBXaVF4bEeVqQDjCL0dzDNZs
         3WvKi0CJD03Vt6dlnNGQIru5M49y3HM96rKENtloGZgyUdLNH85Gz0mSUshb/Xo39WkS
         Q94pLg5XvqhTvXpkc5+JmVoAYB/9N3KzqMzIAEJndZt3drApaqGmZDNloBsH8vIWVKE9
         OC+A==
X-Gm-Message-State: AOAM532YAlScp2EAluXj83zIDgcOo0SQUm9xVXXdhJTFmoNYFOiFnuSV
        3eMYxsh+9m/Fvg/n+epWAZKQnJvWvJdgMr1TxiX1
X-Google-Smtp-Source: ABdhPJzjF/RplyACj/w8hLgXo1uknB2oGFSxj5v5sDp4f/gCdMO3xDPCBYlF1V1ov4ADLrAbCjCk2M9vJHrSvIe79xk=
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr6080257edd.405.1643334289633;
 Thu, 27 Jan 2022 17:44:49 -0800 (PST)
MIME-Version: 1.0
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com> <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com> <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
 <a19e0338-5240-4a6d-aecf-145539aecbce@schaufler-ca.com> <3daaf037-2e67-e939-805f-57a61d67f7b8@namei.org>
In-Reply-To: <3daaf037-2e67-e939-805f-57a61d67f7b8@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 20:44:38 -0500
Message-ID: <CAHC9VhSt+c6QksHef=kx3dN_ouVZG0_a6FERzXs2-uzKmyE_zg@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: general protection fault in legacy_parse_param
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 12:46 PM James Morris <jmorris@namei.org> wrote:
> On Thu, 27 Jan 2022, Casey Schaufler wrote:
>
> > The usual LSM hook "bail on fail" scheme doesn't work for cases where
> > a security module may return an error code indicating that it does not
> > recognize an input.  In this particular case Smack sees a mount option
> > that it recognizes, and returns 0. A call to a BPF hook follows, which
> > returns -ENOPARAM, which confuses the caller because Smack has processed
> > its data.
> >
> > The SELinux hook incorrectly returns 1 on success. There was a time
> > when this was correct, however the current expectation is that it
> > return 0 on success. This is repaired.
> >
> > Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>

Looks good to me too, thanks Casey.  Since James' already ACK'd it, I
went ahead and pulled this into selinux/next.

> > ---
> >  security/security.c      | 17 +++++++++++++++--
> >  security/selinux/hooks.c |  5 ++---
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 3d4eb474f35b..e649c8691be2 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -884,9 +884,22 @@ int security_fs_context_dup(struct fs_context *fc, struct
> > fs_context *src_fc)
> >       return call_int_hook(fs_context_dup, 0, fc, src_fc);
> >  }
> >
> > -int security_fs_context_parse_param(struct fs_context *fc, struct
> > fs_parameter *param)
> > +int security_fs_context_parse_param(struct fs_context *fc,
> > +                                 struct fs_parameter *param)
> >  {
> > -     return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
> > +     struct security_hook_list *hp;
> > +     int trc;
> > +     int rc = -ENOPARAM;
> > +
> > +     hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
> > +                          list) {
> > +             trc = hp->hook.fs_context_parse_param(fc, param);
> > +             if (trc == 0)
> > +                     rc = 0;
> > +             else if (trc != -ENOPARAM)
> > +                     return trc;
> > +     }
> > +     return rc;
> >  }
> >
> >  int security_sb_alloc(struct super_block *sb)
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 5b6895e4fc29..371f67a37f9a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2860,10 +2860,9 @@ static int selinux_fs_context_parse_param(struct
> > fs_context *fc,
> >               return opt;
> >
> >       rc = selinux_add_opt(opt, param->string, &fc->security);
> > -     if (!rc) {
> > +     if (!rc)
> >               param->string = NULL;
> > -             rc = 1;
> > -     }
> > +
> >       return rc;
> >  }

-- 
paul-moore.com
