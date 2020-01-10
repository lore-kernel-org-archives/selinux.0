Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D549DC282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4290206ED
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 17:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="q83Yjf7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgAJRXW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:23:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42081 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgAJRXW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 12:23:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id y4so2906826ljj.9
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 09:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YsBlr7HjURehTQeGD+KFC7v365TVVv+t/1gnDGxnmA=;
        b=q83Yjf7n+RJyPaIAjn0ubyojFzgjHOKEUTYFqN7Hkwck41RvOf2KYBL2/mC8xZQXGt
         SjEzM/p7Zl5Oh5DRFfCpHsksR6eyBV8s/KM5+B1+LddD0ZLVa3WT2fiznWpkznFJnN66
         rZa1hS1umABDfRET5xHB37fUGPeTfM6ML7yhcxgsLVl6bbzc6pQbZEaFQZFMLh7lgTnS
         uCESZcJ8wqGK1cLMD62UeSHh808Gp6lBKLC3nM90fw7idpr1OOMdmi1HvsB+MrqgJMtU
         zPdtODI4h1xAEz3VbBOWitMXEe+Wj/vcYvRfGAFRg023Czmse02fNcVw6Rdz5mm5rzDG
         zISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YsBlr7HjURehTQeGD+KFC7v365TVVv+t/1gnDGxnmA=;
        b=Ptj+BS8nnCLRghm0N2+BZi0KcywPupd4wWx9XXg8jWWefodCi2afRt0bDyMXd3k1Wi
         QBJaR7k8KvUJIy1B6/6tG4wI33Crn2yuufDGyWtlA/vFaUlzN3yyzuTtVCkglCtsa7Oh
         RXhvA2+cZPj7WiJZXwG+EjbPvq7+Es4WoA1mcdN9tEKxVylZu5TigmQVjmQ417GYujDb
         to6VLjUhJyGW3mXzb2gzwcBm67QkJApHeg/jMxblr20T4hGhUhp/0rdzgIq9nDMRDYPT
         pLdvwXO0aD27Cpk1XV1DUCpMiz5Z+i0jeGChJMjpnOpeduZE81CHuP30zGsvpTBemaSs
         HrXQ==
X-Gm-Message-State: APjAAAX+uZ68MXDFQIHeFHjfHk+fsnpHklGtdZSr/qtSrjQfThqHrL9k
        FgiO7i1CRq3vX1hhP0i/dAdagFxIHKwK7ClciuQ17pI=
X-Google-Smtp-Source: APXvYqzMvS1iVIKd9WguelFMB0TVBAWbcrVBLfu8kGFOyXVpvaOm/QCDPRXPVVCOAMIXpjoly90lgKQ5onVXvExCEyw=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3344427lji.93.1578676999726;
 Fri, 10 Jan 2020 09:23:19 -0800 (PST)
MIME-Version: 1.0
References: <1578568247-29760-1-git-send-email-rsiddoji@codeaurora.org>
In-Reply-To: <1578568247-29760-1-git-send-email-rsiddoji@codeaurora.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 12:23:08 -0500
Message-ID: <CAHC9VhT9Rsbaio6SP9NvX-Xp-eDPWhw9soYo6oBHkd1txk=VMQ@mail.gmail.com>
Subject: Re: [PATCH v4] selinux: move ibpkeys code under CONFIG_SECURITY_INFINIBAND.
To:     Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 9, 2020 at 6:11 AM Ravi Kumar Siddojigari
<rsiddoji@codeaurora.org> wrote:
>
> Move cache based  pkey sid  retrieval code which was added
> with  Commit "409dcf31" under CONFIG_SECURITY_INFINIBAND.
> As its  going to alloc a new cache which impacts
> low ram devices which was enabled by default.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
> ---
>  security/selinux/Makefile         |  4 +++-
>  security/selinux/include/ibpkey.h | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)

I just merged this into selinux/next but I had to fix a few style
errors that were found by scripts/checkpatch.pl (whitespace, function
braces); please remember to run checkpatch.pl on all your patch
submissions.

-Paul

> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index ccf950409384..2000f95fb197 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -6,7 +6,7 @@
>  obj-$(CONFIG_SECURITY_SELINUX) := selinux.o
>
>  selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
> -            netnode.o netport.o ibpkey.o \
> +            netnode.o netport.o \
>              ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
>              ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/status.o
>
> @@ -14,6 +14,8 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
>
>  selinux-$(CONFIG_NETLABEL) += netlabel.o
>
> +selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
> +
>  ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
>
>  $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
> diff --git a/security/selinux/include/ibpkey.h b/security/selinux/include/ibpkey.h
> index a2ebe397bcb7..e3c08287fd9a 100644
> --- a/security/selinux/include/ibpkey.h
> +++ b/security/selinux/include/ibpkey.h
> @@ -14,8 +14,20 @@
>  #ifndef _SELINUX_IB_PKEY_H
>  #define _SELINUX_IB_PKEY_H
>
> +#ifdef CONFIG_SECURITY_INFINIBAND
>  void sel_ib_pkey_flush(void);
>
>  int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid);
>
> +#else
> +static inline void sel_ib_pkey_flush(void) {
> +  return;
> +}
> +
> +static inline int sel_ib_pkey_sid(u64 subnet_prefix, u16 pkey, u32 *sid) {
> +  *sid = SECINITSID_UNLABELED;
> +  return 0;
> +}
> +#endif
> +
>  #endif
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project



-- 
paul moore
www.paul-moore.com
