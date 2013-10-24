Message-ID: <52696E16.4020402@tycho.nsa.gov>
Date: Thu, 24 Oct 2013 14:59:34 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Eric Paris <eparis@redhat.com>
Subject: Re: SELinux: Update policy version to support constraints info
References: <1382398322.27942.61.camel@localhost> <5266730C.2010205@tycho.nsa.gov> <1382610164.40150.YahooMailNeo@web87904.mail.ir2.yahoo.com> <11155540.a6QObQOMze@sifl>
In-Reply-To: <11155540.a6QObQOMze@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/24/2013 02:36 PM, Paul Moore wrote:
> On Thursday, October 24, 2013 11:22:44 AM Richard Haines wrote:
>> ----- Original Message -----
>>
>>> From: Stephen Smalley <sds@tycho.nsa.gov>
>>> To: Eric Paris <eparis@redhat.com>
>>> Cc: selinux@tycho.nsa.gov
>>> Sent: Tuesday, 22 October 2013, 13:43
>>> Subject: Re: SELinux: Update policy version to support constraints info
>>>
>>> On 10/21/2013 07:32 PM, Eric Paris wrote:
>>>>  From: Richard Haines <richard_c_haines@btinternet.com>
>>>>  Date: Tue, 18 Dec 2012 19:37:46 +0000
>>>>  
>>>>  Update the policy version (POLICYDB_VERSION_CONSTRAINT_NAMES) to allow
>>>>  holding of policy source info for constraints.
>>>
>>> Before we get into code review, let me ask the following:
>>> Why do we need a new kernel binary policy version for information that
>>> is only used by userspace?  Why can't this information be extracted from
>>> the policy module format or stored in an auxiliary file used only by
>>> userspace?
>>
>> True it could be done the ways you suggest, however the module format would
>> only work for modular policies and the auxiliary file (I felt) would be
>> difficult to track (could be another config type file maybe?).
> 
> My current two cents on the issue ...
> 
> Working under the assumption that the userspace tools would much prefer to 
> read the policy directly from the kernel (for obvious reasons), it makes sense 
> to me that we provide this additional constraint information along with the 
> rest of the policy.  Having to pull policy information from both the kernel 
> and a regular file seems like it could lead to all sorts of problems.
> 
> Further, I believe that for the majority of systems the extra ~5k of kernel 
> memory is not a major deal breaker, although I will concede that for smaller 
> systems (Android perhaps?) this might be more of a concern.  What if, along 
> with this extra constraint information, we add a toggle (perhaps via a new 
> policy capability) which would trigger the kernel to either preserve the 
> constraint info or discard it when the policy is loaded? 

No, if we take it, it should be unconditionally preserved IMHO.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
