Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732BEC433E0
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5380920838
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELaXpUI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHLSxW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLSxW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 14:53:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E745C061383
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 11:53:22 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id q9so2807246oth.5
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IonvAhj00W/OZYFCkJPEmzRzw1AT3aMN7JDqpfe1ywg=;
        b=ELaXpUI+pwuRj7ZUIBWauXPRBPip6eC+lmI8mbI523GQYtCjpIjsgmpPeSUD/4LzTS
         siaeAAMQNE/yZrJkY6cqXzldofK3wpuwQBXGNMe+otscPykXE7UraPM6I/6ScNdS8tCn
         SMQTSVWQCjKZEDibdu9q+QCUlzoFVN3wIefTt2SkBQEu5Q5Rim0GYrKfjz9cSxcuz9MD
         m+VAKWYqTBys5cm64sO6Xv4xxuWudjV2VJD87kxN8lNtl/OyD6FbycRvZfyBar3oTsED
         2mtI68InTLACXEPig1Yzwj3JRbh/hA6KN0hbxJLQcy4oBfVJDTxALcamIh8FvtPbshXG
         kXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IonvAhj00W/OZYFCkJPEmzRzw1AT3aMN7JDqpfe1ywg=;
        b=kSJudBwkuJZw/4CT076WkbLSUFuhENK34oIwcZ3lABg3zSc1cN0RthSLz8Df/HJFol
         Frm7xe9gJNgZeFK591YpMKA/6+6Bc2u5W10huYh4EfLLJ6Ra+H2c4Og6KjwszsvW0EYb
         vq0uYF2wJrU6zjmKK1huPkua1DW+wfbbadenKIMYJUDRhp+ylMY/sc+fV6kxQ2CFfn/1
         gWUHwS5uvi+Qh/Z8cqvHK90IBJB1sKdM7mMCDZZEwwX0W2j0HZIISg0qtP8U15NdhMNF
         Sxld36cF27/N0yLPX9tHGo7CaUyJszMiZFPg4Ya8sSb4UBEDZNjSqw+O3TnhGHLX6cXa
         NQEA==
X-Gm-Message-State: AOAM533zgBH07nebmYBihLvg9BfZ/54kfzCsrgjsTW4o+qGm6IswcemF
        aWnWl6ujbelRY20EImfE19Z0kSUqYf3Kyjof22ooA2wz
X-Google-Smtp-Source: ABdhPJyLRzhs+fXyJ4/xK4xMQElRtuF3UFhpwgB+6Qdk19G2nknQe8KCjK2K9EV0nzFFZ5hj5uAx4UPnUsIQjbifsX0=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr1016431otq.135.1597258401984;
 Wed, 12 Aug 2020 11:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200812140907.1102299-1-dburgener@linux.microsoft.com>
In-Reply-To: <20200812140907.1102299-1-dburgener@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 12 Aug 2020 14:51:48 -0400
Message-ID: <CAEjxPJ7aQLCAxdQHhWiUF6jUT4Fawm8utETAJSCzuY1k7VwK0g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Update SELinuxfs out of tree and then swapover
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 12, 2020 at 10:09 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> In the current implementation, on policy load /sys/fs/selinux is updated
> by deleting the previous contents of
> /sys/fs/selinux/{class,booleans,policy_capabilities} and then recreating
> them.  This means that there is a period of time when the contents of
> these directories do not exist which can cause race conditions as
> userspace relies on them for information about the policy.  In addition,
> it means that error recovery in the event of failure is challenging.

I haven't looked closely yet, but note that my patches stopped
removing the policy_capabilities directory entries altogether and only
create them during initialization of the mount, because the set of
directory entries is not policy-dependent (only the values read from
them are policy-dependent, not the names themselves).  It was a
mistake to ever re-create those entries in the first place.  So you
only need to deal with the class and booleans directories in your
patches.  Also, I would recommend cc'ing viro and linux-fsdevel on
your patch set in addition to selinux so that they can look at it from
a vfs point of view.
