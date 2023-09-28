Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F35E743C0
	for <selinux@archiver.kernel.org>; Thu, 28 Sep 2023 20:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjI1UZP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1UZP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Sep 2023 16:25:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C69C180
        for <selinux@vger.kernel.org>; Thu, 28 Sep 2023 13:25:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50307acd445so21070596e87.0
        for <selinux@vger.kernel.org>; Thu, 28 Sep 2023 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695932711; x=1696537511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7oH8EzYca2UU+MMT4KDSdXWC74nGyzA/1SAID8jdvU=;
        b=H67UJ+YxNb9qforUOES2wF5cpgxxqiEJGjmOlnKWTWp71MIyT4L0KwIVYaHQJPgVy5
         3H6yaqyHGkIUDa2+lo0YFUxEgboNptuBGXqo7SPgY59OqVEqQWlzx2mrgeHlSUMb5teo
         35Nl2WV9QUvhKXiYwWjoguBLFW76en2G4hf4wQZAUUGYbnEQmsKbmvDetlRqZR5eQLG/
         jLUzQlRA/H8smCoM+NwJlpoV0CSHGC1ROr+oloeKqgYnqnpZv7Z3EAB5UqbCYzSfiGT7
         dxy8J9Iw6+xiYeV0UtCEX7Dqn6N6PPO7eNu/j2WOt7LMDHQwpLbpNFrkRtSbu7v1kwhZ
         FATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695932711; x=1696537511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7oH8EzYca2UU+MMT4KDSdXWC74nGyzA/1SAID8jdvU=;
        b=rSPvzp5t0ImW9WFeBasSVV1+EtXmJR/YyyxrUxAHgm70kj0EbL5NdEMKQOaSBWJWXC
         Cm9uo0O0c5mVRRGgEgRmNT7PVn61ol3YeFt7k8MRRZnfv/1w9UeSMTzjEa8ggzmmw7ir
         G/ZVr03FfGhjv/zPet+wpRCnMsj7O0PGjdMGBbC0gWyKxSA2UpbL6DAH+CeXGQNswphX
         lLBgmy/s9+iLAHoPxY/XDTh05avASN6I7I7hwTAAC70ZgWWz5gXmjsoOdsKp6CxjyNAS
         zRv0d7p0bXU8E2jWbN72WPOzbNAUyTO1dM07knidWynR1r4GVEDyeLwQ7ZL5uiPBp28H
         jGRA==
X-Gm-Message-State: AOJu0YwwrrBRkeFnk1JPSm62xoN41P74ACYp8Ep+VN161fk2aDGPUqHm
        sYLwdKgUeZust/D9YwYEhpYdXzFdxrJdp+I9wlQYsRKCk7o=
X-Google-Smtp-Source: AGHT+IGkozM/4Rpg5ag+qkufiRxJQcPjEm3ueb4JR21z6Al2xZQTNpNG9AMcO+03SXfpnPcMJwUdmMWstjEgHMqlz+Y=
X-Received: by 2002:a05:6512:5d6:b0:503:26ab:9ac9 with SMTP id
 o22-20020a05651205d600b0050326ab9ac9mr1767294lfo.48.1695932711072; Thu, 28
 Sep 2023 13:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <260cd39c55ff2d13f5ac916b508f023bedecfce9.1692025627.git.mirai@makinata.eu>
In-Reply-To: <260cd39c55ff2d13f5ac916b508f023bedecfce9.1692025627.git.mirai@makinata.eu>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 28 Sep 2023 16:24:59 -0400
Message-ID: <CAP+JOzQPWZe45H8HrXZtOh9FLo37fSrZdLVxZeNJQ6v_ey_h-g@mail.gmail.com>
Subject: Re: [PATCH] secilc: Use versioned DocBook public identifier.
To:     Bruno Victal <mirai@makinata.eu>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 11:53=E2=80=AFAM Bruno Victal <mirai@makinata.eu> w=
rote:
>
> Fix xml validation issues that often crop up since the XML catalogs
> for DocBook often only contain versioned public identifiers.
>
> Signed-off-by: Bruno Victal <mirai@makinata.eu>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/secil2conf.8.xml | 2 +-
>  secilc/secil2tree.8.xml | 2 +-
>  secilc/secilc.8.xml     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/secilc/secil2conf.8.xml b/secilc/secil2conf.8.xml
> index 33646f97..330b6a07 100644
> --- a/secilc/secil2conf.8.xml
> +++ b/secilc/secil2conf.8.xml
> @@ -1,5 +1,5 @@
>  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> -<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
> +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
>                 "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
>
>  <refentry>
> diff --git a/secilc/secil2tree.8.xml b/secilc/secil2tree.8.xml
> index e95a8947..d7bb177e 100644
> --- a/secilc/secil2tree.8.xml
> +++ b/secilc/secil2tree.8.xml
> @@ -1,5 +1,5 @@
>  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> -<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
> +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
>                 "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
>
>  <refentry>
> diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
> index e9a121e2..5c0680a8 100644
> --- a/secilc/secilc.8.xml
> +++ b/secilc/secilc.8.xml
> @@ -1,5 +1,5 @@
>  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> -<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML//EN"
> +<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.2//EN"
>                 "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd">
>
>  <refentry>
>
> base-commit: f6dc6acfa00707ce25c6357169111937f12512dd
> --
> 2.40.1
>
