Message-ID: <461538F3.1000905@tycho.nsa.gov>
Date: Thu, 05 Apr 2007 13:59:15 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: grant permissions on deny in permissive	mode
References: <4615339A.1060700@tycho.nsa.gov> <1175794555.5711.78.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1175794555.5711.78.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2007-04-05 at 13:36 -0400, Eamon Walsh wrote:
>> This patch duplicates the kernel behavior of granting permissions
>> after a denial to avoid repeated AVC's.
>>
>> It required moving the avc_update_node static inline function further
>> up in the file and changing its prototype.
> 
> Alternatively, in the userspace AVC case, you could just directly mutate
> ae->avd.allowed in avc_has_perm_noaudit(), as:
> 	ae->avd.allowed |= requested;
> 
> That is what the kernel AVC used to do before it was converted to RCU
> (at which point we could no longer mutate entries in-place).  Much
> simpler to do it the above way since you aren't likely to be using RCU
> in the userspace AVC ;)

OK, will resubmit using that approach.

> 
> You also need to reset the cache upon a setenforce 1 in this case just
> like the kernel does so that you flush any cached permissions from
> permissive mode when you enter enforcing mode.

Adding James to the cc list:

I'm having trouble with this because avc_ss_reset() takes a "seqno" 
argument and the selnl_msg_policyload netlink structure provides a seqno 
field, but the selnl_msg_setenforce does not, it just has the new mode.

Does this field need to be added to the message structure?


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
