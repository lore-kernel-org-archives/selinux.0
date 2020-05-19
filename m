Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB410C433DF
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 21:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA5E20C09
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 21:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bLFESTeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgESVmG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 17:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESVmF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 17:42:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE11C08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 14:42:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z5so776213ejb.3
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 14:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qo/TpiIVszNDGy9XUg9NTQAST/L0Z/ciNjxMWC4L6s=;
        b=bLFESTeDtfgXMsChDJLHZ7h2pR7OLKx3ZLFQpDiIViwBvexUmtLCDbOEwEUpaoFrjr
         vVpP9azKJeWpQS79Zduc6rBmJDKxbK2pEKJNv2breWeh3tDL6IU7yRA461LgNsI/tjxE
         +tHz1Jb306tytLJIEc4u4YcH1qce4jmwrS3f+L0KBXAMpvV8EpbQ9iiKjnA28Bl6jYO0
         yfRZiXvDo4WoucGY3ImEexi3Hhi6+Y3kOTtvLXomAVDM0ph5qiY9sW6u3DWGU76eNAD2
         sjycMUrJ43vnrDwSQdqDKnLAys5ensQ7LFq99mSVvbIIa6jX5ragCF/3qNXvKQgGpzvy
         6CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qo/TpiIVszNDGy9XUg9NTQAST/L0Z/ciNjxMWC4L6s=;
        b=P0fH0yEgrNoLHB4tTZ9QgQicv/UszEIugzsERRbrCTRUpI9k0Ql8SS01TZTpGBwNGz
         QwSQ8xiGM7A7Omoju2cdSJLPDW5VtBI0ZO835Xt0PwGaAb38LrML4tXkws0KFKjpkL6I
         RCenhWiu4A++Yamkk+SZPE2axOwYjoaLNaKHxYD/g8PeFc7IoR4Q8IR9o9GrA72eHhKJ
         y6lSG8nQotRuM2FX03WdJVLJbDH8McBRU4J5MZ2cRDuGcKTdju+EzPXwUfnvOc1jJVOY
         PRVkCzWJkL364oFCqaeI5Su7YgaHbPFffAU8wr+F/fs4pgwFHfQOht8XnjMdNQUVu+13
         qAIw==
X-Gm-Message-State: AOAM533XMzPPRcgKJ20YE4KMHtUVMV7n1qyapCZNgqQE5wGxzsXx5y2+
        o32wyM5lXhjCltFQP/XPFvDXjd5lDfKnTFQMv+aXoEo=
X-Google-Smtp-Source: ABdhPJwUgh3o7WATsOggBd2GXFco6a62VvumbzK/uIvPLRrF2Zv018iSHq1ydo0Pgu+P1LLLdtLw0WP1Sk/LhOL/YNA=
X-Received: by 2002:a17:906:4e87:: with SMTP id v7mr1005245eju.431.1589924523930;
 Tue, 19 May 2020 14:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200519151457.31618-1-william.c.roberts@intel.com>
In-Reply-To: <20200519151457.31618-1-william.c.roberts@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 May 2020 17:41:52 -0400
Message-ID: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
Subject: Re: Travis CI: Run selinux-testsuite
To:     bill.c.roberts@gmail.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 19, 2020 at 11:15 AM <bill.c.roberts@gmail.com> wrote:
>
> So I put together a patch that will let the selinux-testsuite run in a Fedora 32
> KVM instance on Travis CI. The userspace selinux bits are rebuilt and installed
> with the current pull-request patches on the CI build. This will help increase
> automated test coverage for CI runs. This will help provide confidence that bugs
> are not being introduced and that master is stable.
>
> For an example of the run see:
>   - https://travis-ci.org/github/williamcroberts/selinux/builds/688853234
>
> Their are some new scripts in the scripts folder. I made a subdir CI to indicate
> that while you can run these locally, they are really meant for the CI environment.
>
> [PATCH] ci: run SE Linux kernel test suite

s/SE Linux/SELinux/

 :-P

-- 
paul moore
www.paul-moore.com
