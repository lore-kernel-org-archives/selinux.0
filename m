Message-ID: <1508769875.24902.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jan Zarsky <jzarsky@redhat.com>, selinux@tycho.nsa.gov
Date: Mon, 23 Oct 2017 10:44:35 -0400
In-Reply-To: <20171023085234.18328-1-jzarsky@redhat.com>
References: <20171023085234.18328-1-jzarsky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] libsepol: free ibendport device names
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-10-23 at 10:52 +0200, Jan Zarsky wrote:
> When reading policy, ibendport device names are allocated in
> ocontext_read_selinux() but they are not freed when calling
> sepol_policydb_free();
> 
> Fix this by freeing them in ocontext_selinux_free().
> 
> Signed-off-by: Jan Zarsky <jzarsky@redhat.com>

Thanks, this looks correct to me; I'm wondering if we have the same
leak in the kernel code (I think so).

> ---
>  libsepol/src/policydb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 37788f36..c7521235 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1420,6 +1420,8 @@ void ocontext_selinux_free(ocontext_t
> **ocontexts)
>  			if (i == OCON_ISID || i == OCON_FS || i ==
> OCON_NETIF
>  				|| i == OCON_FSUSE)
>  				free(ctmp->u.name);
> +			else if (i == OCON_IBENDPORT)
> +				free(ctmp->u.ibendport.dev_name);
>  			free(ctmp);
>  		}
>  	}
