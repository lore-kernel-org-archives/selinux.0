Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535FCC00523
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 05:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF822072B
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 05:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="s6QT5AwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgAHF5y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:57:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33007 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAHF5y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 00:57:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so1534300lfl.0
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 21:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C45gyS45MVzebfUI6IdSbUfGIX5t3jw6CeCl26grZu4=;
        b=s6QT5AwPlApCEVnqS/Ua8N5qeiPanoPN3X0yAm0wCBA3z7XweTwhZ8CoCr/vDVoSNO
         5nUiWnUsVGH9WCwIwPqjjg9jC5qMJWMeuWTWj6RMkGCOhIbrZkLS8/Fr/38hTiFC+H7d
         cpY5UdaLCYSJLI5V9cvieaa+606NRFmduN0MtrQySmRhBP99WSoq7kDF3VSFuGePCXq1
         Ih27MCuaZtnbVlTFm82KBKSow81ziNrYzTS6UykF8HWzxUj43HOD3n0EHpN6mkyjQPhP
         d2xd2+OQhWs2nzKizNPzxnnr6q1YdF+cvSpFB57e27wGlB8QtQtg76NgZJFdqi9iI4+r
         FZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C45gyS45MVzebfUI6IdSbUfGIX5t3jw6CeCl26grZu4=;
        b=huV8CELG7C6/QPnkmuCi15ou5UXXcZv/qzYe3ORV2JIysmhvUrxOd4SmRt4T9UZZdu
         oPPlSIg8xLwLaVdXCOQU87L2og+7tceTjuQnZjww+o7XVEh9N5YrYwIhergVFgJSBdTt
         1PDx0lFbFfGix3jrl9pQKECJi2insgZF09KhRmk44Hc63ZB7EMhOHRGLZb1ZwlfYRqsS
         8gdpBJTZAvsuTosXyyiuNuzgSyHlxo3Rcdm+CPupL+WRujx47m+iSm0R5UXSgAqDd8x4
         nJ6PbSh/TfD+w/2kNLBoXHgG8r4+vST9KBCc7K+wYGOyugA1Ed06VLI7wDykQ5UoLIkm
         d2ZA==
X-Gm-Message-State: APjAAAUr1Yyx2kbHWw7ZGWDPdnxA4+mr6er+DDgwb5eAW8DQVPqtyxA7
        uN0hFOuVIw6xtzXt34bZ+/8e340J7Yrzvq+n8YnQ
X-Google-Smtp-Source: APXvYqz3cu/5W2wWZuxa7iPkv2xQejaglg3cBaoJvP4EDKFHfyHL+4wiXBtJsY4K1u1PaCFKilhyp9PWRcVa10FBClk=
X-Received: by 2002:a19:f514:: with SMTP id j20mr1669166lfb.31.1578463071504;
 Tue, 07 Jan 2020 21:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20200107202322.27380-1-sds@tycho.nsa.gov>
In-Reply-To: <20200107202322.27380-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jan 2020 00:57:40 -0500
Message-ID: <CAHC9VhRH9aPY8ehdA4JseYSMxSCh3zORcM=EnH-srA4qrvQhiw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: deprecate setting checkreqprot to 1
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 7, 2020 at 3:22 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Deprecate setting the SELinux checkreqprot tunable to 1 via kernel
> parameter or /sys/fs/selinux/checkreqprot.  Setting it to 0 is left
> intact for compatibility since Android and some Linux distributions
> do so for security and treat an inability to set it as a fatal error.
> Eventually setting it to 0 will become a no-op and the kernel will
> stop using checkreqprot's value internally altogether.
>
> checkreqprot was originally introduced as a compatibility mechanism
> for legacy userspace and the READ_IMPLIES_EXEC personality flag.
> However, if set to 1, it weakens security by allowing mappings to be
> made executable without authorization by policy.  The default value
> for the SECURITY_SELINUX_CHECKREQPROT_VALUE config option was changed
> from 1 to 0 in commit 2a35d196c160e3 ("selinux: change
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default") and both Android
> and Linux distributions began explicitly setting
> /sys/fs/selinux/checkreqprot to 0 some time ago.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> RFC-only, not yet tested.
>
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  security/selinux/Kconfig                        | 3 +++
>  security/selinux/hooks.c                        | 4 ++++
>  security/selinux/selinuxfs.c                    | 6 ++++++
>  4 files changed, 14 insertions(+)

No objection so long as the testing goes okay, although I don't think
we will see any surprises.

However, as you pointed out earlier, we should probably add an entry
to Documentation/ABI/obsolete; while the "checkreqprot" selinuxfs node
isn't going away, we are restricting it in a way which was previously
allowed.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index eed51293d6cf..c894ddfa1393 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -512,6 +512,7 @@
>                         Default value is set via a kernel config option.
>                         Value can be changed at runtime via
>                                 /sys/fs/selinux/checkreqprot.
> +                       Setting checkreqprot to 1 is deprecated.
>
>         cio_ignore=     [S390]
>                         See Documentation/s390/common_io.rst for details.
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 1014cb0ee956..9e921fc72538 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -88,6 +88,9 @@ config SECURITY_SELINUX_CHECKREQPROT_VALUE
>           'checkreqprot=' boot parameter.  It may also be changed at runtime
>           via /sys/fs/selinux/checkreqprot if authorized by policy.
>
> +         WARNING: this option is deprecated and will be removed in a future
> +         kernel release.
> +
>           If you are unsure how to answer this question, answer 0.
>
>  config SECURITY_SELINUX_SIDTAB_HASH_BITS
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 63a6e36abe9f..11d47bb7d40a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7149,7 +7149,11 @@ static __init int selinux_init(void)
>
>         memset(&selinux_state, 0, sizeof(selinux_state));
>         enforcing_set(&selinux_state, selinux_enforcing_boot);
> +
>         selinux_state.checkreqprot = selinux_checkreqprot_boot;
> +       if (selinux_state.checkreqprot)
> +               pr_warn("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated.\n");
> +
>         selinux_ss_init(&selinux_state.ss);
>         selinux_avc_init(&selinux_state.avc);
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 79c710911a3c..c6c136eee371 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -668,6 +668,12 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>         if (sscanf(page, "%u", &new_value) != 1)
>                 goto out;
>
> +       if (new_value) {
> +               char comm[sizeof(current->comm)];
> +               memcpy(comm, current->comm, sizeof(comm));
> +               pr_warn_once("SELinux: %s (%d) set checkreqprot to 1.  This is deprecated.\n", comm, current->pid);
> +       }
> +
>         fsi->state->checkreqprot = new_value ? 1 : 0;
>         length = count;
>  out:
> --
> 2.24.1

-- 
paul moore
www.paul-moore.com
