Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D7C04AA5
	for <selinux@archiver.kernel.org>; Thu, 25 Aug 2022 13:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiHYNZO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240846AbiHYNZN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Aug 2022 09:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918BB77EAB
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661433911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ctu2l/QKA5VmFMbQ2MFXkQQcXPdvWsMZw+rSek2EGwU=;
        b=W2gILRAjbo+UTpKsoAgozQD0QcS6eCu5hbv5cqAJTMJcdfftpSGuZzf85PCp1y4BAm8v5U
        +B/P/qm/4wTEmUt4ceCkGAfWSV5e7H9I6p9R5l2J6jg2kPU6yHFv6eabGgEV9G1ylVW/l9
        ldme0wlZrOdT1xEh8naEWngVOR7n1LE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-610-YCppSwy_Pdq8_HPtQROnaA-1; Thu, 25 Aug 2022 09:25:10 -0400
X-MC-Unique: YCppSwy_Pdq8_HPtQROnaA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-334d894afd8so343860157b3.19
        for <selinux@vger.kernel.org>; Thu, 25 Aug 2022 06:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ctu2l/QKA5VmFMbQ2MFXkQQcXPdvWsMZw+rSek2EGwU=;
        b=njiimNNkalywKwIjLlbj3toOGvlVpggEraajP1npdh+epXN/zmWoqVUBYCSmu0y8sx
         PxS6ukC2wGgZkofcHrjBBl6UbREpkn7BqWQQHXQmgKMtCfRHtE6vR3R997vkQF9RWX74
         9pGYi7mb/Lc0HmHa/Rsgt9JaEwf9ZIiAAoUpiMmMJgT5zdk8S6rnam/MfLTq4bcIiJfE
         Ms3Vzh0JVYn4QHw6gIelP/R/g66DJdx/9kxEuz8Tm3lvsRxMbN0YecsItlxTXIxBe/oC
         QnQAs7ZTAg8o5xcP5v7DDswUyBtQKeRfovJg/Dg0T7hpbbdBYKr9hYMfNLEFerZOXwR+
         Glxw==
X-Gm-Message-State: ACgBeo1fUcyHAKF16nMdj7UQFjOYZ1D4yh50nyOaj213/UQbs8DgmlX4
        L8NdXnL04aoi7yiFeXw0lV0M2Eoy+yrLoWL2FNenxfU+zDI0XYrSOZBIUb7PmQHOPjkEyNstyQz
        u4+LR21ysSaRec2395R2YPTDEB30QP1y+CQ==
X-Received: by 2002:a25:37cf:0:b0:695:998c:505f with SMTP id e198-20020a2537cf000000b00695998c505fmr3485594yba.196.1661433909496;
        Thu, 25 Aug 2022 06:25:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7+oCw86t7pK2k5uC2K+2G+6tzIOxn3DQcfuV42y87RGj23JPV7ROJlLc0lEBYSuU514Uw1GNAjuuRmHia4g14=
X-Received: by 2002:a25:37cf:0:b0:695:998c:505f with SMTP id
 e198-20020a2537cf000000b00695998c505fmr3485579yba.196.1661433909315; Thu, 25
 Aug 2022 06:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <166061510477.614432.940552725841920786.stgit@olly>
In-Reply-To: <166061510477.614432.940552725841920786.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 25 Aug 2022 15:24:58 +0200
Message-ID: <CAFqZXNsHyi_ga68=jFXh=qb4SQR9HOwCUNgHcascMn_ycOTtWw@mail.gmail.com>
Subject: Re: [selinux-testsuite PATCH] tests/binder: remove stray flag files
 with 'make clean'
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 16, 2022 at 8:50 AM Paul Moore <paul@paul-moore.com> wrote:
>
> Failed or incomplete test runs can leave temporary test files in
> the binder test directory, remove them with 'make clean'.
>
>   mkfifo: cannot create fifo \
>     'binder/manager_flag': File exists
>   mkfifo: cannot create fifo \
>     'binder/service_provider_flag': File exists
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/binder/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/binder/Makefile b/tests/binder/Makefile
> index e78ad16..b89d4db 100644
> --- a/tests/binder/Makefile
> +++ b/tests/binder/Makefile
> @@ -18,6 +18,6 @@ endif
>  all: $(TARGETS)
>
>  clean:
> -       rm -f $(TARGETS)
> +       rm -f $(TARGETS) manager_flag service_provider_flag
>
>  $(TARGETS): $(DEPS)

Thanks, though it would be good to do the same cleanup also in other
tests. I extended your patch to almost all other dirs in [1] - is it
OK if I apply that version?

Note that I didn't bother with the cleanup in filesystem/fs_filesystem
tests, since the tmp dir(s) there may have mounts on them and that's
harder to clean up reliably.

[1] https://github.com/WOnder93/selinux-testsuite/commit/0d5c0af63544a606d42bf9bcb905fc7753994c6d

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

