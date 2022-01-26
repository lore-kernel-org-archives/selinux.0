Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD61C3525A
	for <selinux@archiver.kernel.org>; Wed, 26 Jan 2022 01:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiAZBEW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Jan 2022 20:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiAZBEW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Jan 2022 20:04:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C73C06173B
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 17:04:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ka4so34815333ejc.11
        for <selinux@vger.kernel.org>; Tue, 25 Jan 2022 17:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GTAyGpZpmaUsPX9axsiybxghgU18jS0enUJ4yCmKfeA=;
        b=gqKUWRyRARbRk0SGN0Ug87qWmhiWP++BNrtjFXsLJKVCte7lTE+HTbyWyEoPAy4N5U
         Cr/nvGCQsDIwzs732Xj1dYSYM47ja/d5pm0F5YZMDHNVCSW37GrkW4saw96qY87DLWe9
         3J32o/WgUPqJAAwC8BvNXDmAHZ12guTjhNoCBu6SRZd8H/gbavxyahxeyogwFZC7/Ao/
         TpXQlklenvh9cbGVXERoeSJfI4YGELTJWS0ItxWav3nXitxmb/qlIqL1RYIXHSKrJ5eH
         SqqxjJSARcyscmkEbZlnJF+wBqo52bftQNRUgPljpqcKO7W5ffyJHyJ66Sbe8IlxTkNp
         DNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GTAyGpZpmaUsPX9axsiybxghgU18jS0enUJ4yCmKfeA=;
        b=QAzSMqFu+BvXK1QEJ5CpG5BtAHIt2WuyhQQ9zrFLt2VEFpLuglM21GXHGj/9LsRgwM
         wEe7O8TATNTwLmA0AGiaD4RFP/utoNT5zs08YKXdToAoi/yC/Yp8NB3xbPWN5Il8S4ut
         Ee7/F25Gds0bzZf/+bgA46Hyf71XwIgtKzH3s/ZwkIoMQl2KAcXQnOi9/9DcvPGN+xJx
         SH1bgk9XHJM0ASjkhDk0lmdvv9MoesOzOk1L7R5WPoL7Bpc0zBhttmOdYkUqrELb2rX7
         rpfd4YADUArCDDTS9f4WORPP7z47SCySVy77zIhx8+5RvHzD/WbJxRUabW9ezA8/Kw6P
         rkFw==
X-Gm-Message-State: AOAM530+y2+n0lSEB0GN6hL1NUKCUce7sUPCDuSlRiRjZvbKS0IMAw+p
        jd+3bjFOj70PVQU8i2+nQNsESs24dve3d/FlvGAn552h9w==
X-Google-Smtp-Source: ABdhPJylTjO6CmnEjURDc3496be4uSWx25zcu1IuJcyKxIu4SxC0yap6Qho7LjX/sjkwRB6y+dJR2BuAoych5i4rE90=
X-Received: by 2002:a17:906:c14f:: with SMTP id dp15mr18137575ejc.327.1643159060317;
 Tue, 25 Jan 2022 17:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20220125141422.32655-1-cgzones@googlemail.com>
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 20:04:09 -0500
Message-ID: <CAHC9VhTiGU_PMDGNKdFD977_Uk2iqVKr51kOzJV+njc0B9Eq5g@mail.gmail.com>
Subject: Re: [PATCH 2/9] selinux: declare path parameters of _genfs_sid const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Austin Kim <austin.kim@lge.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
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
> The path parameter is only read from in security_genfs_sid(),
> selinux_policy_genfs_sid() and __security_genfs_sid(). Since a string
> literal is passed as argument, declare the parameter const.
> Also align the parameter names in the declaration and definition.
>
> Reported by clang [-Wwrite-strings]:
>
>     security/selinux/hooks.c:553:60: error: passing 'const char [2]' to p=
arameter of type 'char *' discards qualifiers [-Wincompatible-pointer-types=
-discards-qualifiers]
>             rc =3D security_genfs_sid(&selinux_state, sb->s_type->name, /=
,
>                                                                       ^~~
>     ./security/selinux/include/security.h:389:36: note: passing argument =
to parameter 'name' here
>                            const char *fstype, char *name, u16 sclass,
>                                                      ^
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/security.h | 4 ++--
>  security/selinux/ss/services.c      | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Merged, thanks!

--=20
paul-moore.com
