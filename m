Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E4CCDB47E
	for <selinux@archiver.kernel.org>; Wed, 11 Oct 2023 19:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjJKTA0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjJKTAY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Oct 2023 15:00:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1C6CC
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:50:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c012232792so2063541fa.0
        for <selinux@vger.kernel.org>; Wed, 11 Oct 2023 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050224; x=1697655024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTnQBhxNCkkMGfzJTHFcsHQMMqGA0AoX1fUZ6VHGlGA=;
        b=dMdGkqEGRZaqnw/68vfw5lFwjzG2vAmb9eJfv0nESGIXMTJ6ruU6V4HfoH75zPwQuX
         xBed5sVAeUQaRFWHA/NWwQ5eunzM1jO1vuiaNWfkA8HYX9swLag9/8T3+ZR9vJYfWMm9
         igVZ2HA4IrUT1881MS2BiYl0lL1VuB2ClTnT/AFXfLsy8SmEQNLAefx2QTeZopPiwyTW
         6YWYv+22eEprpuShRkr+E4AtmXha4DoAn+E4Ybmcv60oF7NVtCQBnE+D4JYenU9oOGzq
         pXe02SJPCO4QZvtWP6YESizenQRsCoBNqrUeb5K7/AHdMNB+ao2VqUyHWonv1uZy0w01
         2TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050224; x=1697655024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTnQBhxNCkkMGfzJTHFcsHQMMqGA0AoX1fUZ6VHGlGA=;
        b=grjfsS1AZhGQd7YB7MlqnHsPivGLphSjaxcmm9ys9DYrwR09TW2uDPXQ+LBoDJ559P
         wf+ZStsoBkkqBfaZCEBB7aKbgsS+UjC3Dyhu69cUi1HoiZUToNQB5ASTCYyJ/3GG27Ns
         a9k5m10Ql5ro2g0MYVexGoDQ+38tR5byIank0xxnp5h2EwjPx7E7FF4ESsfwC9+xwxIf
         woYDTnOg5vzBaLfaCe4Zzx32NpGYsGW1H+ADGFTrflRPTGgBypJBs+DEe5yGRJFPbuk2
         l+2YvsqSMQVELFdvnUBqVWkekk2op6xzYEZU/xX2KEPVd0MihTfrqdEzi0mBzn8kqywx
         rwOA==
X-Gm-Message-State: AOJu0YxiYRq8yabtISjqveiXo4NEUInc6hyrwYznm6UdSJH1M2L2eUle
        DMbbgzSEqGMSVIdytanMJ20hKbiFI+veQP6LLxgg4NFP9Qk=
X-Google-Smtp-Source: AGHT+IGyUUDIBdT9OTRLkMgbRiAJhnBqHoPiCaCEuSEhGM+AEUGjgpL7zEQnEiPjf+ymfm5911mfcbVaFH63qbCrltE=
X-Received: by 2002:a19:910d:0:b0:501:ba04:f34b with SMTP id
 t13-20020a19910d000000b00501ba04f34bmr16381822lfd.44.1697050223714; Wed, 11
 Oct 2023 11:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com> <20230814132025.45364-24-cgzones@googlemail.com>
In-Reply-To: <20230814132025.45364-24-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Oct 2023 14:50:12 -0400
Message-ID: <CAP+JOzSnUCL3_vte_4oNfnyOxq-yj+EfFEdpECiux5-qUW9-JQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 23/27] libselinux: free elements on
 read_spec_entries() failure
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
> Some entries might have been already parsed and allocated.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: add patch
> ---
>  libselinux/src/label_file.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index 56439e2d..3827b5c0 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -446,6 +446,9 @@ static inline int process_line(struct selabel_handle =
*rec,
>                                     "%s:  line %u error due to: %m\n", pa=
th,
>                                     lineno);
>                 }
> +               free(regex);
> +               free(type);
> +               free(context);
>                 return -1;
>         }
>
> --
> 2.40.1
>
