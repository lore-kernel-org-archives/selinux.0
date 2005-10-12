Message-ID: <434D2CFB.5040208@tresys.com>
Date: Wed, 12 Oct 2005 11:34:19 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil>	<1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>	<4346CE4C.1030201@tresys.com>	<1128714852.1450.90.camel@moss-spartans.epoch.ncsc.mil>	<4346D745.6080203@tresys.com>	<1128716625.1450.96.camel@moss-spartans.epoch.ncsc.mil>	<4346DD70.1070806@tresys.com>	<1129058140.3308.213.camel@moss-spartans.epoch.ncsc.mil>	<434C41D9.7010206@tresys.com> <1129129084.3308.255.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129129084.3308.255.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2005-10-11 at 18:51 -0400, Joshua Brindle wrote:
> 
>>Why are we still adding the policy version if we aren't going to support 
>>building different versions anyway.
> 
> 
> As you know, the policy version suffix allows multiple policies to exist
> simultaneously on the disk for multiple kernels that support different
> versions, and allows userspace to select the appropriate policy to load
> based on the suffix without having to parse the policy itself.
> 
> 
>>In the case of multiple kernels with different supported versions this 
>>could be detrimental in the case that, for example, a version 18 policy 
>>is built, the kernel is upgraded, a version 20 policy is built, the 
>>policy is changed, modules/users/whatever added. Then an older kernel is 
>>booted and loads the stale version 18 policy..
> 
> 
> Certainly not ideal, but better than not having a policy that can be
> loaded at all, thereby causing init to halt the system.
> 
true, and I'm not suggesting it's good to bail, but loading a stale 
policy is a concern.

> 
>>I'm not exactly sure how to handle this situation but this scenerio 
>>seems undesirable.
> 
> 
> You've previously suggested having init/load_policy automatically
> downgrade the binary policy image to the kernel's version (via
> libsepol), but I had some concerns with that idea at the time.  I
> suppose it could be looked at again.  Having libsemanage generate
> multiple binary policies (as has been done in Fedora during transition
> periods between kernels) doesn't seem to generalize well and would be
> costly.
> 

Alternatively if an appropriate binary cannot be found one can be 
expanded from the linked policy in the module store. This would give a 
(hopefully) lossless and current binary policy. It would make startup 
slower in the case that a policy can't be found but seems better than 
loading a stale policy or none at all.

This follows on the theme of not mangling the binary image once it gets 
to load_policy/init, which I think is important. If semanage is managing 
the policy this should be included in that.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
