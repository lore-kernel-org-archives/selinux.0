Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48532C41513
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbjHHVVk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbjHHVV0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 17:21:26 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18ADA25D
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 11:33:06 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so89582841fa.2
        for <selinux@vger.kernel.org>; Tue, 08 Aug 2023 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691519585; x=1692124385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+FQ9Pvhakam5/58U+uBvMgwCqAm3HQiFp+DCs1/Xsw=;
        b=ZQBei8Aj74ygjr5pzuPF4+xVT/qjE8+UD6y3mfp3IqDx9SGNp35TtG6Zuof24bkF6x
         kqvmH5578wkEQFgLSFQD6X6XMEwcUb7ncHL8GxV8zdikmvoHVPjQgrN7e5siPvAbdSd/
         zoiADmfh9YUchSCGpE1hHfMUVVizzVAruJTJx0f4fZEMabg9O2YSP8UPmY8JwK3v3g0d
         Mbfr1Eq3P9wLc3iTYc42prRdAP1bK2eKWT17w2wdzfTCzBThB98AGIzTD9cf9/x5MdMY
         Go3TNY3Sk7CZYN+cGUX8otoVkGeoCFI5VOtlNU3m4TjZxw4ICeXZBMDw+ngcq+TIplbK
         c6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691519585; x=1692124385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+FQ9Pvhakam5/58U+uBvMgwCqAm3HQiFp+DCs1/Xsw=;
        b=Wv3KQ3Ce4blc7JQENv4ylncWMF4AyzLLxZG/hC9QxW1XqYM/mJRP48bcDKxeJmn4Va
         0lC5IuC2EQGR+iflbFYqzJCnMPnectfb/XBjkpbS6PwZo5ZPATyIfusmAsMjnUU8Jwoz
         hSR1TWvyaUul5TtACBQX63VP7xTSbnzEMJ6jpOwxPFXTd6vNIEabNMA1jUTMAwXwJRKu
         jbwiERM1kIuf+CNL3+rRhBysQeZLeR1/zmx2ZDmP+jTITFM2oCQGi0QPh/VALgP5lrFK
         8UU5PbGYAF07XNHHE5i1Mq+IGEeEsOEdgMFRscy+RsBKF1Wagq099PyE399m1asPd+MO
         BEPw==
X-Gm-Message-State: AOJu0YzjBbBHi+gd1qNHSr4FNHovdM7+h3h8POitqPb+Z/U/m4GzlW42
        gVCTUiXWX0tMzj5EQ3JQDYv/Axb5sv0Zf/yOT0k=
X-Google-Smtp-Source: AGHT+IGz1OmiK2ue0MeBGqgJ/jV+pi+NIoRRV3+l4yqNtDgJqh57KJxXNgxqOzUqTX/E46nLCGoHUgIqUQkqStDAbQo=
X-Received: by 2002:a2e:9792:0:b0:2b9:c005:c1e5 with SMTP id
 y18-20020a2e9792000000b002b9c005c1e5mr262459lji.34.1691519584711; Tue, 08 Aug
 2023 11:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230807185510.237623-1-cgzones@googlemail.com>
In-Reply-To: <20230807185510.237623-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 8 Aug 2023 14:32:53 -0400
Message-ID: <CAP+JOzTO0S4xj+thGk7TLy6-uNuJHaEjRdtuCZiDUnXnyRfmBw@mail.gmail.com>
Subject: Re: [RFC PATCH] semanage: use instance check
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 7, 2023 at 3:40=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Please flake8:
>
>     ./python/semanage/seobject.py:250:16: E721 do not compare types, for =
exact checks use `is` / `is not`, for instance checks use `isinstance()`
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Another patch just like this has been merged.
Thanks,
Jim

> ---
> This currently breaks the GitHub CI.
> ---
>  python/semanage/seobject.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 361205d1..cc944ae2 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -247,7 +247,7 @@ class semanageRecords:
>          global handle
>          if args:
>              # legacy code - args was store originally
> -            if type(args) =3D=3D str:
> +            if isinstance(args, str):
>                  self.store =3D args
>              else:
>                  self.args =3D args
> --
> 2.40.1
>
