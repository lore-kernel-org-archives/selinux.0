Message-ID: <43E0BF09.3040308@tresys.com>
Date: Wed, 01 Feb 2006 09:00:41 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: Desktop integration
References: <43DE6244.5010100@cornell.edu> <43DE6578.9050302@redhat.com> <20060201130811.GA26269@europium.cip.ifi.lmu.de>
In-Reply-To: <20060201130811.GA26269@europium.cip.ifi.lmu.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thomas Bleher wrote:
> * Daniel J Walsh <dwalsh@redhat.com> [2006-01-30 20:33]:
>> Ivan Gyurdiev wrote:
>>> For the type field, it makes sense to me to have a drop-down box with 
>>> the customizable types in there (as the user shouldn't relabeling to 
>>> any other types). I also think we should translate those types into 
>>> something more user friendly, possibly in multiple languages. I 
>>> imagine a box that you can choose from "Office Document", "Music 
>>> File", "Image FIle", "Sensitive Data", "Untrusted Content", things 
>>> like that. Any other suggestions?
>> Changing types is a tougher problem.  First you are making two bad 
>> assumptions.
>>
>> 1. That a user can relabel to all of the customizable types.  In most 
>> policies he will not be allowed to .
>>
>> 2. That the only types he can relabel to are customizable.
> 
> Wouldn't it be better to look up the allowed relabels directly? 
> You'd first have to check if the user has "relabelfrom" rights on the
> file and then collect all the file types for which the user has
> "relabelto" rights.
> This is could be done with compute_av, but I don't think we want to
> allow users to do this.
> 
> IMHO it would be best to create a new interface to query the policy for
> this type of information. Maybe not in the kernel, but the policy server
> surely could provide it.
> 

To clarify, the policy management server does not perform av lookups for 
the user. It will make the exposed policy components (users, ports, 
booleans, etc) available through a client (semanage, semodule) and 
enforce access controls on policy updates.

I don't think it makes sense to duplicate permission information into an 
semanage database. However a helper app can easily do compute_av's on 
behalf of the user in a privileged domain from either the kernel 
security server or later on the userspace security server.

Rather than trying to query every file type a user has access to 
relabel, which may be a little time consuming and give make the 
interface practically unusable (almost every type is relabel able 
to/from by sysadm_t) it should be limited to customizable or some 
superset of customizable.

This is probably best accomplished using dbus so that the desktop apps 
(running as the user domain?) don't maintain their own netlink 
connection to the kss but still know when the avc has been flushed and 
new av checks must be done (via the helper app over dbus).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
