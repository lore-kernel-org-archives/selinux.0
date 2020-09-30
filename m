Return-Path: <SRS0=YCxb=DH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DA5C4727E
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A37206D9
	for <selinux@archiver.kernel.org>; Wed, 30 Sep 2020 13:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocSGRWv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgI3Nut (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Sep 2020 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nut (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Sep 2020 09:50:49 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AE1C061755
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 06:50:49 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id w25so487817oos.10
        for <selinux@vger.kernel.org>; Wed, 30 Sep 2020 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srSMvRKSNiP48fQGPmG9tWwn/VWAMY48Ol5wwM+ChkY=;
        b=ocSGRWv5rWH5gtq8ZxkYPHZtRlP0Z9F30Tg33jPEwKKzD4QLEHs8WAMjG6VwUcm7Ad
         nWbj6crOdYQD4b+a07tvEtF0AQdTLaL39keL7vfwzuZAR0SAx8GBQiADuwZFSVybhTzY
         045jOSaavOPGxTYBLLXcWfWLKGAXMnuSu6DpJgwnWCTCpSRdG33ZlSBIr5GF+5lYaapm
         BLpzdDejOA0Sb7MnVGBKYZN+ljSFNqzuCktmW2sbuX6rlTMPcOeWMZ9lGXPagY+Ykm9q
         bkL5qAZW+cM5rAJ2A3Kc2g5S6rU6OqlyzO1Pd3mZ9ntsZGLqf3hMy8ECCsj1IMLalIZ/
         JKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srSMvRKSNiP48fQGPmG9tWwn/VWAMY48Ol5wwM+ChkY=;
        b=CWxmqmqP/EysnP4ftkCT/+D5nWMongSOvIEx55NMUDwxgpHx4PxR4FI9rirOs2SuTc
         zggWtOjZieokW+H2rR66u48LZZI//Gyt/1ZY4ywQjfCtyRc9gflEQAbRzrEdBLY5AM9k
         mC4QKdU3xycIxjpip7bSVy3uu9mP/B2WNCrSrFSmqQmamx/d8w98/KAZjbrmx/vc9t0H
         QUzvJcQsgXMHR/tSmtOvPmwPqMEVmOUVx2X88aRjRl1rffYtQOcaklsVlC0jLQ0mtcSp
         9bda2vHAAC0Lzb8Onq0vqXOk6SbajCEV5HUrGn1egdbfP0kIqdE84S5gakXM1lD5VwxZ
         LdvQ==
X-Gm-Message-State: AOAM5314jCkwyaytqGfPd2dYtEeiTcPlyPQbJLHhevIIAAuZteP/CR8d
        rUNWuOYBxrrmQDJx+78J6FGkjUbUd4fOzMJXrBwFoXMY
X-Google-Smtp-Source: ABdhPJweUEzXGJGCkkHnfdsZLQbwKThuFjMEjAH7hMehNMY2smEjhWUj8Kd6aVI5knLNJiYTSDWD2MjfnX1yv4bsad4=
X-Received: by 2002:a4a:c541:: with SMTP id j1mr2046908ooq.13.1601473848502;
 Wed, 30 Sep 2020 06:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ7==mkXDKuDw2YueRP+ymoQjPDdCS8Wk7GJfth+CpLqkg@mail.gmail.com>
 <20200930013653.48787-1-rentianyue@tj.kylinos.cn> <20200930013653.48787-2-rentianyue@tj.kylinos.cn>
In-Reply-To: <20200930013653.48787-2-rentianyue@tj.kylinos.cn>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 30 Sep 2020 09:49:29 -0400
Message-ID: <CAEjxPJ74F7D-3hJbObYXUsJdRcBJs9F5DW4Q-mwn2dm1TwMHmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     =?UTF-8?B?5Lu75aSp5oKm?= <rentianyue@tj.kylinos.cn>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        yangzhao <yangzhao@kylinos.cn>,
        SElinux list <selinux@vger.kernel.org>,
        Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 29, 2020 at 9:38 PM <rentianyue@tj.kylinos.cn> wrote:
>
> From: Tianyue Ren <rentianyue@kylinos.cn>
>
> Mark the inode security label as invalid if we cannot find
> a dentry so that we will retry later rather than marking it
> initialized with the unlabeled SID.
>
> Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
> Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
