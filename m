Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A62EC43334
	for <selinux@archiver.kernel.org>; Thu, 16 Jun 2022 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiFPBXm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346887AbiFPBXk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 21:23:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA437BCA
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 18:23:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so75383wml.2
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5beKOIePOHDcSdyCTJnmbPVPydJjL0ifJ6rL5/iJBz4=;
        b=W+O0kqWD2r/3gK92AEWBFlvFIJue6uqA3PrZMX4Q6693Jzb4GMFxgTlunh3+ZkcQxr
         5kmHYdCWigvCHbxAYmzcSP72st71IX8zRIkZiKpBLFn3sBVkHWrNJBcqsnU5AXJynz03
         0T7HhXj4M5jY2RlSL25dG5tEbmP8C3tScX+2tFyk03rNEQuq90wPJjsEEOjFjOLE2nfS
         xmlYu6vElG2xoop9i3xbuqJMPmuSV298KmGui2jyHMj2TL8+dOVIbWU3MSNCwL0/168+
         +mHrZCWiL5Z+RJhInV3TPvYLbTSCRS0iq4IEvdLwpa9fnSJZvW4+BSVxirJhTFNkF+nt
         LSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5beKOIePOHDcSdyCTJnmbPVPydJjL0ifJ6rL5/iJBz4=;
        b=Ui1/9a8Zv3pbCWcOFg5+xEfhYKR2FVJOpEs2kwqEDXldHkpqXt0TKJzgRbOCgr2l+N
         OOzbxU8IdWFE+LKFXiZCHyOMS34aobyXiDPE99xaFxeJsXyEUV7yO2u2g+qFNXwPcpQY
         1V9jWU4GHR3Rf3tKgdGEzFUL4c0Ezn5cbnT24WlGpPHfo/qhzcNEJsfOUbPwLVxGzpoQ
         odqZm9ENv2l37uXsYA4268WF57hijvdCFsg4OggLBMxUQ9A0Cn2J5SoLeV1g8efutpWN
         46Xy8meGzc0aQCqB/XmAigm3AFUGEufP8QBMhzrCzE5DuUVny8lblGFC8Gvn44AiXMYd
         1fZA==
X-Gm-Message-State: AOAM530PfBqiPGFuybb7gQurS+dijJPMTtVHhtEZGOBAgZjBUJdbwEHE
        IfGfaKxoAtwXsBkAMcw+K75ww6NoDfrkjcYuCigchjJBfc3T
X-Google-Smtp-Source: ABdhPJy+tpSnfCS++5eS83lIi55ozR3xGVf3kOSfVcclfH7we/r63ukXv3HxoJqnYQDpNc2yek4PBRLvdrqRobj7Ek0=
X-Received: by 2002:a05:600c:1c24:b0:39c:6530:2a60 with SMTP id
 j36-20020a05600c1c2400b0039c65302a60mr12778063wms.78.1655342617944; Wed, 15
 Jun 2022 18:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220615153839.314007-1-cgzones@googlemail.com>
In-Reply-To: <20220615153839.314007-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Jun 2022 21:23:27 -0400
Message-ID: <CAHC9VhSAUEYas_dEdn6BLaKO7RiaCQpaucXLf4yM0OrMSZo8bw@mail.gmail.com>
Subject: Re: [PATCH] selinux: free contexts previously transferred in selinux_add_opt()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 15, 2022 at 11:39 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> `selinux_add_opt()` stopped taking ownership of the passed context since
> commit 70f4169ab421 ("selinux: parse contexts for mount options early").
>
>     unreferenced object 0xffff888114dfd140 (size 64):
>       comm "mount", pid 15182, jiffies 4295687028 (age 796.340s)
>       hex dump (first 32 bytes):
>         73 79 73 74 65 6d 5f 75 3a 6f 62 6a 65 63 74 5f  system_u:object_
>         72 3a 74 65 73 74 5f 66 69 6c 65 73 79 73 74 65  r:test_filesyste
>       backtrace:
>         [<ffffffffa07dbef4>] kmemdup_nul+0x24/0x80
>         [<ffffffffa0d34253>] selinux_sb_eat_lsm_opts+0x293/0x560
>         [<ffffffffa0d13f08>] security_sb_eat_lsm_opts+0x58/0x80
>         [<ffffffffa0af1eb2>] generic_parse_monolithic+0x82/0x180
>         [<ffffffffa0a9c1a5>] do_new_mount+0x1f5/0x550
>         [<ffffffffa0a9eccb>] path_mount+0x2ab/0x1570
>         [<ffffffffa0aa019e>] __x64_sys_mount+0x20e/0x280
>         [<ffffffffa1f47124>] do_syscall_64+0x34/0x80
>         [<ffffffffa200007e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
>     unreferenced object 0xffff888108e71640 (size 64):
>       comm "fsmount", pid 7607, jiffies 4295044974 (age 1601.016s)
>       hex dump (first 32 bytes):
>         73 79 73 74 65 6d 5f 75 3a 6f 62 6a 65 63 74 5f  system_u:object_
>         72 3a 74 65 73 74 5f 66 69 6c 65 73 79 73 74 65  r:test_filesyste
>       backtrace:
>         [<ffffffff861dc2b1>] memdup_user+0x21/0x90
>         [<ffffffff861dc367>] strndup_user+0x47/0xa0
>         [<ffffffff864f6965>] __do_sys_fsconfig+0x485/0x9f0
>         [<ffffffff87940124>] do_syscall_64+0x34/0x80
>         [<ffffffff87a0007e>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> Fixes: 70f4169ab421 ("selinux: parse contexts for mount options early")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Thanks Christian, I've merged this into selinux/stable-5.19 and I'll
send this up to Linus once the automated tests come back clean.

--=20
paul-moore.com
