Message-ID: <5321DE1C.2050301@tycho.nsa.gov>
Date: Thu, 13 Mar 2014 12:34:36 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [RFC PATCH v1] selinux: add transitions for kernel keys
References: <20140312215305.9695.86521.stgit@localhost>
 <5321AFD7.4010100@tycho.nsa.gov> <3794276.87hdXQ4UL5@sifl>
In-Reply-To: <3794276.87hdXQ4UL5@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mgrepl@redhat.com, selinux@tycho.nsa.gov, eparis@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/13/2014 11:46 AM, Paul Moore wrote:
> On Thursday, March 13, 2014 09:17:11 AM Stephen Smalley wrote:
>> On 03/12/2014 05:53 PM, Paul Moore wrote:
>>> Unfortunately, experience has shown that transitions are necessary for
>>> keys stored in the kernel's keyring ...
> 
> ...
> 
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 57b0b49..3ea05b6 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -5682,18 +5682,25 @@ static int selinux_inode_getsecctx(struct inode
>>> *inode, void **ctx, u32 *ctxlen)> 
>>>  static int selinux_key_alloc(struct key *k, const struct cred *cred,
>>>  
>>>  			     unsigned long flags)
>>>  
>>>  {
>>>
>>> -	const struct task_security_struct *tsec;
>>> +	int rc;
>>> +	const struct task_security_struct *tsec = current_security();
>>>
>>>  	struct key_security_struct *ksec;
>>>
>>> +	u32 sid;
>>> +
>>> +	if (tsec->keycreate_sid)
>>> +		sid = tsec->keycreate_sid;
>>> +	else if (selinux_policycap_keytrans) {
>>> +		rc = security_transition_sid(tsec->sid, SECINITSID_KERNEL,
>>> +					     SECCLASS_KEY, NULL, &sid);
>>
>> Wouldn't it be more general and help avoid the need for a separate
>> policy capability and avoid special casing keys, to pass both the
>> cred->security->sid and the current->security->sid to
>> security_transition_sid()?
>>
>> Then you just arrange the sid argument order so that the current default
>> behavior will be in effect in the absence of any type_transition or
>> default_type rules?
>>
>> Also, isn't the use of current_security() here rather than the provided
>> cred a divergence from the keyring model for DAC, and what implications
>> exist there?  Why isn't this a problem for their DAC model if it is a
>> problem for SELinux?
> 
> My mistake, I agree that we should use cred->security instead of 
> current_security(), thanks for catching that.
> 
> However, I'm not sure passing both cred->sid and current->sid to the 
> transition call is the correct solution, regardless of which is acting as the 
> source/target (although both could be kernel_t in certain cases).  In my mind 
> the target is either the kernel, or ideally, the linked keyring; unfortunately 
> we don't have a keyring in this scope and in some cases we may never have a 
> keyring.  Perhaps you can elaborate a bit ... ?

I guess I don't understand the original problem or fix then.  I assumed
that cred->security was referring to one set of credentials while
current_security() was referring to another and you wanted to use the
latter instead of the former.  If not, then none of this makes any
sense.  Transitions are for computing new labels from a pair of labels,
either by allowing selection of either subject or object or by deriving
a new label from the two.  If there is only one label in view and the
other is always fixed (kernel), then under what conditions are you going
to label some keys with the kernel domain and why does that make any
sense at all?  It was still allocated by some userspace process and
ought to carry along the credentials of that process.

The SELinux key/keyring model was designed quite a while ago and vetted
by the keys/keyrings maintainer, so I'd be careful about any changes
without careful consideration and review by the keys maintainer (David
Howells).  It is also documented in Documentation/security/keys.txt.
