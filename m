Subject: Re: RFC Kernel interface to conditional policy
From: Karl MacMillan <kmacmillan@tresys.com>
To: James Morris <jmorris@redhat.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0312040833250.32432-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0312040833250.32432-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1070570425.28675.24.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 04 Dec 2003 15:40:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-12-04 at 08:40, James Morris wrote:
> On Wed, 3 Dec 2003, Karl MacMillan wrote:
> Firstly, why does this need to be done in kernel space at all?  Why not 
> recompile the policy in userspace and reload it via the already simple and 
> well defined user/kernel policy interface?  
> 
> If it doesn't need to be done in the kernel, then it shouldn't be.
> 

I think that it needs to be done in kernel so that the loaded kernel
policy can control the changes made to itself. Changing a boolean (in
the current version) is a well-defined change to the policy that is
controlled by the policy; reloading the policy is potentially not well
defined.

Additionally, because the files for changing the booleans can be
individually labeled, there is fine-grained control over what domains
can change which aspects of the policy. If this was done in userspace
permission to change a boolean becomes permission to change any aspect
of the policy, which is not ideal.

> > 1) Manipulate proc files directly. This allows fine-grained labeling of
> > the boolean files, but kernel developers seem to be frowning on new uses
> > of proc.
> 
> Yes, extending proc is deprecated.
> 

OK.

> > 
> > 2) Extend the selinux filesystem. This wouldn't allow fine-grained
> > labeling and would pollute the policy-neutral security server interface
> > with type enforcement policy specific functionality.
> 
> I'm not clear on why you need fine-grained labeling to update security
> policy: would you not allow just one domain to do this?
> 

See above - fine-grained control over which domains can change which
portions of the policy is a useful feature in my mind.

> 
> > 3) Create a new filesystem. This would be the most work, but otherwise
> > meet our needs.
> 
> This sounds like the best approach, if you have to manipulate policy in 
> the kernel.  You might also consider netlink messaging (as an example, 
> this is how the in-kernel routing table is manipulated).
> 

Netlink messaging won't give us the fine-grained labeling, correct? I
think I'll look into extending selinuxfs.

Karl

> 
> - James
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
