Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A9DC4332F
	for <selinux@archiver.kernel.org>; Sat, 11 Nov 2023 22:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjKKWhq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Nov 2023 17:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWhq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Nov 2023 17:37:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1908AE1
        for <selinux@vger.kernel.org>; Sat, 11 Nov 2023 14:37:43 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50930f126b1so4170127e87.3
        for <selinux@vger.kernel.org>; Sat, 11 Nov 2023 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699742261; x=1700347061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KtulQF0FMiiEBpQEJqCLBQq/gTXD/vsIsOTBSPu/GJ0=;
        b=EvA+kPMuNRgd7D0DT+FCVKZvn7O2tippZGSlqwiIVUkNztbjnU678qTo22YJBroUPZ
         VDuhpG4ccnZXH8OS3sDcw03B8nVLAbIaJvNq3d8+tO/R3CdYiSRsRh6oMKF13aqCV2SN
         xZ+a+MDFpaDUw4zdZT1dkvUMgOqK7XCpzYLsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699742261; x=1700347061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtulQF0FMiiEBpQEJqCLBQq/gTXD/vsIsOTBSPu/GJ0=;
        b=v8TYNpl33z7v0mYCQAC7S8udtBZfOJbcYLTpCF7gbe3kSmj0oIxsS6V3zzEauPbW09
         NGCQDpFcnj6ngYfw/nljim8bsVAOKZjlx/VB+89Xhl7Lnm6nRK/SS8iWYeMThINKx9t1
         dJxstv7Yp8YvgWbHv63uU0nE2uVlUBnCIUgq2Yiv19Yw+k0k7+FAWGNeRmJZIg/gluBd
         sAtNGB2iErU3X44QSd59iEfs0K9XK/gNuttZyTvEH8/JJmxZ2cWEbf5sYooZyChiTj+S
         89Gei4fAeCmtvJk9js9Lrk13i1xoTmmv5jMiUABJlEIrFur9TdevSHS3ZaPII2mPeZwf
         u8zA==
X-Gm-Message-State: AOJu0YxoXSr+ZA3go2mDpGeMLyFxEI8y4vSEzblTmvI9eVaRJ1wsUiRC
        SppLAhib9cbxtQP/lO5K+FmW6Y+kw6C0NCVEsCa9Ag==
X-Google-Smtp-Source: AGHT+IFJUsItfkWI4Mg6szDShCqU1HMIC+9ydsVr+oGp7DlFVFmn/2s6FoG3PJdKtz0SVAnhTW7VYQ==
X-Received: by 2002:a19:f819:0:b0:509:489f:d84e with SMTP id a25-20020a19f819000000b00509489fd84emr1757822lff.37.1699742261067;
        Sat, 11 Nov 2023 14:37:41 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i20-20020ac25234000000b005008c11ca6dsm401120lfl.184.2023.11.11.14.37.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 14:37:40 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c50906f941so46105431fa.2
        for <selinux@vger.kernel.org>; Sat, 11 Nov 2023 14:37:40 -0800 (PST)
X-Received: by 2002:ac2:5202:0:b0:507:9854:3b95 with SMTP id
 a2-20020ac25202000000b0050798543b95mr1723462lfl.14.1699742260169; Sat, 11 Nov
 2023 14:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20231111160954.45911-2-paul@paul-moore.com> <CAHk-=wjg45Pg5qxbio9szL+rMSGT7qm3a466d-zVwZwO96FNdw@mail.gmail.com>
In-Reply-To: <CAHk-=wjg45Pg5qxbio9szL+rMSGT7qm3a466d-zVwZwO96FNdw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Nov 2023 14:37:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5CQiZ5GbN6+L4704uekH4PR308Zo+EMnDxL-re-xvgg@mail.gmail.com>
Message-ID: <CAHk-=wi5CQiZ5GbN6+L4704uekH4PR308Zo+EMnDxL-re-xvgg@mail.gmail.com>
Subject: Re: [PATCH] selinux: update filenametr_hash() to use full_name_hash()
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, 11 Nov 2023 at 13:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, I want to state this very clearly once again: this attached patch
> is ENTIRELY UNTESTED.  It might have some completely stupid thinko in
> it, and may be entirely broken.

Well, it boots for me, with selinux enabled. Not that I tested any
actual selinux functionality outside of my normal desktop being
active.

So it might still be entirely broken, but it's hopefully not going to
do actively bad things to your system. I assume you have some test
suite that you could test this against..

             Linus
