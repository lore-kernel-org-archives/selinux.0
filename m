Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFBC433FE
	for <selinux@archiver.kernel.org>; Wed,  2 Feb 2022 11:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbiBBLPa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:15:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343840AbiBBLP2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Feb 2022 06:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643800527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+RrgHuoDl7M1QEbXcn4m2MpVuIXUyU64Gjjitl9CAU=;
        b=Y+S3ZXciTN7OMjj0Sv73iYyFBKDyv21F8II7Sz7klBga+gt1Ht9cFU//vxBrVA8nNpYlI5
        fnhEJT7tGnqOeHmR6FDaHY8EghSf6g3bSIKNrTCpsJftXIzcIJc4gYFY2Ou9WGfTj9awND
        nH8CVY/5ESOrkXUj/DixCkjk9788Sqs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-FTtE4VxvN-WAddjFMl1y8w-1; Wed, 02 Feb 2022 06:15:25 -0500
X-MC-Unique: FTtE4VxvN-WAddjFMl1y8w-1
Received: by mail-wr1-f71.google.com with SMTP id q4-20020adfbb84000000b001dd3cfddb2dso6771153wrg.11
        for <selinux@vger.kernel.org>; Wed, 02 Feb 2022 03:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+RrgHuoDl7M1QEbXcn4m2MpVuIXUyU64Gjjitl9CAU=;
        b=3GZUxe207jniQ7JGLEWPz6lp8PkQ9anDcHPWHLkumd0DVE7ye7dRAn+NsaDTVqKDQC
         ktl9ygqhVTzi/9aCUAZYAKY4fcAvwR0CpFG0XHWOChatVaNHgX79zDc5Tf04EwM7fnqU
         aRZ6BwmCyjqP/oml7448kkrGcdusJ5NWX7Kqn1kVgxMhI28rsr4rZp+NQdstOq5337x7
         30DpplbxxiHg3VODZtMvLGcL0OIMOiBMNyVFIpCmd0svezpzPkYrYI+pYn8NK8DQyKPR
         6t0bZQr8EgGjSgS4DleFexVXvCM291mB9URcl02KJpUrOuUvG3ITsg9J2gPXdWAxTcU2
         83FQ==
X-Gm-Message-State: AOAM532yAXKW2AOmY3WejufVZO9wjOLuh40mdraNEnl0RA0p+pYX1WGe
        HoV2mWcZT2fhYT4kShr9o9l7IZ+TTPaBBKA6SpKuowYXl0xK0LjkVtVHN7L5cQXFmry6q/L2OWt
        lPZyNR6JcayP0GPNCG4bllwl0aE242XHj+A==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr25398156wrw.351.1643800524158;
        Wed, 02 Feb 2022 03:15:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYXUHhgSLHqw5s9ksxKF1GddwzaXPe6Jy+furjkmPn1aaYRk34LT/vH3NGrNrnm0KYLC9ewubhdeprXBtk3pA=
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr25398136wrw.351.1643800523886;
 Wed, 02 Feb 2022 03:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com> <20220128202858.96935-2-vbendel@redhat.com>
 <CAHC9VhR78VGMPLv1xBRQEqzaPjJa_KvFE8OLmHa6J2pjaG6m1w@mail.gmail.com> <CAHC9VhRkL++m_jkqK+0D2rXc_LMbkH1SSFGmAJiGEeDu6rA-xQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRkL++m_jkqK+0D2rXc_LMbkH1SSFGmAJiGEeDu6rA-xQ@mail.gmail.com>
From:   Vratislav Bendel <vbendel@redhat.com>
Date:   Wed, 2 Feb 2022 12:15:07 +0100
Message-ID: <CAHrQN1zVgNFrxns32nw5r5iEA21SKWgyYUeoApwz5UC1K86KfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: consistently clear cond_list on error paths
To:     Paul Moore <paul@paul-moore.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 1, 2022 at 9:10 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Feb 1, 2022 at 12:38 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Jan 28, 2022 at 3:29 PM <vbendel@redhat.com> wrote:
> > > From: Vratislav Bendel <vbendel@redhat.com>
> > >
> > > Currently there are two users of policydb->cond_list: cond_read_list()
> > > and duplicate_policydb_cond_list(). On their error path one clears
> > > ->cond_list to NULL, but the other doesn't.
> > > Make the behavior consistent by resetting ->cond_list to NULL in
> > > cond_list_destroy(), which is called by both on the error path.
> >
> > It's also important to see if there are any callers of
> > cond_list_destroy() which incorrectly might be making use of
> > policydb::cond_list after it has been freed; thankfully that does not
> > appear to be the case in any of the call paths I looked at just now.
> > As this is more a a style/Right-Thing-To-Do patch and not an immediate
> > bugfix I'm going to go and merge this into selinux/next.
>
> After looking at patches 2/3 and 3/3, ignore the last sentence above
> and see my comments below :)
>
> > Thanks Vratislav.
> >
> > > Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> > > ---
> > >  security/selinux/ss/conditional.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> > > index 2ec6e5cd25d9..1d0e5f326b62 100644
> > > --- a/security/selinux/ss/conditional.c
> > > +++ b/security/selinux/ss/conditional.c
> > > @@ -152,6 +152,7 @@ static void cond_list_destroy(struct policydb *p)
> > >         for (i = 0; i < p->cond_list_len; i++)
> > >                 cond_node_destroy(&p->cond_list[i]);
> > >         kfree(p->cond_list);
> > > +       p->cond_list = NULL;
>
> While patch 1/3 may not be a candidate for selinux/stable-5.17 by
> itself, patch 2/3 definitely qualifies.  Considering that both patches
> are small, easily understood, and the likelihood of a merge conflict
> between the two is high, why don't you squash 1/3 and 2/3 together so
> we can submit this for selinux/stable-5.17?  In addition, put the two
> lines which reset cond_list and cond_list_len together in v2, it's
> cleaner that way, example below.  If you don't have time to do that
> let me know and I can squash them together and move the
> "p->cond_list_len = 0" line (don't worry, I'll preserve your
> name/email as the patch author).

I was also wondering about the possible conflict for submission
into stable. I see no problem with squashing 1/3 and 2/3 together.
I'll send the v2, as per your suggestions. :)

Thank you and have a nice day!

>
>   static void cond_list_destroy(...)
>   {
>
>     /* ... */
>
>     kfree(p->cond_list);
>     p->cond_list = NULL;
>     p->cond_list_len = 0;
>   }
>
> > >  }
> > >
> > >  void cond_policydb_destroy(struct policydb *p)
> > > @@ -441,7 +442,6 @@ int cond_read_list(struct policydb *p, void *fp)
> > >         return 0;
> > >  err:
> > >         cond_list_destroy(p);
> > > -       p->cond_list = NULL;
> > >         return rc;
> > >  }
>
> --
> paul-moore.com
>

