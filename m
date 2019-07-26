Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F0FC7618F
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 22:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BE021880
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 22:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="xDoqrrAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfGZW1T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 18:27:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47089 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfGZW1T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 18:27:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so33822474lfh.13
        for <selinux@vger.kernel.org>; Fri, 26 Jul 2019 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8eYeTl821S82smPw9iJiAqMlU60zOMO209BKAWQFkI=;
        b=xDoqrrAX/29fjsdMdZBkiD/AzlWVmoHoysj3jMsW9h5wlS6M5rwC69CXH7vrH306DV
         LCOu1+jvjkNXiYrMHyVk14XZoM2Chnxzi8mzN8HIMe4eNYFV0S2geieD3lWPZy8yvyoG
         8WcrN93agtOQM935hiyi+VW3mlsaHHgYzvZuFdN/QPrxefzIPKjhgR8MSRhtbE9nBWtJ
         JpYf3ZOkgRKSki+bZumRnufVb0iICjXdOFXJt7uFZZIezqE3s8LfsqVYxHb7hv9ya6LK
         pOGeyHy1O/k6dY6GctJWboq3so2A7Bx6ZhKQDNVXjOgfkVPBR55mMfsqAFswpffNZ7G0
         Amkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8eYeTl821S82smPw9iJiAqMlU60zOMO209BKAWQFkI=;
        b=HRhHpuof6Qogm6uH4GtZenYQPcLBDDeX2/gvmA1OTdEx+4kHNnAnAiFJT7lCb9X/Cl
         eGEWfAmiqyW52dIlN7KSkmuEAKEw7HDCpeR1yBYhO3qgiELJvfnHt344QoNcQUKRnVCc
         Ts77RwC5EAjhqUzLKBWdoFCCmBh1/wmH9l1Kt7duWwRqb+FDahCdAjKfZFmw5Bq2+Ufy
         QvDTUyIo/mSL4GKzXDfQNY/oOdPhhTMTDidYNdJ9CMZl3V3dr93rM20alYxjIIQ6CLfj
         9UsMMZJt75I3Ev9vljKT+mRRt/Lpb/0g6V4jafXcGKbtm1QAOkwsA7JlVcLbkMo2Ht0p
         XY0w==
X-Gm-Message-State: APjAAAWwAJy7ZNsMOrH4Sg+ntLxlE1ib9OanhJif9N+pt1b5VxeivmMT
        bfWZiJGZBvEIUMP6JLQQXyzIyJZrmjU2mtNq/g==
X-Google-Smtp-Source: APXvYqy4cGGx88Pb6/5fOA5yuzwIGPtQppUI1B7UpGEIvm8tG6d5sF26ExArwdjJRSkswKbcJM5DBQEffZHD6qiyfms=
X-Received: by 2002:a19:8093:: with SMTP id b141mr46782170lfd.137.1564180037460;
 Fri, 26 Jul 2019 15:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190725105243.28404-1-omosnace@redhat.com>
In-Reply-To: <20190725105243.28404-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Jul 2019 18:27:06 -0400
Message-ID: <CAHC9VhR9Lfy0iddbpue2iMKqKGAfqMBeV17KbDoLrM62ngQzKg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix memory leak in policydb_init()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 25, 2019 at 6:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Since roles_init() adds some entries to the role hash table, we need to
> destroy also its keys/values on error, otherwise we get a memory leak in
> the error path.
>
> Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/policydb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index daecdfb15a9c..38d0083204f1 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -274,6 +274,8 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
>         return v;
>  }
>
> +static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap);

I'm prefer not to use forward declarations if they can be avoided, and
in this particular case it looks like we can move the *_destroy
functions up just below policydb_lookup_compat() and avoid the forward
declaration while keeping some sanity to the layout of the file.

Yes, the patch does become much larger (378 lines changed in the test
patch I just did), but I think the end result is cleaner.

>  /*
>   * Initialize a policy database structure.
>   */
> @@ -321,8 +323,10 @@ static int policydb_init(struct policydb *p)
>  out:
>         hashtab_destroy(p->filename_trans);
>         hashtab_destroy(p->range_tr);
> -       for (i = 0; i < SYM_NUM; i++)
> +       for (i = 0; i < SYM_NUM; i++) {
> +               hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
>                 hashtab_destroy(p->symtab[i].table);
> +       }
>         return rc;
>  }
>
> --
> 2.21.0
>


-- 
paul moore
www.paul-moore.com
