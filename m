Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA6CD8CB4
	for <selinux@archiver.kernel.org>; Tue, 10 Oct 2023 19:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjJJTNh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjJJTNg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Oct 2023 15:13:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46C94
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 12:13:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50325ce89e9so7938422e87.0
        for <selinux@vger.kernel.org>; Tue, 10 Oct 2023 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696965212; x=1697570012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEa5TM1fjRckDjnSnL+lPLxvftK75tA9Fzai5Q60DUQ=;
        b=dLMRxHHtKo3Trc6YRtVenCA9DoTrzQgVY0bxsBaP3Ln46nuCnT3NKCf/agvnuzU/+0
         MPr6UuQxzWW+BOSKNqmfqE3QIynsEqeOMHe3WMsY/4e7Pt3nAF8esUHKQXFtpxDJEECg
         WOt7EPkym+v1sauY8rJXkCUtTW6Y4Q8dWSymNHpE3HPun4vSbi+FEKFbOZZwevgpH6rH
         zx8ZkSdM0MIbLHLJdG+RSWOrF6DfCvr261kqhhYn0cvBEjHnqVN6lfUdbtiWKpQ9mAgM
         gZspl+HRour1ke8hx8T6KKeirGUfUxDavEb3XI4tWHTrU6eLv31Syukjc3LXtxSeVekR
         UR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965212; x=1697570012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEa5TM1fjRckDjnSnL+lPLxvftK75tA9Fzai5Q60DUQ=;
        b=l3HjYuD5v9jkGPS9afca/XHHywGqlCYKgsZfqdCwgDxanWOLIeqZU+tAsgbCuuARID
         PE2vLKO8ffI+pG5Qwfk+ADKsGt4xEm+zHsSqD+g/BwkFKI8bfoQ9nIOglTz45fo1x3NY
         ucXcUjgpVcVIXUidh29n3l89mcFvPu1SIoC8lVC8bsldy/fi9cn3f19Zki0wzQa5uTwP
         blV6kmLlipE+dmGOv+4Kf0LOmM1L/dR+wumMQg8tRbOvYwA6lxgK52xi6tjYiu1mvWlU
         WP5yCjX7d0lM5QokTV7uWOXsKzm10nSMOL/kwY9BgsMRRjelBcwH/m5MZxhqKn6/qxTT
         r3XQ==
X-Gm-Message-State: AOJu0YwX9JRqTERGk7NQTmKFdxRjzaAIMsEepCLo2JHAVPsJTzzvoIWl
        /PZRt4TiJivpXpEeqLEcRfdov79o1sioj8rjD/R/AZATbj0=
X-Google-Smtp-Source: AGHT+IHRYYnpSmN7VEyKFoK7sLgK8nVBYXxykvuYVD2zYNGeWcNsPYB0OuO/SO6iiIZc1kgee/5bni8zy9V+dVxD99A=
X-Received: by 2002:a05:6512:238a:b0:502:a588:6609 with SMTP id
 c10-20020a056512238a00b00502a5886609mr20608938lfv.3.1696965212324; Tue, 10
 Oct 2023 12:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-19-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-19-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Oct 2023 15:13:20 -0400
Message-ID: <CAP+JOzTdSgh0Sf5tf0x0ZE4hmnnCQyUury8A6Kjwx921s9=eVA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 18/27] libselinux: fix logic for building android backend
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:42=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Fix the typo and adjust the logic accordingly so the android backend is
> not build by default, but if either ANDROID_HOST or
> LABEL_BACKEND_ANDROID is set to y.
>
> Fixes: c2a58cc52574 ("libselinux: LABEL_BACKEND_ANDROID add option to ena=
ble")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 15d224e1..86a254da 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -131,11 +131,10 @@ DISABLE_FLAGS+=3D -DNO_MEDIA_BACKEND -DNO_DB_BACKEN=
D -DNO_X_BACKEND \
>  SRCS=3D callbacks.c freecon.c label.c label_file.c \
>         label_backends_android.c regex.c label_support.c \
>         matchpathcon.c setrans_client.c sha1.c booleans.c
> -else
>  LABEL_BACKEND_ANDROID=3Dy
>  endif
>
> -ifneq ($(LABEL_BACKEND_ANDROIDT),y)
> +ifneq ($(LABEL_BACKEND_ANDROID),y)
>  SRCS:=3D $(filter-out label_backends_android.c, $(SRCS))
>  DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND
>  endif
> --
> 2.40.1
>
