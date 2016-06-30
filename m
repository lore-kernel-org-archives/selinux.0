Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5UKY2TH030092
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 16:34:11 -0400
Received: by mail-oi0-f49.google.com with SMTP id u201so82521307oie.0
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 13:33:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466711578-64398-2-git-send-email-danielj@mellanox.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-2-git-send-email-danielj@mellanox.com>
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 30 Jun 2016 16:33:56 -0400
Message-ID: <CAGH-KgtcpKPciy-1-KhQDw2xA5-35t_W9TKCf3z9tj=Vg_hjsg@mail.gmail.com>
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

...

> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 432bed5..3f6780b 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1428,6 +1428,10 @@ struct ib_srq {
>         } ext;
>  };
>
> +struct ib_qp_security {
> +       void *q_security;
> +};

Sorry, I missed this earlier and didn't realize it until I was going
through 4/12 ... why both with ib_qp_security?  Why not just use a
straight void pointer?

-- 
paul moore
security @ redhat
