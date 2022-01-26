Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79800C2BA4C
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 20:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiAZUQt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiAZUQt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jan 2022 15:16:49 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6195C06173B
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 12:16:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m4so932462ejb.9
        for <selinux@vger.kernel.org>; Wed, 26 Jan 2022 12:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A3b8xpUhSLA5M+IUc3Agl+5CEs6ipYNvsnYaDA/rCGQ=;
        b=fddLQHWQ9FWkZ1IMQ1ZUpxLMcE7AdfrOem/bhqB9SWPr7z61z/l0rnUUpSDqkhVYMS
         m3naNjBHWGRtJBs++9DtG6o68enjNAjmxMyV5SK6Aqa6EycnEfR6iyzj4EGeUTsN3cH9
         Uznjb33bfprUf9XRE5aON6kudelbj34Ct1Whfe5+HLKe8Ci9gYEIpdYHw0QupPDKXQLW
         BDcElgkakgyh6Zkx1GDdbums3gTceeJjtQIt7IZ287FJyyQviVf55eGEmVWcbqILEuTx
         zF3g45AE5qJaOh2Odi+xtMLtWmcMJeMMvnC5mBvfaNyeGRynKNoiZCdbc6WcaR3TSxDK
         De2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A3b8xpUhSLA5M+IUc3Agl+5CEs6ipYNvsnYaDA/rCGQ=;
        b=IMbeR0SGSUpF+rh58XXQFExrhAmsqm3i+Ks5fYhwkKPJrBphsTOfuvH2z3FoHEhfqF
         /2T6NJ2qIlinIfjYZijMB8bhUVKG+OxHwlDpUFOoDIfEaRGl22lyhQf9J1+A4ZkllIe2
         RsTvM3hHfRADXMXn2D2PFI2GnSAGFbiohq4kZAthFx5yWoNPoyB14k2id9FHR/Thjrmu
         6s1rkSocrJPLo7XiXU5fjcErifME2At6pSnPQG2c5bnXarqja0CsmlTRas0y+TxzSbns
         D+TWQFIfLfKWU3RAMN+L8HjjGiLdqXY55AlxoS6Jl0V0ErkDypjVl+L2k1QAWmXWEPz0
         5eMw==
X-Gm-Message-State: AOAM5332Dki7VPuR1dNanKyr7f/Q0hPg5CE9XvUMrTNChiNC9G7M67+O
        ky8+ez6VV4imrZYk52TeT9E6WECDWW8KQQUF/Vfv
X-Google-Smtp-Source: ABdhPJz4+ZIfL4JZ7er4GLbfEAAChz0dMPqm7fOs5fzCEK006fkfioZAiwokuBYiTq6k3bdCehyi0TnvF3RM3BMp09E=
X-Received: by 2002:a17:907:7faa:: with SMTP id qk42mr298070ejc.29.1643228207156;
 Wed, 26 Jan 2022 12:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com> <20220125141422.32655-3-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-3-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 15:16:36 -0500
Message-ID: <CAHC9VhRb3bcFVG3ZGgnqDXx0RizSVh6Vxjh88ytkhO-gu+o14w@mail.gmail.com>
Subject: Re: [PATCH 4/9] selinux: enclose macro arguments in parenthesis
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 25, 2022 at 9:14 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Enclose the macro arguments in parenthesis to avoid potential evaluation
> order issues.
>
> Note the xperm and ebitmap macros are still not side-effect safe due to
> double evaluation.
>
> Reported by clang-tidy [bugprone-macro-parentheses]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 4 ++--
>  security/selinux/ss/ebitmap.h       | 6 +++---
>  security/selinux/ss/sidtab.c        | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

Merged, thanks.

--=20
paul-moore.com
