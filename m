Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0294C3F2C6
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 00:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89245246A0
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 00:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nCU1EbhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgB1Ag4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:36:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38771 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1Ag4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 19:36:56 -0500
Received: by mail-qk1-f194.google.com with SMTP id z19so1423488qkj.5
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 16:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xa/VZybxSsIgs76xZxNdg8tCTbSNvadILR1A0qk70+U=;
        b=nCU1EbhRfioR1LhtKzvWzc69SiK7mT0s5oWcd1EbvNwDHaurt+ineYAMzJM7I1P2Ek
         zDamE3AuOuLgx28dj5x1PRwOCyPeiccEVovo8AdTwf4LXc9+uJlW8E5FcAbrgDtftTGj
         a29kvi7CHQYIvWqvBEFaeh7mJTPaNPa1Ra2t4sxm2xe38MOTiFSdkkUOuN+YUkbuIDtG
         4KrMoR2QNkwA/uVU6Oy0V3do5hcScOWsPMgfXDwnidW9sRtf/2KQ68zNvOVWN2b5choN
         JSv1E6UQZz4Q0/GhEu9kEBTrAAjeewjA3gJ4idrabXRdSui14fEE/MUmTHv2wnCO5HAF
         0CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xa/VZybxSsIgs76xZxNdg8tCTbSNvadILR1A0qk70+U=;
        b=WlTSHT6BbBYv1rJAxsPjGHafH2D7D/Q0VWBGBsG13JDjgvs2OkmoXETZ3jBn3sy1dj
         YxWNlBzZIQVF/bTMFXKmathVqpMIXrJBYYiYGWOIAU8wqRLbq0RqKxhcaWeyRcIbgaaL
         3ppSWZcVPDl7YDlfyypHiOAmoy8ugzVLThCP1djYkzO/bJXNREqS7rQZh1Tw9BbN3DeZ
         PDosyZeC+i+uNkDlJygOyqitNrKszyy5Ll+qLcN039v6d8oBnIaiwoo85feZYsTWeTXt
         TJvdyLT51wL2K4DyhrXcR2EJsW1c7d4JNPRZaUX7r3QLcaGBXaxgp4l3FlVRiNFqqIAi
         7HRA==
X-Gm-Message-State: APjAAAXEGxEgZqrQ1oPPLXRpzEgDUQcmHjfiqfZ50XxSBtZNdknnF3El
        6FE9SIde7OhIEeDtMitgeF/f5TIJxOSy2QlO+Zdr
X-Google-Smtp-Source: APXvYqx3Q9xysbF+kpZcyRxsOXB8mAHok4CuTZvPgnYMzbqHP6ZzjNe3jZYqYDYqHAniyFafTZyN8eLcI+lNr91O0rA=
X-Received: by 2002:a05:620a:102a:: with SMTP id a10mr2319350qkk.108.1582850213553;
 Thu, 27 Feb 2020 16:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20200224161023.116134-1-sds@tycho.nsa.gov>
In-Reply-To: <20200224161023.116134-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Feb 2020 19:36:42 -0500
Message-ID: <CAHC9VhSFAmGEMqG=MxiKHrNGb2r6tyhomzrB3AaKNW_XSJTBJw@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: remove unused initial SIDs and improve handling
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, pebenito@ieee.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 24, 2020 at 11:09 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Remove initial SIDs that have never been used or are no longer used by
> the kernel from its string table, which is also used to generate the
> SECINITSID_* symbols referenced in code.  Update the code to
> gracefully handle the fact that these can now be NULL. Stop treating
> it as an error if a policy defines additional initial SIDs unknown to
> the kernel.  Do not load unused initial SID contexts into the sidtab.
> Fix the incorrect usage of the name from the ocontext in error
> messages when loading initial SIDs since these are not presently
> written to the kernel policy and are therefore always NULL.

...

> Fixes: https://github.com/SELinuxProject/selinux-kernel/issues/12
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v4 fixes the commit hashes that I cut-and-pasted from the GH issue
> comments to be the proper length and added the one-line descriptions.
> Oddly checkpatch.pl didn't catch that originally.
>
>  scripts/selinux/genheaders/genheaders.c       | 11 +++-
>  .../selinux/include/initial_sid_to_string.h   | 57 +++++++++----------
>  security/selinux/selinuxfs.c                  |  6 +-
>  security/selinux/ss/policydb.c                | 25 ++++----
>  security/selinux/ss/services.c                | 26 ++++-----
>  5 files changed, 66 insertions(+), 59 deletions(-)

Merged into selinux/next, thanks Stephen.

-- 
paul moore
www.paul-moore.com
