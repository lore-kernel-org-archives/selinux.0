Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528C7C433F5
	for <selinux@archiver.kernel.org>; Mon,  3 Jan 2022 17:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiACRpZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jan 2022 12:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiACRpZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jan 2022 12:45:25 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4499BC061761
        for <selinux@vger.kernel.org>; Mon,  3 Jan 2022 09:45:25 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t19so55968122oij.1
        for <selinux@vger.kernel.org>; Mon, 03 Jan 2022 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+hIRbW83O/UE0+SBVRnGqQbWHjdcY3NTvCI77e1rq+U=;
        b=ZVzXkWTcZFlXeORiv7yMYAeo71eGmh/kR6j3dMfXprdDrzrnphVLqy0wjMyQscEY2N
         5xtHkdIVOCcRoDhVXppbYugCAB1ag8IyV5dn5Je+PkLMAR/Q8DaitprYxXRkSJMZFEL/
         oAr5c8PPmqsE2lIOUqhbDY3yFzqOaNnSQVrRyqpFNZssnHMFc3ayeqsEJi9wABRTj7hB
         mEu3CpuSX/tD7fuJvtl7Fqk88zBl0sLQH1WqNcHgbBO5H/2FqsMFOvH0oeErUTApcPil
         1x+2IovPl2+tm2kJOQ+K1N7RMIX+uLQqnjElptFAt4qvO+Lm5jltGRuJDdzbVcH+eBMp
         dlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+hIRbW83O/UE0+SBVRnGqQbWHjdcY3NTvCI77e1rq+U=;
        b=df+dMja0EO9Ro7dUHgFcwOm4T7+8laxBdemAt5g7xcBO19L+K1s7TGzVfkfMaaG0ic
         1AzSRY3XhvqW7O3h7EvFpM8+iaCn+64Rtc151CNCWyATDIh4lQNwM12JpjLVpIp1Zav3
         wbFkj027QD2ZcitUvVdqfyar2OGMlaPY0v/Xr0yknXuT+a/T4whIut5Mh+GqIRZL0A+i
         2zq7IDmoyiL8mkm39MryRTOeGipPd4yRdcPU8jRcNwuo603RuCrvoxfjOmJWcZS+XFiT
         yr4gAZ2lsN/7PAZF/HeXOBJ3d0mDGl1CtCdVXrXeZRyQhuL8+fofCg337dJJjN8kxWb0
         d1wA==
X-Gm-Message-State: AOAM530t1SsR0GrS4MLC0iTgPvJdW6iHYFm57VozfoNOqCPHLlaaAXw0
        cCg6ia+MHtzYN4OvdLS03GH7L756yt6HkdNgQ7bHpxH+5zU=
X-Google-Smtp-Source: ABdhPJwLOMeu7Zkf50PTLFugHCEAnZ7j96pXXx15AWVcN21Up+oY2x9HwtdvSN2MvVGbOKNBakm2lXmPYitwq2ww8oc=
X-Received: by 2002:a05:6808:e87:: with SMTP id k7mr37930948oil.16.1641231924681;
 Mon, 03 Jan 2022 09:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20211220180318.37453-1-cgzones@googlemail.com>
In-Reply-To: <20211220180318.37453-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 3 Jan 2022 12:45:14 -0500
Message-ID: <CAP+JOzRZRyzDH0vnmSdOqNcf=rxq5gYcwyMeWHqiWYUrXJpJTw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: bail out on snprintf failure
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 20, 2021 at 3:16 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not continue with a negative return value once a string append
> operation fails to avoid increasing the buffer length variable
> `str_len`, potentially leading to an out-of-bounds write.
>
> Found by GitHub CodeQL.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 9916cbee..38edcf8e 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -1456,6 +1456,12 @@ int cil_userprefixes_to_string(struct cil_db *db, =
char **out, size_t *size)
>
>                 buf_pos =3D snprintf(str_tmp, str_len, "user %s prefix %s=
;\n", user->datum.fqn,
>                                                                         u=
serprefix->prefix_str);
> +               if (buf_pos < 0) {
> +                       free(str_tmp);
> +                       *size =3D 0;
> +                       *out =3D NULL;
> +                       goto exit;
> +               }
>                 str_len -=3D buf_pos;
>                 str_tmp +=3D buf_pos;
>         }
> --
> 2.34.1
>
