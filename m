Date: Thu, 4 Dec 2003 08:40:05 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Karl MacMillan <kmacmillan@tresys.com>
cc: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: RFC Kernel interface to conditional policy
In-Reply-To: <1070484482.3774.54.camel@colossus.columbia.tresys.com>
Message-ID: <Xine.LNX.4.44.0312040833250.32432-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Dec 2003, Karl MacMillan wrote:

> We have added conditional expressions to the selinux policy language.
> This allows you to place TE rules in if/else blocks with conditional
> expressions. The booleans in the conditional expressions can be
> controlled at runtime to allow the addition or removal of rules based on
> the value of the booleans/expressions.
> 
> Problem
> 
> Our initial prototype exports the booleans as files under
> /proc/sys/selinux/booleans using the sysctl interface
> ([un]register_sysctl_table). On each policy reload we call
> unregister_sysctl_table and then re-register all of the booleans. The
> problem is that if one of the boolean files is in use the file is not
> removed and unregister_sysctl_table gives no indication that unregister
> was not successful. The solutions to this problem that we see are:

Firstly, why does this need to be done in kernel space at all?  Why not 
recompile the policy in userspace and reload it via the already simple and 
well defined user/kernel policy interface?  

If it doesn't need to be done in the kernel, then it shouldn't be.

> 1) Manipulate proc files directly. This allows fine-grained labeling of
> the boolean files, but kernel developers seem to be frowning on new uses
> of proc.

Yes, extending proc is deprecated.

> 
> 2) Extend the selinux filesystem. This wouldn't allow fine-grained
> labeling and would pollute the policy-neutral security server interface
> with type enforcement policy specific functionality.

I'm not clear on why you need fine-grained labeling to update security
policy: would you not allow just one domain to do this?


> 3) Create a new filesystem. This would be the most work, but otherwise
> meet our needs.

This sounds like the best approach, if you have to manipulate policy in 
the kernel.  You might also consider netlink messaging (as an example, 
this is how the in-kernel routing table is manipulated).


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
