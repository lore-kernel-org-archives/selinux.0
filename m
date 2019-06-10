Return-Path: <SRS0=W683=UJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C289C282DD
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 10:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1EB20859
	for <selinux@archiver.kernel.org>; Mon, 10 Jun 2019 10:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbfFJKUY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:20:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32953 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfFJKUX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jun 2019 06:20:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id p4so4564459oti.0
        for <selinux@vger.kernel.org>; Mon, 10 Jun 2019 03:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgSu+RcyF05gzutIFikMSZWvKrevwvmXF1eWvD0Yj/Q=;
        b=UQNJ/u3f0avwXG7pQWOs+acdkpuiSwibdwaldkemvgdEDZIHjdfcuUh19zWPcxEP1I
         oCQtatt4SbTaLDDktU+Ynvhr5KQ7Qo7pK9exwuApLtM4MJtQSOe4fBAKbfLq7Dik87u/
         4ts1DLM5Ox/I3V2kqCPxUoMLWYg7S7TzcPM9Mqvm5sHL+ODj7u9fiFkFIklrFbE0teak
         eh4H7PRXsoOQ6e2Tq9/1sXARFo40/Ynq8I5mjovUFdRctYW9e4dxbkhmZZwqVgMGevjD
         3QrFLxW9HeKkhXd9hHA4onpoyFV3F49IYYknWotz+fDIXSmkG3EwZ9FcEZ/67KbrdZp7
         0Miw==
X-Gm-Message-State: APjAAAVdF6QdJvzDRY9OEhbU58YJqNWq3Nw3ZGU4/LWvdpx7IArqY9cX
        GOSdSOdmAq135aX3AJ0MXtM5dPeI6eGSfL8Ikav+4A==
X-Google-Smtp-Source: APXvYqw9jyUJEnRpyEgpHRmm9Z8RwZ9lkQLvqAltCXZQs9FqKAY5Xd+YP1REENwwbcGHbOehU+5bfLdTmNCYxLQUW0M=
X-Received: by 2002:a9d:6c54:: with SMTP id g20mr7405767otq.66.1560162023325;
 Mon, 10 Jun 2019 03:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190602165101.25079-1-casey@schaufler-ca.com> <20190602165101.25079-36-casey@schaufler-ca.com>
In-Reply-To: <20190602165101.25079-36-casey@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 10 Jun 2019 12:20:12 +0200
Message-ID: <CAFqZXNuDLKSnnJcH+G09CfypqQ2MtKJbU3Rt+kZc9-KmpK17uA@mail.gmail.com>
Subject: Re: [PATCH 35/58] LSM: Limit calls to certain module hooks
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Casey,

On Sun, Jun 2, 2019 at 6:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> LSM hooks dealing with security context strings should
> only be called for one security module. Add call macros
> that invoke a single module hook and us in for those cases.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 69983ad68233..365970f2501d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -698,6 +698,16 @@ int lsm_superblock_alloc(struct super_block *sb)
>                         P->hook.FUNC(__VA_ARGS__);              \
>         } while (0)
>
> +#define call_one_void_hook(FUNC, ...)                          \
> +       do {                                                    \
> +               struct security_hook_list *P;                   \
> +                                                               \
> +               hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> +                       P->hook.FUNC(__VA_ARGS__);              \
> +                       break;                                  \
> +               }                                               \
> +       } while (0)
> +
>  #define call_int_hook(FUNC, IRC, ...) ({                       \
>         int RC = IRC;                                           \
>         do {                                                    \
> @@ -712,6 +722,19 @@ int lsm_superblock_alloc(struct super_block *sb)
>         RC;                                                     \
>  })
>
> +#define call_one_int_hook(FUNC, IRC, ...) ({                   \
> +       int RC = IRC;                                           \
> +       do {                                                    \
> +               struct security_hook_list *P;                   \
> +                                                               \
> +               hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> +                       RC = P->hook.FUNC(__VA_ARGS__);         \
> +                       break;                                  \
> +               }                                               \
> +       } while (0);                                            \
> +       RC;                                                     \
> +})
> +
>  /* Security operations */
>
>  int security_binder_set_context_mgr(struct task_struct *mgr)
> @@ -1951,7 +1974,8 @@ EXPORT_SYMBOL(security_ismaclabel);
>
>  int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
>  {
> -       return call_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata, seclen);
> +       return call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata,
> +                                seclen);
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>
> @@ -1959,13 +1983,13 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>                              struct lsm_export *l)
>  {
>         lsm_export_init(l);
> -       return call_int_hook(secctx_to_secid, 0, secdata, seclen, l);
> +       return call_one_int_hook(secctx_to_secid, 0, secdata, seclen, l);
>  }
>  EXPORT_SYMBOL(security_secctx_to_secid);
>
>  void security_release_secctx(char *secdata, u32 seclen)
>  {
> -       call_void_hook(release_secctx, secdata, seclen);
> +       call_one_void_hook(release_secctx, secdata, seclen);
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>
> @@ -2090,7 +2114,7 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>                                       int __user *optlen, unsigned len)
>  {
> -       return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> +       return call_one_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>                                 optval, optlen, len);
>  }
>
> --
> 2.19.1
>

Shouldn't dentry_init_security() use call_one_int_hook() as well? It
also returns a context string.

Thanks,
-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
