Return-Path: <SRS0=Wrvk=XF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F95C3A5A2
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 11:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36C020692
	for <selinux@archiver.kernel.org>; Tue, 10 Sep 2019 11:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+yiEHfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfIJLEv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:04:51 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:45230 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfIJLEv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Sep 2019 07:04:51 -0400
Received: by mail-ua1-f42.google.com with SMTP id j6so5379122uae.12
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2019 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5xJ4C5E39btEZQHuUZ/aC+3qMNx9XpQrqxkUaGyRQA=;
        b=H+yiEHfq3QW4IVP34Eg5UcCOUuYNmFgORkptQug2ykvNhDCg+Hr8xQwKZi90fSLSIr
         d0cmQnqKF1RqGMKTcIDeCFmqvV3yNgeqwJGsyetHFno9aBwBOUl2v5dFabg0YJZuaEIT
         SbKLa3ZXp3HG9sK6W7WrgL+lYSwH533nEBa7psiVJyKlskH0wnVIlpjbmsuSXKOPKfnL
         TiSm9kv1IVPfR15SjcDFgI/Z1xS+FrIXJNgdSK/jQgRym1EAPLPqVM6Bxkm3eKCkU317
         sL4jFvpGdjEuQNGKKxZosfIvaVDcphjN4KJfCY9kYK+NaB5PyzfpbyfI/ry8zw/HsKgE
         QHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5xJ4C5E39btEZQHuUZ/aC+3qMNx9XpQrqxkUaGyRQA=;
        b=WB6NbvuAyP45IWjLPUtv2WrboK076zNht4I08VwZsQqQUsJKf1Zmkzy85Cqg9fJ9Kd
         jdReomoiuzymEzDyj2BbYH2l6uBlI8D/b1bx59O4YUZpGwRzFx2PoOEd6+XakfyyY7oH
         OLaz0nx1UpD7FM4DAbbB/KoIj513B6yCHvLfOci7p3tC8SKj/IvJKUy/JFkyZXTqkZdT
         Eq3xuUJ05sUlU6dy8u89IjLVR/XVG78e/YslN1xpgWdex2nmxJrLBiYwSJNFFhMoy69K
         INlRJc8rhF0P8hOIqF+wls4YqPolQz2df9eAF+Wu/nE+rLGVFLclbp0uFCwQF2ZZaUi0
         n+HQ==
X-Gm-Message-State: APjAAAUfLLoZxPEwBUsvdBjD4c+/J3p+sFGTTnLqJehreJNUzgfONq7e
        XRXhboIvQPddgFHMxA2zya84iYQPXxSrBScsCJYAjd8g
X-Google-Smtp-Source: APXvYqzywU3BqOcFToHgoZPh3vVxntSYsGzwz3cHO7GOzJKTegTijPhMl3vsneRp34+33O+CIIBMXoy8GBB2eepSvw0=
X-Received: by 2002:ab0:7452:: with SMTP id p18mr13290136uaq.108.1568113490000;
 Tue, 10 Sep 2019 04:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHO8so3mL4hOLd12gg=DZQz7=1auXQET6dVip+r=9GGPjec+Q@mail.gmail.com>
 <45562434-a8bc-ba91-2eee-7407dab4a97f@tycho.nsa.gov>
In-Reply-To: <45562434-a8bc-ba91-2eee-7407dab4a97f@tycho.nsa.gov>
From:   Srivatsa Vaddagiri <vatsa.ml@gmail.com>
Date:   Tue, 10 Sep 2019 16:34:37 +0530
Message-ID: <CAMHO8sq4J8wOicx57uNyVa1bsbR7ACz87On2NS0sXve6D-5UrQ@mail.gmail.com>
Subject: Re: Changing selinux enforcing mode at runtime
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> The more complicated scenario is tasks created before initial policy
> load, because those may not be assigned the correct security context.

I think we may be interested in that case (tasks created before
initial policy load). Would those tasks' operations
fail when subsequently selinux policies are loaded and mode set to enforcing?

- vatsa
