Return-Path: <SRS0=8qmv=EF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF38C00A89
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 20:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C389E20797
	for <selinux@archiver.kernel.org>; Fri, 30 Oct 2020 20:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="GxBUFZvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgJ3UiH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Oct 2020 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgJ3UiG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Oct 2020 16:38:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC37C0613CF
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 13:38:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t11so7909808edj.13
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2020 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtPauSqKwJG5D5tXCeCcRBhlhHsdB0HpiFXLoo+fML0=;
        b=GxBUFZvgq5bsOLRF3G84VhjEqHDdIhTwWOPjIIqoJZG63kQ/W7QPdx2MmUo1rfOXXS
         d4kQ8dDsbb6aXEkjCPTusrfNQOhA0GDB5cswx0HzCXNCIbMrStkYM9f3Kj5rMsXNLH6F
         ULsJnFrfRvCcWMZZysIxVyM9ILQwquXjNCURhRZ/92wLdM1EA5brfeyh0U4jdEPIw0WX
         1mwqjOqiw4OvZ9nTXXd79KyaaM/PM3svHnh7E2YIrxyoWdlPF7XRNV6o9DAlkknUnXLn
         9SILO/cWefxXXFKV+JYj+aVRex+Lf2jeXOTdyaWTibZxTkFfOYtWv9WWSkACftv4XTsS
         oANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtPauSqKwJG5D5tXCeCcRBhlhHsdB0HpiFXLoo+fML0=;
        b=l4lYXusmMe6Zkq5TednfavhXj17oormq/hUYwTUSCBd2+vlTZ8UXAj6EMfcV8Mv0l3
         JUSFOqlUowhwRPnRHnaP58o5YYUzM6CKUIv852l6oykuPYPI2dBEuIjf8j77y6YMo94p
         3L/3bL9+Z/GbIF5DKwThVc+ysw9kFmU+6PkpZS2Vb/Uj3m4OMJUtGgm0Xa7pMzpNEPSW
         qvevWanb9JKHgJc1x16mbTrFv5loF/4UQ7tvy3o0qqPBUJN9LYUwP9oupQubTN6G+6W6
         xMcmzgd9Z3Ugk226OgE8eN18qKcDIKB6xAovyjHwjW+HGlQ+hUK3pcle1dG/vKBCz7Q4
         PVlQ==
X-Gm-Message-State: AOAM531EDxnj4158PBm2S0A+ZXElVwXYQyAr/TH8BqZ7+zsZ1YG0F6t7
        RhdaIqaoYvWNMLOvqqUIfzODb7TQzhMkqIro6PNrcm22nmSA
X-Google-Smtp-Source: ABdhPJwCTC9hqhAPRcAXeSRxUNIhXXZ6FqpWVMydk28cE7eJAdL1lcm2vdJwxicSEgr+1VaVQ+gK8Ng2Mz7izW1PxJY=
X-Received: by 2002:a50:a6d0:: with SMTP id f16mr4271625edc.135.1604090285122;
 Fri, 30 Oct 2020 13:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
 <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com> <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
In-Reply-To: <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Oct 2020 16:37:53 -0400
Message-ID: <CAHC9VhR8mbqZS3TVgG7MxQywe9uqDRCN+c59PozLTpOoQ-mK7Q@mail.gmail.com>
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 30, 2020 at 12:43 PM Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
> > Unless this patch set is specifically dependent on the two patches in
> > the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1.
>
> Thanks Mimi. We don't have dependencies on those two patches in SELinux
> tree.
>
> We'll base our changes on v5.10.0-rc1 in SELinux tree.
>
> Thanks for the quick response.

I'm not as fast as Mimi, but I thought it might be worthwhile to
provide a bit more detail as to what I expect from SELinux kernel
submissions.  I believe most other maintainers operate in a similar
manner, but I obviously can't speak for them.

Unless there is an exception due to a previous discussion, I ask that
all SELinux kernel patches be based on either the selinux/next branch
or Linus' current tree.  If your patch(set) applies cleanly to either
of those branches, and passes review, I'll merge it into the
selinux/next branch taking care of any merge conflicts that may arise.
If the merge is particularly tricky I may ask you to double check the
merge afterwards, but in my experience that is rare, most merge
conflicts are trivially resolved.

In the case where a patch(set) being proposed for inclusion in the
SELinux tree has significant changes to another subsystem, I will ask
the affected subsystem's maintainer to review the patch(set).  If the
other maintainers do not provide an ACK for the patch(set) I will not
merge the patches.  If the other maintainers do not respond at all for
a few weeks, I may go ahead and merge the patch(set) anyway; that is a
decision made on a case-by-base basis.

If the patch(set) introduces new functionality I will ask you to add
or update an existing test in the selinux-testsuite.
* https://github.com/SELinuxProject/selinux-testsuite

If the patch(set) introduces new, or changed, functionality I may ask
you to update The SELinux Notebook.
* https://github.com/SELinuxProject/selinux-notebook

Beyond the above, the general SELinux kernel tree process is
documented in the README.md found in selinux/main:
* https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/tree/README.md

-- 
paul moore
www.paul-moore.com
