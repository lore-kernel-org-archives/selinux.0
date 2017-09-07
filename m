To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170903121928.24024-1-nicolas.iooss@m4x.org>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <616900b7-e1ff-56fc-18af-b39e4c6868ca@tycho.nsa.gov>
Date: Thu, 7 Sep 2017 10:57:01 -0400
MIME-Version: 1.0
In-Reply-To: <20170903121928.24024-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 1/6] libsepol: use IN6ADDR_ANY_INIT to initialize IPv6
 addresses
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/03/2017 08:19 AM, Nicolas Iooss wrote:
> When compiling libsepol with clang and some warning flags, the compiler
> complains about the way IPv6 addresses are initialized:
> 
>      kernel_to_cil.c:2795:35: error: suggest braces around initialization
>      of subobject [-Werror,-Wmissing-braces]
>              struct in6_addr subnet_prefix = {0};
>                                               ^
>                                               {}
> 
> When replacing the initializer as suggested, gcc 4.8.4 complains:
> 
>      kernel_to_cil.c: In function ‘write_selinux_ibpkey_rules_to_cil’:
>      kernel_to_cil.c:2795:9: error: missing initializer for field
>      ‘__in6_u’ of ‘struct in6_addr’ [-Werror=missing-field-initializers]
>        struct in6_addr subnet_prefix = {};
>               ^
> 
> Thankfully netinet/in.h provides a macro to initialize struct in6_addr
> variables:
> 
>      #define IN6ADDR_ANY_INIT { { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } } }
> 
> Both clang and gcc no longer report warnings when using this macro.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

This series has been applied.

Thanks,
Jim

> ---
>   libsepol/src/kernel_to_cil.c  | 2 +-
>   libsepol/src/kernel_to_conf.c | 2 +-
>   libsepol/src/module_to_cil.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index f1905a958ec0..0055c2386695 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2788,7 +2788,7 @@ static int write_selinux_ibpkey_rules_to_cil(FILE *out, struct policydb *pdb)
>   {
>   	struct ocontext *ibpkeycon;
>   	char subnet_prefix_str[INET6_ADDRSTRLEN];
> -	struct in6_addr subnet_prefix = {0};
> +	struct in6_addr subnet_prefix = IN6ADDR_ANY_INIT;
>   	uint16_t low;
>   	uint16_t high;
>   	char low_high_str[44]; /* 2^64 <= 20 digits so "(low high)" <= 44 chars */
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> index a74873f01687..95aa92fc8c26 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -2649,7 +2649,7 @@ static int write_selinux_ibpkey_rules_to_conf(FILE *out, struct policydb *pdb)
>   {
>   	struct ocontext *ibpkeycon;
>   	char subnet_prefix_str[INET6_ADDRSTRLEN];
> -	struct in6_addr subnet_prefix = {0};
> +	struct in6_addr subnet_prefix = IN6ADDR_ANY_INIT;
>   	uint16_t low;
>   	uint16_t high;
>   	char low_high_str[44]; /* 2^64 <= 20 digits so "low-high" <= 44 chars */
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 619a48f8c7b6..15b58a7aacee 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2687,7 +2687,7 @@ static int ocontext_selinux_ibpkey_to_cil(struct policydb *pdb,
>   	int rc = -1;
>   	struct ocontext *ibpkeycon;
>   	char subnet_prefix_str[INET6_ADDRSTRLEN];
> -	struct in6_addr subnet_prefix = {0};
> +	struct in6_addr subnet_prefix = IN6ADDR_ANY_INIT;
>   	uint16_t high;
>   	uint16_t low;
>   
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
