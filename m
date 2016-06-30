Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5UKS1FD029231
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 16:28:01 -0400
Received: by mail-oi0-f49.google.com with SMTP id u201so82293414oie.0
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 13:27:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466711578-64398-2-git-send-email-danielj@mellanox.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-2-git-send-email-danielj@mellanox.com>
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 30 Jun 2016 16:27:58 -0400
Message-ID: <CAGH-KgtVpX-y+r+pA0_0Hg-Yqx6YWpuc6ud-rk_pHQCtOEFGag@mail.gmail.com>
Subject: Re: [PATCH 01/12] security: Add LSM hooks for Infiniband security
To: Dan Jurgens <danielj@mellanox.com>
Cc: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jun 23, 2016 at 3:52 PM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> Add nine new hooks
>  1. Allocate security contexts for Infiniband QPs.
>  2. Free security contexts for Infiniband QPs.
>  3. Allocate security contexts for Infiniband MAD agents.
>  4. Free security contexts for Infiniband MAD agents.
>  5. Enforce QP access to Pkeys
>  6. Enforce MAD agent access to Pkeys
>  7. Enforce MAD agent access to Infiniband End Ports for sending Subnet
>     Management Packets (SMP)
>  8. A hook to register a callback to receive notifications of
>     security policy or enforcement changes.  Restricting a QPs access to
>     a pkey will be done during setup and not on a per packet basis
>     access must be enforced again.
>  9. A hook to unregister the callback.
>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Eli Cohen <eli@mellanox.com>
> ---
>  include/linux/lsm_hooks.h | 71 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/security.h  | 63 +++++++++++++++++++++++++++++++++++
>  include/rdma/ib_verbs.h   |  4 +++
>  security/Kconfig          |  9 +++++
>  security/security.c       | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 230 insertions(+)

I'd recommend putting the IB hook calls into this patch as well, it
helps make the hooks a bit more concrete as you can see where, and how
they are called.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7ae3976..6b47c8d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2001 Silicon Graphics, Inc. (Trust Technology Group)
>   * Copyright (C) 2015 Intel Corporation.
>   * Copyright (C) 2015 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) 2016 Mellanox Techonologies
>   *
>   *     This program is free software; you can redistribute it and/or modify
>   *     it under the terms of the GNU General Public License as published by
> @@ -876,6 +877,50 @@
>   *     associated with the TUN device's security structure.
>   *     @security pointer to the TUN devices's security structure.
>   *
> + * Security hooks for Infiniband
> + *
> + * @ib_qp_pkey_access:
> + *     Check permission to access a pkey when modifing a QP.
> + *     @subnet_prefix the subnet prefix of the port being used.
> + *     @pkey the pkey to be accessed.
> + *     @qp_sec pointer to the ib_qp_security structure.
> + * @ib_mad_agent_pkey_access:
> + *     Check permission to access a pkey when transmiting and receiving MADS.
> + *     @subnet_prefix the subnet prefix of the port being used.
> + *     @pkey the pkey to be accessed.
> + *     @mad_agent pointer to the ib_mad_agent structure.
> + * @ib_end_port_smp:
> + *     Check permissions to send and receive SMPs on a end port.
> + *     @dev_name the IB device name (i.e. mlx4_0).
> + *     @port_num the port number.
> + *     @mad_agent pointer to the ib_mad_agent structure.
> + * @ib_qp_alloc_security:
> + *     Allocate and attach a security structure to the qp_sec->q_security
> + *     field. The q_security field is initialized to NULL when the structure
> + *     is allocated.  A separate QP security structure is used instead of the
> + *     QP structure because when a QP is destroyed the memory is freed by the
> + *     hardware driver.  That operation can fail so the security info must be
> + *     maintained until the destroy completes successfully.
> + *     @qp_sec contains the ib_qp_security structure to be modified.
> + *     Return 0 if operation was successful.
> + * @ib_mad_agent_alloc_security:
> + *     Allocate and attach a security structure to the mad_agent->m_security
> + *     field. The m_security field is initialized to NULL when the structure
> + *     is allocated.
> + *     @mad_agent contains the ib_mad_agent structure to be modified.
> + *     Return 0 if operation was successful.
> + * @ib_qp_free_security:
> + *     Deallocate and clear the qp_sec->q_security field.
> + *     @qp_sec contains the ib_qp_security structure to be modified.
> + * @ib_mad_agent_free_security:
> + *     Deallocate and clear the mad_agent->m_security field.
> + *     @mad_agent contains the ib_mad_agent structure to be modified.
> + * @register_ib_flush_callback:
> + *     Provide a way for security modules to notify ib_core of policy changes.
> + *     @callback function pointer to call when policy changes.
> + * @unregister_ib_flush_callback:
> + *     Unregister the callback function.
> + *
>   * Security hooks for XFRM operations.
>   *
>   * @xfrm_policy_alloc_security:

-- 
paul moore
security @ redhat
