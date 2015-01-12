Message-ID: <54B404CC.90908@tycho.nsa.gov>
Date: Mon, 12 Jan 2015 12:30:52 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: John Brooks <john.brooks@jolla.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/3] Use a better hash function for libsepol's avtab
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1420668221-52637-3-git-send-email-john.brooks@jolla.com>
In-Reply-To: <1420668221-52637-3-git-send-email-john.brooks@jolla.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/07/2015 05:03 PM, John Brooks wrote:
> This function, based on murmurhash3, has much better distribution than
> the original. Using the current default of 4096 buckets, there are many
> fewer collisions:
> 
> Before:
> 2893000 entries and 4096/4096 buckets used, longest chain length 1649
> After:
> 2732000 entries and 4096/4096 buckets used, longest chain length 764
> 
> The difference becomes much more significant when buckets are increased.
> A naive attempt to expand the current function to larger outputs doesn't
> yield any significant improvement; so this function is a prerequisite
> for increasing the bucket size.
> ---
>  libsepol/src/avtab.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index ea947cb..9c01a8d 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -49,10 +49,39 @@
>  #include "debug.h"
>  #include "private.h"
>  
> -static inline int avtab_hash(struct avtab_key *keyp, uint16_t mask)
> +/* Based on MurmurHash3, written by Austin Appleby and placed in the
> + * public domain.
> + */
> +static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
>  {
> -	return ((keyp->target_class + (keyp->target_type << 2) +
> -		 (keyp->source_type << 9)) & mask);
> +	uint32_t h1 = 0;
> +
> +	const uint32_t c1 = 0xcc9e2d51;
> +	const uint32_t c2 = 0x1b873593;
> +
> +#define mix(n) { \
> +	uint32_t k1 = n; \
> +	k1 *= c1; \
> +	k1 = (k1 << 15) | (k1 >> (32 - 15)); \
> +	k1 *= c2; \
> +	h1 ^= k1; \
> +	h1 = (h1 << 13) | (h1 >> (32 - 13)); \
> +	h1 = h1*5+0xe6546b64; \
> +}
> +
> +	mix(keyp->target_class);
> +	mix(keyp->target_type);
> +	mix(keyp->source_type);
> +
> +#undef mix
> +
> +	h1 ^= h1 >> 16;
> +	h1 *= 0x85ebca6b;
> +	h1 ^= h1 >> 13;
> +	h1 *= 0xc2b2ae35;
> +	h1 ^= h1 >> 16;
> +
> +	return h1 & mask;
>  }
>  
>  static avtab_ptr_t
> 

Thanks, this looks like a significant improvement for neverallow
checking.  I'm trying to make sure I understand what if any implications
it has for other uses of the avtab, since the neverallow checker is
unusual in that it fully expands all entries.

On Fedora 20 policy, checkpolicy -Mb
/etc/selinux/targeted/policy/policy.29 before and after this patch (with
avtabh_hash_eval called) shows:

before.txt:rules:  101401 entries and 8169/8192 buckets used, longest
chain length 84
betterhash.txt:rules:  101401 entries and 8192/8192 buckets used,
longest chain length 27

So that's a definite improvement.

Could you amend your code to define constants for the various magic
values used above?  Thanks.
