Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD00C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 14:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiLPOQR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 09:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLPOQP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 09:16:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC0554F8
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 06:16:11 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so6495654ejc.4
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0fmEnseGIFEICNCA6q30GS5vtYvoKHfclhX2cOQ+b4=;
        b=Xuh0qSZ3JMjn/IU4OFRUGh15iq7ARLk9Och8enwYDbE5NunEUx7u5atS4XD2WJdgZH
         RROL0ZXw1xF/qCN+sQcUMLw4veMSGp6nQW5A2cXmLHZ1eQmRY2gK3Ygu3hyThpsE3aOn
         pPaMxC4JwmI/tHlV0/idN/SANWl+ElweJE0wmiiNxuZeP/rGncZ6lzUn2lJc5q7XMuhF
         /ZNV6QrgBRuVhz4afuO6mnrSCgLp1wrTPAyk09B5kR6Y7C3325Q50diyu7TjIVKxCOTO
         kJJVichcDS9pphlaCIzoI/PrOrOijbvEJo+JeXrjD5CLyRX+JBj4K4n+bNY7zYQJ1I8e
         7TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0fmEnseGIFEICNCA6q30GS5vtYvoKHfclhX2cOQ+b4=;
        b=WrLJSk19sz08+Z8WCnsrp4VsOShlOsJW0UUSNSr0xNvM9aOSo6iCdB8MnwGBVXr9dm
         EhLTp/m9K6j6DCmD3xFLZyxTtnukoKFHes/qTGBedB+UuScPXgB/c1d0VIK0m7fsmlfx
         /FZXlRvIT0uS0bO7O5qPbp4nsOomDBvfxJcCjivi9mRAnqgU1wCIFka8uMhwlGYkuFI3
         Sve4mU4e3lR85g786dsS948K4neXVxRLAX5B5YpM/N/5Nnxe4D6LyUu8BoXjFE/f353I
         7VVL9Ap3k1mvfHqlf9rqG9C6AAXFM1pfaBEhiMzgM6pyGoHbZCyVMc/6au7huvz9k5UJ
         Io9Q==
X-Gm-Message-State: ANoB5pk9QM6Mpo70YOoAk6bn1+KehWOKxiCcfO2PDWMg0zEw1vxAgRQT
        A0h7WSrTyppQ6FLGOUKYfqQwtHduFKGoWEnlgd8SuwtOjMQ=
X-Google-Smtp-Source: AA0mqf54F6Yg5JZQl85LjxuC1TKh2ueV0a91nmob1DObu9rprsFF2HP6588mVOhAK7RbAWE9x3r/EQEPRYaVJWh7Ujs=
X-Received: by 2002:a17:906:3a15:b0:7c1:b65:ad79 with SMTP id
 z21-20020a1709063a1500b007c10b65ad79mr10905616eje.402.1671200169954; Fri, 16
 Dec 2022 06:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20221129120020.1915666-1-lujie54@huawei.com>
In-Reply-To: <20221129120020.1915666-1-lujie54@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 09:15:58 -0500
Message-ID: <CAP+JOzSa5KU90uwNt3d16WKQudo_zDDbruHaVzUa1d67-gtcVw@mail.gmail.com>
Subject: Re: [PATCH] libselinux:add check for malloc
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 29, 2022 at 9:45 AM Jie Lu <lujie54@huawei.com> wrote:
>
> Add return check for regex_data_create() to avoid NULL reference of regex_data
>
> (gdb) bt
>  #0  0x00007fbde5caec14 in pthread_mutex_init () from /usr/lib64/libc.so.6
>  #1  0x00007fbde5e3a489 in regex_data_create () at regex.c:260
>  #2  0x00007fbde5e3a4af in regex_prepare_data (regex=regex@entry=0x7fbde4613770, pattern_string=pattern_string@entry=0x563c6799a820 "^/home$", errordata=errordata@entry=0x7ffeb83fa950) at regex.c:76
>  #3  0x00007fbde5e32fe6 in compile_regex (errbuf=0x0, spec=0x7fbde4613748) at label_file.h:407
>  #4  lookup_all (key=0x563c679974e5 "/var/log/kadmind.log", type=<optimized out>, partial=partial@entry=false, match_count=match_count@entry=0x0, rec=<optimized out>, rec=<optimized out>)
>      at label_file.c:949
>  #5  0x00007fbde5e33350 in lookup (rec=<optimized out>, key=<optimized out>, type=<optimized out>) at label_file.c:1092
>  #6  0x00007fbde5e31878 in selabel_lookup_common (rec=0x563c67998cc0, translating=1, key=<optimized out>, type=<optimized out>) at label.c:167
>
> Signed-off-by: Jie Lu <lujie54@huawei.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/regex.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 73987d9f..149a7973 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -257,6 +257,9 @@ struct regex_data *regex_data_create(void)
>  {
>         struct regex_data *regex_data =
>                 (struct regex_data *)calloc(1, sizeof(struct regex_data));
> +       if (!regex_data)
> +               return NULL;
> +
>         __pthread_mutex_init(&regex_data->match_mutex, NULL);
>         return regex_data;
>  }
> --
> 2.27.0
>
