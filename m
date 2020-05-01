Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B0AC47253
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0042A2173E
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jZWHktIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbgEATIc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730466AbgEATIc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 15:08:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C236AC061A0E
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 12:08:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l3so7977772edq.13
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCkpkOtlwOsj6yyByDhOCENLq0uryXJZ7j98jV5XREE=;
        b=jZWHktIohCDrUqPhu/jEoxkztd3YJBuBCoZdjhaqYxp6ywGOHpItKmE1ZwKFb6QDCy
         V9TxOVv5hMV6eroo1tn29Nrdboy+WCIdhWlsVe1wfJBBrHeaJmE3DDhVKRDQA8D+vMUP
         iUiJQgOzvhvfXrEtFIdEU172W+57HypM/193TSbzIHpfZ10OD4y0dgwsUnA6QfprBA+z
         lt94UWriv9DYBZ17gKh9c1ovp8BC2M5Fx+OtX/JX1BBShbM7RA7KA1h2n80qK69zqV9/
         pU3tq4m3zHEIz9NFmyz0mkEJo5rB9bsWpbBMNhMOzeTrgjrD4yA8NNNPWnuKC80zBOEh
         ytlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCkpkOtlwOsj6yyByDhOCENLq0uryXJZ7j98jV5XREE=;
        b=oO5f0drXHckYBEXdPxO/iDZv1QcsKUkroXwmHp1hT5KkdReSN54DS/tJLk3jB9191F
         sT5gNvfnuEFwRXHyi5zy5PDBnnN59Duh3zA2xn5MC3sHIma9gILszU4UNM1uKuS9nVUE
         SOtLtk5IeLVUoInJn5ExrVwaU6uYvqTNM8EPnrvOdai3RHbVDYbyUA/Wj7tHxfOsudUO
         bFweYG3+jnSWs9ufdDl6O/7j/b6cRn0SE7xNlAN67Q1e+FVRtpRtI3ugQ3+lEIDyquaV
         jiIoadAhdIG2AfiK2MqYxUYLD6OJV6Wi3VtinIWoWuPSfv0eOSqsTfjtAvwc4zBbML3S
         Hj+g==
X-Gm-Message-State: AGi0PubqtacpaWJzv+icEQDBOSllrlt56L1uwbvB+7TtqcCXpxKyrM+o
        hbxaCld6UUF/Qdv48P+E9xgf5sgGgzFFlE1M7uOH
X-Google-Smtp-Source: APiQypIORs+Cop9IBQicsbUSYN+TGqrD67m97odNJVFMYGwyyQGN1TOIF9907nZhf6eAobrIQN3gAawIrU+7oKHPMKQ=
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr4723691edt.164.1588360110335;
 Fri, 01 May 2020 12:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200429073053.83660-1-weiyongjun1@huawei.com>
 <20200429130738.GQ2014@kadam> <CAFqZXNs=YTn-mnzSEssR1szRhSw7Ajdaqg=wy88O_F3gBL2rOQ@mail.gmail.com>
In-Reply-To: <CAFqZXNs=YTn-mnzSEssR1szRhSw7Ajdaqg=wy88O_F3gBL2rOQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 May 2020 15:08:18 -0400
Message-ID: <CAHC9VhTxDkrLP4nvwsUTZDNiLPQJn0=gqTr609MCTrXQU40arw@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: fix error return code in policydb_read()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 9:32 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Apr 29, 2020 at 3:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Wed, Apr 29, 2020 at 07:30:53AM +0000, Wei Yongjun wrote:
> > > Fix to return negative error code -ENOMEM from the kvcalloc() error
> > > handling case instead of 0, as done elsewhere in this function.
> > >
> >
> > Please add a Fixes tag and Cc Kent.
> >
> > Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
> >
> >
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > index a0b3dc152468..a51e051df2cc 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -2638,6 +2638,7 @@ int policydb_read(struct policydb *p, void *fp)
> > >       if (rc)
> > >               goto bad;
> > >
> > > +     rc = -ENOMEM;
> > >       p->type_attr_map_array = kvcalloc(p->p_types.nprim,
> > >                                         sizeof(*p->type_attr_map_array),
> > >                                         GFP_KERNEL);
> >
> > There is another bug earlier in the function as well:
> >
> > security/selinux/ss/policydb.c
> >   2537
> >   2538          rc = next_entry(buf, fp, sizeof(u32));
> >   2539          if (rc)
> >   2540                  goto bad;
> >   2541          nel = le32_to_cpu(buf[0]);
> >   2542
> >   2543          p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
> >   2544          if (!p->role_tr)
> >   2545                  goto bad;
> >                         ^^^^^^^^
> >
> >   2546          for (i = 0; i < nel; i++) {
> >   2547                  rc = -ENOMEM;
> >
> > This style of setting the error code seems very bug prone.
> >
> > The Fixes tag for this one is:
> > Fixes: e67b2ec9f617 ("selinux: store role transitions in a hash table")
>
> FYI, this one is also indirectly fixed by this patch, which is
> currently pending review:
> https://patchwork.kernel.org/patch/11514495/

If we know the code is broken, let's fix it independently of a feature
patch.  Ondrej, I believe the original patch is yours so please send
me a new patch with just the fix, thank you.

-- 
paul moore
www.paul-moore.com
