Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F41EC433F5
	for <selinux@archiver.kernel.org>; Fri,  4 Mar 2022 20:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiCDUDK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiCDUDD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Mar 2022 15:03:03 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9891C9B73
        for <selinux@vger.kernel.org>; Fri,  4 Mar 2022 11:54:06 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i5so8947486oih.1
        for <selinux@vger.kernel.org>; Fri, 04 Mar 2022 11:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CS8WvJ+cwEzXMkmnUayuy35oDsZmvuJn0tH7pfUOhsw=;
        b=JMR/BfxYWDDH5WDLICH+3zPz4zjFs/l39CiecKrV2UVb0meZM6lsHr3mwJLTiaOqu/
         2vUAJtAZ/fVhXOvBtiXPbA30FY4mO0U+V8vD0JEVwakvkM7GCV/n6jt0gOn2WQwodixA
         O8z8YLmPSTOhZ5hyIhf3udtfXMMDUVEAtpmZzvnCFdlrxncJNKxwNbxYQx4uCb4TSJYz
         4gksJVKgrAtd4BJ/UdtYgcinzHuxkWzPQzZ6JojssM2kb9v5LqllhEjDLrqxRioeLJRX
         hUautNJmlprAqR4T5xbLvtMfrhGkFJaAROmTKHGZDL6+5JIYXN781oapT7U/2AleovEG
         0ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CS8WvJ+cwEzXMkmnUayuy35oDsZmvuJn0tH7pfUOhsw=;
        b=WPeaNcb75LQuThicnOqlhOfuSqBPz16eC/2fdn2xiUdVsyhnRhkN6/+aTvelt7+mpS
         PQJ2iJgDvy0ad+rpyC9YyIz4KP9MTJjjq9pJuoEplcdPAy0dPnQbnQUV+eTyK4xZi8+Y
         62kdm63RU980jypvQCjrb1/AP4DmkbutrXHGQ9ktOPpWeniymvhf0PZARYKvgL08rg34
         Xz0Pv/8IGYqA05gXsrxHugWFIXpyaBJGN8IjvzYtffzwzjxAv38V/sL97IvLQ8LpBEyn
         3gZZ9JOkX9WG6ZLaTQUlpwO9vwqbdVlA31Wyk+a8lmdvVEwn4oD3CW9qmeO6rOXMmc5N
         tXqA==
X-Gm-Message-State: AOAM532UgmL3op894ZXbJ7GXAthJYnJ8J7yWY4PvbFyUTf1OEpFf3omf
        Xa4ejf3LtqTLs05LlV4WOj7m2wBtbGkA5sXB+28=
X-Google-Smtp-Source: ABdhPJyFAn+srU+sKOWi9WUeT7Ext6Z6uHSlCzoGyB8kt/WtM/ttWE4CQS+h6G0wB1Uc/VAPCZnhINVtgngbBbQ2ccQ=
X-Received: by 2002:a54:4611:0:b0:2d7:988a:5784 with SMTP id
 p17-20020a544611000000b002d7988a5784mr10747885oip.156.1646423645498; Fri, 04
 Mar 2022 11:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20220303052306.357002-1-tweek@google.com>
In-Reply-To: <20220303052306.357002-1-tweek@google.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 4 Mar 2022 14:53:54 -0500
Message-ID: <CAP+JOzQr0vA4AuEYcvOXHwxcG+bFEjmq=07Z8gLgb0sk=XXXQw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix reallocarray imports
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Alan Stokes <alanstokes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 3, 2022 at 2:20 AM Thi=C3=A9baud Weksteen <tweek@google.com> wr=
ote:
>
> In f0a5f6e, calls to reallocarray were introduced. Ensure that the
> correct header (private.h) is included when necessary.
>
> Fixes: f0a5f6e ("libsepol: use reallocarray wrapper to avoid overflows")
> Test: Built using Android CI (glibc 2.17)
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_common.c | 1 +
>  libsepol/src/util.c             | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_com=
mon.c
> index dc9e689e..972499ab 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -18,6 +18,7 @@
>  #include <sepol/policydb/hashtab.h>
>  #include <sepol/policydb/symtab.h>
>
> +#include "private.h"
>  #include "kernel_to_common.h"
>
>
> diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> index b7230564..1cd1308d 100644
> --- a/libsepol/src/util.c
> +++ b/libsepol/src/util.c
> @@ -28,6 +28,8 @@
>  #include <sepol/policydb/policydb.h>
>  #include <sepol/policydb/util.h>
>
> +#include "private.h"
> +
>  struct val_to_name {
>         unsigned int val;
>         char *name;
> --
> 2.35.1.574.g5d30c73bfb-goog
>
