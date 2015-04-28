Message-ID: <553F81F6.1030905@tycho.nsa.gov>
Date: Tue, 28 Apr 2015 08:49:58 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] dispol: display operations as ranges
References: <1430172331-29172-1-git-send-email-jeffv@google.com>
In-Reply-To: <1430172331-29172-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/27/2015 06:05 PM, Jeff Vander Stoep wrote:
> Displays operations ranges more concisely. E.g.
> 
> { 0x8901-0x8930 }
> 
> instead of
> 
> { 0x8901 0x8902 0x8903 0x8904 80x8905 0x0806 ... 0x8930 }
> ---
>  checkpolicy/test/dispol.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)

Thanks, applied.

> 
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 133759f..157361a 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -55,23 +55,50 @@ int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
>  }
>  
>  #define operation_perm_test(x, p) (1 & (p[x >> 5] >> (x & 0x1f)))
> +#define next_bit_in_range(i, p) \
> +	((i + 1 < sizeof(p)*8) && operation_perm_test((i + 1), p))
>  
>  int render_operations(avtab_operations_t *ops, avtab_key_t * key, FILE * fp)
>  {
>  	uint16_t value;
> -	unsigned int bit = 0;
> +	uint16_t low_bit;
> +	uint16_t low_value;
> +	unsigned int bit;
> +	unsigned int in_range = 0;
>  
>  	fprintf(fp, "{ ");
>  	for (bit = 0; bit < sizeof(ops->perms)*8; bit++) {
>  		if (!operation_perm_test(bit, ops->perms))
>  			continue;
> +
> +		if (in_range && next_bit_in_range(bit, ops->perms)) {
> +			/* continue until high value found */
> +			continue;
> +		} else if (next_bit_in_range(bit, ops->perms)) {
> +			/* low value */
> +			low_bit = bit;
> +			in_range = 1;
> +			continue;
> +		}
> +
>  		if (key->specified & AVTAB_OPNUM) {
>  			value = ops->type<<8 | bit;
> -			fprintf(fp, "0x%hx ", value);
> +			low_value = ops->type<<8 | low_bit;
> +			if (in_range)
> +				fprintf(fp, "0x%hx-0x%hx ", low_value, value);
> +			else
> +				fprintf(fp, "0x%hx ", value);
>  		} else if (key->specified & AVTAB_OPTYPE) {
>  			value = bit << 8;
> -			fprintf(fp, "0x%hx-0x%hx ", value, value|0xff);
> +			low_value = low_bit << 8;
> +			if (in_range)
> +				fprintf(fp, "0x%hx-0x%hx ", low_value, (uint16_t) (value|0xff));
> +			else
> +				fprintf(fp, "0x%hx-0x%hx ", value, (uint16_t) (value|0xff));
> +
>  		}
> +		if (in_range)
> +			in_range = 0;
>  	}
>  	fprintf(fp, "}");
>  	return 0;
> 
