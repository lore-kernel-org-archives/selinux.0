From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH v1 2/9] libsepol: Add ibpkey ocontext handling
Date: Wed, 17 May 2017 20:50:20 +0000
Message-ID: <VI1PR05MB1678541B6214919717EF2E33C4E70@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-3-git-send-email-danielj@mellanox.com>
 <1494960225.21557.5.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/16/2017 1:39 PM, Stephen Smalley wrote:
> On Mon, 2017-05-15 at 23:42 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> Add support for reading, writing, and copying Infinabinda Pkey 
> Infiniband
>
>> ocontext
>> data. Also add support for querying a Pkey sid to checkpolicy.
>>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>>
>> ---
>> v1:
>> Stephen Smalley:
>> - Removed domain and type params from sepol_ibpkey_sid.
>> - Removed splen param from sepol_ibpkey_sid, it never varied.
>> - Removed extra XPERMS_IOCTL version from policydb_compat_info.
>> - Confirm that low order bytes of IPv6 addr for subnet prefix is 0's.
>>
>> James Carter:
>> - Added ibpkey handling to kernel_to_cil.c and kernel_to_conf.c
>>
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>> ---
>>  checkpolicy/checkpolicy.c                  | 25 +++++++++++++
>>  libsepol/include/sepol/policydb/services.h |  8 ++++
>>  libsepol/src/expand.c                      |  9 +++++
>>  libsepol/src/kernel_to_cil.c               | 58
>> +++++++++++++++++++++++++++++
>>  libsepol/src/kernel_to_conf.c              | 59
>> ++++++++++++++++++++++++++++++
>>  libsepol/src/libsepol.map.in               |  1 +
>>  libsepol/src/module_to_cil.c               | 38 +++++++++++++++++++
>>  libsepol/src/policydb.c                    | 37 +++++++++++++++++++
>>  libsepol/src/services.c                    | 51
>> ++++++++++++++++++++++++++
>>  libsepol/src/write.c                       | 16 ++++++++
>>  10 files changed, 302 insertions(+)
>>
>> diff --git a/libsepol/include/sepol/policydb/services.h
>> b/libsepol/include/sepol/policydb/services.h
>> index 9162149..459254e 100644
>> --- a/libsepol/include/sepol/policydb/services.h
>> +++ b/libsepol/include/sepol/policydb/services.h
>> @@ -188,6 +188,14 @@ extern int sepol_port_sid(uint16_t domain,
>>  			  uint16_t port, sepol_security_id_t *
>> out_sid);
>>  
>>  /*
>> + * Return the SID of the ibpkey specified by
>> + * `subnet prefix', and `pkey'.
>> + */
>> +extern int sepol_ibpkey_sid(void *subnet_prefix_p,
> Why void *?  Can't this just be struct in6_addr *subnet_prefix or
> uint32_t subnet_prefix[]?  The only reason we use void *addr in
> sepol_node_sid() is because that argument can actually vary depending
> on the domain.  Likely can be const too.

Changed to uint32_t *, since that's what the type is in the ocontext structure.  Added const.

>> +				n->u.ibpkey.subnet_prefix[2] = c-
>>> u.ibpkey.subnet_prefix[2];
>> +				n->u.ibpkey.subnet_prefix[3] = c-
>>> u.ibpkey.subnet_prefix[3];
> [2] and [3] should always be zero.

Done

>
>> +				n->u.ibpkey.low_pkey = c-
>>> u.ibpkey.low_pkey;
>> +				n->u.ibpkey.high_pkey = c-
>>> u.ibpkey.high_pkey;
>> +			break;
>>  			case OCON_PORT:
>>  				n->u.port.protocol = c-
>>> u.port.protocol;
>>  				n->u.port.low_port = c-
>>> u.port.low_port;
>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> index 7093b29..d6e8e6f 100644
>> --- a/libsepol/src/policydb.c
>> +++ b/libsepol/src/policydb.c
>>
>> @@ -2782,6 +2804,21 @@ static int ocontext_read_selinux(struct
>> policydb_compat_info *info,
>>  				    (&c->context[1], p, fp))
>>  					return -1;
>>  				break;
>> +			case OCON_IBPKEY:
>> +				rc = next_entry(buf, fp,
>> sizeof(uint32_t) * 6);
>> +				if (rc < 0 || buf[2] || buf[3])
>> +					return -1;
> Kernel code also rejects buf[4] or buf[5] > 0xffff.

Done

>> @@ -1410,6 +1411,21 @@ static int ocontext_write_selinux(struct
>> policydb_compat_info *info,
>>  				if (context_write(p, &c->context[1], 
>> fp))
>>  					return POLICYDB_ERROR;
>>  				break;
>> +			case OCON_IBPKEY:
>> +				 /* The subnet prefix is in network
>> order */
>> +				for (j = 0; j < 4; j++)
>> +					buf[j] = c-
>>> u.ibpkey.subnet_prefix[j];
> Kernel write code always writes [2] and [3] as 0.

Done
