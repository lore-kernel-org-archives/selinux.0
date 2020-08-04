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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C5C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 14:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4FE206DA
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faGo8kzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgHDOpb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgHDOpS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 10:45:18 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAACC06174A
        for <selinux@vger.kernel.org>; Tue,  4 Aug 2020 07:45:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q9so15083514oth.5
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2020 07:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ec+XWOJhBRLLw0C/hyTyOsZxelgJJktTL0zEZrLmhxE=;
        b=faGo8kzj/aeYkOXuJShw1GL0Alh5i/g8kb3JE2Xaoitpaf/dyqt90AC18bmGik7pej
         yFppp9ohyB2w9u02s4K2CY6dhLXTTcidr9+AwVsPEoIZ+7sdfTdqJ858FHucTMcg+ksS
         kzyYiZiS7BBUvTD2lqhWYZP2Hf8MAdNvN3YCWxz1NFncsgkXOe+Yhi++LA3ng/T+GrxT
         RTZzU5nqt8xYkuBs7cxLSTYjKxPVTYOGtWmo6ORXDWPxrW1wQ89ftVEBo5utHfEmUBcw
         cPKB3YGXUT7y7x5VSVKgF9uWUJPOQeW8vlxYzIAoe4e3IbYyTH2/eXiBcuFlsC8wiYwF
         0Sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ec+XWOJhBRLLw0C/hyTyOsZxelgJJktTL0zEZrLmhxE=;
        b=sl0L5lISLB20Uq6hZsFgI75lX5LAJRMSCyjFteJK30mwtlMbSKPZ4sRWoYd7x9+iYW
         HbZKsMoTR+5qglAX98eohMf5SLIkDysvAuWh1FStgk0eM7wDS6r8x1ElBRq9BQ773vgf
         JlSS2Fjm197ToVKxLZju3mGUKLoLdhBEgRqHapO4w5ATQlChKb0f9L8AAJPoEw268eNp
         MbvjLMtKfq9ZqcAdHvW9ilXXh/+egk6eZ5j7X+ZO/I8y+FpQtDELFM8aL8Md7Ag3bigw
         oZhSoiW5KalxVAkYa8R02EBHkW9w6KnShqlWxNFC4hv4dLjHng2qrHCOSTQl7a9PgCEm
         AoBw==
X-Gm-Message-State: AOAM5317PnA+vqqD+aS78K/nTBeUgMZKrngyEuu0GDEKAkJejDFyt3is
        /0p18ngDGs5ZHwKCkM8Z2ktA77qLFSbFv7UzedGlkQ==
X-Google-Smtp-Source: ABdhPJzwmbkVW0sYsNhMfTrXxnkB11KYeG0Alq0Lb48RaNp6P0Tax0Cs7kdpNKPeAiYS6yqEHGC5qQdVHcoRBki2R6o=
X-Received: by 2002:a05:6830:209a:: with SMTP id y26mr2626020otq.59.1596552317336;
 Tue, 04 Aug 2020 07:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
 <20200802123421.222597-1-dominick.grift@defensec.nl> <CAP+JOzQ=wnAWHp7i6OVjpV58QxdFPT63ON7HOLuVHjoL8O2Oqg@mail.gmail.com>
 <ypjlft9298vi.fsf@defensec.nl>
In-Reply-To: <ypjlft9298vi.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 4 Aug 2020 10:45:06 -0400
Message-ID: <CAP+JOzRgJmD8NE-_nY118G_h7B70Y70=jT1n8TimcMGPjDYFxw@mail.gmail.com>
Subject: Re: [PATCH v4] secilc/docs: document expandtypeattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 4, 2020 at 3:18 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Sun, Aug 2, 2020 at 8:39 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >> This was added for Androids Treble in 2017.
> >>
> >> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> >> ---
> >> v2: overriden is overridden
> >> v3: add link to README.md
> >> v4: rephrase and add another example
> >>
> >>  secilc/docs/README.md              |  1 +
> >>  secilc/docs/cil_type_statements.md | 44 ++++++++++++++++++++++++++++++
> >>  2 files changed, 45 insertions(+)
> >>
> >> diff --git a/secilc/docs/README.md b/secilc/docs/README.md
> >> index 3f1838e6..efab2a71 100644
> >> --- a/secilc/docs/README.md
> >> +++ b/secilc/docs/README.md
> >> @@ -126,6 +126,7 @@ CIL (Common Intermediate Language)
> >>    * [typealiasactual](cil_type_statements.md#typealiasactual)
> >>    * [typeattribute](cil_type_statements.md#typeattribute)
> >>    * [typeattributeset](cil_type_statements.md#typeattributeset)
> >> +  * [expandtypeattribute](cil_type_statements.md#expandtypeattribute)
> >>    * [typebounds](cil_type_statements.md#typebounds)
> >>    * [typechange](cil_type_statements.md#typechange)
> >>    * [typemember](cil_type_statements.md#typemember)
> >> diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
> >> index f9dd3a76..41f0f01a 100644
> >> --- a/secilc/docs/cil_type_statements.md
> >> +++ b/secilc/docs/cil_type_statements.md
> >> @@ -213,6 +213,50 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
> >>          )
> >>      )
> >>
> >> +expandtypeattribute
> >> +-------------------
> >> +
> >> +Overrides the compiler defaults for the expansion of one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers.
> >> +
> >> +Note that this statement can be overridden at compile-time with `secilc -X SIZE` and that this functionality is not intended to override `secilc -X SIZE` for individual type attributes!
> >> +
>
> <snip>
> > When the value
> > is false, the type attribute will not be removed from the policy, even
> > if the default expand rules or "-X" option cause the rules involving
> > the type attribute to be expanded.
>
> Yes but I cannot produce that. In my earlier test the type attribute
> was expanded regardless of the -X option.
>
> In my test I instructed secilc to expand all attributes with more than 3
> members (-X 4), then I added a expandtypeattribute statement telling
> secilc to not expand pets and colors.
>
> The result was that it expanded pets and colors anyway.
>

I see the source of your confusion now. "-X 4" means that all
attributes with LESS than 4 types associated with it will be expanded.

Jim

> >
> > Thanks,
> > Jim
> >
> >> +**Statement definition:**
> >> +
> >> +    (expandtypeattribute typeattribute_id true|false)
> >> +
> >> +**Where:**
> >> +
> >> +<table>
> >> +<colgroup>
> >> +<col width="25%" />
> >> +<col width="75%" />
> >> +</colgroup>
> >> +<tbody>
> >> +<tr class="odd">
> >> +<td align="left"><p><code>expandtypeattribute</code></p></td>
> >> +<td align="left"><p>The <code>expandtypeattribute</code> keyword.</p></td>
> >> +</tr>
> >> +<tr class="even">
> >> +<td align="left"><p><code>typeattribute_id</code></p></td>
> >> +<td align="left"><p>One or more previously declared
> >> <code>typeattribute</code> identifiers. Multiple entries consist of
> >> a space separated list enclosed in parentheses '()'.</p></td>
> >> +</tr>
> >> +<tr class="odd">
> >> +<td align="left"><p><code>true | false</code></p></td>
> >> +<td align="left"><p>Either true or false.</p></td>
> >> +</tr>
> >> +</tbody>
> >> +</table>
> >> +
> >> +**Examples:**
> >> +
> >> +This example uses the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
> >> +
> >> +    (expandtypeattribute domain true)
> >> +
> >> +This example uses the expandtypeattribute statement to not expand
> >> previously declared `file_type` and `port_type` type attributes
> >> regardless of compiler defaults.
> >> +
> >> +    (expandtypeattribute (file_type port_type) false)
> >> +
> >>  typebounds
> >>  ----------
> >>
> >> --
> >> 2.28.0
> >>
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
