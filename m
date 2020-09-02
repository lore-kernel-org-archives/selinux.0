Return-Path: <SRS0=YX5s=CL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D4BC433E7
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D1D20767
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="teQ8xUX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIBPVG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgIBPUc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Sep 2020 11:20:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DFDC061246
        for <selinux@vger.kernel.org>; Wed,  2 Sep 2020 08:20:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i26so7169806ejb.12
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2020 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CpOevaoV/ViHE4HZL0DE5SdzI+K48EqJ7HWNdzlNJqY=;
        b=teQ8xUX+J+E08eAUisSrurhAi6lohD9y/mNJtIm2x7T91upbRQ7MVNlS8yOMnnCUmW
         4QPdjis3Zz7aOei9H7aAJM0/YsI3ngrnvdfXhuE8e7+zV+ZswKiR0/sCSg70napnA8ds
         ufC0ob5NssHK6jnbW+gXqnGp1V4CdDcO44E31V3VbWOqDN44yXXNBCzbicEzffShCsI+
         JQ1IkivRqyEaZ9mXZBWubB3WHa9ExGMJzg0vB1DEQTlnTNIEho7IurmNARvmnBt0Ww9l
         QkzzHzbb8oaU09wWJu3Ml/S0b5uCIskT9JvifWhhTJdOlpnsIDsgRNR3r9UWEFj3TkXR
         Dbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CpOevaoV/ViHE4HZL0DE5SdzI+K48EqJ7HWNdzlNJqY=;
        b=RigsWzIR44FJ6o1gNDH7VmZQNdEp03inIYGujOrOxR0Xc3rtMbpFntfNIc67Bc2CGG
         9usvkyUVRw6duHN429or9/DQv+JGrPHUaL1d6n8Vl5mJ0JNEq9mrxxplsMsT/+WVr0YS
         ThfT/JSk+bfwH2pUKGKeuiC9Zye9oGENGyWePs+cH0mcsgQtlvnYVAsHD998ioP702z1
         POBHsDgQQh9HVTbj/s/td5wQ1hJne2aDv0lo8y2Xt92wYewe2/IVrFc2qvjGVTgns3vs
         Zth+/fIOvP88vF6gq8XOhAglqeEzPQNZpbrcAIsfXXNGtI5T6WK3AQH/aVGuhnTu1ogA
         AraA==
X-Gm-Message-State: AOAM531DysYX5Aprqf0xYz2LM1sRFLr3X4pR2G7NhiXzzqV7iQEWcW1h
        GHqJzcUsE1jC+ve76P/gQ+De5CeJX21mIOKzzjj3uKvMDg==
X-Google-Smtp-Source: ABdhPJy6QRqxEULweQ6r65giEA4EdWYJ56a4NluW3+tchI3yFVGkTQWAKJv2oZ7ISucWlCjMhkZQv/JEjGXxx8Hfu8E=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr448283ejz.431.1599060030269;
 Wed, 02 Sep 2020 08:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6s0AgwoMqP=YCweRGpkC5wsvtusmNO235_S=97NmvSeA@mail.gmail.com>
 <CAHC9VhTbOfFxtjWYytX4qC9hqeNuUV5dnfcES2qUtYzpuUnBuA@mail.gmail.com>
 <CAEjxPJ5cRbCogQ17aakpnMp_0nwDHbMQTqC69SXBA3JcmP1nuQ@mail.gmail.com>
 <CAHC9VhSm2qKkhUK7dnn6_aPPY4LsVqeQwD2Xf6k7EvV9xJg_sQ@mail.gmail.com>
 <CAEjxPJ6KD4FfhWMYqBu7tupNAWEQqbWbA2o4YgsTQ1sPQTUNzA@mail.gmail.com>
 <CAEjxPJ6kj6LRFoiVG0v2QPEMXHw7YHPCOgJqQwvaMbDCYnyZTw@mail.gmail.com>
 <CAEjxPJ5ovzeQ+NQ5YZitjrWmEUFPBEAAj5Gq7fHNkpwJfv8eFQ@mail.gmail.com> <CAEjxPJ7_XM2NGBsAc+4W4akAm8TNa=m1rz=YGWxcZbipD-REqg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7_XM2NGBsAc+4W4akAm8TNa=m1rz=YGWxcZbipD-REqg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Sep 2020 11:20:18 -0400
Message-ID: <CAHC9VhQh3h2Ob1y0EsWwyky5KeHYk4Tp9iAQGSnjk1e10kkf6Q@mail.gmail.com>
Subject: Re: working-selinuxns rebase
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 31, 2020 at 11:52 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Re-based again and dropped the two externally contributed patches; we
> can always revive those later and add them on top if desired but I
> don't think they are essential.

Thanks Stephen, I just updated selinux/working-selinuxns with your
tree.  I think the rationale for dropping James' and Peter's patches
make sense; if we decide we need them back I keep all of the previous
working-selinuxns branches in my local tree so it should be easy
enough to restore/port them.

-- 
paul moore
www.paul-moore.com
