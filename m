Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CC8C433EF
	for <selinux@archiver.kernel.org>; Wed,  9 Mar 2022 20:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiCIUXo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiCIUXn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Mar 2022 15:23:43 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7472458B
        for <selinux@vger.kernel.org>; Wed,  9 Mar 2022 12:22:43 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id i5so3875182oih.1
        for <selinux@vger.kernel.org>; Wed, 09 Mar 2022 12:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dgWXda1Ikk6W25RJ3vhbkAsm//ESBQEI0YlHGaYz2u0=;
        b=LbwYVLL8ewDj28FtH+OU+NWSSXhPhUKDJWLUDTVKPwBHU5Ds/QpgquXzQd3dpY7ugF
         UIDjL1RSRSALIvCHLEsaSKnwVyaPxnipbycnIOxQ47N04XuXjO8jX9/LU0gU6owWjLM2
         5AfYtKIpBBZOAqsIAm+5MYazF3R9lCb0zZFCTv8dHhLyfKt/Km/HGsgV/W15dvY83V7N
         Qg/CRCfFRN4k/3WX4wLF7IkzYDL6CegXlJh+sPUFadEhSVHQ97+rhou3CX/C+gLXR6AK
         WSGjokwGM+2BVQ0hbS9qXy/Y9LTUWHr5993lLJqEf6iWG3bRSRfDBNiBaRc/uH5zNMVh
         fAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dgWXda1Ikk6W25RJ3vhbkAsm//ESBQEI0YlHGaYz2u0=;
        b=Ba7VYF4MBxU/E6F42cjRkXtp41d3GGPxJzRGHO85MMH9aeJL1YRuUehogGT4JkDeDn
         DC75BYNrajiqenoR+ToMgGJ+BoWxJa52RzSp0vUQ29gObEis9s6sMzBTkRpgeZL5K1CI
         SndJJyzx+Neen8q6ZlKuaYZcs42dtEMpzDM7koIXF8HEB31T72cTYBAnGWk4yE7GvzET
         DvtoFx7y6wqDksLAtDX3v6NsVVp5qyoAQv0x0MNxps8zqLgpIhznpCSzHx+mEGPmVqpb
         8Zqpzav2IpbthtRYN/8KnampSbhN3YL9B0pNHgrNWZIt0cfGc+WY4ulIWNssUjAg2AOV
         NJjw==
X-Gm-Message-State: AOAM532H7J/UegZzzUgzDv1XglVFQeJmheINsnV4Rlw+pi3QBlVlEEVP
        OIf/sij+ZlDrKAEa4J7q4FzDwRAQNBhjb1+Xh9s=
X-Google-Smtp-Source: ABdhPJxjwUWVzTK4J89DenGjb0IPy0x3Ejt6rcV1YI+amWYDWbTPyBP+K8A6nM0CqzSFmADM/KhyVYbIhuLgHJZKx9g=
X-Received: by 2002:a54:4611:0:b0:2d7:988a:5784 with SMTP id
 p17-20020a544611000000b002d7988a5784mr6801877oip.156.1646857361995; Wed, 09
 Mar 2022 12:22:41 -0800 (PST)
MIME-Version: 1.0
References: <077581c9-4169-5c12-e551-0db4bfa78655@gmail.com>
In-Reply-To: <077581c9-4169-5c12-e551-0db4bfa78655@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Mar 2022 15:22:31 -0500
Message-ID: <CAP+JOzSyE=qZg3VHfdiR7NfVgXwtne3WuhTnoJSjVB--AyEYKA@mail.gmail.com>
Subject: Re: Recently fixed neverallowx checks report (range 0x)
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 8, 2022 at 6:21 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Hello,
>
> The recently merged commit https://github.com/SELinuxProject/selinux/comm=
it/71291385cf149a0316d5fa995d70641d3b1a0ab3 seems to have caused some never=
allowx failures for my pipeline, they're correct.
>
> However during reporting a `(range 0x)` is printed, which does not seem r=
ight, please see the log of my CI that failed https://gitlab.com/bauen1/bau=
en1-policy/-/jobs/2174049183#L1653 the associated commit is 73b511c30509525=
27fff3050bb75774214691d24 of my policy.
>
> My policy can be build by invoking make, however this involves many modul=
es.
> A smaller policy that still reproduces the bug can be build by creating a=
 `policy/base/test.cil` file with:
> ```
> (type t2)
> (allow t2 .dev.dri.type (chr_file (ioctl)))
> (allowx t2 .dev.dri.type (ioctl chr_file (0x640D)))
> ```
> and `make validate-core` will build a policy with less modules that will =
still fail the neverallowx checks and print this message:
>
> neverallowx check failed at policy/base/permission_sets.cil:1002
>    (neverallowx all_types all_types (ioctl chr_file (not ((range 0x5401 0=
x540B) (range 0x540D 0x5410) 0x5413 0x5414 0x5420 (range 0x5429 0x5431) 0x5=
437 0x5441 0x5456 0x5457 (range 0x5601 0x5603) (range 0x5605 0x5608) 0x4B33=
 0x4B3A 0x4B3B 0x4B44 0x4B45 0x4B4B 0x4B4E 0x4B64 0x4B67 0x4B68 0x4B6A 0x4B=
72 0xFD00 (range 0xFD02 0xFD04) (range 0xFD06 0xFD0D) (range 0x9371 0x9374)=
 0x9376 0x937A (range 0x4501 0x4503) (range 0x4506 0x450A) 0x4518 0x4519 0x=
451B (range 0x4520 0x457F) 0x4593 0x45A0 (range 0x45C0 0x45FF) 0x690B 0x690=
D 0x6910 0x6911 (range 0x))
>      <root>
>      allowx at policy/base/test.cil:3
>        (allowx t2 dev.dri.type (ioctl chr_file (0x640D)))
>
> As far as I know the `(range 0x)` appears to be a bug.
>

The output is being truncated because the log buffer has a max size of
512 bytes and the extended permissions would need 1254 bytes. The
easiest fix is to add a message that the log has been truncated. Even
if MAX_LOG_SIZE is increased, you would still want to detect the case
where the message is too large for the buffer.

Thanks,
Jim


> Sadly I don't have the time right now to condense my policy down to a sma=
ller reproducible example.
>
> --
> bauen1
> https://dn42.bauen1.xyz/
