Message-ID: <53A86289.1080207@tycho.nsa.gov>
Date: Mon, 23 Jun 2014 13:23:21 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] selinux: Permit exec transitions under NO_NEW_PRIVS
 or NOSUID under certain circumstances.
References: <5399FD14.60101@tycho.nsa.gov> <5399FF80.604@tycho.nsa.gov>
 <2612411.5tyaPs4jv0@sifl> <2193314.0u2ajp0mRJ@sifl>
In-Reply-To: <2193314.0u2ajp0mRJ@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/19/2014 04:51 PM, Paul Moore wrote:
> On Thursday, June 19, 2014 04:04:18 PM Paul Moore wrote:
>> On Thursday, June 12, 2014 03:29:04 PM Stephen Smalley wrote:
>>> v2 - fix patch description to match the code.
>>
>> Okay Stephen, I suppose you should get some special consideration, but is
>> posting your patches inline really that hard :)
>>
>> ---
>> From c1fa21950c5c3eb0dd97ae5145fa3d3f04adc5c4 Mon Sep 17 00:00:00 2001
>> From: Stephen Smalley <sds@tycho.nsa.gov>
>> Date: Thu, 12 Jun 2014 08:17:48 -0400
>> Subject: [PATCH] selinux:  Permit exec transitions under NO_NEW_PRIVS or
>>  NOSUID under certain circumstances.
>>
>> If the callee SID is bounded by the caller SID or if the caller SID is
>> allowed to perform a dynamic transition (setcon) to the callee SID, then
>> allowing the transition to occur poses no risk of privilege escalation and
>> we can therefore safely allow the transition to occur.  Add these two
>> exemptions for both the case where a transition was explicitly requested by
>> the application and the case where an automatic transition is defined in
>> policy.
>>
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Acked-by: Andy Lutomirski <luto@amacapital.net>
> 
> Comments below ...
> 
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 83d06db..d5e8dc5 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2086,6 +2086,36 @@ static int selinux_vm_enough_memory(struct mm_struct
>> *mm, long pages)
>>
>>  /* binprm security operations */
>>
>> +static int check_nnp_nosuid(const struct linux_binprm *bprm,
>> +			    const struct task_security_struct *old_tsec,
>> +			    const struct task_security_struct *new_tsec)
>> +{
>> +	int nnp = (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS);
>> +	int nosuid = (bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID);
>> +	int rc;
>> +
>> +	if (!nnp && !nosuid)
>> +		return 0; /* neither NNP nor nosuid */
>> +
>> +	if (new_tsec->sid == old_tsec->sid)
>> +		return 0; /* No change in credentials */
>> +
>> +	rc = security_bounded_transition(old_tsec->sid, new_tsec->sid);
>> +	if (rc == 0)
>> +		return 0; /* allowed via bounded transition */
> 
> I think there might be an audit issue here; security_bounded_transition() will 
> generate an audit record on failure which probably isn't what we want in this 
> case.
> 
> Other than that, this seems reasonable, even in the face of NNP, and as others 
> point out, standard DAC capabilities do something similar.
> 
>> +	/* Only allow if dyntransition permission aka setcon() is allowed. */
>> +	rc = avc_has_perm(old_tsec->sid, new_tsec->sid, SECCLASS_PROCESS,
>> +			  PROCESS__DYNTRANSITION, NULL);
>> +	if (rc) {
>> +		if (nnp)
>> +			return -EPERM;
>> +		else
>> +			return -EACCES;
>> +	}
>> +	return 0;
> 
> I know this dyntransition/NNP/NOSUID interaction has been discussed quite a 
> bit off-list (mostly while I was away, my apologies), but I haven't seen a lot 
> on-list and while the descriptions hints at it the code itself doesn't 
> elaborate on why this is "OK".  I'd like to see some comments about why it is 
> okay to allow the transition, regardless of NNP/NOSUID, if the dyntransition 
> is allowed.  I'd also like to see a quick comment about why we return -EPERM/-
> EACCES.
> 
> There was a lot of discussion around these points and I want to make sure the 
> ideas aren't lost.

The claim was that dyntransition is sufficient since it would allow the
caller to setcon() to the new domain directly and therefore perform any
action in that domain.  Thus, allowing it to transition to that domain
upon exec under NNP or on a file in a nosuid mount does not enable it to
do anything it could not already do directly.

However, this presumes that the policy writer does not merely add
dyntransition to the caller domain upon encountering the avc denial in
this situation without thinking about the implications and deciding
whether to truly trust the caller domain in this way.  Which is likely a
dangerous assumption, especially for people who write policy via
audit2allow.

At least with the bounded transition, you have to explicitly declare
that the new domain is bounded by the caller domain and the kernel will
then enforce the restriction that the new domain is not granted any
permission not allowed to the caller domain.

I'm also unclear as to whether this in fact solves the actual problem
for sandbox -X.

So I'd drop this patch for now at least.
