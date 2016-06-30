Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5UKHPRL027999
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 16:17:25 -0400
Received: by mail-oi0-f46.google.com with SMTP id f189so81956885oig.3
 for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2016 13:17:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466711578-64398-3-git-send-email-danielj@mellanox.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-3-git-send-email-danielj@mellanox.com>
From: Paul Moore <pmoore@redhat.com>
Date: Thu, 30 Jun 2016 16:17:22 -0400
Message-ID: <CAGH-KgsOE7Ryjy7a6z8Q0o=0yae2FrUc3Qso-1geygULh18Msw@mail.gmail.com>
Subject: Re: [PATCH 02/12] selinux: Create policydb version for Infiniband
 support
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
> Support for Infiniband requires the addition of two new object contexts,
> one for infiniband PKeys and another IB End Ports.  Added handlers to read
> and write the new ocontext types when reading or writing a binary policy
> representation.
>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Eli Cohen <eli@mellanox.com>
> ---
>  security/selinux/include/security.h |   3 +-
>  security/selinux/ss/policydb.c      | 129 +++++++++++++++++++++++++++++++-----
>  security/selinux/ss/policydb.h      |  27 +++++---
>  3 files changed, 135 insertions(+), 24 deletions(-)

...

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 992a315..78b819c 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2219,6 +2229,58 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>                                         goto out;
>                                 break;
>                         }
> +                       case OCON_PKEY: {
> +                               rc = next_entry(nodebuf, fp, sizeof(u32) * 6);
> +                               if (rc)
> +                                       goto out;
> +
> +                               c->u.pkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
> +                               /* The subnet prefix is stored as an IPv6
> +                                * address in the policy.
> +                                *
> +                                * Check that the lower 2 DWORDS are 0.
> +                                */

Any particular reason why you reusing an IPv6 address format here?
Why not use a u64 for the prefix and u16/u32 fields for the partition
keys?

> +                               if (nodebuf[2] || nodebuf[3]) {
> +                                       rc = -EINVAL;
> +                                       goto out;
> +                               }
> +
> +                               if (nodebuf[4] > 0xffff ||
> +                                   nodebuf[5] > 0xffff) {
> +                                       rc = -EINVAL;
> +                                       goto out;
> +                               }
> +
> +                               c->u.pkey.low_pkey = le32_to_cpu(nodebuf[4]);
> +                               c->u.pkey.high_pkey = le32_to_cpu(nodebuf[5]);
> +
> +                               rc = context_read_and_validate(&c->context[0],
> +                                                              p,
> +                                                              fp);
> +                               if (rc)
> +                                       goto out;
> +                               break;
> +                       }
> +                       case OCON_IB_END_PORT:

This is a little bit of bikeshedding, but is there such thing as an IB
"port" that isn't an *end* "port"?  Could we simply use OCON_IB_PORT?

> +                               rc = next_entry(buf, fp, sizeof(u32) * 2);
> +                               if (rc)
> +                                       goto out;
> +                               len = le32_to_cpu(buf[0]);
> +
> +                               rc = str_read(&c->u.ib_end_port.dev_name, GFP_KERNEL,
> +                                             fp,
> +                                             len);
> +                               if (rc)
> +                                       goto out;
> +
> +                               c->u.ib_end_port.port = le32_to_cpu(buf[1]);

No range checking on the port value like you do on the partition keys above?

> +                               rc = context_read_and_validate(&c->context[0],
> +                                                              p,
> +                                                              fp);
> +                               if (rc)
> +                                       goto out;
> +                               break;
>                         }
>                 }
>         }

-- 
paul moore
security @ redhat
