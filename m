Return-Path: <SRS0=k17o=CX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F6C433E2
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C3320759
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 17:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2PdanAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgINRqx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgINRqp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Sep 2020 13:46:45 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5EC06174A
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 10:46:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d189so711751oig.12
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UcMPpL7ohSeeaddIMQZ4Kob6HUB6ya29pJMzCdoImo=;
        b=p2PdanAjpD6WfrA5+A2/EzGm3UVVBUzXY2+z69Xky4GVNFiGM2nZ5RO/DUifaaA+Sm
         N920crWud8tUjv3qC81KWYC/sJYdc+xVyZCNPTQexHQTFdfLA2GnUrOYUoG92mbuFKSl
         aH7bQPfxgpYrJGQzVB59maOPX2ainWcGfHFPj4QOJvxuHX/eu44s/XXfpes+tubd1+7y
         r4UwZUUNlDfLCszdwcy7Nkz/z+zTXSDtnLLQR1dgHTsaHSkz5l3C8eJXIrCSDcEtIDDD
         LWOt4Bm3G+OPBgD4H7xz9ThNntdSA6895Z3OlrZtcXquj09zrwQA0ZzVPDmK1rLz0n3Q
         SwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UcMPpL7ohSeeaddIMQZ4Kob6HUB6ya29pJMzCdoImo=;
        b=pZj1bIGp2kV+/RINIK/JeJygHZ49qaVPQquZ3yCwO6evuUGertmasp+dm99dpI71v7
         hBlyjJmlvjOvE6yJ/m7GMsu/MGwwVi64YIylaebUS3fMCXmzjRBihaNL0NC0vw5Wb9Ik
         HdW6A87/C+Z4q5BaaDZwLKgSDkLfa4K7/7iuFxhRl8vusCS4WmdiPt0inCgzZUzvpV/q
         e3QiWmw90OoNlf09uut+ZWk3lmUNIyWZ0lfO5RrhBRFdOzdTz8qSjvdK+vc1Lk5r3tTb
         SUAi6pbC+zEaF9RkDiHCmcwVWSHEkepkUNusVZZrFzkIMPOgzeTHwhP/7fJwS70Nttmi
         4/Mw==
X-Gm-Message-State: AOAM533R7pr2kKkqtCaevqADbzgb4mSjiTIjFsYAwe0DS/3Z4DOl70HQ
        A/eVqSLDrRiHyXXZxpY9lkT+pnNurYJ3pzsevbdT0fGL
X-Google-Smtp-Source: ABdhPJy530DvV/4+j9MkMxGqKltzzrEDAsrih0iNVQzuIE6imp95z7OA2L9Po/SQsE9afC2S+JSNhIRh9EFE8KKVCd0=
X-Received: by 2002:aca:ec53:: with SMTP id k80mr340284oih.92.1600105603652;
 Mon, 14 Sep 2020 10:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200914173157.4655-1-nramas@linux.microsoft.com>
In-Reply-To: <20200914173157.4655-1-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 14 Sep 2020 13:46:33 -0400
Message-ID: <CAEjxPJ64u0BGUbm2R3bX0gVqysh3-uyupjfh_H56n3Df+mJmFA@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: Add helper functions to get and set checkreqprot
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 14, 2020 at 1:32 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> checkreqprot data member in selinux_state struct is accessed directly by
> SELinux functions to get and set. This could cause unexpected read or
> write access to this data member due to compiler optimizations and/or
> compiler's reordering of access to this field.
>
> Add helper functions to get and set checkreqprot data member in
> selinux_state struct. These helper functions use READ_ONCE and
> WRITE_ONCE macros to ensure atomic read or write of memory for
> this data member.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Suggested-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
