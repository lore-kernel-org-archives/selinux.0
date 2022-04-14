Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391C0C433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiDNXjr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 19:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDNXjq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 19:39:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C06BB912
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 16:37:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c64so8181284edf.11
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyu+gdDRfE05wK/y1KmzYA2KdZAavuLSshOg2NvZMt0=;
        b=OuRkExVIalzicE06EE0SSu9Ef0fthRYIWULOT/9rm77St99RlA3zhFBW6vyT1fE1i+
         VfLKenIwsqE7wUHGiODZsfxmv0u3yOpOKnoghaHETGhZ30GmBL3GI1Nz6NcQAscQER6i
         Vlu+eQO2iRDEIHRYoCXxjNxaa7h84q2xph+3WPX/UPVaTbtXNE+cENczL/PpeiBEHQN7
         ulwTvbrm7vMeHsxgf0gl2ybF/WpZtw5Suaz38kMf06UmH97tGfIE454126t9HnE1TzIF
         /QmCfhc9DTAtL2Ra/N/ywqyybyzuQO+9yroejRz1HbJoO6YuvZuJsPhQrgJxudqFSFj8
         qj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyu+gdDRfE05wK/y1KmzYA2KdZAavuLSshOg2NvZMt0=;
        b=eHMgfgdcfMR/a854xgrRljmb2sxEmFJH4HeoWDVZeFgycqQcWDGey5M9CTgIo8Sw46
         2O9VbKEeviLjxESxpJDDyvGxiPdygVdqqOSAC2+mRBU8umxHeCQSi1Kwe9M7mfWglpkJ
         XupCSQBg+FE+eCe8X4BDoRAXG2O5rYnsx/q3bClCanl2J6du/cLUKf3kYNdlf4p+wxZu
         kRVsg9wjrp9GuszehW5wSaEbF4s96Dq4qRnXMC1DqWfXtw0vpGqmmrP+RUG/bfsiAOcJ
         WQv/p9dVkN8uZmeWe1ooTOgUTl+PsPRoDhLzQ2paAE6/g1UIRKDNBjmtSV+apGSQEKyK
         re0A==
X-Gm-Message-State: AOAM532qJhw0ZmdhCgAsFHYlmNm0h2Vece3GZWV7JaywkxMrDO5sj8oT
        V6zm+N/dtuJ/HBvrRUug+aDDtX+q5UUSVVxX4Yn/zK4rxA==
X-Google-Smtp-Source: ABdhPJyHX07N2hHvsJhGijj6lH8NDCOimISMp3/v0AM7m5YeyC0sS8bBE+4IFhmtpBoCUKHJczEhrpAP8QwB+o5t77w=
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id
 i20-20020a05640242d400b00412c26b0789mr5583828edc.232.1649979438342; Thu, 14
 Apr 2022 16:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <164996959615.228204.13557296900347416352.stgit@olly>
 <CAHC9VhTm2rgrP9wRiuQFDDY2iCN=iguBeopVU0=saA=jvP0VtQ@mail.gmail.com> <CAHC9VhQWBp1xffJp22KexsanEt4vqyUgbSR1LSWOjEtYXKc+fw@mail.gmail.com>
In-Reply-To: <CAHC9VhQWBp1xffJp22KexsanEt4vqyUgbSR1LSWOjEtYXKc+fw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Apr 2022 19:37:07 -0400
Message-ID: <CAHC9VhTH86YS4nzXL2R_mw+jrqr5nrFwxOdnx5D3ZF7oj=NJ4Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't sleep when CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE
 is true
To:     selinux@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 6:05 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Apr 14, 2022 at 4:54 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Apr 14, 2022 at 4:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Unfortunately commit 81200b0265b1 ("selinux: checkreqprot is
> > > deprecated, add some ssleep() discomfort") added a five second sleep
> > > during early kernel boot, e.g. start_kernel(), which could cause a
> > > "scheduling while atomic" panic.  This patch fixes this problem by
> > > moving the sleep out of checkreqprot_set() and into
> > > sel_write_checkreqprot() so that we only sleep when the checkreqprot
> > > setting is set during runtime, after the kernel has booted.  The
> > > error message remains the same in both cases.
> > >
> > > Fixes: 81200b0265b1 ("selinux: checkreqprot is deprecated, add some ssleep() discomfort")
> > > Reported-by: J. Bruce Fields <bfields@fieldses.org>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  security/selinux/include/security.h |    4 +---
> > >  security/selinux/selinuxfs.c        |    2 ++
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > This patch is very trivial, but just a word of warning that I haven't
> > actually tested it yet, so YMMV ... my test kernel is building now.
>
> Everything is behaving sanely on my Rawhide VM, both when built with 0
> and 1 values for checkreqprot, so unless I hear any objections I'll
> merge this later tonight.

.... aaaand it's merged.

-- 
paul-moore.com
