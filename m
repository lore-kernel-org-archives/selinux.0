Subject: Re: Non-Computing Abstractions & An Issue Thereof
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Kramer <josh@globalherald.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4C0189D1.3030301@globalherald.net>
References: <4C0189D1.3030301@globalherald.net>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Jun 2010 08:51:51 -0400
Message-ID: <1275396711.2924.1.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2010-05-29 at 17:40 -0400, Joshua Kramer wrote:
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

A require block specifies the dependencies of the module; it does not
define them.  So if you put a symbol in a require block that is not
defined by any module, the module linking will fail as above.

Also note that you cannot define new classes/permissions in any non-base
module presently; they have to be defined in the base module.  That
should change in the future but is a limitation of the current
toolchain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
