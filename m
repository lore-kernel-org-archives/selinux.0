Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08DBC433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 20:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E582065E
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 20:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blr+fAhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgHDUU2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgHDUU2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 16:20:28 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3DDC06174A
        for <selinux@vger.kernel.org>; Tue,  4 Aug 2020 13:20:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z22so6912173oid.1
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2020 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uku6k7czFxYwBRzp1XBmy92JDklLtLo7BirOqX+E+2M=;
        b=blr+fAhGzT2zCBP95cFe3xZfevvQh+9qMQlHQ4aR3cFbTCZuezG78RC7pfTkrKqBu1
         Hx3rDNBYa9IvyTVuLj5s3sEGCkh9LIB8g/X2EV/1MQvWegGwLtZs3G+m/OpjnUp3ucGS
         z9oe4LT6pR4CEURhG4ZvZdDz2aAqcHsZRWM11LAtAVTNBetwAha2WJc5VgMl3393x5c9
         ajH8+lLnE3ffZus0B7g+4vYxyVwn1GXXHBh4CCKPs0mrnv8w9hzrj3bZKVpWWYaIq9DA
         +QSyHeJKLhzqv3vkylWPQbXQpdEFzBSmVHR4QplQtsrLCPg87UUYvYOQabjHivzU0rEO
         72ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uku6k7czFxYwBRzp1XBmy92JDklLtLo7BirOqX+E+2M=;
        b=FbfMc72WistD/UkdsTMtBE0iNzEqDuNdfYas/RYBNOtGCBzRUYAwBKpk9yB5q+6EL7
         fZSx5seFPPpKjD1YhVeI9xnxogqYcnaOgf98vp2zP+XyLZNH4GGFU8X2BvYtov+oL8kL
         WTEDk8LVNuBqYYfuWXkcfWYyY6NSv6ZjY+pdclHEF4kNsF/MdxVD7YwJVqU82SkjIaO0
         RfBFtHyoPdB9kDOERcWAqlTyKvUt+vdxzutPvyWpdqRX45fTIqDk805o9O1Pv5P4W+4J
         vISdgVfr1FB1zc4P9FHzlUaiKmfIJu93djB7dcCl8t4V6kLB4XcIXlVR0wv90PWn+0uQ
         zSPA==
X-Gm-Message-State: AOAM532eGjCxYzczr/oI+66UEaHqKW8cUdPTb8F6XfLJB4XcJIJpchUa
        K7Y0Xr6gdmwpjERPKl6tDiZIZQKRYVJjg+ivHSs=
X-Google-Smtp-Source: ABdhPJyTPDXRcOuDfp1jeovfY7qOCPxEqKxu6LuaY6DhVhp4STviGXGE4ccRwkk8Md00HZb2lUFIDH2zv5Slb3V6k98=
X-Received: by 2002:aca:cd05:: with SMTP id d5mr95171oig.138.1596572427420;
 Tue, 04 Aug 2020 13:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
 <20200802123421.222597-1-dominick.grift@defensec.nl> <CAP+JOzQ=wnAWHp7i6OVjpV58QxdFPT63ON7HOLuVHjoL8O2Oqg@mail.gmail.com>
 <ypjlft9298vi.fsf@defensec.nl> <CAP+JOzRgJmD8NE-_nY118G_h7B70Y70=jT1n8TimcMGPjDYFxw@mail.gmail.com>
 <ypjlbljq8l9d.fsf@defensec.nl>
In-Reply-To: <ypjlbljq8l9d.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 4 Aug 2020 16:23:41 -0400
Message-ID: <CAP+JOzRUPpWXXmmuX5zdS1qCCbhpAXm8uO9JXvy+pYeBOoGbnA@mail.gmail.com>
Subject: Re: [PATCH v4] secilc/docs: document expandtypeattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 4, 2020 at 11:48 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Tue, Aug 4, 2020 at 3:18 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >> James Carter <jwcart2@gmail.com> writes:
> >>
> >> > On Sun, Aug 2, 2020 at 8:39 AM Dominick Grift
> >> > <dominick.grift@defensec.nl> wrote:
> >> >>
> >> >> This was added for Androids Treble in 2017.
> >> >>
> >> >> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> >> >> ---
> >> >> v2: overriden is overridden
> >> >> v3: add link to README.md
> >> >> v4: rephrase and add another example
> >> >>
> >> >>  secilc/docs/README.md              |  1 +
> >> >>  secilc/docs/cil_type_statements.md | 44 ++++++++++++++++++++++++++++++
> >> >>  2 files changed, 45 insertions(+)
> >> >>
> >> >> diff --git a/secilc/docs/README.md b/secilc/docs/README.md
> >> >> index 3f1838e6..efab2a71 100644
> >> >> --- a/secilc/docs/README.md
> >> >> +++ b/secilc/docs/README.md
> >> >> @@ -126,6 +126,7 @@ CIL (Common Intermediate Language)
> >> >>    * [typealiasactual](cil_type_statements.md#typealiasactual)
> >> >>    * [typeattribute](cil_type_statements.md#typeattribute)
> >> >>    * [typeattributeset](cil_type_statements.md#typeattributeset)
> >> >> +  * [expandtypeattribute](cil_type_statements.md#expandtypeattribute)
> >> >>    * [typebounds](cil_type_statements.md#typebounds)
> >> >>    * [typechange](cil_type_statements.md#typechange)
> >> >>    * [typemember](cil_type_statements.md#typemember)
> >> >> diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
> >> >> index f9dd3a76..41f0f01a 100644
> >> >> --- a/secilc/docs/cil_type_statements.md
> >> >> +++ b/secilc/docs/cil_type_statements.md
> >> >> @@ -213,6 +213,50 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
> >> >>          )
> >> >>      )
> >> >>
> >> >> +expandtypeattribute
> >> >> +-------------------
> >> >> +
> >> >> +Overrides the compiler defaults for the expansion of one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers.
> >> >> +
> >> >> +Note that this statement can be overridden at compile-time with `secilc -X SIZE` and that this functionality is not intended to override `secilc -X SIZE` for individual type attributes!
> >> >> +
> >>
> >> <snip>
> >> > When the value
> >> > is false, the type attribute will not be removed from the policy, even
> >> > if the default expand rules or "-X" option cause the rules involving
> >> > the type attribute to be expanded.
> >>
> >> Yes but I cannot produce that. In my earlier test the type attribute
> >> was expanded regardless of the -X option.
> >>
> >> In my test I instructed secilc to expand all attributes with more than 3
> >> members (-X 4), then I added a expandtypeattribute statement telling
> >> secilc to not expand pets and colors.
> >>
> >> The result was that it expanded pets and colors anyway.
> >>
> >
> > I see the source of your confusion now. "-X 4" means that all
> > attributes with LESS than 4 types associated with it will be expanded.
>
> I think its important to clarify this in the documentation. ie:
> expandattribute false will not work if you use -X (-X will override the
> false statement)
>
> I think that is unintuitive, I would actually want to be able to for
> example expand all attributes with less then 4 members except a few
> specific ones.
>

It is poorly named at this point. I think it was a victim of multiple
changes over time. A better name now would be removeattribute. That
would be more accurate, because what is really being controlled is
whether the attribute is kept as defined in the policy or not.

I am not sure what advantage there would be to expanding and removing
all except a few selected attributes with less than 4 members, except
for the case when you needed those selected attributes to remain
defined in the policy.  Not much space is going to be saved by not
expanding them. Ok, I guess the advantage would be that the name of
the rule would make more sense. I will grant that.

At any rate, the name stinks, but the functionality is exactly what is
needed. I can trade a large policy for quicker access checks by using
the "-X SIZE" option and I can retain the definitions of the
attributes that need to be defined using expandattribute false.

This whole discussion is why keeping the selinux-notebook in sync with
language changes will be very valuable practice.

Thanks,
Jim

> >
> > Jim
> >
> >> >
> >> > Thanks,
> >> > Jim
> >> >
> >> >> +**Statement definition:**
> >> >> +
> >> >> +    (expandtypeattribute typeattribute_id true|false)
> >> >> +
> >> >> +**Where:**
> >> >> +
> >> >> +<table>
> >> >> +<colgroup>
> >> >> +<col width="25%" />
> >> >> +<col width="75%" />
> >> >> +</colgroup>
> >> >> +<tbody>
> >> >> +<tr class="odd">
> >> >> +<td align="left"><p><code>expandtypeattribute</code></p></td>
> >> >> +<td align="left"><p>The <code>expandtypeattribute</code> keyword.</p></td>
> >> >> +</tr>
> >> >> +<tr class="even">
> >> >> +<td align="left"><p><code>typeattribute_id</code></p></td>
> >> >> +<td align="left"><p>One or more previously declared
> >> >> <code>typeattribute</code> identifiers. Multiple entries consist of
> >> >> a space separated list enclosed in parentheses '()'.</p></td>
> >> >> +</tr>
> >> >> +<tr class="odd">
> >> >> +<td align="left"><p><code>true | false</code></p></td>
> >> >> +<td align="left"><p>Either true or false.</p></td>
> >> >> +</tr>
> >> >> +</tbody>
> >> >> +</table>
> >> >> +
> >> >> +**Examples:**
> >> >> +
> >> >> +This example uses the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
> >> >> +
> >> >> +    (expandtypeattribute domain true)
> >> >> +
> >> >> +This example uses the expandtypeattribute statement to not expand
> >> >> previously declared `file_type` and `port_type` type attributes
> >> >> regardless of compiler defaults.
> >> >> +
> >> >> +    (expandtypeattribute (file_type port_type) false)
> >> >> +
> >> >>  typebounds
> >> >>  ----------
> >> >>
> >> >> --
> >> >> 2.28.0
> >> >>
> >>
> >> --
> >> gpg --locate-keys dominick.grift@defensec.nl
> >> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> >> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> >> Dominick Grift
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
