Return-Path: <SRS0=kVhJ=4Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ABEC10F25
	for <selinux@archiver.kernel.org>; Sat,  7 Mar 2020 00:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1D7206D7
	for <selinux@archiver.kernel.org>; Sat,  7 Mar 2020 00:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="YpSU++Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCGA7A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:59:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37782 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCGA7A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 19:59:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id m9so4622823edl.4
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 16:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEFrFhJuKXtQHO3sBOgxaymoHeACglon9STK5/+BVuQ=;
        b=YpSU++Kuy+Qse2DeLnYgqkgISnBR+bvNxyO9ahSuKUr+wpMabJoWHKNfuuJrKnTW15
         qo+wGSPlEwlxVMsLX3Mj1G1TBzs8hNsGJ2ypL6A/8nFKI1t3t7JGSfzwFHvvFgwhovuD
         t8W4l7cHuEhfR1bFIynh8oJuPXf2TpEC8finrMXSDl8GLpVol5n+rPlITyUokQjStsLi
         S6SwWYeu1n1CLpKg3UoksgyMmIdSDK46EkLRQt0LM7NTQ+l5s2xz+wprWqZ8ADp0Zjea
         6RMrYAn2IAsyxuTG1KsfGOF3x4JPTAwevNZ4Udmo1h3SxH7Zte9gedw0+89CnCz8yawM
         qrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEFrFhJuKXtQHO3sBOgxaymoHeACglon9STK5/+BVuQ=;
        b=ZAofXCOQa9oJtZYclQBrRMp7SEJOIN8X0IghBL0162lAgG3u/FQ01ZNCbG+L6VzGU1
         hiXRhmIvAMO8cwGkni1RU+uRNHXU7paL2owu5J9pTEBwgkiBT3lqUZMViu+fh8VQUv/6
         AHVyepG5o6jcTw1gt7r2ge0d+fQeu9ebI6j2Bif99iKQjI9a4/iNpR6VhEh5lWho3iwE
         eeRJzP70rTDFYCbncQhQ25QZxr2CU+RmoLzmkBVTiUGrnFwMFU2Ou/pHpw67xOtKoPQc
         Qx+RrMrNcPxfqCwpBCy66PLKStRvmkBJJlmDBT3+Pga8mJWHwjP12kOl8+r7U7czLpjn
         Ltqw==
X-Gm-Message-State: ANhLgQ2FzqCyu5SC8wLSSJkcG5z57EeEpdfE8ZVV9oy8MTubMnpDt6To
        agmkYx0iCyLQ3WJDwCuvfaEL8zB13U8A3TMfUSmm
X-Google-Smtp-Source: ADFU+vtNNPQBI+/KSMvcaYZI0nbbeXLvsPeA4NN3qat5M1I2B+zkXj9PG7N1iTbkRtajMAUgXn+g+G0znZrFwCCCJLQ=
X-Received: by 2002:a05:6402:309b:: with SMTP id de27mr6070742edb.269.1583542736667;
 Fri, 06 Mar 2020 16:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20200214234203.7086-1-casey@schaufler-ca.com> <20200214234203.7086-7-casey@schaufler-ca.com>
In-Reply-To: <20200214234203.7086-7-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 19:58:45 -0500
Message-ID: <CAHC9VhQyXEhU+2+Js+7B2AuebnD2ZQDT+5bHU-gO4FshvcFzGQ@mail.gmail.com>
Subject: Re: [PATCH v15 06/23] Use lsmblob in security_secctx_to_secid
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 6:43 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change security_secctx_to_secid() to fill in a lsmblob instead
> of a u32 secid. Multiple LSMs may be able to interpret the
> string, and this allows for setting whichever secid is
> appropriate. In some cases there is scaffolding where other
> interfaces have yet to be converted.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h          |  5 +++--
>  kernel/cred.c                     |  4 +---
>  net/netfilter/nft_meta.c          | 12 +++++++-----
>  net/netfilter/xt_SECMARK.c        |  5 ++++-
>  net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
>  security/security.c               | 18 +++++++++++++++---
>  6 files changed, 38 insertions(+), 20 deletions(-)

...

> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index 951b6e87ed5d..e12125b85035 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -811,21 +811,23 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
>
>  static int nft_secmark_compute_secid(struct nft_secmark *priv)
>  {
> -       u32 tmp_secid = 0;
> +       struct lsmblob blob;
>         int err;
>
> -       err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
> +       err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
>         if (err)
>                 return err;
>
> -       if (!tmp_secid)
> +       if (!lsmblob_is_set(&blob))
>                 return -ENOENT;
>
> -       err = security_secmark_relabel_packet(tmp_secid);
> +       /* Using le[0] is scaffolding */
> +       err = security_secmark_relabel_packet(blob.secid[0]);
>         if (err)
>                 return err;

At the very least it looks like the comment above needs an update.
However, I would really like to see an explanation in this patch,
either in the comments or in the commit description, about how you
plan to handle secmarks.  If your plan is to always have it be the
first LSM, let's admit that and document it appropriately.  If there
is something much grander coming later in the patchset I guess
"scaffolding" is an okay term, but it would be good to mention in the
commit description that this will be replaced with something better
later in the patchset.

I'm worried about the case five years from know when we are changing
this code, either due to bugs or new features, and we stumble across
this commit.  Was it always intended to be this way?  Or was this
temporary?  Right now I don't know.

> -       priv->secid = tmp_secid;
> +       /* Using le[0] is scaffolding */
> +       priv->secid = blob.secid[0];
>         return 0;
>  }

...

> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index d2e4ab8d1cb1..7a5a87f15736 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -881,7 +881,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>         void *addr;
>         void *mask;
>         u32 addr_len;
> -       u32 secid;
> +       struct lsmblob blob;
>         struct netlbl_audit audit_info;
>
>         /* Don't allow users to add both IPv4 and IPv6 addresses for a
> @@ -905,12 +905,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>         ret_val = security_secctx_to_secid(
>                                   nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
>                                   nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
> -                                 &secid);
> +                                 &blob);
>         if (ret_val != 0)
>                 return ret_val;
>
> +       /* scaffolding with the [0] */
>         return netlbl_unlhsh_add(&init_net,
> -                                dev_name, addr, mask, addr_len, secid,
> +                                dev_name, addr, mask, addr_len, blob.secid[0],
>                                  &audit_info);
>  }

Same as above, although this time with the peer label.

-- 
paul moore
www.paul-moore.com
