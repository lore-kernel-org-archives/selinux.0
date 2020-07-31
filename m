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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B89AC433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 19:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247EA21744
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 19:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYRYbRLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgGaTvE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGaTvE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 15:51:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73775C061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 12:51:04 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id r21so12999022ota.10
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUKr4LfYqqQ/cLDdBDHelf1b1ePeLqU441f4wtdgTdg=;
        b=cYRYbRLv/d1iqf87dBpiJnYxksEs2jtY7qdrsODZmGj0Fe/pS0fNbnjChzqmvWVgHV
         QTk2ujGNsmvmPWF0RHZBgsBv2fo5d6nJ9zfqKPmwFoS2ZC0O5Jw88/14d6wRPNHbfo2y
         A/g2HFJ3NFJ4G3g8iPNbLOXwo0YQpuztvpKhfdK7tlleCMEzVNxKWEaR/X1YkNoxf8zR
         KTpnzsnZEsMCFf0ue9/H7Cg0kPG5fsgqNLvN91MSMG2r9dXDfEa98592UUdQ2OYrFnRN
         /R+p2RL6Opdf4Or3wTym0znMK/5811L3wesap93Y+vJkgbpcmMEWWXL+oAMNxdI+vuXE
         bJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUKr4LfYqqQ/cLDdBDHelf1b1ePeLqU441f4wtdgTdg=;
        b=KkWI5BzLNE1JyKOrliCeomAFjzpyhN02wooMLUztaGzlrUo5MONPebCISp/rSw/Gqb
         Kn8jbrj+zgxoMvP4drJL8n9hAJLJMkyM3HGx4ZG2i35SN9MOZRg+hBmPgutpJRewclMV
         Fg8X7MtVQ9fHeCE+rtE93vcVoASMY+uXMv1V3k/qqbC4CYJ3uFdbWZ1MUi5VViGwpsyB
         AUrHiDU+QJs65y2bYSLGZPXCGgOXz+Y8/Ngn/mHREjw2KvSHGw9GIQq/VrnG1enMhQy/
         FSl0+rEv6/uWoYUg/vHV4QUkdOzsAjzjUSP4dLRKKzvvzFLEaub9XOr9QUYhAEjda34y
         VyyQ==
X-Gm-Message-State: AOAM532yVzGFkQdcNemcxUeAD6bi/PMaSqj3tQpka7yrZ6pxgS8BOmc5
        R0fQX9vbHpHn8PuneZN0uVU1j3k0HsNYMfTQzH9VXA==
X-Google-Smtp-Source: ABdhPJw/IObSeAUzg2updBaTY6AC110oO0ZEtVwkLLTjeCfc2rh7Yoe6/xQWC91PvlQ8slpHf9kOH35NqIFf8zN1Uug=
X-Received: by 2002:a9d:328:: with SMTP id 37mr4508475otv.196.1596225063712;
 Fri, 31 Jul 2020 12:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200730114555.915996-1-dominick.grift@defensec.nl>
 <20200730131149.928220-1-dominick.grift@defensec.nl> <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
 <ypjlh7tom9gs.fsf@defensec.nl>
In-Reply-To: <ypjlh7tom9gs.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 31 Jul 2020 15:50:50 -0400
Message-ID: <CAP+JOzQNc6DHRJ88Yyu5MOULeFvk9F7_MGHmtxDnQ7_Si9jEQQ@mail.gmail.com>
Subject: Re: [PATCH v3] secilc/docs: document expandtypeattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 31, 2020 at 3:26 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Thu, Jul 30, 2020 at 9:14 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >> This was added for Androids Treble in 2017.
> >>
> >> I was unsure whether this belongs in type_statements or in conditional_statements.
> >>
> >
> > I think that it fits best with the type statements as you have it.
> >
> >> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> >> ---
> >> v2: overriden is overridden
> >> v3: add link to README.md
> >>
> >>  secilc/docs/README.md              |  1 +
> >>  secilc/docs/cil_type_statements.md | 38 ++++++++++++++++++++++++++++++
> >>  2 files changed, 39 insertions(+)
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
> >> index f9dd3a76..f819b3c6 100644
> >> --- a/secilc/docs/cil_type_statements.md
> >> +++ b/secilc/docs/cil_type_statements.md
> >> @@ -213,6 +213,44 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
> >>          )
> >>      )
> >>
> >> +expandtypeattribute
> >> +-------------------
> >> +
> >> +Allows expansion compiler defaults for one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers to be overridden.
> >
> > The wording confused me at first.
> > I think "Overrides the compiler defaults for the expansion of one ...
> > identifiers." would be clearer.
> >
> >> +
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
> >> +<td align="left"><p>One or more previously declared <code>typeattribute</code> identifiers.</p></td>
> >> +</tr>
> >> +<tr class="odd">
> >> +<td align="left"><p><code>true | false</code></p></td>
> >> +<td align="left"><p>Either true or false.</p></td>
> >> +</tr>
> >> +</tbody>
> >> +</table>
> >> +
> >> +**Example:**
> >> +
> >> +This example will use the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
> >> +
> >> +    (expandtypeattribute domain true)
> >> +
> >
> > It would be nice to have another example that shows a list of type
> > attributes, so there is an example of that syntax as well.
>
> I was looking into an example but turns out that either i am
> misunderstanding this functionality or that it does not work as advertised:
>
> Example:
>
> 1. compiler defaults to expand typeattributes with less
> than four members
> 2. override pets and dogs expansion in policy
>
> # cat > mytest.cil <<EOF
> (sid mysid)
> (sidorder (mysid))
>
> (class myclass (mypermission))
> (classorder (unordered myclass))
>
> (type blue)
> (type green)
> (type red)
> (typeattribute colors)
> (typeattributeset colors (blue green red))
>
> (type dog)
> (type cat)
> (type goldfish)
> (typeattribute pets)
> (typeattributeset pets (dog cat goldfish))
>
> (dontaudit pets colors (myclass (mypermission)))
>
> (expandtypeattribute (colors pets) false)
> EOF
>
> # secilc -v -X 4 mytest.cil
> # sesearch policy.32 --dontaudit
>

The key is that expandtypeattribute works differently for the default
behavior than when you ask for attributes to be expanded.

The default rules for removing attributes are complex. In general,
attributes automatically created when converting a binary module to
CIL; attributes that are not used in allow and dontaudit rules; and
attributes that have only one type assigned are all removed. This
means that the attribute rule and the typeattributeset rules for the
attribute are removed and all rules using the attribute are expanded.
Using expandtypeattribute in this case will keep the attribute
declaration, the typeattributeset rules, and any allow rules.

When you use "-X SIZE" all allow rules with attributes that contain
less than SIZE types will be expanded and the attribute removed. Using
expandtypeattribute in this case will cause the attribute declaration
and the typeattributeset rules to be retained, but the allow rules
will still be expanded.

I just verified that everything does work like that.

It is a bit of a mess, but it is working as intended.

I probably need to document how the default expansion works. ;)

Thanks,
Jim


> >
> > Thanks for doing this.
> > Jim
> >
> >>  typebounds
> >>  ----------
> >>
> >> --
> >> 2.28.0.rc1
> >>
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
