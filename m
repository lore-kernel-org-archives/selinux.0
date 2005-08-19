Subject: Re: [RFC] Checking the loaded policy against a policy on disk
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Steve G <linux_4ever@yahoo.com>, SELinux-dev@tresys.com,
   James Morris <jmorris@namei.org>
In-Reply-To: <4305DFB1.60000@tresys.com>
References: <1124454737.32663.27.camel@moss-spartans.epoch.ncsc.mil>
	 <4305DFB1.60000@tresys.com>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 10:45:28 -0400
Message-Id: <1124462728.32663.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-19 at 09:33 -0400, Joshua Brindle wrote:
> I'd definitely prefer the latter. With policy modules, rpm should not 
> even install a kernel binary. The policy rpm packages would contain the 
> policy module for the respective package which would then be installed 
> into the module store and consequently incorporated into the kernel 
> policy.

Plus other modifiers to policy beyond modules, such as local boolean
settings, user definitions, net contexts, etc.

I think we need to hash out how this is expected to work and convert
rawhide over to this model as soon as possible.  Might also have
implications for the installer.

>  Unfortunatly, if LSPP has a strong requirement for which policy 
> is running the module system becomes much less useful.

As long as we can verify the policy against some set of managed files, I
think we are ok.  It is simply a matter of being able to reproduce the
transforms that converted the original managed files into the final
generated kernel binary policy file for comparison, and then being able
to check the in-memory policy against that generated policy file.

> If something also needs to be done in the non-module case then we 
> certainly need to take that into consideration when fixing the 
> infrastructure to do modifications on disk, I am under the impression 
> that semodule is going to be added into FC5 and some targets would be 
> converted to modules, comments Dan?

semodule is in rawhide, but no one is using it yet AFAIK.  In any event,
even aside from modules, we need to convert over the current booleans
and users definitions to a model where each change goes through a
toolchain and yields a new generated policy file.

> Further, does LSPP disallow booleans? If not how will the checksum 
> account for boolean state changes? (Or will it just ignore them, which 
> sounds like a bad idea)

The checksum would just verify that the policy in memory matches some
policy file on disk.  As part of verifying consistency, I suppose you
would also query the current boolean settings via selinuxfs and compare
them against legal settings.  Hopefully the booleans won't affect
anything relevant to the MLS support.

> anything already included in cryptoapi would be free, right?

Yes, but the SELinux module still needs some way to select an algorithm,
and userspace needs to know which one it is using and have a
corresponding implementation.  selinuxfs interface for getting and
setting the algorithm, with some initial default?

> I don't know how useful this is. Once the modules are in widespread use 
> this name won't mean much, other than possibly the base policies name, 
> which won't help much since any number of modules could be loaded on top 
> of it. If information about the policy is needed it's probably better to 
> ask the policy server or whathaveyou, since you'll have some fine 
> grained query means.

True.  Note however that even with a policy server, there is going to be
an initial policy load by /sbin/init prior to the startup of the policy
server.  Right?  But init is just going to load the generated policy
file created earlier by the policy server, so the policy server should
be able to provide identifying information about the loaded policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
