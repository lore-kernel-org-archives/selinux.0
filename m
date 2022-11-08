Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69800C4332F
	for <selinux@archiver.kernel.org>; Tue,  8 Nov 2022 16:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiKHQyU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Nov 2022 11:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiKHQyT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Nov 2022 11:54:19 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FC11145
        for <selinux@vger.kernel.org>; Tue,  8 Nov 2022 08:54:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b9so22008125ljr.5
        for <selinux@vger.kernel.org>; Tue, 08 Nov 2022 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zMbnSO113QTxSGmFbYdeH2Gb9WPgBsB6b2OUJQTY00M=;
        b=a4zJou/e8QFE9VeWoBMLCyCkLa131pXd+h6F+kedSiO/JDFqWtLk5lZFWNiMIWQ9fq
         aF71eswsEGld6unUrNKpO81xg0rg0ljYiq49BApffZheafkSSveWSgUIrZuAervNn+Zt
         //Y9bsNwXn5F5oAQcy9nNfNjqT0U7MMK254xXReD0HQ20b2WF/kF+LVrSsLXtHs4gOHY
         ZkNCjw4D9bND/L9mA+4z7/uPCHuJaHms10/UUqyLPdAuN4x8CPxT3ywKafFevrQUZyo8
         Qznnyu6beqKFSvID/pNEu3CVSDMp1nG5/774QUCQJmXCjwBSL7rx9soyvfLY1o41107b
         AZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMbnSO113QTxSGmFbYdeH2Gb9WPgBsB6b2OUJQTY00M=;
        b=iz8zLSuR0+m22eUexLSWcAmqIGvjMEZPB0LxJHSTdyysYPPHmzqSfSLGKGgZM7lTSH
         zJ44touaWHzSyDnVPqXVvloc3ptdbMxy33mOGZRRD0XKgajcSlGb/02vXTkhbWw7J1F6
         NJgcLMstprtCq55XZMIGVfF6xKWkrC1nM9HkDPAt/f+q4lSFCs9V8kwHILgtUZir0Aid
         r5pSmDNYCFv7KzidhUqP+KCMJkGvN9L366bfsBOr0x7tS9Io/EO6nVL4S/vHl3l5Uzj4
         izP5Dszl4ehXFc47fS4OK/6QML0eeq2VNFXVsbZy/USxmL8ce8o5fki5eSannLFq+6qQ
         R+rQ==
X-Gm-Message-State: ACrzQf178KDBa8h2OPYI0su8EvMK4ZX0VZZh1wkhd+mYB2fOxuk9WcHA
        odu574uVu3D3keHcaqFLwB9Xh2NF+l0Ct9b/ni9QZPj9ZLIRYQ==
X-Google-Smtp-Source: AMsMyM5LZRCJH2qaDD4HRJrND/loMXJRbQmW9CUqwiR3/CQ+tzPE0z4792WcwHfB6Xs5HpYsGinetWaM/5Znx/uPEDU=
X-Received: by 2002:a2e:904b:0:b0:277:a9d:9355 with SMTP id
 n11-20020a2e904b000000b002770a9d9355mr6541874ljg.102.1667926456918; Tue, 08
 Nov 2022 08:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20221108101854.1136685-1-plautrba@redhat.com>
In-Reply-To: <20221108101854.1136685-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 8 Nov 2022 11:54:05 -0500
Message-ID: <CAP+JOzTenjFNOAPd-bWppmpoPCq79Hfov523hrVxp6tvvzxwjg@mail.gmail.com>
Subject: Re: [PATCH] python: Fix typo in audit2allow.1 example
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 8, 2022 at 5:20 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  python/audit2allow/audit2allow.1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/audit2allow/audit2allow.1 b/python/audit2allow/audit2allow.1
> index c61067b33688..f1a4b8ea33b3 100644
> --- a/python/audit2allow/audit2allow.1
> +++ b/python/audit2allow/audit2allow.1
> @@ -151,7 +151,7 @@ policy_module(local, 1.0)
>  gen_require(`
>          type myapp_t;
>          type etc_t;
> - };
> +');

Should be:
+\[aq]);

Otherwise, the line does not show up.
You can't use \' because that is translated into a closing single quote.

Thanks,
Jim

>
>  files_read_etc_files(myapp_t)
>  <review local.te and customize as desired>
> --
> 2.37.3
>
