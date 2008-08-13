Message-ID: <48A276D2.1050303@ak.jp.nec.com>
Date: Wed, 13 Aug 2008 14:53:22 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org, paul.moore@hp.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/3] Thread/Child-Domain Assignment (rev.2)
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com> <4897E974.2040003@ak.jp.nec.com> <06A6610D4F464D4EBEAFBF2C5F86911E1CB38D@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E1CB38D@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> KaiGai Kohei wrote:
>> The series of patches enables to assign a thread an
>> indivisual "more bounded" domain, even if the process is
>> multithreaded. 
>>
>> We can apply this feature to set up a server application
>> which handles user's request withing more restricted domain,
>> to protect potential harms come from application bugs.
>>
>> It also adds a new binary policy format (version 24).
>> This version allows each definitions of user/role/type to
>> have its bounds. The bounds restrict capabilities of bounded
>> one with similar rules compared to existing name based
>> hierarchy support.
>> The following rules are enhanced from existing hierarchy stuff.
>> - A bounded type cannot have any attribute which does not assigned  
>> to the upper type. 
> 
> I don't think this is necessary. The original hierarchy implementation
> only cared about the net effect of the rules, not how they were granted.
> For example, if I have 2 attributes, one that is given more privilege
> and one that is given a subset of the first why should I have to assign
> both to the 'parent' type? I don't agree with this constraint.

The major purpose of attribute bounds was a restriction for CONSTRAIN
or MLSCONSTRAINT rules. However, I reconsidered it can be implemented
by sanity checks at policy load time, without any attribute bounds.

I agree what you pointed out.
In the next patch, I'll remove the code to check attribute bounds.

>> - CONSTRAIN/MLSCONSTRAIN rules are enhanced to pay attention   the
>> boundary relationships. 
>>
>> I adds a new statement of TYPEBOUNDS as follows:
>>
>>   TYPEBOUNDS <parent type>  <child type 1> [, <child type 2> ...] ;
>>
>> It defines boundary relationships between two types, and
>> these are loaded to the kernelspace via policy version 24.
>> (*) The existing hierarchy is implicitly expanded to bounds.
>>
>> I don't provide a statement to define boundary relationships
>> between roles/users, although existing hierarchy supports
>> them, because its purpose/worth is unclear now.
> 
> Its purpose was the same as the original purpose for the hierarchy. The
> hierarchy was developed for policy access control using the policy
> management server. One would 'label' policy objects using the hierarchy
> and could constrain the permissions (or roles or types) using the
> hierarchical constraints. I request that you not remove this support in
> your version.

Sorry, my explanation might be misleadable. :(

The new facilities can have a data structure to represent boundary
relationships between two types/roles/users. However, I didn't add
a new syntax in policy language statement, like USERBOUNDS/ROLEBOUNDS.
If the checkmodule founds existing name based hierarhies, implicit
boundary relationships are assigned to them, and these are shipped
into kernelspace later.

For example, a definition of "staff_u.kaigai" does not define a SElinux
user only, but a boundary relationship between "staff_u" and
"staff_u.kaigai" is also defined automatically.

I consider this behavior can follows existing name based hierarchies.

> Additionally, if you are enforcing hierarchy on types in constrain
> statements you should also do this for roles and users, for consistency.

The latest kernel patch enables to check (MLS)CONSTRAINT statement for
users, roles and types. Please show constraint_bounds_sanity_check()
which is invoked at policy load time.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
