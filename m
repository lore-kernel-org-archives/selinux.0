Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D8AC5AC75
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 00:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiAZAgM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiAZAgM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 19:36:12 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BDC06173B
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 16:36:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j23so61189191edp.5
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 16:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oXZqBE0q9OTqMHj3VdB5E02o4A6FjZEHOwhK0PXA+iU=;
        b=Bq9cmOB9xSKfZwy7Sb1XHF82ViyWkrje71gb/xt7h6ltMt4beZ5ceHBDi96kl0nAsy
         7hwTrD2JuT4/B6Lxq9l9pEyKUoTnD45PPoNywBMh9zQ/VSEaUXGi8Cb7cboTYLHZRkFc
         2J7zO9jzPrpkNBZ3wyV7yRdQP9RjmM8yzGHmRpzdBLGpNFUhhwAK63gDPwV6Srikwyeq
         1q5oROvo9gb5pyYQ7RDMtAA+jJStxllOIiLe7rTZW7Kj/IHIQKSRN84w/6pKz/eJ6KDM
         mglRA+0XbSyg6dRCLAgGLLT6P95YsSuYQwvrk/4eImwAngVNZSkPnaA0JXhLlcM+hj1H
         S33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oXZqBE0q9OTqMHj3VdB5E02o4A6FjZEHOwhK0PXA+iU=;
        b=ZlT540AXrAt4Qwtef7WB768jXYA9RrH4ViJDirkCCIRflDEgoaHyR5cYf8nxYSSixa
         0cbUoCwft5Zt2r/hA9d0vfYppTdJJ5S2Di4Z2TxR9ab75zWhW6VNW1NsloMGnKUX0bEN
         +oBjfY5sfJ6nU/flMOju3E3H0LlXNMSCLj9pP7KQnO9ALvX1D8xO17WRwiZCERfGsB9q
         IaeAeyVGeVPh1k58t8LKUkKQcTJV0DhLh4Moqi6/2kGLjnxL02Tnac4xO6hZtPFhEwmP
         8PN2MoXRBN7MRdtIxkaJq4jqZ08Tmzjw3NxFYGOt3xhaTxkPXQzeUrrZEfK8Il4y9tbZ
         sUgQ==
X-Gm-Message-State: AOAM5339gzGWW9jhR0oHGDwbJWBJCJK9kTJfRGt10E36ayX543US1FJ7
        tj1q4olhlVzOS1yWz9VxqTA/ejlbaYwZgBG7jpGu
X-Google-Smtp-Source: ABdhPJw+5aBMxr72MniVbnSkXxgNfff7nte9AAvKFJsRelZrQ9UuB4LYEUqXJpDD12F6xo3uaFoUBbxUcqYfEI6UJok=
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr9937844edc.232.1643157370397;
 Tue, 25 Jan 2022 16:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-9-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-9-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 19:35:59 -0500
Message-ID: <CAHC9VhQ-kSWQ_w0KwgMboidktdQNN+G5jRpRWsY0Ayb8-HPmMA@mail.gmail.com>
Subject: Re: [PATCH 1/9] selinux: check return value of sel_make_avc_files
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 9:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> sel_make_avc_files() might fail and return a negative errno value on
> memory allocation failures. Re-add the check of the return value,
> dropped in 66f8e2f03c02.
>
> Reported by clang-analyzer:
>
>     security/selinux/selinuxfs.c:2129:2: warning: Value stored to 'ret' i=
s never read [deadcode.DeadStores]
>             ret =3D sel_make_avc_files(dentry);
>             ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into selinux/next, thanks Christian.

--=20
paul-moore.com
