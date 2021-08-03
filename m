Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3584C4338F
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822AE60EC0
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 14:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbhHCOFW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbhHCOFT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Aug 2021 10:05:19 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF298C061757
        for <selinux@vger.kernel.org>; Tue,  3 Aug 2021 07:05:07 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so20821981oti.0
        for <selinux@vger.kernel.org>; Tue, 03 Aug 2021 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1hADwSvuWWaGO5qP34TmiRw7mKIuBAGpYgcQfRjAp0=;
        b=AK8Cb8cRL5oyiAWRebMWBOtXgz/qpKukflapMMe6/GoEbjyxfgwCxedJN1cM4mtPeO
         2VTr1UyAxFGo4YzF8wmlyrmFYfwx/Y9N3ihw6E6P3XZ+/ZbarqKh+5IuGC04XI/lsqek
         cBwnx0H21TjT2SaGyLSdyaI1Hy/tmqkSevXfZLHej52QFNk87UbKKPcgK8hZYn/n4TwT
         Xdda57ouWbiQBlW7GShLi4Jxmc7r2Bxq0aAr+FGdSTg3t1c5hGB2kIJBguNfoJI7mpLH
         44cJyOc3+CznRJnwYiqXuCvOHldGGabgz5y1WsQ3KwiBayAfbNFLsSBNYl2/qdOykvcC
         4vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1hADwSvuWWaGO5qP34TmiRw7mKIuBAGpYgcQfRjAp0=;
        b=nGrUh8huLSt9kl8iPxKs4aGm/0SBkRaIgeGsrb+BpDVzIum4h/dQxzgo++4vnos+KL
         wxMAFPku9XcC0/Sab6bIg1PvdDNAcjrojDBtadXBMjHljDgSlfkXlGv4OEyUQJJ+UJ9m
         4jRmbCH6ePVSaKuAQvjJ5WYFBHxgPa0DBw4Dmpc8oQYDnEV85vdrfT0dLJIxgNKDDCDX
         WZd+IdUmyNlow0YLwK+dJcam6uBMicZ8bQRQSi7nu/6HiTg/dSIB6jfN+JrJIxhulWdL
         su1v77cdduZNeD59UJ//c4lK38fVjbO/wBLovqkNAvVQcMsq/fxFs7wZOsAFrG0z8H5Q
         b0Rw==
X-Gm-Message-State: AOAM532wtwhsjkLgiB3Fdk6XEXNiTYQq2pxoxLGNhAZKPC8Vk2/53MTy
        6QgUtb8DsToOeyxDF+WIDbvYugAWUAeQxEm/4oA=
X-Google-Smtp-Source: ABdhPJwPDzupP/Xs3Lsu9f9tiV//zHtbQg/Px9ns3AwtUdjsCVjY4M8xX7Ct0aMviiDC3a3vY/tNlEtq6E5hPqasev0=
X-Received: by 2002:a05:6830:2452:: with SMTP id x18mr15478568otr.196.1627999507415;
 Tue, 03 Aug 2021 07:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210730115256.411543-1-plautrba@redhat.com> <CAP+JOzRuApPnmSHZbap_fpa_Wh_N_crUVmY7gJKFq1PcadoS0Q@mail.gmail.com>
In-Reply-To: <CAP+JOzRuApPnmSHZbap_fpa_Wh_N_crUVmY7gJKFq1PcadoS0Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 3 Aug 2021 10:04:56 -0400
Message-ID: <CAP+JOzRU+2YP7VROEFWP1V-ghtcRUyVZU5UZ54j0Ot-M1dqLQQ@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: Fix COPY_PASTE_ERROR (CWE-398)
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 30, 2021 at 10:23 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jul 30, 2021 at 7:55 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Fixes:
> >     Error: COPY_PASTE_ERROR (CWE-398): [#def3]
> >     selinux/python/sepolicy/sepolicy/__init__.py:1032: original: ""_key_t"" looks like the original copy.
> >     selinux/python/sepolicy/sepolicy/__init__.py:1035: copy_paste_error: ""_key_t"" looks like a copy-paste error.
> >     selinux/python/sepolicy/sepolicy/__init__.py:1035: remediation: Should it say ""_secret_t"" instead?
> >     # 1033|
> >     # 1034|       if f.endswith("_secret_t"):
> >     # 1035|->         return txt + "treat the files as %s secret data." % prettyprint(f, "_key_t")
> >     # 1036|
> >     # 1037|       if f.endswith("_ra_t"):
> >
> >     Error: COPY_PASTE_ERROR (CWE-398): [#def4]
> >     selinux/python/sepolicy/sepolicy/__init__.py:1065: original: ""_tmp_t"" looks like the original copy.
> >     selinux/python/sepolicy/sepolicy/__init__.py:1067: copy_paste_error: ""_tmp_t"" looks like a copy-paste error.
> >     selinux/python/sepolicy/sepolicy/__init__.py:1067: remediation: Should it say ""_etc_t"" instead?
> >     # 1065|           return txt + "store %s temporary files in the /tmp directories." % prettyprint(f, "_tmp_t")
> >     # 1066|       if f.endswith("_etc_t"):
> >     # 1067|->         return txt + "store %s files in the /etc directories." % prettyprint(f, "_tmp_t")
> >     # 1068|       if f.endswith("_home_t"):
> >     # 1069|           return txt + "store %s files in the users home directory." % prettyprint(f, "_home_t")
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  python/sepolicy/sepolicy/__init__.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> > index df773a6b314e..6b6160a449df 100644
> > --- a/python/sepolicy/sepolicy/__init__.py
> > +++ b/python/sepolicy/sepolicy/__init__.py
> > @@ -1039,7 +1039,7 @@ def get_description(f, markup=markup):
> >          return txt + "treat the files as %s key data." % prettyprint(f, "_key_t")
> >
> >      if f.endswith("_secret_t"):
> > -        return txt + "treat the files as %s secret data." % prettyprint(f, "_key_t")
> > +        return txt + "treat the files as %s secret data." % prettyprint(f, "_secret_t")
> >
> >      if f.endswith("_ra_t"):
> >          return txt + "treat the files as %s read/append content." % prettyprint(f, "_ra_t")
> > @@ -1071,7 +1071,7 @@ def get_description(f, markup=markup):
> >      if f.endswith("_tmp_t"):
> >          return txt + "store %s temporary files in the /tmp directories." % prettyprint(f, "_tmp_t")
> >      if f.endswith("_etc_t"):
> > -        return txt + "store %s files in the /etc directories." % prettyprint(f, "_tmp_t")
> > +        return txt + "store %s files in the /etc directories." % prettyprint(f, "_etc_t")
> >      if f.endswith("_home_t"):
> >          return txt + "store %s files in the users home directory." % prettyprint(f, "_home_t")
> >      if f.endswith("_tmpfs_t"):
> > --
> > 2.32.0
> >
