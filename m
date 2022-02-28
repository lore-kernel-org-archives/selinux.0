Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C493C433F5
	for <selinux@archiver.kernel.org>; Mon, 28 Feb 2022 20:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiB1UJ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Feb 2022 15:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiB1UJ4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Feb 2022 15:09:56 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543CC35851
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 12:09:17 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id a6so14259046oid.9
        for <selinux@vger.kernel.org>; Mon, 28 Feb 2022 12:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zZzIUyww4TaFdAgWrS9NkLKZC1sjVsoNfm1GxNzE+2s=;
        b=olUbqxZM4xH1m3hNQbRKCquGIukargKlNbvAOAtQ8gsp46j70slPhYzk0RaijeU8ee
         tCrHIzM/fHkkUx0wVFcSnQtSst63NgFUOE01QTjmNelZNmrwZuwSUEc0M5oOef01pQAM
         288jk94nDHjQmF+p4bmBlfEfiBj9gtXl5pElcrtpnyLtd4BE/e403ka3MyhPEGz2GcfI
         QIid20Ti/9VSLEnYJz6jsqFAz0T9aJeYRDAdgli8Gb4wyBEL9nxmJbnm6CpjukihHEZq
         N7GDs3LtVa1SIVKGNBOhrJzicFNOWVA0opHtYRQgLCtsv3jZHECAyMn7IardJI0Yq5OT
         nGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zZzIUyww4TaFdAgWrS9NkLKZC1sjVsoNfm1GxNzE+2s=;
        b=T/AXt+ncoqjUIwVGxk1szTlSnxCRFsuSvgqdceee6pCJZ23UPmfE8gJNIiL17Vt+lL
         L7Pkp1kbmk3LxdZCZoi6tmWVowQsMRpXQ58dCnYIq6wKJdYZAIFGmD26jVJe6+Exny0o
         qifiAf12Pkr/df8sdVB6gqX6tfVO6T+raltytDoV9DvadNBjyYNcnsnkDi9lL2kXRAah
         OcS14ofY2qWBUF5sXNa8zeYOXaelLmz2plPb6M/rEkOUj5HTYWKX3hU+45tjtWpLJf91
         TJ7GftbP7yusuWLlQiIrtWD27Qzn9VLDHSWA9cev8cLGASxrjrIGEuX3Tg+DRbvZyd+a
         lOiA==
X-Gm-Message-State: AOAM531JLwTOwHhzAQ0xVE8HKwTs1ALWCjBc24ZEBgD39MaCM8g6AIGV
        WNKud9sdIluoRLvCONdAtBBWaHrB8WLXn+9Im9w0bFBK298=
X-Google-Smtp-Source: ABdhPJx3KzzxX8onolMqKxXwXMbAVRv5gBpQjeP7EP/Wh6d9q1M5dfLgmewiFTqv0yInb5xy752CxLrjRuuFfFfNFQA=
X-Received: by 2002:a05:6808:150e:b0:2d4:d2a5:85ff with SMTP id
 u14-20020a056808150e00b002d4d2a585ffmr10145548oiw.16.1646078956719; Mon, 28
 Feb 2022 12:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20220214165812.9359-1-cgzones@googlemail.com> <20220214170855.10603-1-cgzones@googlemail.com>
In-Reply-To: <20220214170855.10603-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 28 Feb 2022 15:09:05 -0500
Message-ID: <CAP+JOzQ=WsaQJnQv4AKNCEzPBevvhRKXDHrgUO14XVxm4nCjCQ@mail.gmail.com>
Subject: Re: [PATCH] python/sepolgen: accept square brackets in FILENAME token
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 14, 2022 at 4:19 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> When parsing Reference Policy style files accept square brackets in file
> names.  The FILENAME token is used in the TYPE_TRANSITION grammar rule
> for the optional name based argument.  This name can contain square
> brackets, e.g. for anonymous inodes like "[io_uring]".
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> added missing signed-off
> ---
>  python/sepolgen/src/sepolgen/refparser.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/=
src/sepolgen/refparser.py
> index e611637f..1bb90564 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -261,7 +261,7 @@ def t_IDENTIFIER(t):
>      return t
>
>  def t_FILENAME(t):
> -    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :]+\"'
> +    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :\[\]]+\"'
>      # Handle any keywords
>      t.type =3D reserved.get(t.value,'FILENAME')
>      return t
> --
> 2.34.1
>
