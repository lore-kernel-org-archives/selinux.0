Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A343C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB84F20775
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 15:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXi1KMLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD2PbA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD2PbA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 11:31:00 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD6C03C1AD
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 08:31:00 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id e18so510290oot.9
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yz7CpURSy+1UtKZPka4TEK9+xWBPtPGTe4zpVrkMYOc=;
        b=BXi1KMLna4Jb3o6I20Yd91g2ZJqpYq5gkDb5r4MIsf4TZXsvF7ZJ8yln8G3fWYO/pQ
         x4Kbj4t2zctYFSbirRr/dx2lDHkEzHlVmpo5R94glNW+oen+o/Fr6uTHsvWGjBc/ENnA
         yiZyL82QYlUIsDuesVxjQp86YCT/7/e5IF7T1HfzBEMxvQve9kgoxy6HKYwqvKwDRpy1
         /XmqXL/0j9VuxgGA35fKyX49524hpAk36/Nt+sIVQYbn75uObgwhYxFNkG5/JMtLvkBH
         UhLMAndW3nxR8YeQ2poIGy7qusSAbjDINCREbId09l1f/qRCL/vd8wEYl+hH3+nIl5jW
         akew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yz7CpURSy+1UtKZPka4TEK9+xWBPtPGTe4zpVrkMYOc=;
        b=mXqadOjrdwKFU9RW2RynwcO2nRJsTlzyTq3l/CtqKgnP0l4N5KGG2ngoFTfLuJBsgR
         ZTmY7INabYGAUSKnpkKn426HnV1ab4ItyijLfYReVz5Mb2XsuA/VvZM6MvrLDSU//3hQ
         +lCjpxwO8jFL9oMXgnNDCtRrqowKQ1BfTF8dkCT1Ulm6+oECkwJmP1CxTnitM8Wq5Uoy
         6IJvbe5RATg5Lj5xr0ygWQt5A9eLgek/hbE6nbp+STX8+LwWHf1hiGFW4U0SEcBS45H+
         IX+Twr8z5IieLZYzMSTBTpL65NqxGcMYnxgTB9CYvu+sHJW816TPB9a2iYJQneDRJ+t/
         Kc+A==
X-Gm-Message-State: AGi0Pub0RdsJJTErD2knzJaHQD4TSBlnCAxo//nqBhW9VqFXB0HV0etg
        XJpkKLykF8kuddl5dgkBx2ry2157zgqARauKVx/KZMZL
X-Google-Smtp-Source: APiQypKNWjq9n53IcNKkAYGozNX0P0ln57+5AJztt5kWz0L2QxIDAqLintQgRGrLE4Tp86RxXKz/PRD33lHuWP/joe4=
X-Received: by 2002:a4a:b489:: with SMTP id b9mr27380257ooo.71.1588174259538;
 Wed, 29 Apr 2020 08:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200428111142.6072-1-toiwoton@gmail.com>
In-Reply-To: <20200428111142.6072-1-toiwoton@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 29 Apr 2020 11:30:47 -0400
Message-ID: <CAEjxPJ46DeG6epaYBFnd7iCetGBVe8z69x1Da3efP9coAYndFg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: mount selinuxfs noexec and nosuid
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 28, 2020 at 7:13 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Mount selinuxfs with mount flags noexec and nosuid. It's not likely
> that this has any effect, but it's visually more pleasing.
>
> Option nodev can't be used because of /sys/fs/selinux/null device,
> which is used by Android.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
