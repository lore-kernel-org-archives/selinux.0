Return-Path: <SRS0=Z/YK=VU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9DFC7618B
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 14:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C1C2239F
	for <selinux@archiver.kernel.org>; Tue, 23 Jul 2019 14:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXzwwQuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbfGWOyP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:54:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42149 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbfGWOyO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jul 2019 10:54:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so44308366otn.9
        for <selinux@vger.kernel.org>; Tue, 23 Jul 2019 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4KWYzLiz8Q76GJXEl0Zz0b7uhOVauu+r5qbYmNBT7A=;
        b=qXzwwQuBz/BmI26lbVCqNhkrQrcAoVMmFk29raVO7XCfT+iYt7qIl5aMn+cE0enLiD
         3+xaEvX2sNlGH8nkUL47bNlG38bxXHpFIXUqMIM/39Zba78y5N1D9sev9Ti45+6yKvFo
         fnptNuTBEsfw1q7trWYvR9MRl1i1CmZJ81dZIrb9qrELPtiW892ktHWMpqYVyezzutph
         EzfwjamCsf8fVFG4I08D2wdsCJDH1gV8GIksnHln9mgLPk0eckvQ9VliameBuufWzcy4
         PlTOxHKX/9Vzj1mpMqG7PlDpXbg/JnOaAe+W5cw6SU3DpVodIr8KnfpprqFivQ+asM2D
         WWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4KWYzLiz8Q76GJXEl0Zz0b7uhOVauu+r5qbYmNBT7A=;
        b=j+f5SX7VioJBEpGkw2243LnEbN+5VSWlTQODMOJDtv9VJmkPVAklzpLOLScVzLMqzf
         kLf5G2tOAUjiLQOuoisr15uWdfJnxqdc9WbkKz8UqHr1jd5PyYI2SLDcs6fsKiRG6anm
         Gk2XR6H81LsdCIrGkf8tse0jpKfT1KuT4jbIOI0ujdok4hUJf7YCsLdV4v5cXwG3MAjU
         nrUfT9uF3TlEkz683y++tddiUX50tllQKruK/O51PYPb9H3ZN6i4dXli72p+Wzbbn3zq
         Q3JEvjVA2kTi8B3KTh1VWSsnwMNhstRLdRM9U0TkrEJcCYnpGFmMy1DC77Z2254lESFL
         zy4w==
X-Gm-Message-State: APjAAAUoXJH1qSxF5fpEPlRxAXXCjMq63jnlArcdp+WExM5v3s9kwEQ5
        TfYMzqmP1wRmH4ARSh/yQV9H1QnKkbm1fnOtGuLVgw==
X-Google-Smtp-Source: APXvYqz6MT1sE9TYkC+Gt3TnmGvb96tCIp+1WidsrIqgtwnzoYqgfblBqQU7t6GJZutpN2xUNv4oxyMInzb5C00uRSI=
X-Received: by 2002:a9d:812:: with SMTP id 18mr48441341oty.180.1563893653534;
 Tue, 23 Jul 2019 07:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190722113151.1584-1-nitin.r.gote@intel.com> <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
In-Reply-To: <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 23 Jul 2019 16:53:47 +0200
Message-ID: <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 22, 2019 at 3:44 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Jul 22, 2019 at 1:35 PM NitinGote <nitin.r.gote@intel.com> wrote:
> > refcount_t type and corresponding API should be
> > used instead of atomic_t when the variable is used as
> > a reference counter. This allows to avoid accidental
> > refcounter overflows that might lead to use-after-free
> > situations.
> >
> > Signed-off-by: NitinGote <nitin.r.gote@intel.com>
>
> Nack.
>
> The 'count' variable is not used as a reference counter here. It
> tracks the number of entries in sidtab, which is a very specific
> lookup table that can only grow (the count never decreases). I only
> made it atomic because the variable is read outside of the sidtab's
> spin lock and thus the reads and writes to it need to be guaranteed to
> be atomic. The counter is only updated under the spin lock, so
> insertions do not race with each other.

Probably shouldn't even be atomic_t... quoting Documentation/atomic_t.txt:

| SEMANTICS
| ---------
|
| Non-RMW ops:
|
| The non-RMW ops are (typically) regular LOADs and STOREs and are canonically
| implemented using READ_ONCE(), WRITE_ONCE(), smp_load_acquire() and
| smp_store_release() respectively. Therefore, if you find yourself only using
| the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
| and are doing it wrong.

So I think what you actually want here is a plain "int count", and then:
 - for unlocked reads, either READ_ONCE()+smp_rmb() or smp_load_acquire()
 - for writes, either smp_wmb()+WRITE_ONCE() or smp_store_release()

smp_load_acquire() and smp_store_release() are probably the nicest
here, since they are semantically clearer than smp_rmb()/smp_wmb().
