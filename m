Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2ACC77B7C
	for <selinux@archiver.kernel.org>; Tue,  9 May 2023 14:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjEIOor (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 May 2023 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbjEIOoq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 May 2023 10:44:46 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C344BE
        for <selinux@vger.kernel.org>; Tue,  9 May 2023 07:44:45 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-43470e2f643so2063179137.3
        for <selinux@vger.kernel.org>; Tue, 09 May 2023 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683643484; x=1686235484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIJOIb6/7kV6PnzI4blZBlQ5+RqRbSMHK1Puioz9YIY=;
        b=L/czfchbWfdGDYHke+a46UnPNhK70EC12bf6X0vM9iPdlWOx0fBdlOeeLSj8nlNqgP
         onrSKHcpRmg0oVjigGPaBccr4dCzVziP7//yg2FUpN5pMOpig/laib6SG5+FTIYX+ikF
         z2Hb0TKailSkrhu5YeX1MoJqSLIfmhsVXDQoszVm1b1Ar3t37WdWgI8MTPLNtheGPWgQ
         n+FcTYZCBBbxN0C1eZtZv9o/2TJJYYDoWgHU6HiKOiLWdXaDIxy/OR8KEa5/fLnX0npL
         JKWjZGL9SUO8ktULzvKR5RAd0rtm4tUsaAZrCUdrxYFUz8yPXjToPpMzvHaHSJ+15YWp
         Gj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683643484; x=1686235484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIJOIb6/7kV6PnzI4blZBlQ5+RqRbSMHK1Puioz9YIY=;
        b=MOn4nwZ7maEStf8AltQRx+vKf+5ihfZt9ClgBaW41AZwNTf0P+E9jpFUE8I7nluZRX
         GowVOVdmCU3hD30Iljs2M1gTHPD0z8CiSWlHUlmCncrh8LP7Kd4DGKXbKi6OAZJi69DJ
         Jew0Q82naO8xg7g6TeyjtVACk+c53dip0M8G4asfKgiKaKH6EFpm4afzg9cLF4IqTMV7
         1MpnqUKuYk/Fg+bgCG5How9iwNPHVxZiNcfJfDMgTVey0BQ9YfXDc5td8ifbVKig9XWA
         uXiIaZeCSsswV/BlBxrbwUgpWjkbMKdz7a5m9oqkzj96h3+ktOgs4+kxztXKJZ1gIQ+x
         9sQQ==
X-Gm-Message-State: AC+VfDykWr/s3y646a4CvhGOORvPMSCNz3iQTtlaFUprMqF/KiFxQmcc
        rD1gqpbIw6W+fLVkXAoFX7NYEdq/cNs5spGdiF/VpPmJpAS9/ZFz
X-Google-Smtp-Source: ACHHUZ7vNhUv+zDvnBNJTzJUWirxxKC4oD/U03Dy9lgdth4gq1hDpeK5ApCCJyTc25JwCmK33u5KnlTSMnBR7EJg25w=
X-Received: by 2002:a67:fe02:0:b0:42f:c2c2:2961 with SMTP id
 l2-20020a67fe02000000b0042fc2c22961mr4194438vsr.16.1683643484438; Tue, 09 May
 2023 07:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230420150503.22227-1-cgzones@googlemail.com> <CAHC9VhSA_i0xcjPEkoTYhnoG4oFjzzBqmN5d47=mNuPhbpyAaQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSA_i0xcjPEkoTYhnoG4oFjzzBqmN5d47=mNuPhbpyAaQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 9 May 2023 16:44:33 +0200
Message-ID: <CAJ2a_DeoWOd7p5rLZiKOZdm=NcV5DqtJRKtjk+iAcGsyL8vUTw@mail.gmail.com>
Subject: Re: [PATCH 1/6] selinux: do not leave dangling pointer behind
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 8 May 2023 at 22:42, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Apr 20, 2023 at 11:05=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > In case mls_context_cpy() fails due to OOM set the free'd pointer in
> > context_cpy() to NULL to avoid it potentially being dereferenced or
> > free'd again in future.  Freeing a NULL pointer is well-defined and a
> > hard NULL dereference crash is at least not exploitable and should give
> > a workable stack trace.
> >
> > Fixes: 12b29f34558b ("selinux: support deferred mapping of contexts")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/ss/context.h | 1 +
> >  1 file changed, 1 insertion(+)
>
> Merged into selinux/next.
>
> Did you actually run into a problem where the system
> crashed/panic'd/etc. due to this?

No, no actual crash, just came to mind while looking over the code.

My understanding of the sidtab code is only superficial, so maybe
Stephen can correct my analysis:

There are two callers of context_cpy(): sidtab_set_initial() and
sidtab_context_to_sid():

sidtab_set_initial() is only called in policydb_load_isids(). If
context_cpy() fails on `&isid->entry.context` `isid->set` is not set
to 1 and thus the cleanup via sidtab_destroy() called in
policydb_load_isids() causes no use-after-free, since sidtab_destroy()
calls sidtab_destroy_entry() only on `if (s->isids[i].set)`.

In sidtab_context_to_sid(), if context_cpy() failed, the sidtab count
remains unchanged, since `smp_store_release(&s->count, count + 1);` is
skipped. So simple lookups via sidtab_lookup() should not access the
zombie context since the count is checked. But I think
sidtab_destroy(), e.g via a policy load on the old policy,
unconditionally calls, via sidtab_destroy_tree(),
sidtab_destroy_entry() on all fixed sized array elements, which leads
to a call of context_destroy() leading to a double-free.


Even if this analysis is wrong the change seems to me a good
defence-in-depth measure, e.g. for future refactorings.
Also the cost of a pointer assigmnment in an OOM error branch seems negligi=
ble.

I'll probably send a patch to set `dst->len` to 0 as well, since both
members are coupled.


>  I'll leave the fixes tag on this
> since it is pretty minor, but generally I think it is best to reserve
> the fixes tag for problems that can be triggered as a fixes tag
> generally results in a stable backport, regardless of it is marked for
> stable or not.
>
> --
> paul-moore.com
