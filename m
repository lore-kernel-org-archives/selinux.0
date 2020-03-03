Return-Path: <SRS0=zB1t=4U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5DFC3F2C6
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 19:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E192073B
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 19:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inWc3LYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgCCTM1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:12:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43268 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgCCTM1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Mar 2020 14:12:27 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so4166159oif.10
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2020 11:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2hyh25cH559WIqmlgSMqVDMJ/AexJ+M3LScxYVGuuM=;
        b=inWc3LYhTDPjYsX6Y+XBKuE+ZtjvtbL2rB7joJ89ujgGEK/gqEVjgoSYriv6HrpM4U
         yifYvLL10f6PvuxMd01Pii5Q85F6FeU1GiYV0YVQKDuKVaou1uCiQQvJaFVKgFD+3bty
         riVlQptlYaQ+IzUeZNYoMeD2Z1MyRNmYIDk7bPKrAIS3X4ZxdcHWf+PUzf3eehSjqQwN
         mqw7hSOgR4Nwn4CnU4SFB95KVqFGHFieQO2UWb63Z4w8yTuJCj3xfslD/BAgaekEXU6n
         vENKcwh/uFAFVoxGiSXuzsE+yETboI3OVpz5sFIHIv9Sh5lBywTwtdRDbHW+ZC+1hnWA
         HAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2hyh25cH559WIqmlgSMqVDMJ/AexJ+M3LScxYVGuuM=;
        b=a86RUCnG4R73rJAk5Elz1/k2Ew9ZHdJtjLVyWaGK8JFyCKQ++7NsidFkUq7moo4guy
         i8WguTvJF2MGp6ae7kMDEMYvx0mrtB/osRMl78Nsee8k5PP1zBC047gt2YSvxtA46Irn
         rK/+3x58YrtP1Yytuv7FGdy62TeY3k3DQ0JlddULNvmaASUKbYbv1prTQ7murzAsoLwY
         6g52dTuzShNszlUwBlTkNnHBtGVqLKt9lMpJ3EsWNyIsAqY+O1ZmQgij3Sau0UWxWH4W
         Ss+t4kxtOvHvIf6FSWtPEIWCzWNps8ADKB2mRpQWILySSqHU4oqvIkuSO5bg65IId+4S
         YuqQ==
X-Gm-Message-State: ANhLgQ2N54nB1OaQX9bvlTPUEtnkffzfU+JgY3fnyW0ZTTXUQYg2UyOL
        zVVi3+rw9itqOBrkbOZayABxbJMtpsbdT9N5d+A=
X-Google-Smtp-Source: ADFU+vvyd2UvfgAUOC15kD1VheZuTuUd9twQ/qFJ4hdvKRIfMs85HKLCwZ8N6HCHIUp99V0DM4o9hrqCtZucB//ionc=
X-Received: by 2002:a05:6808:48c:: with SMTP id z12mr50629oid.92.1583262746525;
 Tue, 03 Mar 2020 11:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20200303112910.147788-1-omosnace@redhat.com>
In-Reply-To: <20200303112910.147788-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 3 Mar 2020 14:14:22 -0500
Message-ID: <CAEjxPJ591G_wJrEb4dFSfS=DHNYWRWkWwxTqAM=AK1YL3uvN3g@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up error path in policydb_init()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 3, 2020 at 6:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Commit e0ac568de1fa ("selinux: reduce the use of hard-coded hash sizes")
> moved symtab initialization out of policydb_init(), but left the cleanup
> of symtabs from the error path. This patch fixes the oversight.
>
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 7739369f5d9a..00edcd216aaa 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -463,36 +463,28 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
>   */
>  static int policydb_init(struct policydb *p)
>  {
> -       int i, rc;
> +       int rc;
>
>         memset(p, 0, sizeof(*p));
>
>         rc = avtab_init(&p->te_avtab);
>         if (rc)
> -               goto out;
> +               return rc;
>
>         rc = cond_policydb_init(p);
>         if (rc)
> -               goto out;
> +               return rc;

Looks like avtab_init() and cond_policydb_init() can no longer return
errors, merely initialize fields to 0/NULL,
which is already done via the memset above, and are not used anywhere
else so those can go away entirely?

>
>         p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
>                                            (1 << 11));
> -       if (!p->filename_trans) {
> -               rc = -ENOMEM;
> -               goto out;
> -       }
> +       if (!p->filename_trans)
> +               return -ENOMEM;
>
>         ebitmap_init(&p->filename_trans_ttypes);
>         ebitmap_init(&p->policycaps);
>         ebitmap_init(&p->permissive_map);

Technically these aren't needed either but I guess we can leave them
in case ebitmap_init() does more than just memset
at some point.
