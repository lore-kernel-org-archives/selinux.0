Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF4C05027
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 14:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBAOej (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBAOei (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 09:34:38 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15047087
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 06:34:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m2so51524772ejb.8
        for <selinux@vger.kernel.org>; Wed, 01 Feb 2023 06:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJJ9VuQ2oXc/RR/zOnxk/2CU9TE8PPIk4DbQDc9ZFJ8=;
        b=P4u8o6zIuURcQPQ/xYGaFNAs92FTlIlI5r1OuODannKayPuzkvsjmOMriMpsGn+eBU
         QJqFiXp59M38bBgmpxDVapctzvnd3unMAetEAJSaOT4nsbX6PkkHwFNcJdgsippQ+8AZ
         bxKvtMAU0PfSATvXdu6nHe9Yzatp8iRweAtbBd+2y8Rgqoh5itW8JIc5IO3FmrWTC8jw
         XFAzvxNrGlKb+gfBfM/poNRWQlmW1MrKOL+AHUfKfCkWeB4s3Cw9NR3RvbCdYp56JURH
         Wit3s/f09avNMBm9SF7S3Ap8ZyMWcdbiM2Vf3R7mdr4exvQgryQGcTauHRXXIdJLpZG7
         +zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJJ9VuQ2oXc/RR/zOnxk/2CU9TE8PPIk4DbQDc9ZFJ8=;
        b=g1QeIKpiGLFB3+5L/pqNaQcVPlpTFr4rJgQC45LVWELrGbV+qRFdMzwlZKBggr6l5a
         ITg6bZma3Ou8gN/jDx/KUrSP80yYHEgyKfHhNZtlSsk57GFo2ynQRYIl+vqWVsF4dKmr
         SLdUo/P82194Om+PGD7WiZyjbM3iaEbiD0L3+rjYivm9gaIo8lQ7KsPjeaMTIMbmHcqO
         YnqyrYXCYclTCIorLMt/1pE3w2qrMq3WQeNqr7CotFlpUY99IK2Aq3U6OsPwrEEL/Cwt
         YhIvkScMYVTm2HMiB+zVNxDbQxgyx3o0Uc9zY1sSJrCxyb31OHFJCFLij8Em+KN53MIT
         EV4A==
X-Gm-Message-State: AO0yUKUdG4OwLeOo+fJjxxBNw5Hd8Kvc8LmXhKhpAhZy1Ff/u8pIRVpF
        i13XJKJ7z6r4Nujk5T7GBLzS1VLF2Sl9h8Fs0RSOeTazDww=
X-Google-Smtp-Source: AK7set8URvQxybOTxuGAbesOHbgzXjzVmVvrPit+XfVwjtHD4xSCj5YEAf+f0/Nc+cyPFYzi1lskQyAR6rQIHvH/rc8=
X-Received: by 2002:a17:906:49da:b0:882:3e56:a854 with SMTP id
 w26-20020a17090649da00b008823e56a854mr757464ejv.263.1675262076174; Wed, 01
 Feb 2023 06:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20230117172050.18462-1-cgzones@googlemail.com>
In-Reply-To: <20230117172050.18462-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Feb 2023 09:34:24 -0500
Message-ID: <CAP+JOzSvvg_2pZ6aeLGs9Oqh2nK0zpBGAURwbofh9DSAT39iVw@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: preserve runtime directory
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 17, 2023 at 12:36 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not remove the runtime directory /run/setrans/, which is the parent
> for the security context translation socket .setrans-unix, when the
> service is stopped, so the path can not be taken over by a foreign
> program, which could lead to a compromise of the context translation of
> libselinux.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  mcstrans/src/mcstrans.service | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.servic=
e
> index c13cd09a..fdcfb0d4 100644
> --- a/mcstrans/src/mcstrans.service
> +++ b/mcstrans/src/mcstrans.service
> @@ -9,6 +9,7 @@ Conflicts=3Dshutdown.target
>  [Service]
>  ExecStart=3D/sbin/mcstransd -f
>  RuntimeDirectory=3Dsetrans
> +RuntimeDirectoryPreserve=3Dtrue
>
>  [Install]
>  WantedBy=3Dmulti-user.target
> --
> 2.39.0
>
