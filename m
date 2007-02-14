Message-ID: <45D35110.10608@tresys.com>
Date: Wed, 14 Feb 2007 13:12:32 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC] Ability to allow undefined permissions and classes -v2
References: <1171309430.10871.2.camel@localhost.localdomain>	 <1171369673.3242.16.camel@moss-spartans.epoch.ncsc.mil>	 <1171387714.10871.22.camel@localhost.localdomain>	 <1171388407.3242.87.camel@moss-spartans.epoch.ncsc.mil> <1171395416.10871.37.camel@localhost.localdomain>
In-Reply-To: <1171395416.10871.37.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Tue, 2007-02-13 at 12:40 -0500, Stephen Smalley wrote:
>   
>> On Tue, 2007-02-13 at 12:28 -0500, Eric Paris wrote:
>>     
> [snip snip]
>   
>>> This is a vestige of the original av padding where I had to be concerned
>>> that p->p_classes.nprim was larger than kdefs->cts_len.  Since now I
>>> only use the array when making permission checks I can assume that I
>>> will never get a class from the check greater than the number of kernel
>>> classes defined.  So all that can be simplified to just
>>> p->undefined_perms = kzalloc(sizeof(u32)*kdefs->cts_len, GFP_KERNEL);
>>>       
>> No - security_compute_av can also be called via selinuxfs to check
>> userland security classes (from libselinux for userspace object
>> managers).
>>     
>
> I'm starting to wonder if the entire way I am constructing and using
> using my table might be wrong.  Right now I am finding the permissions
> which are defined in the kernel but are not defined in the policy,
> storing just those select permissions, and then adding those to the
> allow rules.  This works very well when I only consider the kernel and
> don't think about things in userspace.
>
>   
What happens when we start using a userspace security server and the 
kernel policy doesn't have any userspace object classes? If the avc 
routing gets changed the policy suddenly turns to default allow, not 
good. We have to be careful here, chances are we'll remove user object 
classes from kernel headers and that would make the result acceptable 
but in the mean time this puts the policy in a bad state.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
