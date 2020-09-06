Return-Path: <SRS0=stgd=CP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C67C43461
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 03:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665B220760
	for <selinux@archiver.kernel.org>; Sun,  6 Sep 2020 03:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ykReTnxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgIFDLh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Sep 2020 23:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgIFDLf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Sep 2020 23:11:35 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15AFC061574
        for <selinux@vger.kernel.org>; Sat,  5 Sep 2020 20:11:34 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i22so13473773eja.5
        for <selinux@vger.kernel.org>; Sat, 05 Sep 2020 20:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SybKxt5r4DpvJrcMyqAvCQLDougVZq4LzKHHKUMsChQ=;
        b=ykReTnxBXkJsWZZN0PHYU3YOHbOnWIm0kjaI7+WAIAr1lrM94tp+tB0exoUy676xU2
         YKwk5Ae/lyF0lu+6+en61/Mo/0wuZNyVsiq7X0EeD0JAHQmEdKIX3ZlIHKzXlwQ8ijE/
         e5uPvT2aOUt3ZdzDDvK+/Si4RmFcxDiSi34Pyrrt+zBBphdUqsNWnJD778wLYFbQPYsQ
         u0w5gkBYuhNlKlps6SlKT4ejErFd0NbDjLZipVA+6AsQds4qmOgrvH+JeKcw0Ttkgdxi
         kJMyHfxnbuKoK/PKSoCM3IbCTRJ9ddqBnzLNWAsvyAyNw9UNdOidjbGAEk4IZilIU/j4
         jiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SybKxt5r4DpvJrcMyqAvCQLDougVZq4LzKHHKUMsChQ=;
        b=Ik4+D9ToXDYRsjUpr5kFIIeEpPmNa5h4ULxTRSMcpCrdLhr09fTZ7BHAkB48wSzcpS
         CtysmJ49gHsS0nwT5QbeHNYmekek8woySVydNsKXtjkZZlKXy1XOCeU7loePxDWI2GPQ
         TdK1H6jdOATRm49pkPQGqCsDbIkoDtV3a6M1ljQJj2kBzL+zlqLcKhxOz5GMjukvroSH
         AFjlWLRlUjgU56o+3Gtly/4YACl1TCtdqFhmMevNJEMYQPYWaY5NGC6eAlJAD8/ltLcr
         VofcL5T7MpYOqTGhDhNN25acPxfgQf7yv3Ik9qWdqQBz6sJCCgzdu0nBqy/LCF5eka3C
         QjEw==
X-Gm-Message-State: AOAM532KQNsVggzjZH9ji+o3K+IgkmwLNj3ZPpKPIXdKh9C1xdR5/l1k
        59eRk9IBLU147dfTd3qqPMBrivUWG/3mHQmI6MGH
X-Google-Smtp-Source: ABdhPJz5gSoHhhwkKtx1ywEnb64j++4ZT6agTN648mykHqeVYLGtzaHe4GRGCTjL1A1eMy+wXx/j7tG+2Bw+w4rGAXU=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr13979834ejz.431.1599361892319;
 Sat, 05 Sep 2020 20:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-18-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-18-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 23:11:21 -0400
Message-ID: <CAHC9VhQEvw2jKekJeC+-eXVNii4gTS7vxqDHqWVgQL2vFCJqXA@mail.gmail.com>
Subject: Re: [PATCH v20 17/23] LSM: security_secid_to_secctx in netlink netfilter
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 11:20 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Change netlink netfilter interfaces to use lsmcontext
> pointers, and remove scaffolding.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org
> ---
>  net/netfilter/nfnetlink_queue.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)

...

> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
> index d3f8e808c5d3..c830401f7792 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
> @@ -401,8 +399,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>         enum ip_conntrack_info ctinfo;
>         struct nfnl_ct_hook *nfnl_ct;
>         bool csum_verify;
> -       struct lsmcontext scaff; /* scaffolding */
> -       char *secdata = NULL;
> +       struct lsmcontext context = { };
>         u32 seclen = 0;
>
>         size = nlmsg_total_size(sizeof(struct nfgenmsg))
> @@ -469,7 +466,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
>         }
>
>         if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
> -               seclen = nfqnl_get_sk_secctx(entskb, &secdata);
> +               seclen = nfqnl_get_sk_secctx(entskb, &context);
>                 if (seclen)
>                         size += nla_total_size(seclen);
>         }

I think we can get rid of the local "seclen" variable, right?  We can
embed the nfqnl_get_sk_secctx() in the conditional and then simply
reference "context.len" everywhere else, yes?  For example:

  if (nfqnl_get_sk_secctx(..., &context))
    size += nla_total_size(context.len);

-- 
paul moore
www.paul-moore.com
