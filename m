Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD17C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 14:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B190206D7
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 14:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="okP+QpSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfLPO0A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:26:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40132 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfLPOZ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 09:25:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so7006882ljs.7
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2019 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNsMW+NwAwrOgzKdybNMTFImbblwkHO9DHhy0HiCdBU=;
        b=okP+QpSoosMPSchTjgJs4anufmI11Ah5fTVGpn5ZnQTG0TNzq1Qsxt2nmAr2PMVFHt
         4dF9nIwXdIA4VrJlVxdiQtAKtfQXifUIiatfLTl/gLfpUNBH78o816Z6+2d0l0I0Qw1w
         SwXvhLY2L4KWGbQxn04LvP2pwNakxGEIVwS7CrJ4yIiHIke7Zv657c50xRbUNwobLr/V
         6ZTQqcybq98OMspHMwF60K9X0y47/0z9QKsdBTANBI4cZl6yvZbrBCUx8fYnbw6Gqksl
         VdPXhWCagwnXpUQiW0vr+Eu5niZ+IiQk6qf7sKmlTKYpOchrCawIMyu40wn7agABSozo
         /vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNsMW+NwAwrOgzKdybNMTFImbblwkHO9DHhy0HiCdBU=;
        b=EYowXI+e7pDoiRbXTtfoOqkygeHzyWOdHF4dgcj85kfSUWtgHUGu3+e3D5+Om+tk6v
         Ogbm/SJ6ta8ddeCKu6+0v6Ok9xnYl7UMoF6J8s6JSi2RZiMc7UPX4k9J3sWKl2bCdqNI
         a8Qzf+A2Xq8ZtCUYVobc3diljRIh/woqQCXGdI07dMRJerlBFS1hahpQXu+1DHfJVnHQ
         eFLFKYPt3G/tH6Ex5Bny+Ep2JnG+NuzvgC9Y+x+ESuwfPYzGXOTx7vMc67+bQGGZcLqh
         +SGBCEjdseCmBQ3/fZcEUA8tlvVdJdl/HtpQSYc84LE89U6nImnqUzlDxAHbpqL87KOo
         Yz4w==
X-Gm-Message-State: APjAAAXvieN0vtgv9TeEwycm6lE2sFRbkyNqelXGJCSUsPb7Ay1AeYRw
        N/ovGf++fbqrSSnrkmZhB1nVgZLFt8+8FfG4sFO+YTi12w==
X-Google-Smtp-Source: APXvYqzkEnMFcc+THl0las6y/AFr4evh18cERz7X47/ouDOEKn+VVbDsMqrkAdNHfXW/UQiGxTNfIhQoRA+aez6HsDs=
X-Received: by 2002:a2e:800b:: with SMTP id j11mr17878980ljg.126.1576506357652;
 Mon, 16 Dec 2019 06:25:57 -0800 (PST)
MIME-Version: 1.0
References: <001501d5b3f8$bdc5b610$39512230$@codeaurora.org>
In-Reply-To: <001501d5b3f8$bdc5b610$39512230$@codeaurora.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 16 Dec 2019 09:25:46 -0500
Message-ID: <CAHC9VhQXrukJZWrc2ZxOZg5vvmJUHdQyuTJAKR0Kf7-qFEWGNQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: move pkey sid cache based retrieval under defconfig
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 16, 2019 at 5:13 AM Ravi Kumar Siddojigari
<rsiddoji@codeaurora.org> wrote:
> Hi Team,
> We see an increase in the memory consumption from 4.9 ->4.19 kernel which is
> impacting the low_ram device .
> So thought of enabling only that are really needed for the such  device
> where performance might not be of priority list .
> One such patch is on the  pkey sid cache  which was added with commit :"
> 409dcf31"
> which can be moved under defconfig where enabled by default and only
> disabled for low_ram targets.
> Which is going to save ram/reduce slub usage .

Why not just reuse CONFIG_SECURITY_INFINIBAND?  I'm guessing these
systems are using the SELinux/IB controls at all, so why not remove
them completely?

-- 
paul moore
www.paul-moore.com
