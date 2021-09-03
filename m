Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75DAC433F5
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 12:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE7861057
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 12:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhICMi5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Sep 2021 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhICMi5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Sep 2021 08:38:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81172C061575
        for <selinux@vger.kernel.org>; Fri,  3 Sep 2021 05:37:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso6357067otv.12
        for <selinux@vger.kernel.org>; Fri, 03 Sep 2021 05:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJ+Y30HQd8LYryA6jr3Q3Ewfa19wzK/9k73N0BrOu6I=;
        b=cOckqL753OJdmFwCc04dG3sYf04FXB30fJGmFWJ2gRLE0IPEB7gyXnCJHRPC8UekXY
         lQmj87Kii3V6nZxeU+a2gG/9DYEfb3lBehqUS++AqpeDam2beBNz4KLpMBxHSMR9sOd/
         EuVVqyzr+RAP8Pw+vFi1fTMnzsyR68ZBqUjWYEzNjvVLhGILiZ0Hkq4pfwl4TjqkmwA/
         HDeoQfYZmEuwHBfbb9f7vl+M8EL7Oci/JFtNOi8jJANqxpXFm8TQ4c0FpzpcigFZY9hM
         5fsp8zXv21q/7oJOsNiXnIxkl2LbcVKDBcRbSl6IGQwTqq+f3Eno5T69Y6GkdsaD3qKt
         hLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJ+Y30HQd8LYryA6jr3Q3Ewfa19wzK/9k73N0BrOu6I=;
        b=rIcHlvm7s4dPWLvA7csuOphCWjrjpP0lpTzLI+KCOSaLAa0rpkL5oecIoIcFXAz3lz
         WP5LZWymOwa/C6roR6xVO70/un+IVxuqvNNUWI4Jwnn9YCCIcaCIepG6HZXfrhRWwctf
         Zsdm47cowngDPFDsbXvGYa+hTkDEHQcVpZ3qJKVnTXuKuwrenPakCs0TzRERFTwsBIjd
         S0eDjLoYQsOTMbqHQitODT9SEXbmUD6+yPiPSeGelkptKw1uKE4llfmzewMSOiFr5pdd
         /4wrW6vPr3B/0QAzaKxyjt/TJmF6Fmzd1DjDDC1mwcT9o1oPUMcj0l+dFDFavxJzyoGF
         gU4Q==
X-Gm-Message-State: AOAM533Su98ShTnzKNM3JmF/Us2Gqx9vzeGer4hp9JbrSaebcyelpcF6
        d7s0ETKHBKGix1DOODBIYFtYsDbrMbVDo/C45OA=
X-Google-Smtp-Source: ABdhPJzeW/USbYIxoQo9TwocONrtmJxdisv/PLl0aqHQKwXLVRlkVm+oN/GpaZDqfsVk1fypee63crQfovjfKieOVY4=
X-Received: by 2002:a05:6830:1f0a:: with SMTP id u10mr2964854otg.53.1630672676906;
 Fri, 03 Sep 2021 05:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <87fsvmu2xa.fsf@redhat.com> <87zgsu9j9c.fsf@redhat.com> <87pmtq8374.fsf@defensec.nl>
In-Reply-To: <87pmtq8374.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 3 Sep 2021 08:45:27 -0400
Message-ID: <CAP+JOzSmoDp_9XhoXXghu9HL=H3iXPFWAVkN_AnDxbhdDRRF2g@mail.gmail.com>
Subject: Re: lets think about 3.3 release
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 3, 2021 at 4:38 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Petr Lautrbach <plautrba@redhat.com> writes:
>
> > Petr Lautrbach <plautrba@redhat.com> writes:
> >
> >> Hello,
> >>
> >> I's about 184 commits and 5 months since the last release so I think
> >> it's time to slowly stop the development and start with 3.3 release
> >> candidates.
> >
> >
> > Currently patchwork contains just these patches which should be relevant
> > to 3.3:
> >
> > https://patchwork.kernel.org/patch/12435365/ New [1/2] libsepol/cil:
> > Improve in-statement to allow use after inheritance
> > https://patchwork.kernel.org/patch/12435363/ New [2/2] libsepol/secilc/docs: Update the CIL documentation
>
> Strictly speaking these can probably wait until after 3.3 although it would
> be nice to get this in.
>
> Maybe eventually some day in the distant future we can re-consider
> disallowing duplicate macro and block declarations in favor of this functionality.
>
> >
> > These are probably superseeded already, but I'm not sure. Please take a look.
> >

They are waiting for the three patches below, so they can all be
merged together.

> >
> > https://patchwork.kernel.org/patch/12470297/ New [1/3,v2] libsepol/cil: Remove redundant syntax checking
> > https://patchwork.kernel.org/patch/12470301/ New [2/3,v2]
> > libsepol/cil: Use size_t for len in __cil_verify_syntax()
> > https://patchwork.kernel.org/patch/12470299/ New [3/3,v2]
> > libsepol/cil: Fix syntax checking in __cil_verify_syntax()
> >
> > Wait for review.
> >

The only changes are what Nicolas suggested when he reviewed them, so
I don't think it will be too long before these will be merged. I don't
have anything else other than these.

Jim




> > So I think selinux-3.3-rc1 can be released on next Wednesday 2021-09-08
> >
> > If you have any concerns, comments or suggestion, let us know.
> >
> > Also I really don't understand all the changes in libsepol so please help me
> > to collect release notes information for it. I'll post a release notes
> > draft with other components later today.
> >
> >
> > Thanks,
> >
> > Petr
> >
> >
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
