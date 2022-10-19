Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E9AC4332F
	for <selinux@archiver.kernel.org>; Wed, 19 Oct 2022 19:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJSTHL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJSTHK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Oct 2022 15:07:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06401ACABF
        for <selinux@vger.kernel.org>; Wed, 19 Oct 2022 12:07:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y8so18085716pfp.13
        for <selinux@vger.kernel.org>; Wed, 19 Oct 2022 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5LL0sXIWvCZpKzPERvgYQUO0WAdQSoxklzjsnSRDEP0=;
        b=mviw0ADPLhx/ykdF37DunOmOBNiJWKH5oAt75UV4qHVZwxxn+m07DVOd30/ni4HzNI
         srq7njJDFKoI1lsPW6PlSV918Dd6ode7hiiPGDpQ7K3Q2fXXFC/ndoR+ytprBIbHYNEZ
         wMEyfwqlwYVWiqwcidW9Uukmy2isCSen/8np579vpWZpxRoPMSGn7DlkkGujuaHZTnjZ
         HI7RwM8qmMmN9wV05URv7AqgqSOrMh/hYS0OOrQnNjtsb8Vj9eDAQ8hPEasgAWIVQFy0
         p4wfnLjvofkBGWXzkzZSF2Pq3wcdE8sJrrhZ2jjYAVanQ+KCG3fQlcM0aTLF6IrC9AUR
         OmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LL0sXIWvCZpKzPERvgYQUO0WAdQSoxklzjsnSRDEP0=;
        b=Iaf6RXx3QSA86qhf09ZhWVM5h1Q/TI9StmgrM2M7CQyvelKLjTKft3Ue34VMvAa1wr
         c5/8+DQwu+J7yJEZ/+Rt/w31T/0zAscjgMhrlqIM/g3Cx9hvrj7zDtFMSAz+DLRgTKXU
         ZmVMqckjU6OHQBa/CuxJ3bHuJqi00Yyvi3b7hjdFPobkXZf6pPH8zt0AJ+sV8ykTCLiv
         J9B2KnLdtKdFMerHaFuMJebrc4jn23cFOqKzY/5W5JVilmJm9wcu58jxXNtS+7vzIk/y
         /p858frbVu69u4qNJkdtNwkufRkfHmc/YJ5/f2wbS2Q2X6Y3pDKm3SMku4jsiQyJ/pgP
         32SA==
X-Gm-Message-State: ACrzQf0i9GKT05Gu/SzHL5cByDB3xZuwVNLy0IyINHwtZARnbPTUU2Pp
        CmCUeSOzi+2sgmWvQrZnQvbkUJIrMmH3Mq74fC6Oa9mS
X-Google-Smtp-Source: AMsMyM7sGwlGL7gLY1Hlp56asnQxQezRTxIPWVydamp5Zt/hWgDUjaLJX0SIvvvI41XRyBjkw+oxm02xUiuCOsMOjmA=
X-Received: by 2002:a63:f924:0:b0:46b:1a7d:3b91 with SMTP id
 h36-20020a63f924000000b0046b1a7d3b91mr8581799pgi.133.1666206429317; Wed, 19
 Oct 2022 12:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220914220337.165813-1-vmojzis@redhat.com>
In-Reply-To: <20220914220337.165813-1-vmojzis@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 19 Oct 2022 15:06:58 -0400
Message-ID: <CAP+JOzSmdtMH=3kHowRpvXwYVhELXvnyz2y6arD6Amh3ziSRtA@mail.gmail.com>
Subject: Re: [PATCH] python: Hide error message when modifying non-local fcontext
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 14, 2022 at 6:08 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Fixes:
>   # semanage fcontext -f f -m -t passwd_file_t /etc/security/opasswd
>   libsemanage.dbase_llist_query: could not query record value (No such file or directory).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/semanage/seobject.py | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 0782c082..2d52f53c 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -177,6 +177,22 @@ except (OSError, ImportError):
>              for l in self.log_list:
>                  syslog.syslog(syslog.LOG_INFO, message + l)
>
> +# Define a context manager to suppress stderr.
> +class suppress_stderr(object):
> +    def __init__(self):
> +        # Open a /dev/null file to be used as stderr
> +        self.null =  os.open(os.devnull,os.O_RDWR)
> +        self.save_fd = os.dup(2)
> +
> +    def __enter__(self):
> +        # Set stderr to the null file
> +        os.dup2(self.null,2)
> +
> +    def __exit__(self, *_):
> +        # Restore stderr
> +        os.dup2(self.save_fd,2)
> +        os.close(self.null)
> +
>
>  class nulllogger:
>
> @@ -2510,7 +2526,8 @@ class fcontextRecords(semanageRecords):
>                  raise ValueError(_("File context for %s is not defined") % target)
>
>          try:
> -            (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
> +            with suppress_stderr():
> +                (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
>          except OSError:
>              try:
>                  (rc, fcontext) = semanage_fcontext_query(self.sh, k)
> --
> 2.35.3
>

I think it is better to rework semanage/seobject.py so that there is
no error. I sent a patch to the list that should fix this.
Thanks for the report. Sorry that it took so long to get to.
Jim
