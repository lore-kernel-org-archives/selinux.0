Return-Path: <SRS0=6Qkr=BI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB7EC433DF
	for <selinux@archiver.kernel.org>; Wed, 29 Jul 2020 21:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265C9207F5
	for <selinux@archiver.kernel.org>; Wed, 29 Jul 2020 21:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCHzz3Pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2VCo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VCo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jul 2020 17:02:44 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD5C061794
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2020 14:02:44 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id a9so4804640oof.12
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2020 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5xQaj9i2aqzPswEX3BzlbxBmJZ8BAd4DFPEQMLoxwY=;
        b=cCHzz3Pvhf0p0Au9ute4SJey345VEvDN48tQbUvExhaGbHAMc+p2Wnxoe6OIOi9MCG
         lx307Xw3qOLtZxwoqRyBI0I2SkEywiIvVTcChV8E3p0/riGEXFX12stpITGQFio2k8AE
         1audMMbRPuZ6gQwRK4208eKgFJE0Ar+Cxhqb9Jw2iBSMDstGFfFU6ycacK4hl2QCEAYh
         GfXkUWhdbdnRCiJQBd2LikCfVFeOee0VYl6E5ffe6ye1zRNnSpC/ZXOXtn22NaoSC1Dk
         +/JznIQ4JMVZZvxwKmYDzX+hzQHIaZNehmKqseXDgxkBHEGnSiPoJ8xOPkI2soqKq97K
         SZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5xQaj9i2aqzPswEX3BzlbxBmJZ8BAd4DFPEQMLoxwY=;
        b=TTiVyJu19sJ3wsRyQZ8DUC3ly/w7YohW4lwsD1lnKvDKctRokB0TL2MFsnnYa9SXaL
         q1M1HfQE4Z/lXiImbhi+1+eV9YyOVMBQCBVh25gEUxVCTATWIgb4GGVn3XM/cg/ywWJG
         8GF5HMpfPFJbWFhi9oJWhtZk75BsurmqUQMYpJi6OFxVVnJQUelxHckKKvYJ6QqP85Ja
         Jp4VxIY1R1SfzmupHkEifxSx87IkjoW6n+M6Ky3n8ueZQ+0MAI50VH01ZTP7H+G1Jsfv
         aKHX1SKOTe/O+j/GadH6sBmKRtzHSPXvXlXSyZULixdGezSrDi8j2Isg98bSmg2DKCai
         A7Nw==
X-Gm-Message-State: AOAM533wK54vYMIV1nGIhmMX1D09c3r8zi/c05UNynR8PIEtiEU777no
        eXcmNyLjYDeDCjxXK+o2TNqOL6fBNwSV+7TZdUiQzg==
X-Google-Smtp-Source: ABdhPJxINT8ZkHta1gf7hwmRnI2Yg12/xWuLy2pgOw9wkBayuGi3ooa+yAWfFsWUqrbAMV3R+7TlxmauW9WsAzMBQm4=
X-Received: by 2002:a4a:675a:: with SMTP id j26mr68621oof.1.1596056562365;
 Wed, 29 Jul 2020 14:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <12fc8da1-4fbd-59f7-08e7-0af9daff118c@gmail.com>
In-Reply-To: <12fc8da1-4fbd-59f7-08e7-0af9daff118c@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 29 Jul 2020 17:02:31 -0400
Message-ID: <CAP+JOzSHRcBQp_3ntqiKiG_fjx0fab6zGCC8F6j50zkB8ac-Bw@mail.gmail.com>
Subject: Re: Invalid output by secilc with constraints containing 4 nested OR
 and a single AND
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 29, 2020 at 3:06 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Hello,
> I've discovered that a constraint like
>
> (constrain (file (open))
>   (or
>     (eq t1 exec_t) ; probably doesn't matter
>     (or
>       (eq t1 exec_t) ; probably doesn't matter
>       (or
>         (eq t1 exec_t) ; probably doesn't matter
>         (or
>           ; Making and the first argument to or will produce a valid policy
>           (eq t1 exec_t)
>           (and
>             ; content probably doesn't matter
>             (eq t1 exec_t)
>             (eq t1 exec_t)
>           )
>         )
>       )
>     )
>   )
> )
>
> allows secilc to finish compilation but generates a policy that is "invalid", file identifies it as an SELinux Binary Policy but seinfo and similiar tools refuse to operate on it.
>

I can confirm that this does cause secilc to create an invalid policy binary.

I will have to investigate.
Thanks,
Jim

> For example (using secilc/test/policy.cil):
> $ file policy.32
> policy.32: SE Linux policy v32 8 symbols 9 ocons
> $ seinfo policy.32 -x --constrain
> Invalid policy: policy.32. A binary policy must be specified. (use e.g. policy.32 or sepolicy) Source policies are not supported.
>
> I've tested this with secilc 3.1-1 (debian) and from the current git master (9e2b8c61bfd275d0f007a736721c557755edf4a0)
>
> I hope that this is enough information to reproduce the issue.
>
> --
> bauen1
> https://dn42.bauen1.xyz/
