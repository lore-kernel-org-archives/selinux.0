Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33451C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Apr 2022 12:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346213AbiDKMmG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346193AbiDKMmF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Apr 2022 08:42:05 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F93541989
        for <selinux@vger.kernel.org>; Mon, 11 Apr 2022 05:39:39 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w127so15682551oig.10
        for <selinux@vger.kernel.org>; Mon, 11 Apr 2022 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wj0rsy3Z8jAtXiDXeNa9tt5apaUuCo0STvpe7IMnto=;
        b=Rd9dR5C0RgLp5YZG1ydVgfleEa3LCKz6Heanpip3LDxKrWwHgOU//3wII2B3YUBRnm
         TgEIAmhlVVCrNkU7LtZIR7dnV3xuiUo/mS1Fjwo6EPTHiCWcq8a48IvZK/NY73V3/tt0
         9bRQppv+mDVdYw85Ps+77f76twzzUJedGB8pFChEoMBb5SuIjy/vtBue77uZJ13np7Bu
         hoE4z/V1RQCgxttiWefu7moClqp/GOJ3PmHupjfrKXdu90yNGYeUOWxjQbV3l3qGK81G
         iNZzwX55vF/5CvS3qqNVFmkoHtExqjN8j6pwoLCZOiWhHajpj59AEnH8JB4MuBi2L+h5
         zCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wj0rsy3Z8jAtXiDXeNa9tt5apaUuCo0STvpe7IMnto=;
        b=cWgYZhsNc6qQVNoo02vJTHUZDH1agEdnInizpfOSFQ2l/rFqQ82RzW12X0JQiHY05n
         ZIccwlQ4Y4/0yXp+CATqtDyBAaNTc0/AzqRq2NHRtEBW7nudfwHeANGxZX+3Fpafdn/V
         urjo8Gf8uXBD6XfW1w6iZJMYxHFgNT3HcfRuDB5i+n/d2wYsmk4xIz+mmK1c23BO2OX1
         EcSgDb99WM31mtOXS9RJbb+8g+oMbVH1UWlNexHlyHJyz1fyeBkORpF7lVGTDmYgOZ6w
         CMcws/Q6e9bgIZM1bh00SxBA+EDj3OypsC8977ASq7xiC61Ih1roCKwUDEHS+0tK7lWr
         qWTw==
X-Gm-Message-State: AOAM532XJOcJmNxFo9BRd1THWeeTmmsnHNl7R0NUacmkpC0DcVWJuz1C
        LkJSHqKKGZv9az7AKpEhb3V8yeYPQqdb1gAY3WW1C4mKmTw=
X-Google-Smtp-Source: ABdhPJwZ5ZUT33+HtOkmWVHyAeHYKEmSYxCCRfIIafjLejnqz01aszaE2IeRE3KVCOkoram43jFjqBytc61vmm6AORA=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr4744576oiw.182.1649680779301; Mon, 11
 Apr 2022 05:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220405071735.251995-1-plautrba@redhat.com> <20220408085907.463960-1-plautrba@redhat.com>
In-Reply-To: <20220408085907.463960-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 11 Apr 2022 08:39:28 -0400
Message-ID: <CAP+JOzRWPuA2eG15ZyUcb2k67d=dEUTtn+7afshN95V=fiXTCA@mail.gmail.com>
Subject: Re: [PATCH v3] setfiles.8: -q is deprecated and has no effect
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 8, 2022 at 4:59 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: James Carter <jwcart2@gmail.com>
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/setfiles/setfiles.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
> index 15f939d1bee0..19b59a2cc90d 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -124,7 +124,7 @@ and
>  options are mutually exclusive.
>  .TP
>  .B \-q
> -Deprecated, was only used to stop printing inode association parameters.
> +Deprecated and replaced by \fB\-v\fR. Has no effect on other options or on program behavior.
>  .TP
>  .BI \-r \ rootpath
>  use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
> --
> 2.35.1
>
