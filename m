Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o52K4hG4016614
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2010 16:04:43 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o52K3tYR004254
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2010 20:03:55 GMT
Date: Wed, 02 Jun 2010 16:04:38 -0400
Subject: Re: Non-Computing Abstractions & An Issue Thereof
From: Chad Sellers <csellers@tresys.com>
To: Joshua Kramer <josh@globalherald.net>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C82C3196.B87E5%csellers@tresys.com>
In-Reply-To: <4C0189D1.3030301@globalherald.net>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/29/10 5:40 PM, "Joshua Kramer" <josh@globalherald.net> wrote:

> Hello,
> 
> I am trying to wrap my head around using SELinux to secure data objects
> in userspace.  My learning style suggests that for a topic like this, I
> abstract the theory away from how it's actually implemented in
> software.  To those ends, I have created the type enforcement file
> attached to this email, that loosely models the behavior of teams of
> sled dogs using SELinux.
> 
> When I try to install the policy using these commands:
> 
> checkmodule -M -m -o seSledDogs.mod seSledDogs.te
> semodule_package -o seSledDogs.pp -m seSledDogs.mod
> semodule -i ./seSledDogs.pp
> 
> ...I get this error from semodule:
> 
> libsepol.print_missing_requirements: seSledDogs's global requirements
> were not met: role dog_owner_r (No such file or directory).
> libsemanage.semanage_link_sandbox: Link packages failed (No such file or
> directory).
> semodule:  Failed!
> 
The error says that things you specified as requirements for your policy
module to work (within the require block) don't exist in the rest of the
policy on the system. The require block in a policy module is for specifying
things that are required to exist outside of this module.

Assuming you do not expect food_t, medicine_t, etc. to exist outside your
module, but rather expect your module to declare those things, you should
move them out of the require block.

> If I comment out the roles, I get a similar message about the types:
> 
> libsepol.print_missing_requirements: seSledDogs's global requirements
> were not met: type/attribute medicine_t (No such file or directory).
> libsemanage.semanage_link_sandbox: Link packages failed (No such file or
> directory).
> semodule:  Failed!
> 
> Where do I need to be defining these roles and types?  I was under the
> impression that the te files were self-contained.
> 
Policy files (.te) are not self-contained, they are modules that are linked
together with the rest of the modules to create the system policy (that's
what semodule does). So, a .te file can declare things (say a type) and use
it internally, or it can require things from elsewhere in order to grant
access between something local and something elsewhere.

Hope that helps,
Chad Sellers
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
