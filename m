Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFEC433EF
	for <selinux@archiver.kernel.org>; Tue,  1 Mar 2022 17:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiCARf0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiCARf0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Mar 2022 12:35:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA9C2BB1F
        for <selinux@vger.kernel.org>; Tue,  1 Mar 2022 09:34:44 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hw13so32890911ejc.9
        for <selinux@vger.kernel.org>; Tue, 01 Mar 2022 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fA+wU5kLcLMBqXhRMKV9dKF5kxH3TH0A/1zIZlyz7uk=;
        b=EXUBHrbJqw7GJBIBA3QnFbgZDrqXDZ8XgvgEzKY5f2OtEEmWBf6/iPV90dhIvtceRz
         qihXKA/o/oVDP6B4U6c1eA9iZwtBk6hceIoJO+rP4X29nuXsXv0I/+tg6+3b0Ra/s7Cj
         BjN/+HP/M8ncA4QhefB1zQ8TJQrJXBZ11tSEPAEiCQ/7bUQKnPSOB+8/tQoebmyles7j
         8jP2KY2AlysEF+NFobsd1Ur6aF42jOQ5NEHVraGq0C0N/X/Lu+vjCpcdqlPlGoT67850
         7/uWDXU9HCqIJbb0nEIUNlSXgzg+Vobgoi+1byJgDdOfNLsp4ejHwdelLveHLrduBM2M
         1jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fA+wU5kLcLMBqXhRMKV9dKF5kxH3TH0A/1zIZlyz7uk=;
        b=M79gkPqPGqhMjyiCejFcNSD2OnuyjBxHg0umz0/HapR2fy8mqkrE6JxiggWiCFzIbn
         2yH5HNF53O4oBQjF8GkqXkhlSoy9InQ1WSarfduXmhWKS0UD393NlmU4UW1FQ+TmF/+B
         V/z1AkrQxrXT+bcWlTOpEabPoEmZpR8I9j6isVMnTB10LRzPphxZYsK8VaPHiZ213NyH
         Mrok5zItmDdU2UwzjydenQLY4huxL5mmhqQsGxwXZgU3o96MgxvdXAnU0B5NV2mcitq6
         5VapdkRXIfm9z6aAvs/VrtM0NAUkuRaTQYk4BWndhnKeQs6yM1oZfbuKG5RxjY4/6vOq
         A7YA==
X-Gm-Message-State: AOAM533qEgbaKAF6LSRG8KPkxcTgVLv5hgMauCtKhh2K1dl2l2VGTQC1
        0VD08QW6r5j+Av+amTvz3YX3lcW9XVJBOd5QbXuFoXN01Q==
X-Google-Smtp-Source: ABdhPJwutbuZwi+5PT0zxNKnuVU5n0uuvL6xb27c/saMNUuMiCO4AOODGSaeqiQQTwVvkYLfmE8FeDmAEg08n2fY/xc=
X-Received: by 2002:a17:906:6b8f:b0:6cd:7984:26fc with SMTP id
 l15-20020a1709066b8f00b006cd798426fcmr19568418ejr.701.1646156082677; Tue, 01
 Mar 2022 09:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20220301041454.18960-1-rdunlap@infradead.org>
In-Reply-To: <20220301041454.18960-1-rdunlap@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Mar 2022 12:34:31 -0500
Message-ID: <CAHC9VhSuzpuEm437SCYC8pf0mU6qdWXRU38sb2+JjVtj-8T4Kw@mail.gmail.com>
Subject: Re: [PATCH] docs: selinux: add '=' signs to kernel boot options
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, patches@lists.linux.dev,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 28, 2022 at 11:14 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Provide the full kernel boot option string (with ending '=' sign).
> They won't work without that and that is how other boot options are
> listed.
>
> If used without an '=' sign (as listed here), they cause an "Unknown
> parameters" message and are added to init's argument strings,
> polluting them.
>
>   Unknown kernel command line parameters "enforcing checkreqprot
>     BOOT_IMAGE=/boot/bzImage-517rc6", will be passed to user space.
>
>  Run /sbin/init as init process
>    with arguments:
>      /sbin/init
>      enforcing
>      checkreqprot
>    with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc6
>
> Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: selinux@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Randy.

Acked-by: Paul Moore <paul@paul-moore.com>

> --- linux-next-20220228.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20220228/Documentation/admin-guide/kernel-parameters.txt
> @@ -550,7 +550,7 @@
>                         nosocket -- Disable socket memory accounting.
>                         nokmem -- Disable kernel memory accounting.
>
> -       checkreqprot    [SELINUX] Set initial checkreqprot flag value.
> +       checkreqprot=   [SELINUX] Set initial checkreqprot flag value.
>                         Format: { "0" | "1" }
>                         See security/selinux/Kconfig help text.
>                         0 -- check protection applied by kernel (includes
> @@ -1409,7 +1409,7 @@
>                         (in particular on some ATI chipsets).
>                         The kernel tries to set a reasonable default.
>
> -       enforcing       [SELINUX] Set initial enforcing status.
> +       enforcing=      [SELINUX] Set initial enforcing status.
>                         Format: {"0" | "1"}
>                         See security/selinux/Kconfig help text.
>                         0 -- permissive (log only, no denials).

-- 
paul-moore.com
