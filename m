Message-ID: <4305DFB1.60000@tresys.com>
Date: Fri, 19 Aug 2005 09:33:37 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Steve G <linux_4ever@yahoo.com>, SELinux-dev@tresys.com,
   James Morris <jmorris@namei.org>
Subject: Re: [RFC] Checking the loaded policy against a policy on disk
References: <1124454737.32663.27.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124454737.32663.27.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>Hi,
>
>For the LSPP work, it has been requested that we provide a way to
>perform a consistency check between the policy in memory and the policy
>on disk.  We could change the SELinux module to compute a checksum over
>the binary policy image when it is loaded and to export that checksum
>via a new selinuxfs node.  One complicating factor is that at
>present, /sbin/init and load_policy mutate the binary policy image in
>memory prior to loading it in order to customize the vendor-shipped
>policy with local boolean settings and user definitions, so the
>checksums would not match at present for the on-disk file and the
>in-memory image unless the verification tool applies the same transforms
>prior to computing the checksums.  Tresys has previously suggested
>shifting to a model where we regenerate the on-disk policy file for each
>change to any local setting, with the generated policy file to be loaded
>into the kernel stored separately from the policy file managed by rpm to
>avoid creating problems for updates, which would eliminate that problem
>altogether.
>
>  
>
I'd definitely prefer the latter. With policy modules, rpm should not 
even install a kernel binary. The policy rpm packages would contain the 
policy module for the respective package which would then be installed 
into the module store and consequently incorporated into the kernel 
policy. Unfortunatly, if LSPP has a strong requirement for which policy 
is running the module system becomes much less useful.

If something also needs to be done in the non-module case then we 
certainly need to take that into consideration when fixing the 
infrastructure to do modifications on disk, I am under the impression 
that semodule is going to be added into FC5 and some targets would be 
converted to modules, comments Dan?

Further, does LSPP disallow booleans? If not how will the checksum 
account for boolean state changes? (Or will it just ignore them, which 
sounds like a bad idea)

>Any comments on this request?  Any particular preference as to the
>particular checksum algorithm?  Does the algorithm need to be
>configurable?
>
>  
>
anything already included in cryptoapi would be free, right?

>A related idea would be to also extend the binary policy format to
>include a field for an arbitrary text string label that could be set
>when the policy is generated, and have the kernel save that string and
>export it via another new selinuxfs node.  This would allow an
>identifier string to be associated with the policy image, such as the
>policy package's name and version (e.g.
>selinux-policy-targeted-1.17.25-3), and extracted later by userspace to
>determine which particular policy the one in memory is supposed to
>match.  This wouldn't replace the need for the checksum, but would
>provide additional information that might be helpful to userspace.
>However, this change would require a change in binary policy format,
>unlike the first change.  
>
>  
>
I don't know how useful this is. Once the modules are in widespread use 
this name won't mean much, other than possibly the base policies name, 
which won't help much since any number of modules could be loaded on top 
of it. If information about the policy is needed it's probably better to 
ask the policy server or whathaveyou, since you'll have some fine 
grained query means.

>Any comments on this related idea?
>  
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
