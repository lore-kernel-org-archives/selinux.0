Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC06C433F5
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 19:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343685AbiC3TFN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350494AbiC3TFM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 15:05:12 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBBCBD9
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:03:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b188so22976155oia.13
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odkcWfFtMJdZmGK8e++UWB1kNTaIfDgT/aiTxQR9FcE=;
        b=MHm3FvW54WgWsnp9IAyUSaMRuHCARgzLm65sfj7231DOq8p+BV4t+o8x6TZJo+5epi
         2kIgvOIda1hEZcTt8uA3OAh/Nl0h53SjoM8GW0bc/UpF+3pOC71Zhw62TvCS6w70/gtN
         VbjHhVQVoBNcGPwuhhyx8HEIy9pBo+7PhHxa2aScXwx/Bd42Pgs7hbMps57JDcrobHJu
         5pRJXz9nMuGB4JOQUO+3ntGcoAop9Him7wbMN7wyuN3kQK5C+vt60SUiM9gkkaKWb2zY
         W08ItOWcnmhEb+1qtfof2CWQiQ36P97DjCfewuozRxYOkyxLz7idAFZ6A8rjuTFI8iWY
         6b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odkcWfFtMJdZmGK8e++UWB1kNTaIfDgT/aiTxQR9FcE=;
        b=BfX3mv4NWldzRT64T7LoN47T9aEEyd6WmRRZBd2ppNDAM1mO7ZRvuyaGHsMKvnBKTv
         RTjOM0tyumggft6k66SSQHCfQHYbMAIPIEZ506bFJ7sQZMJcAb9trzjODiGQoAsbvz+q
         Jt2fnur9GTYqYi7hQ32VABNbyLrqTZxhzqf+xi/6ZAF2VFI1FfMJ4nAMlr/ccgF1DdYz
         PRms2+DDrM/v8m2CtIMBR/5W5+neJwZasiaqouju618Gckq97E8YEhU2RCVSnCxffOT9
         86FeoIovXRsoVRnMR1Yl1TtaVFyjxXIgCr8a8qAlELyCWUuGKPp928KoQ7kOKs0ZbbD6
         Up3Q==
X-Gm-Message-State: AOAM532tQrVOaQeP9cyq/nd7pRDteghlvKvfbtuTCp58vB3CGmjVvPqD
        9WuQM9SHkQzDzdWaN/wKIvEZfNUX6Qka++7mFWZpQ1H6
X-Google-Smtp-Source: ABdhPJxocjyY8+V6MRpurJe0ybM7Q6AZ0DLcui861kA+XNuX0BPtUyH1bHFYAKtes4MjegA4HHSVah6kUzeSY/pJx94=
X-Received: by 2002:a05:6808:ecb:b0:2f7:41cc:21b9 with SMTP id
 q11-20020a0568080ecb00b002f741cc21b9mr697364oiv.156.1648667004722; Wed, 30
 Mar 2022 12:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220309231721.742464-1-jwcart2@gmail.com>
In-Reply-To: <20220309231721.742464-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 15:03:13 -0400
Message-ID: <CAP+JOzSDBiUDtqdHqH8PLdknAkLjH8zr3-upwA0jMqiwR3=6VA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Write a message when a log message is truncated
To:     SElinux list <selinux@vger.kernel.org>
Cc:     bauen1 <j2468h@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 9, 2022 at 6:17 PM James Carter <jwcart2@gmail.com> wrote:
>
> The MAX_LOG_SIZE is 512. It is possible that a log message could
> exceed the max size (such as for neverallowx rules). If so, then
> write out "<LOG MESSAGE TRUNCATED>", so that it is obvious that
> the log message has been truncated.
>
> Reported-by: Jonathan Hettwer <j2468h@googlemail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Merged.
Jim

> ---
>  libsepol/cil/src/cil_log.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
> index a296929b..e78c0aeb 100644
> --- a/libsepol/cil/src/cil_log.c
> +++ b/libsepol/cil/src/cil_log.c
> @@ -53,8 +53,13 @@ __attribute__ ((format (printf, 2, 0))) void cil_vlog(enum cil_log_level lvl, co
>  {
>         if (cil_log_level >= lvl) {
>                 char buff[MAX_LOG_SIZE];
> -               vsnprintf(buff, MAX_LOG_SIZE, msg, args);
> -               (*cil_log_handler)(cil_log_level, buff);
> +               int n = vsnprintf(buff, MAX_LOG_SIZE, msg, args);
> +               if (n > 0) {
> +                       (*cil_log_handler)(cil_log_level, buff);
> +                       if (n >= MAX_LOG_SIZE) {
> +                               (*cil_log_handler)(cil_log_level, " <LOG MESSAGE TRUNCATED>");
> +                       }
> +               }
>         }
>  }
>
> --
> 2.34.1
>
