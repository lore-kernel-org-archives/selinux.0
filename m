Message-ID: <4D9D28DD.8040000@windriver.com>
Date: Thu, 07 Apr 2011 11:00:45 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: qingtao.cao@windriver.com
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov
Subject: Re: [v2 PATCH 1/3] SELinux: Add class support to the role_trans structure
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>	 <1301032323-20363-2-git-send-email-qingtao.cao@windriver.com> <1302131081.2821.1.camel@unknown001a4b0c2895>
In-Reply-To: <1302131081.2821.1.camel@unknown001a4b0c2895>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris 写道:
> On Fri, 2011-03-25 at 13:51 +0800, Harry Ciao wrote:
>   
>> If kernel policy version is >= 26, then the binary representation of
>> the role_trans structure supports specifying the class for the current
>> subject or the newly created object.
>>
>> If kernel policy version is < 26, then the class field would be default
>> to the process class.
>>
>> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
>> ---
>>  security/selinux/include/security.h |    3 ++-
>>  security/selinux/ss/policydb.c      |   14 ++++++++++++++
>>  security/selinux/ss/policydb.h      |    3 ++-
>>  3 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
>> index 348eb00..bfc5218 100644
>> --- a/security/selinux/include/security.h
>> +++ b/security/selinux/include/security.h
>> @@ -30,13 +30,14 @@
>>  #define POLICYDB_VERSION_PERMISSIVE	23
>>  #define POLICYDB_VERSION_BOUNDARY	24
>>  #define POLICYDB_VERSION_FILENAME_TRANS	25
>> +#define POLICYDB_VERSION_ROLETRANS	26
>>  
>>  /* Range of policy versions we understand*/
>>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
>>  #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
>>  #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
>>  #else
>> -#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_FILENAME_TRANS
>> +#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_ROLETRANS
>>  #endif
>>  
>>  /* Mask for just the mount related flags */
>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>> index e7b850a..fd62c50 100644
>> --- a/security/selinux/ss/policydb.c
>> +++ b/security/selinux/ss/policydb.c
>> @@ -128,6 +128,11 @@ static struct policydb_compat_info policydb_compat[] = {
>>  		.sym_num	= SYM_NUM,
>>  		.ocon_num	= OCON_NUM,
>>  	},
>> +	{
>> +		.version	= POLICYDB_VERSION_ROLETRANS,
>> +		.sym_num	= SYM_NUM,
>> +		.ocon_num	= OCON_NUM,
>> +	},
>>  };
>>  
>>  static struct policydb_compat_info *policydb_lookup_compat(int version)
>> @@ -2302,8 +2307,17 @@ int policydb_read(struct policydb *p, void *fp)
>>  		tr->role = le32_to_cpu(buf[0]);
>>  		tr->type = le32_to_cpu(buf[1]);
>>  		tr->new_role = le32_to_cpu(buf[2]);
>> +		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
>> +			rc = next_entry(buf, fp, sizeof(u32));
>> +			if (rc)
>> +				goto bad;
>> +			tr->tclass = le32_to_cpu(buf[0]);
>> +		} else
>> +			tr->tclass = p->process_class;
>>     
>
>
> This doesn't work as p->process_class isn't set until about 100 lines
> later.  This means that a policy.X < 26 always fails on the next test
> since policydb_class_isvalid(p, 0) is going to fail.  I can try to find
> a way to handle this tomorrow, but hopefully you will find something
> sooner!
>
> Thanks!
> -Eric
>
>   

Argh, you are right! I should have tried to boot up an older version
policy image with the udpated kernel. After a quick glance I think we
could fix this problem by bumping the setting of p->process_class before
reading role_transition rules, since all symtabs would have been read
from the policy image.

I will get back to you after I finish the test later. Thanks!

Cheers,
Harry

>> +
>>  		if (!policydb_role_isvalid(p, tr->role) ||
>>  		    !policydb_type_isvalid(p, tr->type) ||
>> +		    !policydb_class_isvalid(p, tr->tclass) ||
>>  		    !policydb_role_isvalid(p, tr->new_role))
>>  			goto bad;
>>  		ltr = tr;
>> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
>> index 732ea4a..801175f 100644
>> --- a/security/selinux/ss/policydb.h
>> +++ b/security/selinux/ss/policydb.h
>> @@ -72,7 +72,8 @@ struct role_datum {
>>  
>>  struct role_trans {
>>  	u32 role;		/* current role */
>> -	u32 type;		/* program executable type */
>> +	u32 type;		/* program executable type, or new object type */
>> +	u32 tclass;		/* process class, or new object class */
>>  	u32 new_role;		/* new role */
>>  	struct role_trans *next;
>>  };
>>     
>
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
