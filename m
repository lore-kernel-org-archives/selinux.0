Return-Path: <SRS0=qhvK=DJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0786EC4363D
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 07:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CC7206DD
	for <selinux@archiver.kernel.org>; Fri,  2 Oct 2020 07:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgJBHC1 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Fri, 2 Oct 2020 03:02:27 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:43749 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBHC0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Oct 2020 03:02:26 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id ADF15561209
        for <selinux@vger.kernel.org>; Fri,  2 Oct 2020 09:02:23 +0200 (CEST)
Received: by mail-oi1-f179.google.com with SMTP id w141so354631oia.2
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2020 00:02:23 -0700 (PDT)
X-Gm-Message-State: AOAM532MQV1jJnmR6aq4AJgzQU3xpx4d6YwFQ642EgugNf8hx54egYMY
        OUNgtFki7MakHwZaVbKVPFPB2GUDZcJLHOYym94=
X-Google-Smtp-Source: ABdhPJw8LY2zH8b5KIG7pckXUEkrfWluqxLnW563uW4DWSPqjtAs1lfeQhv/Q8NaIprjAaozLLQxWkINJtSehYsSyak=
X-Received: by 2002:aca:e08b:: with SMTP id x133mr440855oig.20.1601622142719;
 Fri, 02 Oct 2020 00:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200910113244.818506-1-dominick.grift@defensec.nl> <20200912131411.1213573-1-dominick.grift@defensec.nl>
In-Reply-To: <20200912131411.1213573-1-dominick.grift@defensec.nl>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 2 Oct 2020 09:02:11 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=ntv5eAke7cx-AaonssGznGF9c94jMAuHxp25e=PgkrbQ@mail.gmail.com>
Message-ID: <CAJfZ7=ntv5eAke7cx-AaonssGznGF9c94jMAuHxp25e=PgkrbQ@mail.gmail.com>
Subject: Re: [PATCH v4] cil_access_vector_rules: allowx, auditallowx and
 dontauditx fixes
To:     Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Oct  2 09:02:24 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Sep 12, 2020 at 3:14 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> allowx requires a equivalent "allow ioctl" rule to be present
> auditallowx requires a equivalent "auditallow" ioctl rule to be present
> dontauditx requires atleast one equivalent "allowx" rule to be present (can be a random irrelevant ioctlcmd)
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

It seems that this patch slipped through the review process, as there
could have been some confusion about the repository it was for. It
seems to me that it is for https://github.com/SELinuxProject/selinux,
and its contents looks good. Thanks!

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

If nobody complains, I will apply this patch tonight.
Nicolas

> ---
> v4: add a "proper" clarification for dontauditx
>
> This just can't be how it was designed to behave, but it "works".
>
> There seem to be no logic to this at all and allowx, auditallowx and dontauditx should probably work the same as neverallowx.
> regardless, this behavior should be documented because people will lose their sanity if they have to figure this out on their own.
>
>  secilc/docs/cil_access_vector_rules.md | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/secilc/docs/cil_access_vector_rules.md b/secilc/docs/cil_access_vector_rules.md
> index 9c03c710..683cc28c 100644
> --- a/secilc/docs/cil_access_vector_rules.md
> +++ b/secilc/docs/cil_access_vector_rules.md
> @@ -238,6 +238,8 @@ allowx
>
>  Specifies the access allowed between a source and target type using extended permissions. Unlike the [`allow`](cil_access_vector_rules.md#allow) statement, the statements [`validatetrans`](cil_constraint_statements.md#validatetrans), [`mlsvalidatetrans`](cil_constraint_statements.md#mlsvalidatetrans), [`constrain`](cil_constraint_statements.md#constrain), and [`mlsconstrain`](cil_constraint_statements.md#mlsconstrain) do not limit accesses granted by [`allowx`](cil_access_vector_rules.md#allowx).
>
> +Note that for this to work there must *also* be valid equivalent [`allow`](cil_access_vector_rules.md#allow) rules present.
> +
>  **Rule definition:**
>
>      (allowx source_id target_id|self permissionx_id)
> @@ -274,18 +276,21 @@ Specifies the access allowed between a source and target type using extended per
>
>  These examples show a selection of possible permutations of [`allowx`](cil_access_vector_rules.md#allowx) rules:
>
> +    (allow type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
>      (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
>
>      (permissionx ioctl_nodebug (ioctl udp_socket (not (range 0x4000 0x4010))))
> +    (allow type_3 type_4 (udp_socket (ioctl))) ;; pre-requisite
>      (allowx type_3 type_4 ioctl_nodebug)
>
>
> -
>  auditallowx
>  -----------
>
>  Audit the access rights defined if there is a valid [`allowx`](cil_access_vector_rules.md#allowx) rule. It does NOT allow access, it only audits the event.
>
> +Note that for this to work there must *also* be valid equivalent [`auditallow`](cil_access_vector_rules.md#auditallow) rules present.
> +
>  **Rule definition:**
>
>      (auditallowx source_id target_id|self permissionx_id)
> @@ -324,6 +329,7 @@ This example will log an audit event whenever the corresponding [`allowx`](cil_a
>
>      (allowx type_1 type_2 (ioctl tcp_socket (range 0x2000 0x20FF)))
>
> +    (auditallow type_1 type_2 (tcp_socket (ioctl))) ;; pre-requisite
>      (auditallowx type_1 type_2 (ioctl tcp_socket (range 0x2005 0x2010)))
>
>
> @@ -332,6 +338,8 @@ dontauditx
>
>  Do not audit the access rights defined when access denied. This stops excessive log entries for known events.
>
> +Note that for this to work there must *also* be atleast one [`allowx`](cil_access_vector_rules.md#allowx) rule associated with the target type.
> +
>  Note that these rules can be omitted by the CIL compiler command line parameter `-D` or `--disable-dontaudit` flags.
>
>  **Rule definition:**
> @@ -370,6 +378,7 @@ Note that these rules can be omitted by the CIL compiler command line parameter
>
>  This example will not audit the denied access:
>
> +    (allowx type_1 type_2 (ioctl tcp_socket (0x1))) ;; pre-requisite, just some irrelevant random ioctl
>      (dontauditx type_1 type_2 (ioctl tcp_socket (range 0x3000 0x30FF)))
>
>
> @@ -392,7 +401,7 @@ Note that these rules can be over-ridden by the CIL compiler command line parame
>  </colgroup>
>  <tbody>
>  <tr class="odd">
> -<td align="left"><p><code>neverallows</code></p></td>
> +<td align="left"><p><code>neverallowx</code></p></td>
>  <td align="left"><p>The <code>neverallowx</code> keyword.</p></td>
>  </tr>
>  <tr class="even">
> --
> 2.28.0
>

