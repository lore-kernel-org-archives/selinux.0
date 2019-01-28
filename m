Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E6C282CF
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 16:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF8620811
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 16:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ct0Q3Z8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbfA1QhX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:37:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42587 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390072AbfA1QhW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 11:37:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so14818615lja.9
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 08:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2pvqLhuzfYIpv8wYdIaX+DXl3ocn/v2ZxERcVuLs/eA=;
        b=Ct0Q3Z8aV4A4xJbqdYcHkXgVRMglwKlqP7iW9WS7jnTM6bfn+a5hB9IWrYTog//xdP
         FONgJjaB8IDRHuC1HXFGNsR1IZeHzKm0bu83eHU5tL4oansJ1LVKrj2zniFL1Mqr3lXe
         riMnybyIORvUQ1+vlAkbOuMTxoKMA0fDZFFe/OIg7Y8e3dRxyYdqO51EzXSPDLKHWYVD
         SCq61tzBAHq+YDhzmjniNkUBM1s3AzMTD93IPspQga4nTfOd4twzhVk1SfQWdHQ4qHDt
         HjErGcLOA2wIv5ybo8F5BCmoM+09Kil1xFvkBP/90zRkvhWdgvSxXvHj02ic8PBVDCb7
         kVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pvqLhuzfYIpv8wYdIaX+DXl3ocn/v2ZxERcVuLs/eA=;
        b=MxRP/Ps+azf8BHYsJGcn49P9xQYkjfK3m4nF4XSaaF5AOYUxqvgE95cPglJJsrfIMn
         rK7jBNaK6318vuPMpBIvKItbEr1tpeK5eH+5zQFCqY6ScHS0nimFalORIsgJD+G6RXvP
         +x1zzNA4YdzzEJ5kT2GmWx6B+IN8S1ySLMWRrPiwEhTpoMxpXoikOiVSfc40qDxbsjFd
         jICvZCb9GcIH5z+hCT+IWd+I7QZj4EvUBg6KfPz/cfT9hKOr4D3jfFasUacBX61MY7TL
         GkkuSKzfFuRlZcJiuWUPRqJSsmD/glVgMHuRpT/KR4nAQuRoPBog23/ca9COD7xsDAVn
         kgXA==
X-Gm-Message-State: AJcUukdFYDp4UFe707fH7niQ9/NGYF9SPrnQOkAkuUwvnW89Z8GWf5kp
        pCta/ezpVIXF3fw0ysq986mXw22Qzq7ScFvZ9jct
X-Google-Smtp-Source: ALg8bN5UVyQvvQ+X0JMAf2+QTEAoU2gW5KuZgQcVoVN3SUocIY+Htx7YjLdOU+xaAuNLDHmOs2oxmL83nusS0ItIBtk=
X-Received: by 2002:a2e:4299:: with SMTP id h25-v6mr18087979ljf.5.1548693439394;
 Mon, 28 Jan 2019 08:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org>
In-Reply-To: <20190127081023.21124-1-leon@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 11:37:08 -0500
Message-ID: <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM notifications
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        selinux@vger.kernel.org, ddutile@redhat.com,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 27, 2019 at 3:10 AM Leon Romanovsky <leon@kernel.org> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> When creating many MAD agents in a short period of time receive packet
> processing can be delayed long enough to cause timeouts while new agents
> are being added to the atomic notifier chain with IRQs disabled.
> Notifier chain registration and unregstration is an O(n) operation. With
> large numbers of MAD agents being created and destroyed simultaneously
> the CPUs spend too much time with interrupts disabled.
>
> After this change previously granted access for MAD agents will not be
> revoked if there is a relevant security policy change. This behavior is
> already the case for most things controlled by a security policy.
>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/security.c | 34 ++++--------------------------
>  include/rdma/ib_mad.h              |  3 ---
>  2 files changed, 4 insertions(+), 33 deletions(-)

Perhaps predictably, I'm not very excited about this change.  Have you
looked closer into the slowdown to see where the cycles are being
spent?  I'm wondering if the issue is that a large number of notifiers
are being registered with the same priority causing the while loop in
notifier_chain_register() to take a significant amount of time.

> diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
> index 1efadbccf394..73598acb518a 100644
> --- a/drivers/infiniband/core/security.c
> +++ b/drivers/infiniband/core/security.c
> @@ -676,21 +676,6 @@ static int ib_security_pkey_access(struct ib_device *dev,
>         return security_ib_pkey_access(sec, subnet_prefix, pkey);
>  }
>
> -static int ib_mad_agent_security_change(struct notifier_block *nb,
> -                                       unsigned long event,
> -                                       void *data)
> -{
> -       struct ib_mad_agent *ag = container_of(nb, struct ib_mad_agent, lsm_nb);
> -
> -       if (event != LSM_POLICY_CHANGE)
> -               return NOTIFY_DONE;
> -
> -       ag->smp_allowed = !security_ib_endport_manage_subnet(
> -               ag->security, dev_name(&ag->device->dev), ag->port_num);
> -
> -       return NOTIFY_OK;
> -}
> -
>  int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
>                                 enum ib_qp_type qp_type)
>  {
> @@ -710,16 +695,9 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
>                                                 dev_name(&agent->device->dev),
>                                                 agent->port_num);
>         if (ret)
> -               return ret;
> +               security_ib_free_security(agent->security);
>
> -       agent->lsm_nb.notifier_call = ib_mad_agent_security_change;
> -       ret = register_lsm_notifier(&agent->lsm_nb);
> -       if (ret)
> -               return ret;
> -
> -       agent->smp_allowed = true;
> -       agent->lsm_nb_reg = true;
> -       return 0;
> +       return ret;
>  }
>
>  void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
> @@ -728,8 +706,6 @@ void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
>                 return;
>
>         security_ib_free_security(agent->security);
> -       if (agent->lsm_nb_reg)
> -               unregister_lsm_notifier(&agent->lsm_nb);
>  }
>
>  int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)
> @@ -737,11 +713,9 @@ int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)
>         if (!rdma_protocol_ib(map->agent.device, map->agent.port_num))
>                 return 0;
>
> -       if (map->agent.qp->qp_type == IB_QPT_SMI) {
> -               if (!map->agent.smp_allowed)
> -                       return -EACCES;
> +       /* SMI agent enforcement is done during agent creation */
> +       if (map->agent.qp->qp_type == IB_QPT_SMI)
>                 return 0;
> -       }
>
>         return ib_security_pkey_access(map->agent.device,
>                                        map->agent.port_num,
> diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
> index fdef558e3a2d..12543e09c3ed 100644
> --- a/include/rdma/ib_mad.h
> +++ b/include/rdma/ib_mad.h
> @@ -619,9 +619,6 @@ struct ib_mad_agent {
>         u8                      port_num;
>         u8                      rmpp_version;
>         void                    *security;
> -       bool                    smp_allowed;
> -       bool                    lsm_nb_reg;
> -       struct notifier_block   lsm_nb;
>  };
>
>  /**
> --
> 2.19.1

-- 
paul moore
www.paul-moore.com
