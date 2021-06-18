Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D1BC48BDF
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 16:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522A1613D5
	for <selinux@archiver.kernel.org>; Fri, 18 Jun 2021 16:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhFRQhq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhFRQho (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jun 2021 12:37:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A0C061574
        for <selinux@vger.kernel.org>; Fri, 18 Jun 2021 09:35:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d7so9539513edx.0
        for <selinux@vger.kernel.org>; Fri, 18 Jun 2021 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGe41m1dhvc9F4xTBJF8LWvGPtXlbkSKNbdrcpkCw2c=;
        b=YqTMsQupJJ/Rqehm1zstN9PSsc9uVZ1jbDVE9FhzNmnhRFqbQdoBELADoXCNnYIV12
         jxHeaZhwPMN0W4/ael9iuDEgkI+QiR8gzNF0LvnIk7qTK0tPGXpxyzUoget2StZ89uDL
         lIfS91n+xEOlXiNRB/5dtAGg3tHcF8XlFyKVg6J0+tYyj10781XQNbvX170nyUrM4WM2
         x+XghRcoOwsGJs1c0ZISS0O+7lynGursFbY5vZf0Z85atER/nv+BdYUnUr2vwfBitevF
         Iy5+n5VauhgmSdrc+KMdclZASC4ielzA8kN20FfHdZOEnkS1q0tPaSMiq0gTl+YFrzOp
         Jvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGe41m1dhvc9F4xTBJF8LWvGPtXlbkSKNbdrcpkCw2c=;
        b=IgTizAgazBjKFVLItsURPjbY6eJPvxy81WGW+h3zS0GpL5OdoQFESv+gH9+JvutZ9q
         9fvjQDGpkTcsi05yvTHLgq5FnlLHffVSPVoMf+5VsXiWPw3v+nq/8P0Quxsjt7ltPpb/
         UAS5oXyeT10VlSRbEIjH5is6fzVAXYf2wEtwAQVt30OIspxRn/wRZ2RxcyoclXapzhga
         PPHmRI3Z4dXN9uuO7AX6HL9okziF+aM00Alr6unLXrd6ooLFcCFfGAsETOl2MGfIZKUj
         b1f3cRKz8lJ+TkH+VsNnDjdcJKi+Mwn2I+L+Jj0YMxR9Jg2BUU5w/w+w6J9aw1Z78Xix
         YHJQ==
X-Gm-Message-State: AOAM531vPU7W0qL+B2pRxA3J2McxGjnaALpymSINGctsWm5jXpHXC9Py
        FwTWbQvUdDCJrt+UcmAsnrK5LKKbhqNANSksX6afhgc+1g==
X-Google-Smtp-Source: ABdhPJwwTr61vynpmpeTuVD7iHP9RcUsJA1UzkDCo5K8A+rMW/uXFDAEnX2bTy4S8B0jfm76yIVpOeSx6ENs4l4Szt4=
X-Received: by 2002:aa7:d892:: with SMTP id u18mr6323002edq.196.1624034132630;
 Fri, 18 Jun 2021 09:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <ee75bde9a17f418984186caa70abd33b@huawei.com> <20210616132227.999256-1-roberto.sassu@huawei.com>
 <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com> <9cb676de40714d0288f85292c1f1a430@huawei.com>
 <d822efcc0bb05178057ab2f52293575124cde1fc.camel@linux.ibm.com>
 <CAHC9VhTv6Zn8gYaB6cG4wPzy_Ty0XjOM-QL4cZ525RnhFY4bTQ@mail.gmail.com> <c92d0ac71a8db8bb016a7e94b83c193956d71a26.camel@linux.ibm.com>
In-Reply-To: <c92d0ac71a8db8bb016a7e94b83c193956d71a26.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Jun 2021 12:35:22 -0400
Message-ID: <CAHC9VhRb_Xg11c-qhQUY_KPf6dyHn06NYACigjN4ee+p8NtB6A@mail.gmail.com>
Subject: Re: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 18, 2021 at 12:04 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> On Thu, 2021-06-17 at 23:18 -0400, Paul Moore wrote:
> > On Thu, Jun 17, 2021 at 11:28 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > On Thu, 2021-06-17 at 07:09 +0000, Roberto Sassu wrote:
> >
> > ...
> >
> > > > An alternative would be to do the EVM verification twice if the
> > > > first time didn't succeed (with vfs_getxattr_alloc() and with the
> > > > new function that behaves like vfs_getxattr()).
> > >
> > > Unfortunately, I don't see an alternative.
> >
> > ... and while unfortunate, the impact should be non-existant if you
> > are using the right tools to label files or ensuring that you are
> > formatting labels properly if doing it by hand.
> >
> > Handling a corner case is good, but I wouldn't add a lot of code
> > complexity trying to optimize it.
>
> From userspace it's really difficult to understand the EVM signature
> verification failure is due to the missing NULL.

I would argue that any signature verification failure, regardless of
the mechanism, is hard to understand.  It either passes or it fails,
and if it fails good luck trying to determine what exactly isn't
matching up; especially if you really don't know the Right Value.

What I mean by the corner case was the fact that the recommended tools
should always do the right thing with respect to '\0' termination,
this should really only be an issue if someone is winging it and doing
it by hand or with their own tools.

-- 
paul moore
www.paul-moore.com
