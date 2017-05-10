From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 2/9] libsepol: Add ibpkey ocontext handling
Date: Wed, 10 May 2017 22:23:19 +0000
Message-ID: <VI1PR05MB1678A0C72D3ADFF2FA819D5CC4EC0@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-3-git-send-email-danielj@mellanox.com>
 <1494442533.24408.13.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/10/2017 1:51 PM, Stephen Smalley wrote:
> On Tue, 2017-05-09 at 23:50 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> Add support for reading, writing, and copying Infinabinda Pkey 
> s/Infinabinda/Infiniband/
Done
>
>> --- a/libsepol/include/sepol/policydb/services.h
>> +++ b/libsepol/include/sepol/policydb/services.h
>> @@ -188,6 +188,17 @@ extern int sepol_port_sid(uint16_t domain,
>>  			  uint16_t port, sepol_security_id_t *
>> out_sid);
>>  
>>  /*
>> + * Return the SID of the ibpkey specified by
>> + * `domain', `type', `subnet prefix', and `pkey'.
>> + */
> Can you explain why you are passing a (domain,type) pair to this
> interface and why subnet_prefix is not fixed length as it is in
> corresponding kernel interface (security_pkey_sid)?  Will these
> arguments ever be used?  Could the length change in the future?
>
> For that matter, and I guess I should have asked this on the kernel
> patches, why are you storing and passing the subnet prefix as a
> complete IPv6 address?  Is that just for the convenience of being able
> to use inet_pton() and inet_ntop()?  Is this typical for handling of IB
> subnet prefixes?  Seems a bit wasteful.
I modeled it after sepol_port_sid, which has the unused type and domain.  They are not needed and I've removed them. The length was also not needed, it is always the same size and will never change. 

Regarding using an IPv6 address for the subnet prefix, it is for convenience. There is already code to deal with IPv6 addresses, not just inet_pton and inet_ntop, but in the CIL code as well.  The subnet prefix is just the top half of the IPv6 address.  Using IPv6 address to store it allowed code reuse.  When the policy is loaded into the kernel the lower 8 bytes are not stored, subnet prefix is stored as a u64, so the space is not permanently wasted.
>>
>> @@ -2583,6 +2584,7 @@ static int ocontext_selinux_isid_to_cil(struct
>> policydb *pdb, struct ocontext *i
>>  		"policy",
>>  		"scmp_packet",
>>  		"devnull",
>> +		"ibpkey",
> I thought we dropped the separate initial SID for it?
You're right.  Overlooked this when I changed that during the kernel series review.
>>
>> @@ -185,6 +186,21 @@ static struct policydb_compat_info
>> policydb_compat[] = {
>>  	 .ocon_num = OCON_NODE6 + 1,
>>  	 .target_platform = SEPOL_TARGET_SELINUX,
>>  	},
>> +
>> +	{
>> +	 .type = POLICY_KERN,
>> +	 .version = POLICYDB_VERSION_XPERMS_IOCTL,
>> +	 .sym_num = SYM_NUM,
>> +	 .ocon_num = OCON_NODE6 + 1,
>> +	 .target_platform = SEPOL_TARGET_SELINUX,
>> +	},
> This seems duplicated?

Removed

>> @@ -2782,6 +2812,23 @@ static int ocontext_read_selinux(struct
>> policydb_compat_info *info,
>>  				    (&c->context[1], p, fp))
>>  					return -1;
>>  				break;
>> +			case OCON_IBPKEY:
>> +				rc = next_entry(buf, fp,
>> sizeof(uint32_t) * 6);
>> +				if (rc < 0)
>> +					return -1;
>> +
>> +				c->u.ibpkey.subnet_prefix[0] =
>> buf[0];
>> +				c->u.ibpkey.subnet_prefix[1] =
>> buf[1];
>> +				c->u.ibpkey.subnet_prefix[2] =
>> buf[2];
>> +				c->u.ibpkey.subnet_prefix[3] =
>> buf[3];
> Why load all the values rather than just confirming that [2] and [3]
> are zero as in the kernel?

Changed to confirm they are 0.
