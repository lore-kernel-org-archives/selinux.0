Return-Path: <SRS0=j8XY=XA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C2BC43331
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 20:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242F720825
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 20:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bHZ8uJcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfIEU1M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:27:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36091 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbfIEU1M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Sep 2019 16:27:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id x80so3135094lff.3
        for <selinux@vger.kernel.org>; Thu, 05 Sep 2019 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVsYT5LiDmTkAuyzoCSrPPZFZ3YwCseupt2r60psf1I=;
        b=bHZ8uJcq2zcPozORM+OzqAQ0bUd3F3XQYjLPmB7yusYpkag+KiR64E1V3jWDbDycP2
         vOrw5bkSrr+36y6niHqNRzPtMJQ6GSjsiuF+UC4uv855LXZNJ4rgsMRT28AlJ+Cp1/hI
         rUDkTms10z6P/y2UpO/FxewO0gHi1hYSi2RKoU6ZYGm9DfXNhEHaepUXf2esHvoMzb/E
         5wPof8VuXMSlT7sthHMqWPY/4pBi2Jk3nTZe+3Pl6UM51Yk71NvLz0SWI7qiwWWgTxzw
         LGWlSPIwqjbYVjWl9dR0iGioUGl3k87QExGfIHBFkkfaLW3Ee5e7FIkMaQ84U/vICuA0
         sWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVsYT5LiDmTkAuyzoCSrPPZFZ3YwCseupt2r60psf1I=;
        b=RhbOUyHDVQTzXHoEXK3tRRBKh73I9Y/C8NDjHEVFAjuR3X18fWqaCzm+5waNRTUgEO
         mnxclyVfviMZFJ67S0dTa7K4+d0PGR2TttlKY4GqsLkzZSymbT50vA/Mkt5BL+dOIQpb
         5utf3/Zz3H6G9bnqOzFwqUQ9h9Sav62yxG5iOqHC4OCnNlZe9CjkxbON/QxC6ame12xV
         NK+QglV5bip+4KO2J2eXGnCzgdFx+LCX2gftjArGz/OGUKX8x1E561Gqu427e5bP0PHz
         inLc1G7pur4apeFSmOI5OB1oHRyka4r6WLysLaY4Vzk2UAnv12Ae8qkMWpGqtignxzYj
         rEVw==
X-Gm-Message-State: APjAAAUpjJjD5elB4marj51L97tJ2JG9oP2JwsdOnJHjpUDSYP+1PFpT
        05k/hkj3goD7FvuUqvkUFKcg2dchliw24ux0j1R4E++yVA==
X-Google-Smtp-Source: APXvYqy9TN7/1cq1Af9uGfhXRRn5jIXAUcggtttorgLfQcc8cNyky0AkBfXNplb8OsogBH6JhvMh7RQCbDI4mrQL/QI=
X-Received: by 2002:a19:8c14:: with SMTP id o20mr3712142lfd.158.1567715229715;
 Thu, 05 Sep 2019 13:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <156763801639.13084.2856415198922787618.stgit@chester> <alpine.LRH.2.21.1909051134200.30667@namei.org>
In-Reply-To: <alpine.LRH.2.21.1909051134200.30667@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Sep 2019 16:26:58 -0400
Message-ID: <CAHC9VhS9Rz2T0W=g_e0a5Jn7XxSjXAA7nTHSEi3z__PQN3oxTg@mail.gmail.com>
Subject: Re: [PATCH] lsm: remove current_security()
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 4, 2019 at 9:34 PM James Morris <jmorris@namei.org> wrote:
> On Wed, 4 Sep 2019, Paul Moore wrote:
>
> > There are no remaining callers and it really is unsafe in the brave
> > new world of LSM stacking.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>

Thanks.

> You might as well push this through with the SELinux changes.

That is what I was planning, it will break the build if merged via
another tree without Stephen's patch.  Merged into selinux/next to be
sent upstream during the next merge window.

-- 
paul moore
www.paul-moore.com
