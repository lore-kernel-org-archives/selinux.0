Return-Path: <SRS0=dH2y=DG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E82C4727C
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 13:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD102075A
	for <selinux@archiver.kernel.org>; Tue, 29 Sep 2020 13:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ9QF9Ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgI2Nbw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Sep 2020 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgI2Nbw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Sep 2020 09:31:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F970C061755
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 06:31:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s66so4437888otb.2
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2020 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64fGgb2lZIxqumM6Oe0+CrlqWKgGJI2qmxpw/c+NCe4=;
        b=BZ9QF9AkM1JGe1UTduTXfrvbpwN8XRmwwaxFcnzcDBox6Wa8vNtzqI324QkeOo+t2P
         HU59dTBlk54pQaQpliXiuBS7n1+bj+43fHEPmR9iV5cb5L8fL4mOjJKEqg4GITafn8sk
         Z6GC/LjLe0feALEoIdHimvYlFho1KgtX9eR5B4KOpnz2wvrdLDIhs5reMsDcVGU+RBrP
         qAGTLXjmE5oAtVWXUQNQEpdRYJ1fYNBQZt72TPIiLK0Ou7YXVjfh8f81uspPSqcyXhwI
         m5i1aP1vOUyeVeOamQSCPVJ54Tw46YGwOjPDyjHl3Zm5vjjZmfVAtnO/mz0JL8zXuZUt
         VZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64fGgb2lZIxqumM6Oe0+CrlqWKgGJI2qmxpw/c+NCe4=;
        b=Hpd9vnHcsF9C1t2xbQPK1TnW70fv3C9WOxj16iGqSxWWnm8NtIZpjlM3txdEVS8R4S
         qY/Me63Fc99dMTjJxRzMHY02LsbLzF0bFMLGeS2wYEuwfWhHNyJaewz/2au4pq4Xb2S6
         3wlNi9XMJFXhi7nWzC/8tsnY4dE67tLuYfi0tf78NdUjqaqrp9uiYitnb2MBUheYSSsb
         JHwOPDRb1YtGg1M3F7Tf1KYQutaEkeQoO3s4b7HVvI9dXEWiwFzQAbTnZ9ZXAxCak0yd
         n1KKPY1WvbAyKQk46VnWRq7WEB75vk8maNZArljmo1RsDrlyWqMCRViVnH7gPDMKaBcX
         U9aA==
X-Gm-Message-State: AOAM530vvTHBWrmw9rCpj1rwrj+Qa56zDJk4f9J31zm8GD25CELrfATz
        F7n5LvYMsC4MlbEB9P9vYJPQxG9AHLNhsYrdXg8=
X-Google-Smtp-Source: ABdhPJzJ1aGxAl24L2/wF9IkXgvR8fVe7fz7SBE8F45MGZKUjmEpLnCWFaHH9anN9/9pkfgPqGQIBgJYBqw6apV/zV0=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr2648962otn.89.1601386311410;
 Tue, 29 Sep 2020 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200927094243.43673-1-rentianyue@tj.kylinos.cn>
 <20200927094243.43673-2-rentianyue@tj.kylinos.cn> <de004adf-fde6-11f1-fab1-11289788d4ec@gmail.com>
In-Reply-To: <de004adf-fde6-11f1-fab1-11289788d4ec@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 29 Sep 2020 09:31:40 -0400
Message-ID: <CAEjxPJ6z-ZsbsbdpDtOWxJ3_rJPjREKhNXkBn5bV_pYzW7AYnQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     =?UTF-8?B?5Lu75aSp5oKm?= <rentianyue@tj.kylinos.cn>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     yangzhao <yangzhao@kylinos.cn>,
        SElinux list <selinux@vger.kernel.org>,
        Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 29, 2020 at 8:54 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On 9/27/20 5:42 AM, rentianyue@tj.kylinos.cn wrote:
>
> > From: Tianyue Ren <rentianyue@kylinos.cn>
> >
> > Fix to initialize isec->class with SECINITSID_UNLABELED other
> > than the from the xattr label when then dentry is NULL when
> > the filesystem is remounted before the policy loading.
>
> Looks like this was broken by commit
> 9287aed2ad1ff1bde5eb190bcd6dccd5f1cf47d3 ("selinux: Convert isec->lock
> into a spinlock").

It appears that the broken commit assumed (wrongly) that isec->sid is
0 initially, sets sid = isec->sid, and then in the out: path, if (!sid
|| rc) it sets isec->initialized to LABEL_INVALID.  In fact, isec->sid
is SECINITSID_UNLABELED initially upon selinux_inode_alloc_security(),
so that !sid test never evaluates to true.  And changing it to compare
with SECINITSID_UNLABELED wouldn't be safe either since it is possible
to end up with SECINITSID_UNLABELED without it being invalid.  I think
your fix resolves the issue with ensuring that we retry upon
subsequent attempts to access the inode but we should likely fix up
this code.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>
> >
> > Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
> > ---
> >   security/selinux/hooks.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index bf8328adad8f..da7295a546e0 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1499,6 +1499,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> >                        * inode_doinit with a dentry, before these inodes could
> >                        * be used again by userspace.
> >                        */
> > +                     isec->initialized = LABEL_INVALID;
> >                       goto out;
> >               }
> >
> > @@ -1553,8 +1554,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> >                        * inode_doinit() with a dentry, before these inodes
> >                        * could be used again by userspace.
> >                        */
> > -                     if (!dentry)
> > +                     if (!dentry) {
> > +                             isec->initialized = LABEL_INVALID;
> >                               goto out;
> > +                     }
> >                       rc = selinux_genfs_get_sid(dentry, sclass,
> >                                                  sbsec->flags, &sid);
> >                       if (rc) {
