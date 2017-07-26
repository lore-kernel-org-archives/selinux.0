To: Daniel Cashman <dcashman@android.com>, selinux@tycho.nsa.gov
Cc: Dan Cashman <dcashman@google.com>
References: <20170726150400.143620-1-dcashman@android.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <e12ea3a5-7336-ab70-3d6e-df7e6d1a216e@tycho.nsa.gov>
Date: Wed, 26 Jul 2017 13:30:54 -0400
MIME-Version: 1.0
In-Reply-To: <20170726150400.143620-1-dcashman@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] libsepol: cil: enable cpp compilation of cil.h.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/26/2017 11:04 AM, Daniel Cashman wrote:
> From: Dan Cashman <dcashman@google.com>
> 
> Signed-off-by: Daniel Cashman <dcashman@google.com>

Applied.

Thanks,
Jim

> ---
>   libsepol/cil/include/cil/cil.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
> index 4507892c..86117f24 100644
> --- a/libsepol/cil/include/cil/cil.h
> +++ b/libsepol/cil/include/cil/cil.h
> @@ -32,6 +32,10 @@
>   
>   #include <sepol/policydb/policydb.h>
>   
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
>   struct cil_db;
>   typedef struct cil_db cil_db_t;
>   
> @@ -71,4 +75,7 @@ extern void cil_log(enum cil_log_level lvl, const char *msg, ...);
>   
>   extern void cil_set_malloc_error_handler(void (*handler)(void));
>   
> +#ifdef __cplusplus
> +}
> +#endif
>   #endif
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
