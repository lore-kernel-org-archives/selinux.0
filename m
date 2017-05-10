Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: semanage: is __default__ login map required?
From: Karl Macmillan <karlwmacmillan@gmail.com>
In-Reply-To: <d3c1ae40-55c9-6744-ffe5-e59e9ecff451@mail.mil>
Date: Wed, 10 May 2017 19:59:13 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-Id: <E941337C-361D-4546-9733-53113A29CE24@gmail.com>
References: <fe3cac69-be05-984f-7a71-28989b3ef93b@mail.mil>
 <1493838844.15269.16.camel@tycho.nsa.gov>
 <1493840196.15269.18.camel@tycho.nsa.gov>
 <d3c1ae40-55c9-6744-ffe5-e59e9ecff451@mail.mil>
To: "Arnold, Paul C CTR USARMY PEO STRI (US)" <paul.c.arnold4.ctr@mail.mil>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> On May 3, 2017, at 3:47 PM, Arnold, Paul C CTR USARMY PEO STRI (US) <paul.c.arnold4.ctr@mail.mil> wrote:
> 
>> On 05/03/2017 03:32 PM, Stephen Smalley wrote:
>>> On Wed, 2017-05-03 at 15:14 -0400, Stephen Smalley wrote:
>>> On Wed, 2017-05-03 at 13:36 -0400, Arnold, Paul C CTR USARMY PEO STRI
>>> (US) wrote:
>>>> I have been having problems mapping logins since removing
>>>> __default__
>>>> from the policy.  Is the __default__ login map required in order
>>>> for
>>>> semanage to set a new mapping?
>>>> 
>>>> The error, specifically:
>>>> 
>>>> $ sudo semanage login -a -s existing_u existing_login
>>>> libsemanage.dbase_llist_query: could not query record value
>>>> semanage: Could not query user for existing_login
>>>> 
>>>> 
>>>> Policy is based upon refpolicy, but all utils are RHEL6 dist.
>>> Not sure what is in RHEL6, but upstream it looks like the code tries
>>> to
>>> look up the old login/user information before making the change so
>>> that
>>>  it can audit the old and new values.  Probably ought to be handling
>>> an
>>> exception there and recovering cleanly.
>>> 
>>> Caution-https://github.com/SELinuxProject/selinux/blob/master/python/semanage
>>> /seobject.py#L537
>>> 
>>> Caution-https://github.com/SELinuxProject/selinux/commit/a0e538c208e5af07fecb
>>> 8c045e6341397d0df44a
>> That said, maybe the first question is why do you want to remove the
>> __default__ mapping.  Not sure that is even supported via semanage
>> login -d, and you're likely to end up having it get regenerated
>> automatically on any subsequent semodule/semanage commands even if you
>> manually remove it (unless you removed it from the source policy before
>> building in the first place).
>> 
>> Just set it to the most restrictive values possible, like user_u, s0 or
>> guest_u, s0.
>> 
> 
> Thanks Stephen.  As for why, this is for a high assurance solution for which I do not make the requirements.
> 

Many high assurance systems I've built or reviewed simply map default to a user domain with no privileges. It's quite likely that this is for systems with requirements similar to what you are dealing with. 

If you want to send me a private email I can likely give you some more helpful details. 

Karl

> 
> __default__ is removed from source policy.  I don't think semanage can remove logins defined in base policy, and I wouldn't want to due to regeneration concerns you already mentioned.
> 
> Thank you for the commit reference; that makes it much clearer for me.  I'll do some testing, perhaps just write another python script to add new mappings if I absolutely cannot have __default__ defined.
> 
> 
> 
> Regards,
> 
> -- 
> Paul Arnold, CISSP
> Cole Engineering Services, Inc.
> 
> 
