Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6MIrexQ006163
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 14:53:40 -0400
Received: by mail-oi0-f67.google.com with SMTP id l9so11157726oih.0
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 11:53:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468537011-20407-8-git-send-email-danielj@mellanox.com>
References: <1468537011-20407-1-git-send-email-danielj@mellanox.com>
 <1468537011-20407-8-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Jul 2016 14:53:19 -0400
Message-ID: <CAHC9VhR4kgtpuiM9G5VDYhZPoHZNLmgTbXpTfxT+bDsCgbZqCw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] selinux: Implement Infiniband PKey "Access" access
 vector
To: Dan Jurgens <danielj@mellanox.com>
Cc: chrisw@sous-sol.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, dledford@redhat.com,
 sean.hefty@intel.com, hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 14, 2016 at 6:56 PM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> Add a type and access vector for PKeys. Implement the ib_pkey_access
> hook to check that the caller has permission to access the PKey on the
> given subnet prefix. Add an interface to get the PKey SID. Walk the PKey
> ocontexts to find an entry for the given subnet prefix and pkey.
>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>
> ---
> v2:
> - Use void* blobs for security structs. Paul Moore
> - Add pkey specific data to the audit log. Paul Moore
> - Don't introduce a new initial sid, use unlabeled. Stephen Smalley
> ---
>  include/linux/lsm_audit.h           |    7 ++++++
>  security/lsm_audit.c                |   13 +++++++++++
>  security/selinux/hooks.c            |   23 +++++++++++++++++++
>  security/selinux/include/classmap.h |    2 +
>  security/selinux/include/security.h |    2 +
>  security/selinux/ss/services.c      |   41 +++++++++++++++++++++++++++++++++++
>  6 files changed, 88 insertions(+), 0 deletions(-)

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index fe3d20d..d9c4bfa 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5995,6 +5995,28 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  #endif
>
>  #ifdef CONFIG_SECURITY_INFINIBAND
> +static int selinux_ib_pkey_access(u64 subnet_prefix, u16 pkey_val, void *ib_sec)
> +{

I'm only mentioning this because it looks like there is going to be
another spin of the patches; perhaps move the ib_sec argument before
the subnet_prefix and pkey_val arguments.  This way it matches the
subject-object ordering we have in the avc_has_perm() call.

> +       struct common_audit_data ad;
> +       int err;
> +       u32 sid = 0;
> +       struct ib_security_struct *sec = ib_sec;
> +       struct lsm_pkey_audit pkey;
> +
> +       err = security_pkey_sid(subnet_prefix, pkey_val, &sid);
> +
> +       if (err)
> +               return err;
> +
> +       ad.type = LSM_AUDIT_DATA_PKEY;
> +       pkey.subnet_prefix = subnet_prefix;
> +       pkey.pkey = pkey_val;
> +       ad.u.pkey = &pkey;
> +       return avc_has_perm(sec->sid, sid,
> +                           SECCLASS_INFINIBAND_PKEY,
> +                           INFINIBAND_PKEY__ACCESS, &ad);
> +}

-- 
paul moore
www.paul-moore.com
