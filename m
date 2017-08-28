To: Jan Zarsky <jzarsky@redhat.com>, selinux@tycho.nsa.gov
References: <20170825094647.7925-1-jzarsky@redhat.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <845c0825-07c8-193d-24c9-fd1451332f13@tycho.nsa.gov>
Date: Mon, 28 Aug 2017 16:10:09 -0400
MIME-Version: 1.0
In-Reply-To: <20170825094647.7925-1-jzarsky@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] libsepol: reset pointer after free
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/25/2017 05:46 AM, Jan Zarsky wrote:
> In cil_strpool_destroy(), cil_strpool_tab is freed but it is not reset to NULL.
> When cil_strpool_init() is called again it assumes that cil_strpool_tab was
> already initialized. Other functions then work with invalid data.
> 
> Signed-off-by: Jan Zarsky <jzarsky@redhat.com>

Applied.

Thanks,
Jim

> ---
>   libsepol/cil/src/cil_strpool.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
> index b1396d2..97d4c4b 100644
> --- a/libsepol/cil/src/cil_strpool.c
> +++ b/libsepol/cil/src/cil_strpool.c
> @@ -119,6 +119,7 @@ void cil_strpool_destroy(void)
>   	if (cil_strpool_readers == 0) {
>   		hashtab_map(cil_strpool_tab, cil_strpool_entry_destroy, NULL);
>   		hashtab_destroy(cil_strpool_tab);
> +		cil_strpool_tab = NULL;
>   	}
>   	pthread_mutex_unlock(&cil_strpool_mutex);
>   }
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
