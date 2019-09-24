Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A039C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 17:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6EB20673
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 17:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Mpv1TiJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407039AbfIXRUI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:20:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40743 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404908AbfIXRUI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Sep 2019 13:20:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so2722783ljw.7
        for <selinux@vger.kernel.org>; Tue, 24 Sep 2019 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+maT9LH27wEaHgXwpmHUnOLgFUUoW0dWKeXWGozz1g=;
        b=Mpv1TiJ78kOeML+d3hgNGv4Hnk2mjiPvo2MF1KsLdAiJNk1/xH8kA74iFv5dZQQhzQ
         B/xAEOUSy9bvA+3PCVmaw+ZkgZTyY3W5eNfvULkwwnJNk/025LmUfdHkitE/2z1LH3If
         wWM5f+BoJlcpeQoapdQ/UJej1cyG7XNbf/p21WJcrNKXQ533IE035K2AEaGpN4DxUAV2
         SZlU1OyxfKVjRAe3r0A+EpPslJEiTpmwrs5JmAJFoRaPzXj3hrP+dlHQhGuX+pj2qHP1
         mS9z49bf1ML/uhhUUeQCWMqq5KQQCpJy3jKD9e2N8WuuZSfplyQ51oeaBONrO/S/H6PB
         sMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+maT9LH27wEaHgXwpmHUnOLgFUUoW0dWKeXWGozz1g=;
        b=QdxzPj9YGEoP4onO1R/bBJWyzYgoemURNocQsMxin0jCkwW83AuDDrVz2OFCG6Jn8T
         EmBbKPbM84FRsPgiE9X+x5dhOL3AgxhBOlZcGkgu7uNAPQQ1XsW0dC+GBMj2MVkpDbb6
         HjQvOh9iv7ZKMgNepxpNSnATHnBqhAHgGs1N3830cB3cD+p99wtvCR+0byy/00tCM4SZ
         HZKLYEo/GI4EGOY27xjBh8W4+7M984CYVwOZFEI5emGvSXXqaj76PgbqlOvzLtpiEPPl
         4Y6+/jOSKrtrd7VCVWHDLPqjuXlyWHXavi2K4tfBPrzMy+Xmc9mVtG1lP9arUXoXOpF2
         PX5A==
X-Gm-Message-State: APjAAAV0PCI/rWxZmhkThrWlwecAQNb+lN5Wr/zRybYxtKuKIKIQ2m6S
        paZ0oaAZL4RVo23hSNL+SgWHQx6BsHrFFFG8axVQ
X-Google-Smtp-Source: APXvYqyj2s8e15du5C+C8BZcC95oy7zxu3gp+OeB8yj5+aye906hN/IVwJ//AK5lqKDhhtHDpJpBaSGgMpaQYicxZwc=
X-Received: by 2002:a2e:9b5a:: with SMTP id o26mr2730296ljj.158.1569345604628;
 Tue, 24 Sep 2019 10:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <156927687193.621177.11371002337716273956.stgit@chester>
 <156927696325.621177.10551869484430505777.stgit@chester> <CAFqZXNvhNUvCoquAC-Zq9hZCSmAVUGySubJSUER1x--MqqPdng@mail.gmail.com>
In-Reply-To: <CAFqZXNvhNUvCoquAC-Zq9hZCSmAVUGySubJSUER1x--MqqPdng@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Sep 2019 13:19:53 -0400
Message-ID: <CAHC9VhS3GKytH1_kpMN0tcJMEftxASf8GfwxASQ579B2=hnqYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux-testsuite: use our own version of perltidy in
 the Travis CI tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 24, 2019 at 3:26 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Sep 24, 2019 at 12:16 AM Paul Moore <paul@paul-moore.com> wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > Unfortunately the perltidy results differ between moden distros and the
> > current Travis CI environment.  This patch attempts to address this by
> > using the current upstream perltidy in the Travis CI tests.
>
> Generally thumbs up from me, although I have a few comments below.

...

> > +before_install:
> > +  - git clone https://github.com/perltidy/perltidy.git perltidy
>
> I think it would be safer to add here something like:
>
> - git checkout 8551fc60fc515cd290ba38ee8c758c1f4df52b56
>
> That way the Travis checks won't suddenly break when something changes
> in the master branch (where I'd expect things to change/break once in
> a while). IMHO having to bump the commit manually from time to time is
> less bothersome than having to deal with random changes in the
> upstream branch.

I added a comment indicating that 8551fc60fc51 is a "known good" HEAD,
but I'd prefer to just stick with whatever HEAD might be unless we
find it to be problematic.  If it turns out that things are breaking
often we can always checkout a specific point in time.

> > +  - |
> > +    (cd perltidy;
> > +     perl Makefile.PL;
> > +     make;
> > +     sudo make install)
>
> This is not a big deal, but you might want to join these with '&&'
> instead of ';' since if an earlier command fails, it doesn't make much
> sense to try to run the rest (the pipeline would then almost certainly
> fail later anyway).

Good point.  I'll make that change and push the commits.

Thanks for the review!

-- 
paul moore
www.paul-moore.com
