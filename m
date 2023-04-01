Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07C6C6FD1D
	for <selinux@archiver.kernel.org>; Sat,  1 Apr 2023 18:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjDASEt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Apr 2023 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASEs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Apr 2023 14:04:48 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D211CB9B
        for <selinux@vger.kernel.org>; Sat,  1 Apr 2023 11:04:45 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id h27so21941459vsa.1
        for <selinux@vger.kernel.org>; Sat, 01 Apr 2023 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680372284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DI/XphZrsiW9owrgQ3Z1hQqfRT6JxYhDoEYau4eLCSk=;
        b=KUsNB21Rz0rNM7FTO3y/UeDLb4Fmzxk3zZx1Luh+sjps1x+qETc9RpXa3tczL8kfYS
         sz2jekNGIZO6Spa1UAGeMYgPFo+O5AbQPXyil0SRtawkwVXOMguXLiR2uh1SJvwef6lA
         ZuHZmVZmq5bCysLg6iHAmR8tGBdkrx7296QvC9QEMijQgPx/Kmlx6LnJPJhvQoVM1+qb
         qVazLIwpzi9YNg2NfHQWaKL9K7xNwP/IUg/vEbBEVSVCGSDENFxMjwis/Fs7kf7Gm6F+
         X+PjxoNwMTwuWkEGGm8Fq3oFI10/jp+1Uf3Xyj8wPxVE2fltIVlKmSFSNYlPyU4N2C3O
         Z1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680372284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI/XphZrsiW9owrgQ3Z1hQqfRT6JxYhDoEYau4eLCSk=;
        b=cCt9xSF5ibB7EDyP1nvzHKhdb5tboyR3OTM8JvxLdUfJ01V1O+7VwrylF+3pxhSL7g
         1aZ0AyTdhjPAEeY48w0vqIvrm18Dclva5uiRezdUpUxmYFRbuSzhu6kgoay03ngr8cbX
         gr3n65ENzcBqqAsaFhBNXcqt4SzyambHwfvkdqQeVei2VOKUoM221gsyTkk0+LMM8uPm
         bHbedWx96GWThgIpIWBQMnzzSkGIVl6JPo/LaRgRiL5BNePDY81ihfEVeHjbm/V9PRwx
         r2/3LjbM47qLwO3koNMjvfjDFccTZHYS1g/iw7uEhaohNsuBqkaY4IHXWY/B/jNK2KAV
         dhlQ==
X-Gm-Message-State: AAQBX9f1x4YPSe9luZvy1S2dnusVkka21xJtr5ksdLjzejeW3/6FGNE1
        CrS66v80dl3Mb+zWpc7MFxck0jO5KSygmdnIR5A=
X-Google-Smtp-Source: AKy350ZIMtGm118cEDNtIr55YRh/n+QewHf2iE/OU2+PKvwYxWJxClk8yrTvPKHbcuPOQcEqZpvnYIikX1VZg3EItPo=
X-Received: by 2002:a67:ca84:0:b0:425:a2bf:4033 with SMTP id
 a4-20020a67ca84000000b00425a2bf4033mr17436778vsl.2.1680372284501; Sat, 01 Apr
 2023 11:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230401004252.859777-1-smoreland@google.com>
In-Reply-To: <20230401004252.859777-1-smoreland@google.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 1 Apr 2023 20:04:33 +0200
Message-ID: <CAJ2a_DfHU00V4mZk+NGTh3NjYUW6D9d5XM-KS16WK6rLNEcmSw@mail.gmail.com>
Subject: Re: [PATCH] make avc audit line only have one space
To:     Steven Moreland <smoreland@google.com>
Cc:     selinux@vger.kernel.org,
        smore-lore <45954464+smore-lore@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, 1 Apr 2023 at 02:43, Steven Moreland <smoreland@google.com> wrote:
>
> From: smore-lore <45954464+smore-lore@users.noreply.github.com>
>
> The kernel-based logs only have one space.

I don't think they have:

https://github.com/SELinuxProject/selinux-kernel/blob/dd43102acca0836f5e50746c47c258be1ef9060c/security/selinux/avc.c#L674

> So, many scripts need to
> parse 'avc: denied' and 'avc:  denied'. Also, I frequently have
> developers missing denials because they grep for the single space
> version locally.
>
> Signed-off-by: Steven Moreland <smoreland@google.com>
> ---
>  libselinux/src/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index 8d5983a2..8fdb2389 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -711,7 +711,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
>         /* prevent overlapping buffer writes */
>         avc_get_lock(avc_log_lock);
>         snprintf(avc_audit_buf, AVC_AUDIT_BUFSIZE,
> -                "%s:  %s ", avc_prefix, (denied || !requested) ? "denied" : "granted");
> +                "%s: %s ", avc_prefix, (denied || !requested) ? "denied" : "granted");
>         avc_dump_av(tclass, audited);
>         log_append(avc_audit_buf, " for ");
>
> --
> 2.40.0.348.gf938b09366-goog
>
