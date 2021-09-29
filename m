Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D5CC433F5
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 14:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872D1613CE
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 14:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244783AbhI2OaV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Sep 2021 10:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244630AbhI2OaV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Sep 2021 10:30:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03651C06161C
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 07:28:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g7so9425072edv.1
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XIeKvqZhgJzJNZa7GOO4Ir6Dra8+5eTAK0fDO4Lg9X4=;
        b=39Dex7EWib+/mfgk3cg4rGMYSymgqW9CFLKMbi4PtGzqkIqDpMsVx4Elc6/TU3vhY1
         I+5dAOrmSLVNMsHkaeSJEYCztryiBd+3VqKdJqRgOc29rRshdc0hAtUCpb628dmPrMl9
         8TzBPavkgMhA6oslz/ZjJm+qFyAfMbQg1d0k5T76kDzSJuiLIn7RV7c9a5ZzisbcpSVu
         LBE7S49Uyl78zftwa6vZKqYnQdtmApqsrwy/TNlsImX1Vi53rM6/35opuE+avKhs8s9E
         5jUY4ang9kY3q+oe5HsTfEx6/OLr6V+q9qyrCcOerH+EdGMVQp4VpBdAnCpR0oGSNS4E
         QhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XIeKvqZhgJzJNZa7GOO4Ir6Dra8+5eTAK0fDO4Lg9X4=;
        b=lN3gI/hZQtqO6MaS3r+bFHuTxomTLq5HDFepf7vkJjEFIOH8nHqhiAUvtgxhpOMDrN
         LSBXxSmcUouLVhlRyjIjCLm/CYQZrsZlA/T56qlZ1lmzmkWFBNqt3Y1+dndQCQWXu0hh
         pFbIXP0ULi/Ah1L7He6Syy64Gw3nVhEbEz0cKY3w3HP8hmVDt22An8YPimxpb5AnUHwP
         soukt5J9eDpKJ2vicJlypiLcMsYUqLhHaAcQ8AFKAMbycWI39+LlXG51iKolap1VBNxA
         qxWrylFH7d/IwfcNK+EvAppqJZYLQWawuIi+G+Kh8YTl7wkps0+KG1isyQcil7fJMg/j
         oUeQ==
X-Gm-Message-State: AOAM531T2Bn6ZG20+U18efFO9Cr/Q47uyrncmY0EiHig7wrDVPZsO0U9
        ylMn+IKVqcoVvcY9fZTf8qIUl5MgMHXS1juBs5zFbgX94Q==
X-Google-Smtp-Source: ABdhPJzI5pzerSSOXJynuiNiI14Yo3jsIiLRtkL7f5VXV+CjcMy/b/ADx1+YkhHioG4WM5ZxF/YVevl8lJbpkKh74vY=
X-Received: by 2002:a17:906:919:: with SMTP id i25mr13922080ejd.171.1632925678669;
 Wed, 29 Sep 2021 07:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <163292547664.17566.8479687865641275719.stgit@olly>
In-Reply-To: <163292547664.17566.8479687865641275719.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Sep 2021 10:27:47 -0400
Message-ID: <CAHC9VhTP1ReNDcht=O7SVARHwuF818pBn4PbD395QduBEkfaew@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the SELinux lockdown implementation
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 29, 2021 at 10:24 AM Paul Moore <paul@paul-moore.com> wrote:
>
> NOTE: This patch intentionally omits any "Fixes:" metadata or stable
> tagging since it removes a SELinux access control check; while
> removing the control point is the right thing to do moving forward,
> removing it in stable kernels could be seen as a regression.
>
> The original SELinux lockdown implementation in 59438b46471a
> ("security,lockdown,selinux: implement SELinux lockdown") used the
> current task's credentials as both the subject and object in the
> SELinux lockdown hook, selinux_lockdown().  Unfortunately that
> proved to be incorrect in a number of cases as the core kernel was
> calling the LSM lockdown hook in places where the credentials from
> the "current" task_struct were not the correct credentials to use
> in the SELinux access check.
>
> Attempts were made to resolve this by adding a credential pointer
> to the LSM lockdown hook as well as suggesting that the single hook
> be split into two: one for user tasks, one for kernel tasks; however
> neither approach was deemed acceptable by Linus.  Faced with the
> prospect of either changing the subj/obj in the access check to a
> constant context (likely the kernel's label) or removing the SELinux
> lockdown check entirely, the SELinux community decided that removing
> the lockdown check was preferable.
>
> The supporting changes to the general LSM layer are left intact, this
> patch only removes the SELinux implementation.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c            |   30 ------------------------------
>  security/selinux/include/classmap.h |    2 --
>  2 files changed, 32 deletions(-)

A quick note regarding the selinux-testsuite: the lockdown related
tests fail, unsurprisingly, but everything else succeeds.

I'm going to give this patch 24 hours or so before merging, but once
merged we should probably consider just removing the lockdown tests
from the selinux-testsuite.

-- 
paul moore
www.paul-moore.com
