Return-Path: <SRS0=gjoR=CU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D2CC43461
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8D1223EA
	for <selinux@archiver.kernel.org>; Fri, 11 Sep 2020 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="b0V/gW4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725918AbgIKO5U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgIKO4b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Sep 2020 10:56:31 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6101C0612F4
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:52:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b12so10223801edz.11
        for <selinux@vger.kernel.org>; Fri, 11 Sep 2020 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCqqhHtE89rYvILDb1OrmtXnMHcYLW5OuH1doLV8Gng=;
        b=b0V/gW4L7mkZTOccBaKiIR/GnE5HpuaEs2YO5oCQdm6S3TKutuVeVqWhzbU6XpdeWU
         Fn1BDJjrzjXsh7Wwy0HUudxxomO+M+gcJaZpHDhTZgyKGU7lLaFdjWph/z1h3BHXXEmR
         C3ouK5qjFEw17+lB074HeJAz0ubWg2xNARBV5i/ZmsDSTRUzEy4Tb+1F+4nWN7h1MUnJ
         woiyje3aHRky/et10FmSyI6p4HFfZGZA5rmeVKm/0ajZwe1p3Ma+lUvY7C3d4RKvFuqJ
         M3v04XUICurNxZSJqcYeTDxdCYnFo95qakl3Zkbw2y0yjth/czqXOuiU89liGIwc9A78
         bpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCqqhHtE89rYvILDb1OrmtXnMHcYLW5OuH1doLV8Gng=;
        b=ZTt3zd8kafn0xO1Mkc87gPg1XQZSxqJyIJo+h5hJk4JEp91U6TZ4yy/3Ivdvt2wTOv
         3sWd4FgWYdN1rXtXsxRkIlQzKnMBp5jyHMOCdkCItDJ48vxsdEm5ztvA9j20uIXVLsdo
         1N94wHzExH565TfeyGYemNuPclJVA/5kf5uHN8ZgHtSVnpGYn3G/ndhoC6ksE/AW1F+V
         yO9dXwDVRJTKK/zoXTXYyHY4zkvvaLZ8kliRLN1xSd2GNc1NWQuv0KCB0pG8FlnqiYkv
         aB5a9m9nls+tWTSNCnFYVCUQxFWdZXw9VNbaUlXiqLgmveEBM5KV1z9JlnlVW7l4F9Gf
         2x/g==
X-Gm-Message-State: AOAM533+kOmscHSFHckuTDmr3ByiTp4MuL+8ntKtw2fodvJxtvhxngU6
        leRSzWbPj2ll+Alp2wwyf5iuMR8OhAUS2HwaIsVK
X-Google-Smtp-Source: ABdhPJyl9/01B7MQDSrYftumkCggqMxwLT5PvjIdG1foWybKJcZYAIE3URChhgSUFKQe/btPHvYDLvfIVzAgkGqUJfc=
X-Received: by 2002:aa7:ce97:: with SMTP id y23mr2495962edv.128.1599835956162;
 Fri, 11 Sep 2020 07:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200909222822.23198-1-nramas@linux.microsoft.com>
 <CAHC9VhSZiuHHg+oJPcaRLoZaDhARgiJ2PN5LiMHcVk1yB0a+ng@mail.gmail.com> <CAEjxPJ7Q+7mBh1hjY7sZiEAjX7Z8afrpzMP6UTwDrO3=pKVoRQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Q+7mBh1hjY7sZiEAjX7Z8afrpzMP6UTwDrO3=pKVoRQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Sep 2020 10:52:24 -0400
Message-ID: <CAHC9VhQ2QXWZZhDV03tQg7ZYo0ARS4htEe0Ls0Amnojzgqriyw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Add helper functions to get and set checkreqprot
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 11, 2020 at 10:23 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Sep 11, 2020 at 10:07 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Sep 9, 2020 at 6:28 PM Lakshmi Ramasubramanian
> > <nramas@linux.microsoft.com> wrote:
> > >
> > > checkreqprot data member in selinux_state struct is accessed directly by
> > > SELinux functions to get and set. This could cause unexpected read or
> > > write access to this data member due to compiler optimizations and/or
> > > compiler's reordering of access to this field.
> > >
> > > Add helper functions to get and set checkreqprot data member in
> > > selinux_state struct. These helper functions use READ_ONCE and
> > > WRITE_ONCE macros to ensure atomic read or write of memory for
> > > this data member.
> > >
> > > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  security/selinux/hooks.c            |  6 +++---
> > >  security/selinux/include/security.h | 10 ++++++++++
> > >  security/selinux/selinuxfs.c        |  5 +++--
> > >  3 files changed, 16 insertions(+), 5 deletions(-)
> >
> > ...
> >
> > > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > > index cbdd3c7aff8b..cc29177c8858 100644
> > > --- a/security/selinux/include/security.h
> > > +++ b/security/selinux/include/security.h
> > > @@ -143,6 +143,16 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
> > >  }
> > >  #endif
> > >
> > > +static inline bool checkreqprot_enabled(const struct selinux_state *state)
> > > +{
> > > +       return READ_ONCE(state->checkreqprot);
> > > +}
> > > +
> > > +static inline void checkreqprot_set(struct selinux_state *state, bool value)
> > > +{
> > > +       WRITE_ONCE(state->checkreqprot, value);
> > > +}
> >
> > This is a nitpick, and I recognize that Stephen already suggested the
> > use of "*_set()" and "*_enabled()" for names, but if we are going to
> > name the setter "*_set()" let's also name the getter "*_get()".
>
> I just suggested that we be consistent with the existing naming for
> enforcing_*(), which I thought came from you?

I vaguely remember having a discussion around the naming back then,
but I can't recall who preferred what and when.  I'm sure it's all in
the archives for anyone who cares to look.

Regardless, I think _set() and _get() make the most sense here.  I can
also see an argument being made for "_enabled()" on some bigger flags.
My personal opinion is that the SELinux kernel code, and kernel code
in general, is a bit of a mess when it comes to naming consistency.
Considering the age, size, and number of contributors the current
state really shouldn't be too surprising (and honestly it isn't that
bad considering everything).  Perhaps someday we can look at that, but
that is so far down the priority list it isn't worth discussing; I'd
tackle the coding style inconsistencies before this.

-- 
paul moore
www.paul-moore.com
