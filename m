Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCADC169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 21:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED13218E0
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 21:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KOBhVIsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfBFVw4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:52:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46952 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBFVw4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Feb 2019 16:52:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so6543106lfc.13
        for <selinux@vger.kernel.org>; Wed, 06 Feb 2019 13:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ER2Kib9yxX5ci6rl5T2Fi3tUghChuXPPH8IlXumcszs=;
        b=KOBhVIsTdGZfwBTg4R1rXCE3r/Msf4x4cm/0gVtKd4+gQ97hpLZ5/dGJLmRUk5hLf5
         1lwY2ebyGDfJcOpdHGKG/E8cZx9+jKnSswFuaGZKRqbFc+chgwv5dh45bUs7BNY0l/gp
         /z2JoLJkSaZqFzzi47vVwCOI4OAuAPttPEKSBhw9lVq2K63QbC1Sp91uNTO2Exteauby
         MOLcxuhCStqv+t2MBWujZsLck50Eyi77lSes+lpZjfTaku1ZX/AE82hx7OgwSQnnoxas
         zxGVj/whxTM0mQvzM3aM+2gyKc1/GU+o8dbnfuNu8DoKdanra8gVPNPMsi4Evz1m0wzt
         bjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ER2Kib9yxX5ci6rl5T2Fi3tUghChuXPPH8IlXumcszs=;
        b=n9nt2h7D/aj6EEKCIPiwVFdU0wPpNC3C7fljN/qmb1wzrUK+Z4/a7pPtZ2a1eFT87W
         L4RE+4/e2n9zi87+l+fErO3GrQ/XgCwZfwfyRRSI4S2+JLDZxcJSVIn/pRexA5sz2xU3
         r7qH53z7oZjO2Rq7rObE/9RG/+mTEAJi66FmipMb9mj1vVs67KLR3hSjGND+QtcL+7KL
         x8hSnNcrZo/iTveTtiXpV7fd5htzyxWMrzmbjNiH3ogDlAWCjzTmHV0ppT6pXEgSQd+A
         Cf3nTskmWj3zK3LZTg6cohnP+JpkzRgGmiw2abc3Pmhb2rVwNBg7SQ/s2eO0doOHUsEG
         KTBA==
X-Gm-Message-State: AHQUAuaj/2Ybl9AnMU1XxnnBqeJKUj91JDdCTgSUNeWL6PzOXExxd0Lz
        WMHnahQkJeJGuURLxLeO8mAeUqgs7HqSG0xXJ3/f
X-Google-Smtp-Source: AHgI3IZPLJ6RXtvopv92So4Mw27YgW0k/8Tc4jAULSGllfOvpbQvE/L20AEBzYL+QcHjBN7eFH+ARCw4j7FbKSEvhYY=
X-Received: by 2002:a19:a7c5:: with SMTP id q188mr8235110lfe.102.1549489973326;
 Wed, 06 Feb 2019 13:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20190202090945.4106-1-leon@kernel.org> <20190202090945.4106-5-leon@kernel.org>
In-Reply-To: <20190202090945.4106-5-leon@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Feb 2019 16:52:42 -0500
Message-ID: <CAHC9VhQ7Ltrm6J0s5HxyjXJ90W0WQt-eqEDWeHPUix07JBn-eg@mail.gmail.com>
Subject: Re: [PATCH rdma-rc v1 4/4] IB/core: Don't register each MAD agent for
 LSM notifier
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, selinux@vger.kernel.org,
        ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 2, 2019 at 4:10 AM Leon Romanovsky <leon@kernel.org> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> When creating many MAD agents in a short period of time, receive packet
> processing can be delayed long enough to cause timeouts while new agents
> are being added to the atomic notifier chain with IRQs disabled.
> Notifier chain registration and unregstration is an O(n) operation. With
> large numbers of MAD agents being created and destroyed simultaneously
> the CPUs spend too much time with interrupts disabled.
>
> Instead of each MAD agent registering for it's own LSM notification,
> maintain a list of agents internally and register once, this
> registration already existed for handling the PKeys. This list is write
> mostly, so a normal spin lock is used vs a read/write lock. All MAD agents
> must be checked, so a single list is used instead of breaking them down
> per device.
>
> Notifier calls are done under rcu_read_lock, so there isn't a risk of
> similar packet timeouts while checking the MAD agents security settings
> when notified.
>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> CC: selinux@vger.kernel.org
> CC: paul@paul-moore.com
> CC: ddutile@redhat.com
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/core_priv.h |  5 +++
>  drivers/infiniband/core/device.c    |  1 +
>  drivers/infiniband/core/security.c  | 50 ++++++++++++++++-------------
>  include/rdma/ib_mad.h               |  3 +-
>  4 files changed, 35 insertions(+), 24 deletions(-)

This looks reasonable from a SELinux perspective.  I would still be
curious to see how this would compare to calling
security_ib_endport_manage_subnet() directly in
ip_mad_enforce_security(), but at least this patch should fix the
problem you're seeing.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
> index 616734313f0c..6fd3d3d06d18 100644
> --- a/drivers/infiniband/core/core_priv.h
> +++ b/drivers/infiniband/core/core_priv.h
> @@ -199,6 +199,7 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
>                                 enum ib_qp_type qp_type);
>  void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent);
>  int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index);
> +void ib_mad_agent_security_change(void);
>  #else
>  static inline void ib_security_destroy_port_pkey_list(struct ib_device *device)
>  {
> @@ -264,6 +265,10 @@ static inline int ib_mad_enforce_security(struct ib_mad_agent_private *map,
>  {
>         return 0;
>  }
> +
> +static inline void ib_mad_agent_security_change(void)
> +{
> +}
>  #endif
>
>  struct ib_device *ib_device_get_by_index(u32 ifindex);
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 238ec42778ef..8c1d8ffb09e2 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -455,6 +455,7 @@ static int ib_security_change(struct notifier_block *nb, unsigned long event,
>                 return NOTIFY_DONE;
>
>         schedule_work(&ib_policy_change_work);
> +       ib_mad_agent_security_change();
>
>         return NOTIFY_OK;
>  }
> diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
> index 7662e9347238..a70d2ba312ed 100644
> --- a/drivers/infiniband/core/security.c
> +++ b/drivers/infiniband/core/security.c
> @@ -39,6 +39,10 @@
>  #include "core_priv.h"
>  #include "mad_priv.h"
>
> +static LIST_HEAD(mad_agent_list);
> +/* Lock to protect mad_agent_list */
> +static DEFINE_SPINLOCK(mad_agent_list_lock);
> +
>  static struct pkey_index_qp_list *get_pkey_idx_qp_list(struct ib_port_pkey *pp)
>  {
>         struct pkey_index_qp_list *pkey = NULL;
> @@ -676,19 +680,18 @@ static int ib_security_pkey_access(struct ib_device *dev,
>         return security_ib_pkey_access(sec, subnet_prefix, pkey);
>  }
>
> -static int ib_mad_agent_security_change(struct notifier_block *nb,
> -                                       unsigned long event,
> -                                       void *data)
> +void ib_mad_agent_security_change(void)
>  {
> -       struct ib_mad_agent *ag = container_of(nb, struct ib_mad_agent, lsm_nb);
> -
> -       if (event != LSM_POLICY_CHANGE)
> -               return NOTIFY_DONE;
> -
> -       ag->smp_allowed = !security_ib_endport_manage_subnet(
> -               ag->security, dev_name(&ag->device->dev), ag->port_num);
> -
> -       return NOTIFY_OK;
> +       struct ib_mad_agent *ag;
> +
> +       spin_lock(&mad_agent_list_lock);
> +       list_for_each_entry(ag,
> +                           &mad_agent_list,
> +                           mad_agent_sec_list)
> +               WRITE_ONCE(ag->smp_allowed,
> +                          !security_ib_endport_manage_subnet(ag->security,
> +                               dev_name(&ag->device->dev), ag->port_num));
> +       spin_unlock(&mad_agent_list_lock);
>  }
>
>  int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
> @@ -699,6 +702,8 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
>         if (!rdma_protocol_ib(agent->device, agent->port_num))
>                 return 0;
>
> +       INIT_LIST_HEAD(&agent->mad_agent_sec_list);
> +
>         ret = security_ib_alloc_security(&agent->security);
>         if (ret)
>                 return ret;
> @@ -706,22 +711,20 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
>         if (qp_type != IB_QPT_SMI)
>                 return 0;
>
> +       spin_lock(&mad_agent_list_lock);
>         ret = security_ib_endport_manage_subnet(agent->security,
>                                                 dev_name(&agent->device->dev),
>                                                 agent->port_num);
>         if (ret)
>                 goto free_security;
>
> -       agent->lsm_nb.notifier_call = ib_mad_agent_security_change;
> -       ret = register_lsm_notifier(&agent->lsm_nb);
> -       if (ret)
> -               goto free_security;
> -
> -       agent->smp_allowed = true;
> -       agent->lsm_nb_reg = true;
> +       WRITE_ONCE(agent->smp_allowed, true);
> +       list_add(&agent->mad_agent_sec_list, &mad_agent_list);
> +       spin_unlock(&mad_agent_list_lock);
>         return 0;
>
>  free_security:
> +       spin_unlock(&mad_agent_list_lock);
>         security_ib_free_security(agent->security);
>         return ret;
>  }
> @@ -731,8 +734,11 @@ void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
>         if (!rdma_protocol_ib(agent->device, agent->port_num))
>                 return;
>
> -       if (agent->lsm_nb_reg)
> -               unregister_lsm_notifier(&agent->lsm_nb);
> +       if (agent->qp->qp_type == IB_QPT_SMI) {
> +               spin_lock(&mad_agent_list_lock);
> +               list_del(&agent->mad_agent_sec_list);
> +               spin_unlock(&mad_agent_list_lock);
> +       }
>
>         security_ib_free_security(agent->security);
>  }
> @@ -743,7 +749,7 @@ int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)
>                 return 0;
>
>         if (map->agent.qp->qp_type == IB_QPT_SMI) {
> -               if (!map->agent.smp_allowed)
> +               if (!READ_ONCE(map->agent.smp_allowed))
>                         return -EACCES;
>                 return 0;
>         }
> diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
> index 1c0b914f199d..79ba8219e7dc 100644
> --- a/include/rdma/ib_mad.h
> +++ b/include/rdma/ib_mad.h
> @@ -617,11 +617,10 @@ struct ib_mad_agent {
>         u32                     hi_tid;
>         u32                     flags;
>         void                    *security;
> -       struct notifier_block   lsm_nb;
> +       struct list_head        mad_agent_sec_list;
>         u8                      port_num;
>         u8                      rmpp_version;
>         bool                    smp_allowed;
> -       bool                    lsm_nb_reg;
>  };
>
>  /**
> --
> 2.19.1
>


-- 
paul moore
www.paul-moore.com
