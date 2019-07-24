Return-Path: <SRS0=rVyX=VV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F971C7618B
	for <selinux@archiver.kernel.org>; Wed, 24 Jul 2019 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43C022CF7
	for <selinux@archiver.kernel.org>; Wed, 24 Jul 2019 15:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0k7Z49ri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfGXPSz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:18:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41063 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbfGXPSz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Jul 2019 11:18:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so27364536lfa.8
        for <selinux@vger.kernel.org>; Wed, 24 Jul 2019 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpXolAHctxURYJH2swPfpOApJw1r/Z/fMpwYwxp3zGA=;
        b=0k7Z49rieTQwEYn+pr4ZHWNBM0O21n3yf2nlUkT8AyS4yH7VycqvzHIhe/JyJieTKI
         oi53O2LPyMYJn1+Jq1kn/0yO5wmdOrBNObCEGsQ842AXuewmMZomee1Ib246RM30LMXE
         GMkMpu+6s3vTQgdH8RAZXoL/50V8NNUiFybZdJnUtObKEH+FiOm9NoXJoI3Fqvz6w7BQ
         dEMOZSTDMLyXhCBu6oj+BxtLeEjCYQfg5tbLuX8GjM/W72xdn5P413p1ctJETpdWI4FE
         dfbuFbIQ4guXvBmR9sf/uB3DwuKq1JVh9FepFPkwUXHSPAaVsh+ZLpmxOABNua/iAEHd
         GW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpXolAHctxURYJH2swPfpOApJw1r/Z/fMpwYwxp3zGA=;
        b=n//XDDOcteAQ353VN7msY+Tpx/VIaPv9U6Olb6VWq2cG/B0nvN+z5sj4OF+XjQU0SB
         kO+kRbd/N719kTNNhGKooGgcT5ObxEKdxXHYS99xa/Iq59WqdFvQly2Cbmk+bSJ131Io
         p1ZwGCHjemPQdyvAssrraGHol8QEy082TRLWEji8hgeAiIEhDWfo2BwsBkBdOb8plscd
         p+X9NYNDErzxUfZkegn2IEn6X4HMZ/3tMhvfr1C61grmXaYtvPUCpdaDbnsqvnhXJ0Mq
         gcMlfgeeoHW/0kdjIkVIxeVNSb8I+OfpvXDV/vsrqYKMTNJ5Ci5a5QIUO8/j6G5uXlHo
         V00w==
X-Gm-Message-State: APjAAAWZYaiyFfEHqhongP9atE7E2VnUPEgvr60jXbL3T7xpotl1Hn6M
        1+BMouAg/fun4U3MUVNx7GwLqfjyvsU84PGecA==
X-Google-Smtp-Source: APXvYqwDjCAXKNSCf9phgA2WwAHJa/9JlFijDL24t5LipVWCXhUs6WP4GSNOBAr8FzaiofEf4kATiZe8URpDTgSXrEY=
X-Received: by 2002:a19:8093:: with SMTP id b141mr39572283lfd.137.1563981533496;
 Wed, 24 Jul 2019 08:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190723065059.30101-1-omosnace@redhat.com>
In-Reply-To: <20190723065059.30101-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Jul 2019 11:18:41 -0400
Message-ID: <CAHC9VhSmcGoaDzOp7xbwvh2pYusMS-ReBC5Nrqi5eZYCuZpR7g@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: check sidtab limit before adding a new entry
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, NitinGote <nitin.r.gote@intel.com>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 23, 2019 at 2:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> We need to error out when trying to add an entry above SIDTAB_MAX in
> sidtab_reverse_lookup() to avoid overflow on the odd chance that this
> happens.
>
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/sidtab.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks.  This looks like -stable material to me so I've marked it as
such and merged it into selinux/stable-5.3; assuming it passes
testing, and as long as I don't hear any objections, I'll send it up
to Linus later this week.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index e63a90ff2728..1f0a6eaa2d6a 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>                 ++count;
>         }
>
> +       /* bail out if we already reached max entries */
> +       rc = -EOVERFLOW;
> +       if (count >= SIDTAB_MAX)
> +               goto out_unlock;
> +
>         /* insert context into new entry */
>         rc = -ENOMEM;
>         dst = sidtab_do_lookup(s, count, 1);
> --
> 2.21.0

-- 
paul moore
www.paul-moore.com
