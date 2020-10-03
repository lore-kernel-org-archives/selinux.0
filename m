Return-Path: <SRS0=OlHu=DK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C542C4727D
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 08:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5F0206DB
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 08:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJCICW convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Sat, 3 Oct 2020 04:02:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44493 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgJCICW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Oct 2020 04:02:22 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2020 04:02:19 EDT
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 955BA564913
        for <selinux@vger.kernel.org>; Sat,  3 Oct 2020 09:55:12 +0200 (CEST)
Received: by mail-ot1-f54.google.com with SMTP id n61so3695978ota.10
        for <selinux@vger.kernel.org>; Sat, 03 Oct 2020 00:55:12 -0700 (PDT)
X-Gm-Message-State: AOAM533+8KouHC0oMxTykJre16PqEWwh71t0FTW7SBFd1V8pyopZ9oA0
        CCT90ES6PhktLkqCC7RvPTlSE/6Pb5n6tREbkx4=
X-Google-Smtp-Source: ABdhPJx+5KkVRTlAU258SSK3dZ8QtvTVmLhWYWySX7jq4c9D7rZq5tGY/mbkI8x2QUv5ARUSeo7PQTDFJYU7UoPRgj0=
X-Received: by 2002:a05:6830:15d8:: with SMTP id j24mr4364738otr.361.1601711711462;
 Sat, 03 Oct 2020 00:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200910113244.818506-1-dominick.grift@defensec.nl>
 <20200912131411.1213573-1-dominick.grift@defensec.nl> <CAJfZ7=ntv5eAke7cx-AaonssGznGF9c94jMAuHxp25e=PgkrbQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=ntv5eAke7cx-AaonssGznGF9c94jMAuHxp25e=PgkrbQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 3 Oct 2020 09:55:00 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mhNPNktmZED23PkL=RK2tZPRQvwPPz86a0a5BD-jFxcQ@mail.gmail.com>
Message-ID: <CAJfZ7=mhNPNktmZED23PkL=RK2tZPRQvwPPz86a0a5BD-jFxcQ@mail.gmail.com>
Subject: Re: [PATCH v4] cil_access_vector_rules: allowx, auditallowx and
 dontauditx fixes
To:     Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct  3 09:55:13 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 2, 2020 at 9:02 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Sat, Sep 12, 2020 at 3:14 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > allowx requires a equivalent "allow ioctl" rule to be present
> > auditallowx requires a equivalent "auditallow" ioctl rule to be present
> > dontauditx requires atleast one equivalent "allowx" rule to be present (can be a random irrelevant ioctlcmd)
> >
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> It seems that this patch slipped through the review process, as there
> could have been some confusion about the repository it was for. It
> seems to me that it is for https://github.com/SELinuxProject/selinux,
> and its contents looks good. Thanks!
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> If nobody complains, I will apply this patch tonight.
> Nicolas

Merged. Thanks!
Nicolas

> > ---
> > v4: add a "proper" clarification for dontauditx
> >
> > This just can't be how it was designed to behave, but it "works".
> >
> > There seem to be no logic to this at all and allowx, auditallowx and dontauditx should probably work the same as neverallowx.
> > regardless, this behavior should be documented because people will lose their sanity if they have to figure this out on their own.
> >
> >  secilc/docs/cil_access_vector_rules.md | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
> > index 9c03c710..683cc28c 100644
> > --- a/secilc/docs/cil_access_vector_rules.md
> > +++ b/secilc/docs/cil_access_vector_rules.md
> > @@ -238,6 +238,8 @@ allowx
> >
> >  Specifies the access allowed between a source and target type using extended permissions. Unlike the [`allow`](cil_access_vector_rules.md#allow) statement, the statements [`validatetrans`](cil_constraint_statements.md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans), [`constrain`](cil_constraint_statements.md#constrain), and [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain) do not limit accesses granted by [`allowx`](cil_access_vector_rules.md#allowx).
> >
> > +Note that for this to work there must *also* be valid equivalent [`allow`](cil_access_vector_rules.md#allow) rules present.
> > +
> >  **Rule definition:**
> >
> >      (allowx source_id target_id|self permissionx_id)
> > @@ -274,18 +276,21 @@ Specifies the access allowed between a source and target type using extended per
> >
> >  These examples show a selection of possible permutations of [`allowx`](cil_access_vector_rules.md#allowx) rules:
> >
> > +    (allow type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
> >      (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
> >
> >      (permissionx ioctl_nodebug (ioctl udp_socket (not (range 0x4000 0x4010))))
> > +    (allow type_3 type_4 (udp_socket (ioctl))) ;; pre-requisite
> >      (allowx type_3 type_4 ioctl_nodebug)
> >
> >
> > -
> >  auditallowx
> >  -----------
> >
> >  Audit the access rights defined if there is a valid [`allowx`](cil_access_vector_rules.md#allowx) rule. It does NOT allow access, it only audits the event.
> >
> > +Note that for this to work there must *also* be valid equivalent [`auditallow`](cil_access_vector_rules.md#auditallow) rules present.
> > +
> >  **Rule definition:**
> >
> >      (auditallowx source_id target_id|self permissionx_id)
> > @@ -324,6 +329,7 @@ This example will log an audit event whenever the corresponding [`allowx`](cil_a
> >
> >      (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
> >
> > +    (auditallow type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
> >      (auditallowx type_1 type_2 (ioctl tcp_socket (range 0x2005 0x2010)))
> >
> >
> > @@ -332,6 +338,8 @@ dontauditx
> >
> >  Do not audit the access rights defined when access denied. This stops excessive log entries for known events.
> >
> > +Note that for this to work there must *also* be atleast one [`allowx`](cil_access_vector_rules.md#allowx) rule associated with the target type.
> > +
> >  Note that these rules can be omitted by the CIL compiler command line parameter `-D` or `--disable-dontaudit` flags.
> >
> >  **Rule definition:**
> > @@ -370,6 +378,7 @@ Note that these rules can be omitted by the CIL compiler command line parameter
> >
> >  This example will not audit the denied access:
> >
> > +    (allowx type_1 type_2 (ioctl tcp_socket (0x1))) ;; pre-requisite, just some irrelevant random ioctl
> >      (dontauditx type_1 type_2 (ioctl tcp_socket (range 0x3000 0x30FF)))
> >
> >
> > @@ -392,7 +401,7 @@ Note that these rules can be over-ridden by the CIL compiler command line parame
> >  </colgroup>
> >  <tbody>
> >  <tr class="odd">
> > -<td align="left"><p><code>neverallows</code></p></td>
> > +<td align="left"><p><code>neverallowx</code></p></td>
> >  <td align="left"><p>The <code>neverallowx</code> keyword.</p></td>
> >  </tr>
> >  <tr class="even">
> > --
> > 2.28.0
> >

