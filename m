Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3CCC35280
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8703F216FD
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 19:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmORIokL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgEATwj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 15:52:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34545 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgEATwi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 15:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588362757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5csxLzWMNUcydmBkcgvRvOKjFPEoRujRS5w0gzdFVv4=;
        b=gmORIokLZqON8aC0tNwcB1rY63tH58AyQGgvpQdbusGz/4bmgK/tDBZElXeeaqWHSeXQSP
        Ozih3x+8v+8XHHHpvUDyIhq596qIfCFTheZ5CaJPhxu6vf33uUrwTPrkbwz7jRfQpn93RB
        6O1I1mTnIdon6tvbwngoOJ/ZX05TiH4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-LZ7JABbxNfm3x5XreEYTUw-1; Fri, 01 May 2020 15:52:27 -0400
X-MC-Unique: LZ7JABbxNfm3x5XreEYTUw-1
Received: by mail-oo1-f72.google.com with SMTP id a144so2835900oob.6
        for <selinux@vger.kernel.org>; Fri, 01 May 2020 12:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5csxLzWMNUcydmBkcgvRvOKjFPEoRujRS5w0gzdFVv4=;
        b=RAerSB36dDgH25kSuvJ49YusxlzAsuXz4mVRZL3TjdW0hdlFVzQnk4Wc8yWRRWe+s7
         m9GZn9/R7SB07S25XV3MQWt03TAQs4vcYCy2fpmG02F/D4gDtyxRZqIhdIZ+vskbxOZU
         TL0+4VSrP1CuazbwmbJF6ns6PgoCkwRg/vDI4+YecvrbZO1EaIINlFfRPPSqIgkxMF8j
         /ytHi4cY87cJjU4Q6dRzO54v2vCKFRukzMneIA7WSv/jSEVNZiU/ZYOjqW8pAawcEfd+
         OVoY65jF28L23OKLqW7O8AxaljsZTvBRqQ5WlexOLLyyccea4IDc59uG5ZVpK3g84rAh
         t3sA==
X-Gm-Message-State: AGi0PuZHg0wSHxpcvgFIpyT4RgWFLhujBNiySXBfa9RxnjsnXKehfF0g
        NMkQh7EuNb7fjgwsXLy+0cIsltLr4a1gD04n8B/2RKOKz3u/DVlfXQwFfEfSlJsPVerg0bQNQxw
        MuuKxao7t1vMw2XWqEzp6gglfZejReWZj3A==
X-Received: by 2002:aca:b6c2:: with SMTP id g185mr972482oif.166.1588362746674;
        Fri, 01 May 2020 12:52:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypK6/aBvUt5PEeHemBtXJFQ0+CwnrU00PHWw1MXfKSj+ePVs/ARQT37gMoZUVxJrKw17sbAdRRbhIT8wfrlPVHA=
X-Received: by 2002:aca:b6c2:: with SMTP id g185mr972470oif.166.1588362746403;
 Fri, 01 May 2020 12:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200429073053.83660-1-weiyongjun1@huawei.com>
 <20200429130738.GQ2014@kadam> <CAFqZXNs=YTn-mnzSEssR1szRhSw7Ajdaqg=wy88O_F3gBL2rOQ@mail.gmail.com>
 <CAHC9VhTxDkrLP4nvwsUTZDNiLPQJn0=gqTr609MCTrXQU40arw@mail.gmail.com>
In-Reply-To: <CAHC9VhTxDkrLP4nvwsUTZDNiLPQJn0=gqTr609MCTrXQU40arw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 1 May 2020 21:52:15 +0200
Message-ID: <CAFqZXNthwrGDOWei-8ET8A-3sE+Ecg3DquHy-EB2YCmDtHAaWg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: fix error return code in policydb_read()
To:     Paul Moore <paul@paul-moore.com>
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

On Fri, May 1, 2020 at 9:08 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Apr 29, 2020 at 9:32 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Wed, Apr 29, 2020 at 3:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > On Wed, Apr 29, 2020 at 07:30:53AM +0000, Wei Yongjun wrote:
> > > > Fix to return negative error code -ENOMEM from the kvcalloc() error
> > > > handling case instead of 0, as done elsewhere in this function.
> > > >
> > >
> > > Please add a Fixes tag and Cc Kent.
> > >
> > > Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
> > >
> > >
> > > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > > ---
> > > >  security/selinux/ss/policydb.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > > > index a0b3dc152468..a51e051df2cc 100644
> > > > --- a/security/selinux/ss/policydb.c
> > > > +++ b/security/selinux/ss/policydb.c
> > > > @@ -2638,6 +2638,7 @@ int policydb_read(struct policydb *p, void *fp)
> > > >       if (rc)
> > > >               goto bad;
> > > >
> > > > +     rc = -ENOMEM;
> > > >       p->type_attr_map_array = kvcalloc(p->p_types.nprim,
> > > >                                         sizeof(*p->type_attr_map_array),
> > > >                                         GFP_KERNEL);
> > >
> > > There is another bug earlier in the function as well:
> > >
> > > security/selinux/ss/policydb.c
> > >   2537
> > >   2538          rc = next_entry(buf, fp, sizeof(u32));
> > >   2539          if (rc)
> > >   2540                  goto bad;
> > >   2541          nel = le32_to_cpu(buf[0]);
> > >   2542
> > >   2543          p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
> > >   2544          if (!p->role_tr)
> > >   2545                  goto bad;
> > >                         ^^^^^^^^
> > >
> > >   2546          for (i = 0; i < nel; i++) {
> > >   2547                  rc = -ENOMEM;
> > >
> > > This style of setting the error code seems very bug prone.
> > >
> > > The Fixes tag for this one is:
> > > Fixes: e67b2ec9f617 ("selinux: store role transitions in a hash table")
> >
> > FYI, this one is also indirectly fixed by this patch, which is
> > currently pending review:
> > https://patchwork.kernel.org/patch/11514495/
>
> If we know the code is broken, let's fix it independently of a feature
> patch.  Ondrej, I believe the original patch is yours so please send
> me a new patch with just the fix, thank you.

Sure, here you go:
https://lore.kernel.org/selinux/20200501195111.3335258-1-omosnace@redhat.com/T/

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

