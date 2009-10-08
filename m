Message-ID: <4ACE1F3A.90503@tycho.nsa.gov>
Date: Thu, 08 Oct 2009 13:19:54 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH] libselinux: raw string_to_class/string_to_av_perm variants
References: <4ACCE820.4080007@tycho.nsa.gov>	 <4ACCF117.4060807@tycho.nsa.gov> <1255005053.2182.18.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1255005053.2182.18.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/08/2009 08:30 AM, Stephen Smalley wrote:
> On Wed, 2009-10-07 at 15:50 -0400, Eamon Walsh wrote:
>    
>> This patch adds support for remapping classes and permissions on policy
>> reload.  This is accomplished by separating the code that computes the
>> "real" kernel class and permission values into a helper function,
>> mapping_compute().  This function is called both from
>> selinux_set_mapping() when the user specifies a new mapping, and from
>> the netlink code when a policyload notification is received.  The
>> function now builds up a temporary mapping and swaps it in rather than
>> working on the active mapping in place.
>>
>> Issue: There is a race condition in which old class and permission
>> values may arrive from userspace after a kernel policyload has taken
>> place.  Fixing this would require a string interface to the kernel, or
>> some kind of transaction support.
>>      
> Also, in addition to these changes, you'll want to grab the
> security_deny_unknown() value at startup and upon policy reloads and use
> it inside of map_decision() for unknown permissions and inside of
> security_compute_av_flags_raw() for unknown classes just as in the
> kernel for map_decision() and security_compute_av().  And possibly
> mapping_compute() should log unknown classes/permissions and their
> disposition (allow or deny) in the same manner as the kernel's
> selinux_set_mapping().
>    


Yup, those are the next patches coming, after I manage to free up some 
time to work on them.

-- 
Eamon Walsh<ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
