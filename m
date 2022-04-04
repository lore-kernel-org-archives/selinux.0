Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D0EC433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 14:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbiDDO4C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiDDO4B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 10:56:01 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E891513D21
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 07:54:04 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id e189so10298571oia.8
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdohMB0pWSwUMaAyBY6M8ZlkyJQxS5S40FEXu/3u17k=;
        b=F3rIknapVe27oM3eII8lpXZdD5QYwXF7Oj/8WPzMeLkB6gfdD98KK9iBYrRkSIsHmg
         WlzIrs6ctw7p4w3pkfWEbUFR5FNH2Aq9xl/2z5v8QKipiMwQcrBmGUmf66HiUHr9ptt7
         xCc30m/oljLeCw42YINdFCxsgqsRNaPh52woL8lhKgVS4Nt/arQzQ6GdFOTY+DWV+p9s
         MAq+ac5grPutG5RI1qpyvy3oVyfObLF6xzh1lJ/fXXdNrcif8Tc69LITd/qJIVnjb/QE
         +1TAXHr7out7ynlZY6DYcX+RXR5Ytg2/VXH0kgrFADU8jn6B86+EPBlpWlgUOxStnaOq
         yN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdohMB0pWSwUMaAyBY6M8ZlkyJQxS5S40FEXu/3u17k=;
        b=CxTHVIsGnoYn95QtKILlt5AkpDG3o8St/3xQEVqko/ubSx8imHvgEh4R+t7AiWAjfz
         KQ57u9qUGKnwlcRV8UGqca/X9ASeJck+vAMkrhsgQfIVwVxPlAVqmP0GRiCucn0cVKXu
         XwY8KRTa4OtzMTpfoIs/LbokBmLoq0/nDSmoJ4Kur8zCI9s+lvIDUgHAO7gQiuQyk6RC
         3qVsva2qxl7xrH/PEoT50Qd1wVUQoOHvCzvcXBByNDlzLl1JYR1BBDTUqGJk6Q9QKtJW
         jn0x7l4yQsf20oAo978LWMTsCgQP3Mz/zKDLnT6p5Fayo7FSytXTuHc8xP8jQxgZOoOb
         t2wA==
X-Gm-Message-State: AOAM533rlX/Vwa/P3s0cOZradK/B6YpcLJzH94DhuvHNRl8D00FL5yF3
        LjzwJbnvTKPA//BqpjgdK8bh57L2X6ueQEJy24fWe7fm
X-Google-Smtp-Source: ABdhPJzLHEIyGJV4pgRAx6hxeuRPXBgWFEEvEaadFqg9Mq5yxO2Wv8ZlbhL0vyosiO5tYNS77qD7VFsLXp9FDAoBB14=
X-Received: by 2002:a05:6808:ecb:b0:2f7:41cc:21b9 with SMTP id
 q11-20020a0568080ecb00b002f741cc21b9mr10061607oiv.156.1649084044313; Mon, 04
 Apr 2022 07:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220401112730.108257-1-plautrba@redhat.com>
In-Reply-To: <20220401112730.108257-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Apr 2022 10:53:53 -0400
Message-ID: <CAP+JOzTVdo2N8YKuhaS7xBVYCUjNFfb7NHk=yqTN1LZRncB+gA@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/setfiles: Improve description of -d switch
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Vit Mojzis <vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 1, 2022 at 9:45 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: Vit Mojzis <vmojzis@redhat.com>
>
> The "-q" switch is becoming obsolete (completely unused in fedora) and
> debug output ("-d" switch) makes sense in any scenario. Therefore both
> options can be specified at once.
>
> Resolves: rhbz#1271327
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  policycoreutils/setfiles/setfiles.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
> index 15f939d1bee0..0aab2aa24681 100644
> --- a/policycoreutils/setfiles/setfiles.8
> +++ b/policycoreutils/setfiles/setfiles.8
> @@ -59,7 +59,7 @@ option will force a replacement of the entire context.
>  check the validity of the contexts against the specified binary policy.
>  .TP
>  .B \-d
> -show what specification matched each file.
> +show what specification matched each file. Not affected by "\-q".
>  .TP
>  .BI \-e \ directory
>  directory to exclude (repeat option for more than one directory).
> --
> 2.35.1
>

Looking at setfiles.c, specifying "-q" doesn't do anything at all, so
it makes more sense to me to change what it says for "-q".

Maybe:
Deprecated and replaced by "-v". Has no effect on other options or on
program behavior.

Jim
