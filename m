Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB5C433F5
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 17:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbhKWRqK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbhKWRqI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 12:46:08 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15ACC061748
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 09:42:59 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bk14so46077172oib.7
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 09:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nw48SjbdffiU8mpDVVnKhBAqSFx0BcpJQktBrzkKpg=;
        b=ZKFtchjPD6gRMl5ADF7kldNTTaLvS7HYUdKynrR3xpoTPQ5Q6W3j5MKaZK9K0L+d/4
         4d95WBqgqlb41BYsK/4MfdznFlgJblqjq6uQ5s93XAAoiM5CMO3B0U0AEJ6zLe2NDXVp
         HTVcl0QHbf5yo65ziDvIrr+t93nbYEa/vo2+ZaERBuwOpgryrPspQguiMYhVgp/Fojqn
         jKUJSrgLLvB0vYJEbNYciRjtJ7vuPAhuG3S/EKgFxVOLXuCZ3RvILngQnImtFgl9iCO6
         BMlkkacnHeyqZdrLi5QYLzd2ew2B7BC6nNpGgeX+eERow4wPo7i8yeGV323ccH+NOyUh
         GBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nw48SjbdffiU8mpDVVnKhBAqSFx0BcpJQktBrzkKpg=;
        b=KvQ76LK/Dw3xPIRNmjA3LTW57LMOOIcBRLIf8/KIZqEIqPzsbrKSjtX0nHko88ZoXd
         aNjOCehil4B4Ixt44PJ0e0ltF5+m0hihLxXQmkxMYaPL51g0G665ny2OU0PRTuV/MBlU
         cgi8BMb9UhDuyFS84I1iYozhoEDcMjV0JQADJUmhJYSrwVZAMEdXaOV74H++Syxj2le6
         fUV3ixFPUDrgkIArCQU53XBowaaWXZA7Kqe9ZMHvYoaB4giCr8NjrzK35D8AJJPfhxoF
         fJ27U+dSwfMsbvXlhHj8+xmc6y1dtRgJmWzS7wRUsBczVDnbNG8Vo9ZXPeviMdl2yIxV
         GxGw==
X-Gm-Message-State: AOAM533+rfrnIBU97xDa6pjTLYVqu+/1zpxyfN9ON+5XgSwxCWJAEAyy
        PKMo8HGkfsWXPEscuYRe19CJ2n3n6e7NJLKwHTQ=
X-Google-Smtp-Source: ABdhPJzYsrMda5eGD1chgCv27yJt9fRK7rmTSU9Yo5z0+PRWenqZi1aw/giarQHVWkWL3Ye3xGBap0ArwaPRbEkBjeo=
X-Received: by 2002:a05:6808:179d:: with SMTP id bg29mr4115434oib.138.1637689379249;
 Tue, 23 Nov 2021 09:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20211123163851.438425-1-plautrba@redhat.com>
In-Reply-To: <20211123163851.438425-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 23 Nov 2021 12:42:48 -0500
Message-ID: <CAP+JOzRQSH4Eoox3Vnh8L6WKwxHabqj1KFAEQexy3P+e3xuYaQ@mail.gmail.com>
Subject: Re: [PATCH] semodule: Don't forget to munmap() data
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 23, 2021 at 11:41 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> semanage_module_extract() mmap()'s the module raw data but it leaves on
> the caller to munmap() them.
>
> Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/semodule/semodule.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index 57f005ce2c62..94a9d131bb79 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -394,6 +394,9 @@ static char *hash_module_data(const char *module_name, const int prio) {
>         sha256_buf[i * 2] = 0;
>
>  cleanup_extract:
> +       if (data_len > 0) {
> +               munmap(data, data_len);
> +       }
>         semanage_module_info_destroy(sh, extract_info);
>         free(extract_info);
>         semanage_module_key_destroy(sh, modkey);
> --
> 2.33.1
>
