Return-Path: <SRS0=JMXr=6K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B6C55199
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 20:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F88E2070A
	for <selinux@archiver.kernel.org>; Sun, 26 Apr 2020 20:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Sy4z4gpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZUxq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgDZUxq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 26 Apr 2020 16:53:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60AAC061A10
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 13:53:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id x1so12381614ejd.8
        for <selinux@vger.kernel.org>; Sun, 26 Apr 2020 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYxQZ/VHpUk8aDwHBEcN3uSkkcPD5n3vZowrXu2FAeU=;
        b=Sy4z4gpqV6TUvFmr/pkz8+ieCHMRewKeVFK62DCl35Y3hPotJjBEfNjD91NvhLOYLX
         gLm1tJSOdFse9LdkUruesBAqDZjE7rrR3UzJRo7DgvI+HQYbLA+in/1MKXWLb99jr88x
         EP7wMhTl7yTbyrpDVbmN4hW4GiYjMQ/FhwYCnLKDTigwEN7ZXfnqAnkEelPFYXBYQayP
         A0Hd1vaZORvjLbR/2paKr3Zl35DdzW1nDBKPNyCbdPs4/qoPPbVepCPGUMo9BtZ8oEcc
         uQwzDEHRtUXj79b+MUzimz5Fq9WsIE74poJsLbVfcGWjyrLOIRuIpcGA5NL/3stSsfEN
         YhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYxQZ/VHpUk8aDwHBEcN3uSkkcPD5n3vZowrXu2FAeU=;
        b=XVRk3jl8k41xXchjJxDsX4tIVJFDVfdRXj5h8Tyeq5oGI7lRc15GLlpv7KAGfUtzEx
         4NoCfNJFtdPiereeZWoZPRj/skcFWnIrtIVoZ2fZqdevJZo0DXmzY7fUHmvkW1+VjZW5
         gjlHigeFIQxwqESY07z2qaBtS0L4BgxJKhlatYM6R5S4DAYNdxkYFIkS/sb31DlJVItM
         ga/dY1z3Y3EioB7bGIGqjS19dGJMDmp2gpGMdAPW1QZWdrSyzgQTYKFp6h5eXMpboLnZ
         gy4bdV5p8AoSD7ShGAEQytYdo5zMJpwHI5i00kEUWYfG4tTP+YK2Ms9m827ckZNIvqPU
         KiCA==
X-Gm-Message-State: AGi0PubQgQCZ0nGBI8hJNhO2GPbH2n2Hb9cHaHKjQIUQ8xqXlQ4HgLdP
        XD8tCAUrZux5cVTr3Sv0ej/nDG+KUE0jSROHGvg/j68=
X-Google-Smtp-Source: APiQypIJlgiOpUQWYhXR+TxCE9I+Jva/bGBysjYgG9WxNNhmxM6BP0Ce/ZNDFxdarW7taG1wVPDyn+jJml3Pgf39OwY=
X-Received: by 2002:a17:906:35d0:: with SMTP id p16mr16322444ejb.77.1587934422126;
 Sun, 26 Apr 2020 13:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
 <3834193.1587771802@warthog.procyon.org.uk>
In-Reply-To: <3834193.1587771802@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 26 Apr 2020 16:53:31 -0400
Message-ID: <CAHC9VhQbhG8-ZABtkZr1FXo9cuH4_nsbB=HP_fGvW+FNQ7iAXg@mail.gmail.com>
Subject: Re: Problem with 9ba09998baa9 ("selinux: Implement the watch_key
 security hook") in linux-next
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 24, 2020 at 7:43 PM David Howells <dhowells@redhat.com> wrote:
>
> Paul Moore <paul@paul-moore.com> wrote:
>
> > > > and then use this newly created mapping function in [...]
> > > > selinux_watch_key()
> > >
> > > No, I think I should just hard-code KEY__VIEW there.
> >
> > FWIW, my comment was based on a version of linux-next where you were
> > making policycap based permission adjustments to KEY_VIEW and I
> > thought you would want the same adjustments to be applied to both
> > access control points.  That code appears to now be gone in
> > linux-next.
>
> I don't think I changed KEY_VIEW specifically; anyway, that code is on hold
> for the moment since it collides with this.
>
> What I was wondering is if I should change KEY_NEED_xxx from a bitmask into an
> enum to remove the confusion about whether or not you're allowed to provide
> multiple 'needs' OR'd together.
>
> > > +       perm = selinux_keyperm_to_av(need_perm);
> >
> > ... and add a check for (perm < 0) as discussed above if we stick with
> > the switch statement.
>
> Actually, there was supposed to be a:
>
>         if (!perm)
>                 return -EPERM;
>
> after that line.

Okay, can you send the next version of the patch to the SELinux list for review?

Thank you.

-- 
paul moore
www.paul-moore.com
