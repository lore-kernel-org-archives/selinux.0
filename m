Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68359C636D6
	for <selinux@archiver.kernel.org>; Thu,  9 Feb 2023 14:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBIOjq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBIOjq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Feb 2023 09:39:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A0B611EB
        for <selinux@vger.kernel.org>; Thu,  9 Feb 2023 06:39:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l14so2293715eds.4
        for <selinux@vger.kernel.org>; Thu, 09 Feb 2023 06:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fUY0oSbpQvxD+hi1S+FFd36uAUoz1+GKrtDsauDo6DU=;
        b=YOAYM+5ykkR8M+TXBtOhXC3HCcTWvroYd4cDN7krC8WUy9fLlTZ0eVL+9IE4Hrbz62
         VuXlZsvWgLwPeOajox7FaBJE7vcqtEhctnA69B7Qyf2JX/xw40Ip3CqBh/Drk5G8nnQW
         vH+uNJLMn3bsRNwvexDa8zqgBZ59gB6WLboedSKiULKLv9pLwfyTIzlCAkyMTKo0z3pE
         E8+pJ8IIm1VB7uhoTSnsLMLwQv+NFjb/p20v1KINENR9ZRLwIZV4ueKG+b64STQXqfVL
         CFpHpI9yS2Lm+JBM4ckwTfvYXXbNyvi00y6RM63YEFAdFGyAhF/V75ui54+r8bCuUa6I
         eKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUY0oSbpQvxD+hi1S+FFd36uAUoz1+GKrtDsauDo6DU=;
        b=SMKr1hEdIFuKtuw/yrgvZugpq+Me9VzZKaIsuYfvy3TaX5VW6mKqsUW+E7KFMLW8rw
         isMkhnDw0pZUa/sztX+zikzcVewhRuioJNoavd2G+JSiSMiLWAh+hra/R2Krhe9BAp2x
         AOyQoMKoMQBJJxQ4LtwAWk7FPulND2qPhnYKDJih9dNtwaUCwopt9a+wFtPu8roZyECl
         wuskxhaC3wih26L2iMa56OZdgXvdmGb+fVYgyYMiaOr/T8uUttGW+Idfpp6g8Y2vIred
         p0p67kjOp1MMFlj6wR+wj605fECDpojQvZJCgdCF4pYwD54F2Yocm8W/anr975nmWzIA
         ALqA==
X-Gm-Message-State: AO0yUKWKUG0i4WqesJ6KYhC6gsYQj+20l+llO6q0W4Jv0gjwjyJG6cXF
        ETHOpInk5BsD1hELIHZ0g3dES8YU9wo1AjKNEvH4uwf/
X-Google-Smtp-Source: AK7set9N5CadjcwwPZoQtOtlxCdtbiobnYX1tQOOn6B+KsNQU69t0kHBe2rFJbrzf2pZTIV5TfCx6DTR1C0lP40iNtY=
X-Received: by 2002:a05:6402:2420:b0:4ab:1f1b:95a1 with SMTP id
 t32-20020a056402242000b004ab1f1b95a1mr444553eda.0.1675953555709; Thu, 09 Feb
 2023 06:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20221215213429.998948-1-jwcart2@gmail.com> <20221215213429.998948-10-jwcart2@gmail.com>
 <98d7a37e-dcfb-ca7d-24d1-57f2a3abbadd@linux.microsoft.com>
In-Reply-To: <98d7a37e-dcfb-ca7d-24d1-57f2a3abbadd@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Feb 2023 09:39:04 -0500
Message-ID: <CAP+JOzS4a0T=bQ2oy97+LDmwiMacf_1FLFQn2a0ozG2WYhMV7g@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] secilc/docs: Add deny rule to CIL documentation
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 3, 2023 at 5:55 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 12/15/2022 4:34 PM, James Carter wrote:
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >   secilc/docs/cil_access_vector_rules.md | 68 ++++++++++++++++++++++++++
> >   1 file changed, 68 insertions(+)
> >
> > diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
> > index f0ba4a90..35825283 100644
> > --- a/secilc/docs/cil_access_vector_rules.md
> > +++ b/secilc/docs/cil_access_vector_rules.md
> > @@ -247,6 +247,74 @@ This example will not compile as `type_3` is not allowed to be a source type for
> >           (allow type_3 self (property_service (set)))
> >       )
> >   ```
> > +deny
> > +----------
> > +
> > +Remove the access rights defined from any matching allow rules. These rules are processed before [`neverallow`](cil_access_vector_rules.md#neverallow) checking.
> > +
> > +**Rule definition:**
> > +
> > +```secil
> > +    (deny source_id target_id|self classpermissionset_id ...)
> > +```
> > +
> > +**Where:**
> > +
> > +<table>
> > +<colgroup>
> > +<col width="27%" />
> > +<col width="72%" />
> > +</colgroup>
> > +<tbody>
> > +<tr class="odd">
> > +<td align="left"><p><code>deny</code></p></td>
> > +<td align="left"><p>The <code>deny</code> keyword.</p></td>
> > +</tr>
> > +<tr class="even">
> > +<td align="left"><p><code>source_id</code></p></td>
> > +<td align="left"><p>A single previously defined source <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p></td>
> > +</tr>
> > +<tr class="odd">
> > +<td align="left"><p><code>target_id</code></p></td>
> > +<td align="left"><p>A single previously defined target <code>type</code>, <code>typealias</code> or <code>typeattribute</code> identifier.</p>
> > +<p>The <code>self</code> keyword may be used instead to signify that source and target are the same.</p></td>
> > +</tr>
> > +<tr class="even">
> > +<td align="left"><p><code>classpermissionset_id</code></p></td>
> > +<td align="left"><p>A single named or anonymous <code>classpermissionset</code> or a single set of <code>classmap</code>/<code>classmapping</code> identifiers.</p></td>
> > +</tr>
> > +</tbody>
> > +</table>
> > +
> > +**Example:**
> > +
> > +```secil
> > +    (class class1 (perm1 perm2))
> > +
> > +     (type type_1)
> > +    (type type_2)
> > +     (allow type_1 type_2 (class1 (perm1))) ; Allow_1
> > +     (deny type_1 type_2 (class1 (perm1)))  ; Deny_1
> > +     ; Allow_1 will be complete removed by Deny_1.
> > +
> > +    (type type_3)
> > +     (type type_4)
> > +     (allow type_3 type_4 (class1 (perm1 perm2))) ; Allow_2
> > +     (deny type_3 type_4 (class1 (perm1)))        ; Deny_2
> > +     ; Allow_2 will be removed and replaced with the following when Deny_2 is evaluated
> > +    ; (allow type_3 type_4 (class1 (perm2)))
> > +
> > +     (type type_5)
> > +     (type type_6)
> > +     (typeattribute attr_1)
> > +     (typeattributeset attr_1 (type_5 type_6))
> > +     (allow attr_1 attr_1 (class1 (perm1))) ; Allow_3
> > +     (deny type_5 type_6 (class1 (perm1)))  ; Deny_3
> > +     ; Allow_3 will be removed and replaced with the following when Deny_3 is evaluated
> > +     ; (allow type_6 attr_1 (class1 (perm1)))
> > +     ; (allow attr_1 type_5 (class1 (perm1)))
> > +    )
> > +```
>
> Looks like theres some intermixing of spaces and tabs messing up
> formatting on the example.
>
> -Daniel

That final ")" isn't needed as well.
Thanks,
Jim


> >
> >   allowx
> >   ------
>
