Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B21DC3F2D1
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 19:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F062072A
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UkdGcqra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCETy5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:54:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35545 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCETy5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 14:54:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id cq8so7619243edb.2
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 11:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edntvNOc1wL7OJRGCT3ksRMR/cV/lsJlHzW+xTa+MGU=;
        b=UkdGcqrab8vGA4JeTDi+aw3fOuycSO6dwNcnVe4/etxKtS8eVP+hPykyIlP4NbqnXq
         R4R0ktbiE4zzJ6nv9zE1qcSuXXy13rIofu/W+zAL7bgJ6RoapR8uPohzgBEPeDjItvhK
         IJVDaoVMiQvOEYBxXV/RM4nZYF5egqOYEy785esNdHW31wqGzBSQwhvpfR7wZ5LlSHXc
         bGA0MidVH+KXD4Ul4DVYpMWi5+qvxf7TPZg727NhX5rqQ6MhpNuH5zbGWQN+wzrp/BUh
         4AR6dMU+wtQ1IkXVT/7vmULmiean1qz4AO8ZX9u52CIu9uL0Mx1ykMPLuTZUzLbhbptn
         MQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edntvNOc1wL7OJRGCT3ksRMR/cV/lsJlHzW+xTa+MGU=;
        b=BZA74aVOQYJVwQ1AzEYjAfMCKEKy2DrMgO4IU4f6l1xlODzzpGShBuPKjOv0WFMbXr
         xgTfExEVxBqAllvli2p0sA5M+eke6NUS9xVS7lk/j1QCtrDM4k4VwYKjr556isxqnjYT
         PvBMGF3fmht2FlGuX9JZHXQ7OXJVRdRqOyiT8SXHB2h66x0w4wCprCwhtvnzMIo5Dr7/
         mWEk20c2wHAJvdoKeMiFIqwuS1/iczFrJ0VCGljEf2lDujHsOfZHKXVyYysSH1bel+kz
         fbciyQE1CB9EjYZ7k2NBq8VX1o03K02YpzOJ6Ue7VSbKCb0hmgZYxUKL4Ng4CUNkZBLF
         DH3w==
X-Gm-Message-State: ANhLgQ1aOq6C953WhqCKnhVSiRsWIRr3sE/CDEDT2IPoJF599RO3N0wK
        pL+WbbBkeO8OcebDZzGbZ65MnAuPqq0uPV4w0kpG
X-Google-Smtp-Source: ADFU+vthMPUEzaFIV7r7qIzDc9G7SjufNSw7yYwOxm7VqMfk+TUPg1zB2dadmyEQB794p/8Mr97Zs0tiFpHsv6t+LSM=
X-Received: by 2002:aa7:d64e:: with SMTP id v14mr418313edr.164.1583438095709;
 Thu, 05 Mar 2020 11:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20200303112910.147788-1-omosnace@redhat.com> <CAEjxPJ591G_wJrEb4dFSfS=DHNYWRWkWwxTqAM=AK1YL3uvN3g@mail.gmail.com>
 <CAFqZXNs=hayAWPP9cPXtUCnYiwMeTdUoaWxcU=LkEb8+B=_ePg@mail.gmail.com>
In-Reply-To: <CAFqZXNs=hayAWPP9cPXtUCnYiwMeTdUoaWxcU=LkEb8+B=_ePg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Mar 2020 14:54:44 -0500
Message-ID: <CAHC9VhTr34ombz2XgoxKeg5iw0BhMZXPFgefNOFNx8KnAH+GCw@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up error path in policydb_init()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 4:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Mar 3, 2020 at 8:12 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Mar 3, 2020 at 6:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Commit e0ac568de1fa ("selinux: reduce the use of hard-coded hash sizes")
> > > moved symtab initialization out of policydb_init(), but left the cleanup
> > > of symtabs from the error path. This patch fixes the oversight.
> > >
> > > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 18 +++++-------------
> > >  1 file changed, 5 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > index 7739369f5d9a..00edcd216aaa 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -463,36 +463,28 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
> > >   */
> > >  static int policydb_init(struct policydb *p)
> > >  {
> > > -       int i, rc;
> > > +       int rc;
> > >
> > >         memset(p, 0, sizeof(*p));
> > >
> > >         rc = avtab_init(&p->te_avtab);
> > >         if (rc)
> > > -               goto out;
> > > +               return rc;
> > >
> > >         rc = cond_policydb_init(p);
> > >         if (rc)
> > > -               goto out;
> > > +               return rc;
> >
> > Looks like avtab_init() and cond_policydb_init() can no longer return
> > errors, merely initialize fields to 0/NULL,
> > which is already done via the memset above, and are not used anywhere
> > else so those can go away entirely?
>
> OK, but that can be done in a separate patch, right? Do you plan to
> send it? Anyway, I'd prefer to keep the *_init() functions for the
> sake of abstraction - I'd suggest just changing the return type to
> void where possible.

I tend to agree.  Merged into selinux/next.

I'm also not seeing a patch from anyone to change the return type so
I'll put one together now.

-- 
paul moore
www.paul-moore.com
