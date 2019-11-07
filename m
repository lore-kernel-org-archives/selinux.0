Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC148C43331
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 16:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F34F2085B
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 16:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAQ7RGEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfKGQAM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:00:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33794 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGQAL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 11:00:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so2880579ljf.1
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 08:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTCB+8e4ID2fhFPP4vIjaRPCd2WGoz2VqqECGC98lUo=;
        b=gAQ7RGEazWOFI+c7tI0MqT5wABHs9klQ5Li9/0j26FTNVfPaTaT6m4bVlBL+h74h5i
         tu35ipfmfvAhKuZl8cRAJ4/cCl+4XD7RDtCfXwnVMQwTsN0PfaRYSysxdOON9DXRqpen
         /xBA5Pxe/yRCiWeiu0ZV8w9X4vdlWFPDFhUo5Y+mAz7xE9vrB3q6ERfpDBHhaPDWWtCD
         J43KIEufH/bc9Mnzxga8bpdU5JScNHy2YNZ0JhveJ4Zz+fu/Vd3+iBnHP+gJ3wyCCarq
         MgDIOcQ16IzDBFqD+7RJhkoAJLPHmdJnK6vEk+Y8zF/amxXdjBxQ0vWgP0vhQMTv+gCU
         GkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTCB+8e4ID2fhFPP4vIjaRPCd2WGoz2VqqECGC98lUo=;
        b=Y6fa0VrsPb1UR4oc80eBQrOSRrpbq/R3y6clXfQb3qpNoFWKooZnBKtAPgy9sODkvW
         7l5yXNBwleHB6WO1Xe5QzC4LephVu3Fdbca1VhgQroZXd905JMxm6yRLsP5MRNFN0upg
         zDwGs36y+GX040ddZT07rXVLg7JSspfHHBc24otSyGr6VIMzBfjWBXYXdcK65iPDxNjC
         07JUujjZKSqEy+opxj2XYMGytirIIpDtFO9E0E+ktmvayxcswmw5aQXSNUWok5kY8Cs6
         atWIcpdI3ht0Aymxa0xeM0DaKQ7TFpGjIKXUiEvfNTrjS+Eciv+bUYRPWIqvgWzpqji2
         vQsw==
X-Gm-Message-State: APjAAAXwHmBKGVg/2ixQUMcjcn7DWYpUvlfodqWerh1KFfoY60qbFM/1
        bJYraiwI13XuVSbC1EM15WrIt3kg3Uht84fI+cJL3lny
X-Google-Smtp-Source: APXvYqwT8n88/8A8F6OXlljQ7hwNeYMVkI4VN1yROJJrGjHu/5hR/MK+XskN4xr9ygkZ866FP4RHHm1NxUfvUtrGiac=
X-Received: by 2002:a05:651c:20f:: with SMTP id y15mr2912510ljn.31.1573142409725;
 Thu, 07 Nov 2019 08:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20191107101743.203699-1-jeffv@google.com> <9b0959ff-93be-9086-063e-5403accabc8e@tycho.nsa.gov>
 <CAFqZXNvxn-g3_m-49xBtONwBJwEh7GkrFvy025oX1pe9KcyG1g@mail.gmail.com>
In-Reply-To: <CAFqZXNvxn-g3_m-49xBtONwBJwEh7GkrFvy025oX1pe9KcyG1g@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Thu, 7 Nov 2019 16:59:58 +0100
Message-ID: <CABXk95CSWL4rf7XzE-AeDXiUs27TKjV1Axtpe86Z_pnifHa_Nw@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: sidtab: reverse lookup hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, will@kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> > > @@ -305,29 +284,36 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
> > >               rc = -ENOMEM;
> > >               dst_convert = sidtab_do_lookup(convert->target, count, 1);
> > >               if (!dst_convert) {
> > > -                     context_destroy(dst);
> > > +                     context_destroy(&dst->context);
> > >                       goto out_unlock;
> > >               }
> > >
> > > -             rc = convert->func(context, dst_convert, convert->args);
> > > +             rc = convert->func(context, &dst_convert->context,
> > > +                             convert->args);
> > >               if (rc) {
> > > -                     context_destroy(dst);
> > > +                     context_destroy(&dst->context);
> > >                       goto out_unlock;
> > >               }
> > > +             dst_convert->sid = index_to_sid(count);
> > > +             convert->target->count = count + 1;
> > >
> > >               /* at this point we know the insert won't fail */
> > > -             convert->target->count = count + 1;
> > > +             spin_lock_irqsave_nested(&convert->target->lock, flags,
> > > +                             SINGLE_DEPTH_NESTING);
> > > +             hash_add_rcu(convert->target->context_to_sid,
> > > +                             &dst_convert->list, dst_convert->context.hash);
> > > +             spin_unlock_irqrestore(&convert->target->lock, flags);
> >
> > Still having a hard time understanding why we need to lock the target.
> > The target here is always the newsidtab allocated by
> > security_load_policy(), not yet exposed to any other threads in the system?
>
> I believe this is to avoid a race with the hash_add() in
> sidtab_convert_hashtable(), which locks only the target table.
> However, I don't like the fact that we need to mess with inconsistent
> lock nesting here... I think it would be better to just lock the
> master's spinlock in sidtab_convert_hashtable() - it will then block
> more when entries would be added to sidtab, but that shouldn't be a
> big concern in practice.
>

I'll try that. Thanks.
