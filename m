From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 5/9] libsepol: Add ibendport ocontext handling
Date: Thu, 11 May 2017 16:13:27 +0000
Message-ID: <VI1PR05MB16787B1A5577B341A50DBC34C4ED0@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-6-git-send-email-danielj@mellanox.com>
 <1494443390.24408.17.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/10/2017 2:05 PM, Stephen Smalley wrote:
> On Tue, 2017-05-09 at 23:50 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> --- a/libsepol/include/sepol/policydb/services.h
>> +++ b/libsepol/include/sepol/policydb/services.h
>> @@ -199,6 +199,16 @@ extern int sepol_ibpkey_sid(uint16_t domain,
>>  			  sepol_security_id_t *out_sid);
>>  
>>  /*
>> + * Return the SID of the ibendport specified by
>> + * `domain', `type', `dev_name', and `port'.
>> + */
>> +extern int sepol_ibendport_sid(uint16_t domain,
>> +			       uint16_t type,
>> +			       char *dev_name,
>> +			       uint8_t port,
>> +			       sepol_security_id_t *out_sid);
> Why (domain, type) arguments?

Same case as the pkey one.  Removed.

>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -2585,6 +2585,7 @@ static int ocontext_selinux_isid_to_cil(struct
>> policydb *pdb, struct ocontext *i
>>  		"scmp_packet",
>>  		"devnull",
>>  		"ibpkey",
>> +		"ibendport",
> No new initial SIDs.

Removed


>>
>> @@ -2829,6 +2829,23 @@ static int ocontext_read_selinux(struct
>> policydb_compat_info *info,
>>  				    (&c->context[0], p, fp))
>>  					return -1;
>>  				break;
>> +			case OCON_IBENDPORT:
>> +				rc = next_entry(buf, fp,
>> sizeof(uint32_t) * 2);
>> +				if (rc < 0)
>> +					return -1;
>> +				len = le32_to_cpu(buf[0]);
> if (zero_or_saturated(len))
> 	return -1;

Added, but slightly differently because I'm checking for a smaller max length due to the next comment.

>> +int hidden sepol_ibendport_sid(uint16_t domain __attribute__
>> ((unused)),
>> +			       uint16_t type __attribute__
>> ((unused)),
>> +			       char *dev_name,
>> +			       uint8_t port,
>> +			       sepol_security_id_t *out_sid)
>> +{
>> +	ocontext_t *c;
>> +	int rc = 0;
>> +
>> +	c = policydb->ocontexts[OCON_IBENDPORT];
>> +	while (c) {
>> +		if (c->u.ibendport.port == port &&
>> +		    !strncmp(dev_name, c->u.ibendport.dev_name, 64))
>> +			break;
> Do you ensure that dev_name cannot be > 64 bytes in checkpolicy and in
> ocontext_read_selinux()?  And do we really want strncmp() here rather
> than just strcmp()?  What's the advantage?
The maximum size for an Infiniband device name is 64 bytes. But there really isn't an advantage for the comparison.  I'll switch it, and enforce a length check.
