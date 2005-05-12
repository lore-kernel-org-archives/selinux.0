Message-ID: <42836C4C.6010301@redhat.com>
Date: Thu, 12 May 2005 10:46:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: Busted by constraints.
References: <428368FF.2080603@redhat.com> <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Thu, 2005-05-12 at 10:32 -0400, Daniel J Walsh wrote:
>  
>
>>Auditing of constraint failures sucks.  We are putting out incorrect 
>>error messages.  Or at least not informative enough to help the 
>>user/policy writer to figure out what is wrong.
>>
>>Yesterday,  Another engineer and I spent a lot of time trying to figure 
>>out why setfscreatecon was failing.  The only indication was the the
>>application was not allowed to created a directory.  Of course the allow 
>>rule was present in the policy.  Eventually we figured out we needed
>>the privowner priv to get by a constraint.    Shouldn't the kernel be 
>>reporting a constraint failure.  Isn't this going to become a lot more
>>important with MLS?
>>    
>>
>
>The AVC just sees that a given permission was denied, not what component
>of the policy engine denied it.  See "Flask architecture", "policy-
>flexibility", ...
>
>But nothing prevents you from creating a simple tool linked against
>libsepol that takes an avc denial and determines which part of the
>policy caused it.  I'd expect that to be part of an audit analysis tool
>like seaudit, not a change to the kernel.
>
>  
>
Well I would have no idea how to do it, but it is going to be 
increasingly needed
as constraints grow.

Something to tell me the failure is caused by a missing role or 
constraint would be great.
audit2why :^)
Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
