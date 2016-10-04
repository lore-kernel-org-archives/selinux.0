Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u94EEHwv006827
 for <selinux@tycho.nsa.gov>; Tue, 4 Oct 2016 10:14:18 -0400
Subject: Re: [PATCH V2] libsepol: Add support for converting extended
 permissions to CIL
To: selinux@tycho.nsa.gov
References: <1475590240-8172-1-git-send-email-jwcart2@tycho.nsa.gov>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <6686b816-1f49-6a24-136b-b27a6894e10e@tycho.nsa.gov>
Date: Tue, 4 Oct 2016 10:15:25 -0400
MIME-Version: 1.0
In-Reply-To: <1475590240-8172-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Previous patch didn't have the correct CIL syntax.

Jim

On 10/04/2016 10:10 AM, James Carter wrote:
> Checkpolicy has an option to produce CIL output and is dependent on
> the policydb-to-CIL conversion in libsepol for that option. Add
> support for converting extended permissions to CIL so that checlpolicy
> can generate CIL.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/src/module_to_cil.c | 115 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 111 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 508a861..b7d3b5e 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -609,6 +609,103 @@ exit:
>  	return rc;
>  }
>
> +#define next_bit_in_range(i, p) ((i + 1 < sizeof(p)*8) && xperm_test((i + 1), p))
> +
> +static int xperms_to_cil(const av_extended_perms_t *xperms)
> +{
> +	uint16_t value;
> +	uint16_t low_bit;
> +	uint16_t low_value;
> +	unsigned int bit;
> +	unsigned int in_range = 0;
> +	int first = 1;
> +
> +	if ((xperms->specified != AVTAB_XPERMS_IOCTLFUNCTION)
> +		&& (xperms->specified != AVTAB_XPERMS_IOCTLDRIVER))
> +		return -1;
> +
> +	for (bit = 0; bit < sizeof(xperms->perms)*8; bit++) {
> +		if (!xperm_test(bit, xperms->perms))
> +			continue;
> +
> +		if (in_range && next_bit_in_range(bit, xperms->perms)) {
> +			/* continue until high value found */
> +			continue;
> +		} else if (next_bit_in_range(bit, xperms->perms)) {
> +			/* low value */
> +			low_bit = bit;
> +			in_range = 1;
> +			continue;
> +		}
> +
> +		if (!first)
> +			cil_printf(" ");
> +		else
> +			first = 0;
> +
> +		if (xperms->specified & AVTAB_XPERMS_IOCTLFUNCTION) {
> +			value = xperms->driver<<8 | bit;
> +			low_value = xperms->driver<<8 | low_bit;
> +			if (in_range) {
> +				cil_printf("(range 0x%hx 0x%hx)", low_value, value);
> +				in_range = 0;
> +			} else {
> +				cil_printf("0x%hx", value);
> +			}
> +		} else if (xperms->specified & AVTAB_XPERMS_IOCTLDRIVER) {
> +			value = bit << 8;
> +			low_value = low_bit << 8;
> +			if (in_range) {
> +				cil_printf("(range 0x%hx 0x%hx)", low_value, (uint16_t) (value|0xff));
> +				in_range = 0;
> +			} else {
> +				cil_printf("(range 0x%hx 0x%hx)", value, (uint16_t) (value|0xff));
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int avrulex_to_cil(int indent, struct policydb *pdb, uint32_t type, const char *src, const char *tgt, const class_perm_node_t *classperms, const av_extended_perms_t *xperms)
> +{
> +	int rc = -1;
> +	const char *rule;
> +	const struct class_perm_node *classperm;
> +
> +	switch (type) {
> +	case AVRULE_XPERMS_ALLOWED:
> +		rule = "allowx";
> +		break;
> +	case AVRULE_XPERMS_AUDITALLOW:
> +		rule = "auditallowx";
> +		break;
> +	case AVRULE_XPERMS_DONTAUDIT:
> +		rule = "dontauditx";
> +		break;
> +	case AVRULE_XPERMS_NEVERALLOW:
> +		rule = "neverallowx";
> +		break;
> +	default:
> +		log_err("Unknown avrule xperm type: %i", type);
> +		rc = -1;
> +		goto exit;
> +	}
> +
> +	for (classperm = classperms; classperm != NULL; classperm = classperm->next) {
> +		cil_indent(indent);
> +		cil_printf("(%s %s %s (%s %s (", rule, src, tgt,
> +			   "ioctl", pdb->p_class_val_to_name[classperm->tclass - 1]);
> +		xperms_to_cil(xperms);
> +		cil_printf(")))\n");
> +	}
> +
> +	return 0;
> +
> +exit:
> +	return rc;
> +}
> +
>  static int num_digits(int n)
>  {
>  	int num = 1;
> @@ -1077,7 +1174,8 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
>  	struct type_set *ts;
>
>  	for (avrule = avrule_list; avrule != NULL; avrule = avrule->next) {
> -		if (avrule->specified == AVRULE_NEVERALLOW && avrule->source_filename) {
> +		if ((avrule->specified & (AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
> +		    avrule->source_filename) {
>  			cil_println(0, ";;* lmx %lu %s\n",avrule->source_line, avrule->source_filename);
>  		}
>
> @@ -1095,14 +1193,22 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
>
>  		for (s = 0; s < num_snames; s++) {
>  			for (t = 0; t < num_tnames; t++) {
> -				rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->perms);
> +				if (avrule->specified & AVRULE_XPERMS) {
> +					rc = avrulex_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->perms, avrule->xperms);
> +				} else {
> +					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], tnames[t], avrule->perms);
> +				}
>  				if (rc != 0) {
>  					goto exit;
>  				}
>  			}
>
>  			if (avrule->flags & RULE_SELF) {
> -				rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->perms);
> +				if (avrule->specified & AVRULE_XPERMS) {
> +					rc = avrulex_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->perms, avrule->xperms);
> +				} else {
> +					rc = avrule_to_cil(indent, pdb, avrule->specified, snames[s], "self", avrule->perms);
> +				}
>  				if (rc != 0) {
>  					goto exit;
>  				}
> @@ -1112,7 +1218,8 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
>  		names_destroy(&snames, &num_snames);
>  		names_destroy(&tnames, &num_tnames);
>
> -		if (avrule->specified == AVRULE_NEVERALLOW && avrule->source_filename) {
> +		if ((avrule->specified & (AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
> +		    avrule->source_filename) {
>  			cil_println(0, ";;* lme\n");
>  		}
>  	}
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
