Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC28C433DF
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D697206C3
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 13:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alaKMavg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbgE1NT0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390102AbgE1NTY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 09:19:24 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63074C05BD1E
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 06:19:24 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l6so24835547oic.9
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oz9xfcywEMKotMgLco7h5aXQBpyDqjhJLW/F+NakDyI=;
        b=alaKMavgMgY/PmQ8pzEvoJf1WfI5krNui44W1th6u4H2ICAwpK717xI8PGjyUnQX4w
         vm2AcHmU8UhVm2xe9EIus6pn8KWIJ/UZBnF00mc1cAwm3DuC3336miQ9hz4sh/ZgVFYV
         Hf76j7zxy1TVNcwhkuTp+DIChbWuv+30seRHyJXyySJdx2ntqHuecsb7Y3GICDY+qa6u
         zqlf9uBPlB3EqX6ja7jU/eVUi2Zn50XRlpiH741A82QKjg6ODp65J92Lygw3Lh+ZFYla
         fLvApsdiAtbgJgpbSEgKabXGzoqiCqcaaPWUvaYhHSYXFiQfsqS2JMjocBd0tHBJW45H
         2t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oz9xfcywEMKotMgLco7h5aXQBpyDqjhJLW/F+NakDyI=;
        b=Foz1uMnKV9kwKymCU/BNDSK835hDXGLDlt0Nio/VFkCYpU+o2nUFeVTnH8+NB4IfM4
         91AA5OfFuAmVVixDiEy5D4exKcXNmOORwptJa4IhBOp78Ek5T7YPq2L4r8xge4QX/T5I
         7m31LkKVksmQPjYFRcQyXYjwEY6gXqaDVksBVR4MHOJrbj2yfI+AhhpFLIw13by39fc1
         TgT9bHA/Dvt8hcRTLAEGfjCKizj/11DgmT0cuK7kM/6mT34JM35HOneWnOBGUKolXPhL
         QEZ2KLKxuqL6QwWWF2d0uPHs5YacDgPGNqTDgAvjBkgVbFxeRpmRS/fWKy+l2etR5Jlo
         liuw==
X-Gm-Message-State: AOAM533xsXWmJmCWHS+pIq7lt5IGpjoK0AwbduWZEOoxsbi6B8a0Yd6j
        36r4ul/cvIZTLmrM/SVoIo0nFlehBMdAl5T8075qGQ==
X-Google-Smtp-Source: ABdhPJzfS0yEflk0QsQ0+goxBq/4AeWwWgUFA5VZ1ZJC2pWYCqMSVvFH8iJcmk7sguANsR3Gu64xlr6McawhJdc8s2U=
X-Received: by 2002:aca:bcd4:: with SMTP id m203mr1998632oif.138.1590671963739;
 Thu, 28 May 2020 06:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <ypjlsgfk71po.fsf@defensec.nl>
In-Reply-To: <ypjlsgfk71po.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 28 May 2020 09:19:11 -0400
Message-ID: <CAP+JOzRQzA=PU+djvZmyA_RtdcduMQuyhZPvNSpNodpE_G4xGg@mail.gmail.com>
Subject: Re: CIL typealiases
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 28, 2020 at 7:21 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
> tl;dr typalias (and possibly typealiasactual) statement does not like periods
>
> systemd plans to consolidate systemd-udevd and udevadm and so I was
> looking to consolidate the policy. For compatibility I wanted to add a
> (typealias .udev.udevadm.exec) and (typealiasactual .udev.udevadm.exec
> .udev.daemon.exec)
>
> That reminded me that it does not like the period name space
> delimiter in at least the typealias statement.
>
> Example:
>
> [root@brutus ~]# echo "(block test (type test1) (typealias test2.test1)
> (typealiasactual test2.test1 test.test1))" > mytest.cil
> [root@brutus ~]# semodule -vvv -i mytest.cil
>
> <snip>
> Building AST from Parse Tree
> Invalid character "." in test2.test1
> Invalid name
> Failed to create node
> Bad typealias declaration at
> /var/lib/selinux/mydssp3-mcs/tmp/modules/400/mytest/cil:1
> Problem at /var/lib/selinux/mydssp3-mcs/tmp/modules/400/mytest/cil:1
> Failed to build ast
> semodule:  Failed!
>

CIL doesn't like "." in any name used in a declaration.

If you want an alias with a "." in it, then use blocks.
(block udev
  (block daemon
     (type exec)
  )
  (block udevadm
     (typealias exec)
     (typealiasactual exec .udev.daemon.exec)
  )
)

Or something like that.

Jim
