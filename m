Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA18C3F2CD
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0974E2166E
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 18:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SU95Y4LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgCBSnP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:43:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33181 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCBSnP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 13:43:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id q81so301041oig.0
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 10:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLPoottG7xJQ0MaQfiMyE5ySJzmkgk7hZi2ndW4/auw=;
        b=SU95Y4LIKV4CK4Kj5vgDE8TrDhkEBFprxlnz969+rCQzXcQgoRPaAF+R5tsEUemsfh
         pwBDMXvuzpRTuPXYuaOwketM5A5gitNxGV7GA84XqNxwiYksQqq4QKvz5s+o/z6TyCAp
         xpu7YLfLeW4+vepdQsj35iSlZbJBI4EpAfTNJyc4gSaOf9pteIjUNBnbLc8zXNkkiNgs
         uwWVYjN6w38YWPg+kxrtTmOemhBMNMya7wWMcneuMztiLWuzFibwbk/c2L3rg8k+fwCN
         /TZGs+jdsBUG08TiVZbKPGxfCbHkmKNCJNHvDMKpAfjdIizhqwWdT/ZfWIkHnugpI30v
         63Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLPoottG7xJQ0MaQfiMyE5ySJzmkgk7hZi2ndW4/auw=;
        b=oGI0+ozHFzNhr8ePF2Omocrjrynbztrw0CTi53bGn5r+gpJ9hKPqEudzhiZE/q9jgD
         JqhCiJW3mVKg9h/4VvHBjDiaMX8/0g9jhuo5nKPSasZVIQFy/uQOY5XO+/QpQ0Uu57vo
         n+hEyharvAapbLGyAMW3OIMjtc/LOP22m9ha0LQf3+FWKoISCWg4fcUyTcDcUdWQ0Om5
         P5pBDmHmtpwWjKh/KByjKrFXw0QurJFUWwUD6h6yDkZ1O68p4IcoF0PgmqJzVs1Dph8f
         SQXWbDdJTvLyII+K4+tvwi1PzdrpQw0Zd/9PB730KhGtjVwzVjUDrExhX+LhDv85xsSd
         jC/w==
X-Gm-Message-State: ANhLgQ3wzFE0mVUlPPEM+pad8j9lWRtjc34VFx56y4EW8JgK5fXyF9PK
        vwOR2U63ZpIS/60l3U2JoV2vwhuCyCnZI1uGSxw=
X-Google-Smtp-Source: ADFU+vur1yogaUBb84KJLo2o3tJmzvZv+bZjf/B3poH/nFM/gFkGEy8HbPeKbH3y9OuCrTIXIPtH5nDFaMsis3wntHM=
X-Received: by 2002:aca:3544:: with SMTP id c65mr331688oia.160.1583174594655;
 Mon, 02 Mar 2020 10:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
 <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com> <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
In-Reply-To: <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Mar 2020 13:45:01 -0500
Message-ID: <CAEjxPJ66CZL6-+KbRKwicYuj50uvcTjr-O81LC+BhQGO-jaKew@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 10:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Hm... this is probably a consequence of the second patch. Types are no
> longer considered a superset of an attribute containing a single type,
> so the single-type rule gets removed instead of the attribute one...
> But even before it picked the first rule only by chance (it was first
> in order). I would say that picking a single-type rule over an
> attribute rule in this case is outside of the scope of the algorithm.
> Shouldn't the compiler automatically expand each attribute that has
> less than 5 types in it? I recall seeing something in the code that
> did this. I think this was in the CIL part of libsepol, so maybe it
> applies only when compiling from CIL?

secilc has -G and -X options for controlling expansion of attributes, but
there aren't equivalent settings in semanage.conf to control when
building modular policies.
Internally it all uses the libsepol CIL support so it ought to be fixable.
Looks like the default is 1 in cil_db_init() so it only happens when
the attribute has no types by default?
