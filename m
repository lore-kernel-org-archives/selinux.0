Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435DAC433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 20:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA8D2087C
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 20:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIJsyrgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgGaUW4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaUW4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 16:22:56 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469ECC061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 13:22:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id q4so16055660oia.1
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThpmyEgN7TxexPbUn/tif1SKzPTF9H7Vk8oQdhzdLtY=;
        b=YIJsyrgSE/njc3r9qWSGL/atYAb07H8HBowBMXudSk8KpZyApIHqcBVgx5O50U4dG/
         fb8kgfU+GFLKBSowaq0haLdfxPm3eZiMtXNfgmyy8qQEIYRjSBLsHCqImi8roeyri/F9
         rhdwDXeueiAV2Jhb6RuE+fZWfYaophBnOSTOLVpzetC3iyKaGJTAl0NjIpgBRGxZ15xC
         0+DHug7WVqZ2YeYNlR3Aue5G/NcXJ9eqpXzqQY5itC6fxIwyx7LJeIfh8TxSwVkmYA/x
         m6Rf7mExL6ul6vP+tEnIQlmgckt2wXIvgv0oa7iLhxewziqSvO9tlVTt8YVg6NIR8INt
         ECfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThpmyEgN7TxexPbUn/tif1SKzPTF9H7Vk8oQdhzdLtY=;
        b=ICYj3I/RRLZ5pqMH3xKMI/QSXX61QBf+wMTGnkffTfSsxVFgbSL71lyOjocKzqVU8n
         YMWUEhIjQhYvLa4PD3Evo9vKJpHANQkoeU7PgcciBbrhZbkW16rA+4AxzwMbjGiAdDs4
         YiNE2C7AfDtE+sBLl9L1mjQSi/Nfnd7trAuF3GO4c+Zc5U/rJxssi3rGQ4SnjbB1Cmz9
         Txzk8ENJ/MmbCuB/32yBhHfZyutcRnqOSMJpXD3Lwkdd/DQl8AxyZp/3gq+hF9uu8ReM
         g1z1uKlV2Dmec7826aiQ200uIs5FHfznbeu0ojQv9Gd3+FHIPJIVJfFvDQHqIk7D4QJV
         9YfA==
X-Gm-Message-State: AOAM531KNZYCJnqWWUUEJ0OY1KNwBbub8L8JSbh3MA3QbAqMPhF9/i2U
        MCtF6VzghYIIiDxHIMkorspVgHU5cW59rm9cWhIH6A==
X-Google-Smtp-Source: ABdhPJyHOrmukAIaRo4+YIGs5r86JbOSNAvM3EqHHLnasdJ/vSOH5qWtEo0OwMIefU1UF0TnRC+2sirCzqXoQE+zGpQ=
X-Received: by 2002:aca:cd05:: with SMTP id d5mr4098836oig.138.1596226975562;
 Fri, 31 Jul 2020 13:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200730114555.915996-1-dominick.grift@defensec.nl>
 <20200730131149.928220-1-dominick.grift@defensec.nl> <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
 <ypjlh7tom9gs.fsf@defensec.nl> <CAP+JOzQNc6DHRJ88Yyu5MOULeFvk9F7_MGHmtxDnQ7_Si9jEQQ@mail.gmail.com>
 <ypjltuxnla05.fsf@defensec.nl>
In-Reply-To: <ypjltuxnla05.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 31 Jul 2020 16:22:44 -0400
Message-ID: <CAP+JOzSgp1Xgv29v__SAjZthonqRw=ZmYJ_3=MZm5FX8EOjDBw@mail.gmail.com>
Subject: Re: [PATCH v3] secilc/docs: document expandtypeattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 31, 2020 at 4:12 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Fri, Jul 31, 2020 at 3:26 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >> James Carter <jwcart2@gmail.com> writes:
> >>
> >> > On Thu, Jul 30, 2020 at 9:14 AM Dominick Grift
> >> > <dominick.grift@defensec.nl> wrote:
> >> >>
> >> >> This was added for Androids Treble in 2017.
> >> >>
> >> >> I was unsure whether this belongs in type_statements or in conditional_statements.
> >> >>
> >> >
> >> > I think that it fits best with the type statements as you have it.
> >> >
> >> >> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> >> >> ---
> >> >> v2: overriden is overridden
> >> >> v3: add link to README.md
> >> >>
> >> >>  secilc/docs/README.md              |  1 +
> >> >>  secilc/docs/cil_type_statements.md | 38 ++++++++++++++++++++++++++++++
> >> >>  2 files changed, 39 insertions(+)
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
> >> >> index f9dd3a76..f819b3c6 100644
> >> >> --- a/secilc/docs/cil_type_statements.md
> >> >> +++ b/secilc/docs/cil_type_statements.md
> >> >> @@ -213,6 +213,44 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
> >> >>          )
> >> >>      )
> >> >>
> >> >> +expandtypeattribute
> >> >> +-------------------
> >> >> +
> >> >> +Allows expansion compiler defaults for one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers to be overridden.
> >> >
> >> > The wording confused me at first.
> >> > I think "Overrides the compiler defaults for the expansion of one ...
> >> > identifiers." would be clearer.
> >> >
> >> >> +
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
> >> >> +<td align="left"><p>One or more previously declared <code>typeattribute</code> identifiers.</p></td>
> >> >> +</tr>
> >> >> +<tr class="odd">
> >> >> +<td align="left"><p><code>true | false</code></p></td>
> >> >> +<td align="left"><p>Either true or false.</p></td>
> >> >> +</tr>
> >> >> +</tbody>
> >> >> +</table>
> >> >> +
> >> >> +**Example:**
> >> >> +
> >> >> +This example will use the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
> >> >> +
> >> >> +    (expandtypeattribute domain true)
> >> >> +
> >> >
> >> > It would be nice to have another example that shows a list of type
> >> > attributes, so there is an example of that syntax as well.
> >>
> >> I was looking into an example but turns out that either i am
> >> misunderstanding this functionality or that it does not work as advertised:
> >>
> >> Example:
> >>
> >> 1. compiler defaults to expand typeattributes with less
> >> than four members
> >> 2. override pets and dogs expansion in policy
> >>
> >> # cat > mytest.cil <<EOF
> >> (sid mysid)
> >> (sidorder (mysid))
> >>
> >> (class myclass (mypermission))
> >> (classorder (unordered myclass))
> >>
> >> (type blue)
> >> (type green)
> >> (type red)
> >> (typeattribute colors)
> >> (typeattributeset colors (blue green red))
> >>
> >> (type dog)
> >> (type cat)
> >> (type goldfish)
> >> (typeattribute pets)
> >> (typeattributeset pets (dog cat goldfish))
> >>
> >> (dontaudit pets colors (myclass (mypermission)))
> >>
> >> (expandtypeattribute (colors pets) false)
> >> EOF
> >>
> >> # secilc -v -X 4 mytest.cil
> >> # sesearch policy.32 --dontaudit
> >>
> >
> > The key is that expandtypeattribute works differently for the default
> > behavior than when you ask for attributes to be expanded.
> >
> > The default rules for removing attributes are complex. In general,
> > attributes automatically created when converting a binary module to
> > CIL; attributes that are not used in allow and dontaudit rules; and
> > attributes that have only one type assigned are all removed. This
> > means that the attribute rule and the typeattributeset rules for the
> > attribute are removed and all rules using the attribute are expanded.
> > Using expandtypeattribute in this case will keep the attribute
> > declaration, the typeattributeset rules, and any allow rules.
> >
> > When you use "-X SIZE" all allow rules with attributes that contain
> > less than SIZE types will be expanded and the attribute removed. Using
> > expandtypeattribute in this case will cause the attribute declaration
> > and the typeattributeset rules to be retained, but the allow rules
> > will still be expanded.
> >
> > I just verified that everything does work like that.
> >
> > It is a bit of a mess, but it is working as intended.
> >
> > I probably need to document how the default expansion works. ;)
>
>
> So that makes the "false" scenario practically irrelevant? when would
> one ever use "false" instead of "true"?
>

That is actually the most valuable option. It is the way to ensure
that an attribute definition is not removed. It is being used, for
example, by Google to keep attributes that are used in the neverallow
rules in their compatibility test suite from being expanded.

Jim

> >
> > Thanks,
> > Jim
> >
> >
> >> >
> >> > Thanks for doing this.
> >> > Jim
> >> >
> >> >>  typebounds
> >> >>  ----------
> >> >>
> >> >> --
> >> >> 2.28.0.rc1
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
