Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487AC04EB9
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6965620863
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oG9juktZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6965620863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeK3JVq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:21:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40391 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeK3JVp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 04:21:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so2649349lfe.7
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 14:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6C4e/ZT+qFa2B1H6igoeWl5EHapTOmC65y/uxoOPAU=;
        b=oG9juktZIxecLnsJGCGBF05ByPOtjqoF+yRkqtCMwpdKHbQ7/w/bJzSoyQTGciv/vz
         fZ5rJ9fXQINe7L56s4FHYr1oJCfLXctvW6jZrPrb/LsIThXRO8qRszxvlCqXgo5wYvhW
         agpM2nMGTvlnGb8EWW8K1rUU+96QPDiNMZJx/6MTCp0eU0HbrmIwmdJln3gf+Sld+pbj
         4aoHsy6UqTsGrIgD7N/ctzQHq4c97H2fBex1utGlUrNNeGXlQq1QfbBFg98RNrtJdHBv
         hzxX0VJjsGLPSp4wR6uz0gWINrEnrAjyFcNmRnmfU8zeULDo+dGD+tabHgW+MqY4058k
         2DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6C4e/ZT+qFa2B1H6igoeWl5EHapTOmC65y/uxoOPAU=;
        b=QbxNyb3+Sr2+SKJBHs/x/rJm7LGCU8g/mOaRa6ppCoG57EJ71FMej37lal+l8aqYO6
         8wx+Cz2Vpl985hMfZNSQeFKG6ertEka9uTowa06k5KZ0GQ2PTaogXr0XaixEzfKAGMPr
         uyAO6WYXggHVh4Zbz3gLXhy3SX2lJuBOpO6FGa4fDtq1A/MpTh5NcrEj+ujAqIeJoLG+
         4s8LQXy3tQRGN2eksXY+f7JGwdfA8P4D2ahOcfa752Vtup3/LHo9+6D2nuJpZntT5gko
         yeZu6WmJkNsAHLraOrMpeIAaI3cSyAqKJicQZcETfMk5FF+fqPNG/VRf/4ISBc8wSJ2y
         Q/Jw==
X-Gm-Message-State: AA+aEWaYLfI1GqoCQiBb8YeFH+8vpCj0izQVkzm8emfkihhks9oA/o9V
        W3wfJFXie5Grogt/fENFxQafn4w179r2WeP/SEf5gVU=
X-Google-Smtp-Source: AFSGD/Ww+HB7InV0I+ROKUfl04070iRY4FGBoMC7K9B3lkQRDlXCtIMbfPpQLiy61x2Seej442L3v8nhbPwB+QAWZHQ=
X-Received: by 2002:a19:6719:: with SMTP id b25mr1988406lfc.38.1543529684413;
 Thu, 29 Nov 2018 14:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20181129125402.5900-1-omosnace@redhat.com> <20181129125402.5900-4-omosnace@redhat.com>
In-Reply-To: <20181129125402.5900-4-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Nov 2018 17:14:33 -0500
Message-ID: <CAHC9VhSbbi5+_eqbZ0Gvjx01q-yfS7nQWx-tMh8OCs0mvT3zWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/9] [fixup] fix handling of SECSID_NULL
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 29, 2018 at 7:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> ---
>  security/selinux/ss/sidtab.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

A quick administrative comment: please don't send "[fixup]" patches
except under the most extreme circumstances, especially in the case
where you are respinning the patch{set}.  Using fixup patches makes it
much harder for me to review, test, apply your patches which makes me
grumpy.

I don't like being grumpy.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index e157d8240cf1..31588d704b98 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -123,17 +123,19 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
>         struct context *context;
>         struct sidtab_isid_entry *entry;
>
> -       if (!s || sid == 0)
> +       if (!s)
>                 return NULL;
>
> -       if (sid > SECINITSID_NUM) {
> -               context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
> -       } else {
> -               entry = &s->isids[sid - 1];
> -               context = entry->set ? &entry->context : NULL;
> +       if (sid != 0) {
> +               if (sid > SECINITSID_NUM) {
> +                       context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
> +               } else {
> +                       entry = &s->isids[sid - 1];
> +                       context = entry->set ? &entry->context : NULL;
> +               }
> +               if (context && (!context->len || force))
> +                       return context;
>         }
> -       if (context && (!context->len || force))
> -               return context;
>
>         entry = &s->isids[SECINITSID_UNLABELED - 1];
>         return entry->set ? &entry->context : NULL;
> --
> 2.19.2
>


-- 
paul moore
www.paul-moore.com
