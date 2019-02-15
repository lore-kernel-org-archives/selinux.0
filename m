Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E922C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 14:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF242192D
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 14:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="f01nidXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfBOOxB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:53:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35105 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbfBOOxB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 09:53:01 -0500
Received: by mail-lf1-f68.google.com with SMTP id v7so7402448lfd.2
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 06:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GxZzvaw9/yAmfxU6KFqDEy6lQ+acyIwnoI4L0w/tOk=;
        b=f01nidXSZjNk53rNyIqIo+1ghmqnCbLwvoj6hH5pypcbnUEcwVcpJH1pGtPa7if583
         X72v4tx8z3cf7wLJlUmO3+c1waSFkAplBDbcjKHQwbjv6PAwuRh00HBBg9MOI6r6BKEo
         aaiENEq+gxvQm7VPR35Jfw0ledATvVypIGXk/wr17l0oE9wZo8P5RlEluHXdnLZJFbH7
         n6eyWOvMBJIz5DyceJUNYec6t0FhJ5b/+B7ezrKYX1+9XLYX/EO7Du8uPBdw8HgzScWV
         EMHL95yn51O5ZxwBjI3yc1JZkguzgamJnO4VNLckYK7N3b5lNol90bFwLK/mqw82LAfa
         TjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GxZzvaw9/yAmfxU6KFqDEy6lQ+acyIwnoI4L0w/tOk=;
        b=dTyKjzftcWSi/HAg/FO1nDUtSkKLOAW90jc8qaAocQku2IEiTMuU8Rnp1q4cln1umF
         u1Lz7ZNaBAcLQXddLNhg6TdpybpHDySs4HUVKCU6dzu9gg/z845GEnVo9uXk+IrVnPUh
         reBMDaG3oGoBsG9Xi3vKL9bY4GG1dcvfhoztCptFPZE6BtTaBUIzY9NKaAPAbU8YtIua
         Amczm6yRbPsaxUz94MxaKsZ/7wWox3sg4nOwSV49I6Oy5vMorsp5eqfLmanuBDAqKfRp
         g4l3YKB+z0dpfZ6smC7J3p34U3TZVIunO+JTfht2bkDJKftQ6YhW3b5Hmlp1d3GOIbGg
         lpqA==
X-Gm-Message-State: AHQUAuZhD9HKGgCVttFMwgOugLGwHL/884jKKuIDU5KzxdPEQ5i0uSb/
        a3oiF5KENiYVLvCyuUoigPFl8DheZrpUQAVxyKWxTjc=
X-Google-Smtp-Source: AHgI3IZsSah6oTChR0GBTWJC6aJtmaNLS9fyBSashmytPi0AoN1FDH7mfrWpA4VkBBRIgjC1sVPkVItDp9Dm3eAeXvo=
X-Received: by 2002:a19:ee13:: with SMTP id g19mr5709843lfb.72.1550242378996;
 Fri, 15 Feb 2019 06:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20190214190721.1074-1-sds@tycho.nsa.gov> <1f33e665-6147-9c22-ac53-36843035d321@tycho.nsa.gov>
In-Reply-To: <1f33e665-6147-9c22-ac53-36843035d321@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 15 Feb 2019 09:52:47 -0500
Message-ID: <CAHC9VhT-Up6jV+-EUmN=h=DrhrEVdmUy+DLd19+Jftoa3=7dFQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: fix userspace, refpolicy, and mailing list
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 14, 2019 at 4:31 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/14/19 2:07 PM, Stephen Smalley wrote:
> > Update the URLs for the selinux userspace and refpolicy releases,
> > and the email address for the selinux mailing list.
> >
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> I went ahead and applied this since it is a trivial doc fix.

Thanks Stephen.

-- 
paul moore
www.paul-moore.com
