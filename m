Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDEBC433E1
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA8320708
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 16:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="i3m7gRcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgETQ4m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 12:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgETQ4m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 12:56:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224C3C061A0E
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 09:56:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k19so3850943edv.9
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjLOrzyx9NXeAy8+V0BPv7NC/LuPgJYyJRuAESsqyBc=;
        b=i3m7gRcKd1hc/rN53O49nM/3AymoYKbHEFWNiE3cI1k7LjdHMbniXmHyjr0pr//SzT
         F7a8Fjlmbn3WoI1LZzJRByJQ+MhXTbKqaQkLup1N2Dh4zRS1G0WlDtggNV5xscm3bHUR
         +m7Rs3dDCG911+Le8WbMrTF8TxEWkbQPkS9jDAoJv8aXyM0ZsiwuW4htOKEYS2sKAHTt
         hP21yPhxX0RmQV8LLu6qvsKUA3iyXoKfUJ9bdikBOw/8WWImZ9CSwZUFWukXZxeIoboe
         GfxWTAVLeWfzgG9j/E1RoEehg4+FUXguzzgNj3XsNhxtMxdjRyzz2lNRNKJntpBpK0tj
         V/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjLOrzyx9NXeAy8+V0BPv7NC/LuPgJYyJRuAESsqyBc=;
        b=YFJUJLs/Fu2cORxiwA82hNfzdEAEw8ktV0pm3LKbDRXcILOVldM5P8rf80wCd0oypK
         2SdNRp5j0mbzdi0S5eba6M+IB0VhcTu8/nPm/f2RJTCgzFSxANjv5pyRe1qmfl7liuzo
         szzVVJSMoCrTk9khKa3CgLqH8t7IcfJl9PvS1wxqKmCTYyzkGX8HLJpOCHaNql8C70zn
         rnVOWXESM4gWnzHSND5UcEid9vyv4l2Nqw/T3jlU9vUBYQJK80SS2tgmsGaiFhOGUA21
         zysOQUHHhfSknsalL7si+2LL+BBeF8XWaWQ6OT8kK/iWB9N0vnjjJ6nv12OO9RBKYhrf
         tmJg==
X-Gm-Message-State: AOAM532uNtqgpYwhVN3KvCcut3gPetQ0w0WaFjPikhTMkIXgJ6B0gMl2
        uOZPxnV46emddlSJgSuHKfZ/BdMIvPWrGteXCdM1
X-Google-Smtp-Source: ABdhPJy6+inN9P6TjV9C4k2qlt8cJvX8FU8Aowi7KlnMkCY+lcpEkqZLZ/+XsI4Lyg88pL0Fq3fLlOFykgUkZ1RUf6Y=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr4471428edw.128.1589993800738;
 Wed, 20 May 2020 09:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com>
In-Reply-To: <20200520163421.27965-1-william.c.roberts@intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 May 2020 12:56:29 -0400
Message-ID: <CAHC9VhSw5V3XKa57s+NbVR0XPutRg1c=9q=_SFpBz4hxjG8HUg@mail.gmail.com>
Subject: Re: [v2] Travis CI: Run selinux-testsuite
To:     bill.c.roberts@gmail.com
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 20, 2020 at 12:34 PM <bill.c.roberts@gmail.com> wrote:
> V2:
>   - Added some dnf and ssh options
>   - fixed SE Linux to SELinux

Thanks :)

> FYI The additional dnf commands didn't add any time really to the build,
> the latest build is:
>   - https://travis-ci.org/github/williamcroberts/selinux/jobs/689293166
>
> Note that I squashed the patch series down from what that CI build saw,
> but the diff is the same.
>
> [PATCH v2] ci: run SELinux kernel test suite

-- 
paul moore
www.paul-moore.com
