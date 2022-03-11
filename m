Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB47C433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 22:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiCKWzq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiCKWzk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 17:55:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB89623969E
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 14:42:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e24so14978270wrc.10
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 14:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hz8SKz3vqNTHEdMarFDopqt0Y8Qo36VGxxJ8RjLX2d8=;
        b=QaVKUnd8Daq+++Zdr5clrEyleIJTvKQptUV48ylT4R0VvqyrGsnJN+fXTvCLm3TMoj
         OqRn4LOcvddRKjCTxgU17nxYVD1T4n1ExcOc6LQFFblCynSat/PzeM9vg5LzdOmYr9Qh
         cpEZvmXuzsUnya0p87l/7pJsjhMuw2ogULcDr+4TG8QI6DEre4whBEsfbmbUTzCWIJVn
         +kFlk6h38BDtlDKaj+Nqfi1L8V13RXB416SSHvReKNmmyqbDlGaREXx5ikDpmDMHdfrN
         hHQwI4GF/oyQEKGH4eD4xwvg6notXRNUMniKJ/n/bNopRNhZjpFIImTiBdMZgaIZBDJN
         q1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hz8SKz3vqNTHEdMarFDopqt0Y8Qo36VGxxJ8RjLX2d8=;
        b=VkKPqYPe9IN+8VImUkk+0JRpl4xDXdXtJQKTvjnXDmafRUJD93jJxzzzLCExf7Ur1N
         8SNM80uuYAv7gq/2Nk9V/SepYx5AtnYO2UzjkwS8mVA/ak3Y1SGC+BKHCVukziNbF9VK
         0mFDdcAUl3sJRkxO6psPrwQdEbcnhZ4m6QjfO0E2c+wyXWM+7GD/ZpBV++IfWsMpxXmS
         OQXio038wERv3dJ9D8oocWrd8ybv+V82x/n3vuE883cEBescmLn+twAYNUqf0a7dLzX+
         poT8/1CoS0PJZBAE0biSuc9++2BVktYT829SjUCOvJJ7FoQeHTH/egKJ+aNitV0e8b7/
         buUQ==
X-Gm-Message-State: AOAM5312zRsXLiPSjvO2AcRmPdPYb/1JmMr+0mI9jfqJvQ7R4oLM1rsH
        88xYVhXw5xhl+sW8TYe2oqoR4lTO/i83MjsILWkmpiSKSg==
X-Google-Smtp-Source: ABdhPJyloP5d/fFdqrGGVZbmDAVrW+gXh4LPwR3nCX2OxQ0e7wBzX1fVCnVY1UhHJrTFlIE4WKNbHs0zz5AUFwnEYjU=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr9966406ejp.12.1647032642056; Fri, 11 Mar
 2022 13:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com> <CGME20220308152658epcas5p3929bd1fcf75edc505fec71901158d1b5@epcas5p3.samsung.com>
 <20220308152105.309618-4-joshi.k@samsung.com> <YiqrE4K5TWeB7aLd@bombadil.infradead.org>
 <e3bfd028-ece7-d969-f47c-1181b17ac919@kernel.dk> <YiuC1fhEiRdo5bPd@bombadil.infradead.org>
 <CAHC9VhSNMH8XAKa43kCR8fZj-B1ucCd3R6WXOo3B4z80Bw2Kkw@mail.gmail.com> <Yiu3x/Fxt/b5rNWB@bombadil.infradead.org>
In-Reply-To: <Yiu3x/Fxt/b5rNWB@bombadil.infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Mar 2022 16:03:51 -0500
Message-ID: <CAHC9VhTzQZX=QCKOrk8NNaVZkOwSyRbf8iZZDCu0TFw+uEmwUw@mail.gmail.com>
Subject: Re: [PATCH 03/17] io_uring: add infra and support for IORING_OP_URING_CMD
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Kanchan Joshi <joshi.k@samsung.com>, jmorris@namei.org,
        serge@hallyn.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, hch@lst.de,
        kbusch@kernel.org, asml.silence@gmail.com,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
        a.manzanares@samsung.com, joshiiitr@gmail.com,
        anuj20.g@samsung.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 11, 2022 at 3:57 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Fri, Mar 11, 2022 at 01:47:51PM -0500, Paul Moore wrote:

...

> > Similar to what was discussed above with respect to auditing, I think
> > we need to do some extra work here to make it easier for a LSM to put
> > the IO request in the proper context.  We have io_uring_cmd::cmd_op
> > via the @ioucmd parameter, which is good, but we need to be able to
> > associate that with a driver to make sense of it.
>
> It may not always be a driver, it can be built-in stuff.

Good point, but I believe the argument still applies.  LSMs are going
to need some way to put the cmd_op token in the proper context so that
security policy can be properly enforced.

-- 
paul-moore.com
