From: Daniel Jurgens <danielj@mellanox.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/9] checkpolicy: Add support for ibpkeycon labels
Date: Wed, 10 May 2017 21:46:59 +0000
Message-ID: <VI1PR05MB16781217F6349141611AA57BC4EC0@VI1PR05MB1678.eurprd05.prod.outlook.com>
References: <1494363042-121766-1-git-send-email-danielj@mellanox.com>
 <1494363042-121766-2-git-send-email-danielj@mellanox.com>
 <1494440569.24408.10.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/10/2017 1:18 PM, Stephen Smalley wrote:
> On Tue, 2017-05-09 at 23:50 +0300, Dan Jurgens wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>>
>> +#ifdef DARWIN
>> +	memcpy(&newc->u.ibpkey.subnet_prefix[0],
>> &subnet_prefix.s6_addr[0],
>> +	       sizeof(newc->u.ibpkey.subnet_prefix));
>> +#else
>> +	memcpy(&newc->u.ibpkey.subnet_prefix[0],
>> &subnet_prefix.s6_addr32[0],
>> +	       sizeof(newc->u.ibpkey.subnet_prefix));
>> +#endif
> We can just always use s6_addr instead of s6_addr32 and drop the
> #ifdef.  Just pushed a commit to fix that elsewhere. Also we switched
> from #ifdef DARWIN to __APPLE__ a while ago, but that won't matter once
> you drop the #ifdef altogether.
OK
>
>> @@ -722,10 +728,11 @@ extern int
>> policydb_set_target_platform(policydb_t *p, int platform);
>>  #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
>>  #define POLICYDB_VERSION_XEN_DEVICETREE		30 /* Xen-
>> specific */
>>  #define POLICYDB_VERSION_XPERMS_IOCTL	30 /* Linux-specific */
>> +#define POLICYDB_VERSION_INFINIBAND		31
> This is Linux-specific too.
I'll add a similar comment.
>
>>  
>>  /* Range of policy versions we understand*/
>>  #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
>> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_XPERMS_IOCTL
>> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_INFINIBAND
>>  
>>  /* Module versions and specific changes*/
>>  #define MOD_POLICYDB_VERSION_BASE		4
>> @@ -743,10 +750,11 @@ extern int
>> policydb_set_target_platform(policydb_t *p, int platform);
>>  #define MOD_POLICYDB_VERSION_TUNABLE_SEP	14
>>  #define MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS	15
>>  #define MOD_POLICYDB_VERSION_DEFAULT_TYPE	16
>> -#define MOD_POLICYDB_VERSION_CONSTRAINT_NAMES  17
>> +#define MOD_POLICYDB_VERSION_CONSTRAINT_NAMES	17
>> +#define MOD_POLICYDB_VERSION_INFINIBAND		18
>>  
>>  #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
>> -#define MOD_POLICYDB_VERSION_MAX
>> MOD_POLICYDB_VERSION_CONSTRAINT_NAMES
>> +#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_INFINIBAND
>>  
>>  #define POLICYDB_CONFIG_MLS    1
> Hmmm...we never introduced a binary module version for xperms, since
> the only user is presently Android and they don't use binary modules
> and in general we'd like to get rid of binary modules altogether and
> switch entirely to source modules (either .te modules with a te2cil
> converter or cil modules).  But I guess you probably want to support
> this in the interim for convenient usage within existing Fedora/RHEL
> policies.
>
Yes, we want to pull this back into RHEL once it's available upstream.

Thank you for your quick review.  I'll continue going through your comments on the other patches and post a v1 after giving some more time for others to comment as well.
