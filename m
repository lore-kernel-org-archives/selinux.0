Return-Path: <SRS0=DB+f=3U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A78C33CB2
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 04:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2878120705
	for <selinux@archiver.kernel.org>; Fri, 31 Jan 2020 04:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bbxmVwfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgAaEF2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 23:05:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35643 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgAaEF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 23:05:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id f8so6347757edv.2
        for <selinux@vger.kernel.org>; Thu, 30 Jan 2020 20:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnqJHAOX5mnyD5y524AvMTZZMSysI3Y433w3GaR3GxQ=;
        b=bbxmVwfBfPHrPnd2KdzI7pjCjQoJjMBxplFrLh/Lmmb8AxwwGY7g2Eqs+7Ir16DDwX
         KHvwM91fKtF1uPONFleVNa8DxvrL4OmHnAgTipLOp/oBhI38b/NRdTZJJoFJHdnrAQdO
         jW2W66aDwW0ndlc6c6kLvWmrqLzoW6AdRrpi2oEXiHpGu8WeodrcZl5YoazPH1PjU1kV
         7SaTO8YHbSYiYySrkeCzuHE9ZWWgHXvzW2+aUSYmKJnFvwxGsEIGxCg6YJHp0BGnC5Dt
         FF9wPiMU58UOoJSyPkympNOHtR5015olWz8x5Spb1BR608HQYibg8MY93XZPapyUMEnt
         h9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnqJHAOX5mnyD5y524AvMTZZMSysI3Y433w3GaR3GxQ=;
        b=dEMlQx+kXvZqnbHnHvIJ8kIf2c0AYs8woidhpW2X8rPzllZmRZV9srNYGGEw2OhlYz
         iBXDCxjY0yxP62donW0x4NFAr4Edk9Paa+mimFCHPNidSmoc5OcvTBCGlv0HV1e5ncao
         XbyWwXWRfYk4RcSPM2KIY9aTbGieuFUnGs9Wuk6TfEURsnQUEF8GQsnuh6MeaFVbhadI
         TlCjdDg66kWQI55ZrjjSsb7wz8kqPbmbbEqJ4eBmN9oKXtXKzpOlb1cUcY0FsTcHsV93
         aWCYR8Os9hu0BQCJJ3b9NcWIhQojMCSxVFXd8gF36nwD2Ae4i7sa+/E5kfWCCUf1a8EP
         4R6A==
X-Gm-Message-State: APjAAAWXtm1yJEbl2nSdIjhKKoYkCzFzOM5GH3yatUB9sS/WzQm3bYG7
        ISQy7zj3xFb+J2ctt8ehbdqZ1jf+FsL+CFycrqwR
X-Google-Smtp-Source: APXvYqzffDxlM7keIIsvKeGA+aZqNRfe6Wzu1S9YL+hsp3tNSoYEzlJKghN0hbTeFjXsZgRyrgU8t2q5xic0wpV9iyg=
X-Received: by 2002:aa7:cd49:: with SMTP id v9mr6775935edw.269.1580443524135;
 Thu, 30 Jan 2020 20:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20200117085836.445797-1-omosnace@redhat.com> <20200117085836.445797-3-omosnace@redhat.com>
In-Reply-To: <20200117085836.445797-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 23:05:13 -0500
Message-ID: <CAHC9VhSNBR1kJHrn4Z-eu4NTj09Y6Vrwu3h7MU+UHac3+g_jCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] selinux: convert cond_list to array
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 3:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Since it is fixed-size after allocation and we know the size beforehand,
> using a plain old array is simpler and more efficient.
>
> While there, also fix signedness of some related variables/parameters.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/include/conditional.h |  6 +--
>  security/selinux/selinuxfs.c           |  4 +-
>  security/selinux/ss/conditional.c      | 54 ++++++++++----------------
>  security/selinux/ss/conditional.h      |  3 +-
>  security/selinux/ss/policydb.c         |  2 +-
>  security/selinux/ss/policydb.h         |  3 +-
>  security/selinux/ss/services.c         | 28 ++++++-------
>  7 files changed, 43 insertions(+), 57 deletions(-)
>
> diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
> index 0ab316f61da0..ffb9a33341f8 100644
> --- a/security/selinux/include/conditional.h
> +++ b/security/selinux/include/conditional.h
> @@ -14,12 +14,12 @@
>  #include "security.h"
>
>  int security_get_bools(struct selinux_state *state,
> -                      int *len, char ***names, int **values);
> +                      u32 *len, char ***names, int **values);
>
>  int security_set_bools(struct selinux_state *state,
> -                      int len, int *values);
> +                      u32 len, int *values);

In the future, if you're making changes like this, you might as well
put it all on one line (it fits under 80 chars).

>  int security_get_bool_value(struct selinux_state *state,
> -                           int index);
> +                           u32 index);

Same here.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 04593062008d..c8a02c9b23ee 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -119,6 +119,7 @@ int cond_policydb_init(struct policydb *p)
>
>         p->bool_val_to_struct = NULL;
>         p->cond_list = NULL;
> +       p->cond_list_len = 0;
>
>         rc = avtab_init(&p->te_cond_avtab);
>         if (rc)
> @@ -147,27 +148,22 @@ static void cond_node_destroy(struct cond_node *node)
>         }
>         cond_av_list_destroy(node->true_list);
>         cond_av_list_destroy(node->false_list);
> -       kfree(node);
>  }
>
> -static void cond_list_destroy(struct cond_node *list)
> +static void cond_list_destroy(struct policydb *p)
>  {
> -       struct cond_node *next, *cur;
> +       u32 i;
>
> -       if (list == NULL)
> -               return;
> -
> -       for (cur = list; cur; cur = next) {
> -               next = cur->next;
> -               cond_node_destroy(cur);
> -       }
> +       for (i = 0; i < p->cond_list_len; i++)
> +               cond_node_destroy(&p->cond_list[i]);
> +       kfree(p->cond_list);
>  }
>
>  void cond_policydb_destroy(struct policydb *p)
>  {
>         kfree(p->bool_val_to_struct);
>         avtab_destroy(&p->te_cond_avtab);
> -       cond_list_destroy(p->cond_list);
> +       cond_list_destroy(p);
>  }
>
>  int cond_init_bool_indexes(struct policydb *p)
> @@ -447,7 +443,6 @@ err:
>
>  int cond_read_list(struct policydb *p, void *fp)
>  {
> -       struct cond_node *node, *last = NULL;
>         __le32 buf[1];
>         u32 i, len;
>         int rc;
> @@ -458,29 +453,24 @@ int cond_read_list(struct policydb *p, void *fp)
>
>         len = le32_to_cpu(buf[0]);
>
> +       p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
> +       if (!p->cond_list)
> +               return rc;
> +
>         rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
>         if (rc)
>                 goto err;
>
>         for (i = 0; i < len; i++) {
> -               rc = -ENOMEM;
> -               node = kzalloc(sizeof(*node), GFP_KERNEL);
> -               if (!node)
> -                       goto err;
> -
> -               rc = cond_read_node(p, node, fp);
> +               rc = cond_read_node(p, &p->cond_list[i], fp);
>                 if (rc)
>                         goto err;
> -
> -               if (i == 0)
> -                       p->cond_list = node;
> -               else
> -                       last->next = node;
> -               last = node;
>         }
> +
> +       p->cond_list_len = len;

Hmmm.  Since we don't update p->cond_list_len until here, if we fail
in the for-loop above and end up jumping to "err" we might not cleanup
all the nodes, right?

>         return 0;
>  err:
> -       cond_list_destroy(p->cond_list);
> +       cond_list_destroy(p);
>         p->cond_list = NULL;
>         return rc;
>  }

-- 
paul moore
www.paul-moore.com
