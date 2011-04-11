Subject: Re: SELinux mixed/virtualisation policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <4DA1E50F.4060506@linux.vnet.ibm.com>
References: <4DA1E50F.4060506@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Apr 2011 09:40:25 -0400
Message-ID: <1302529225.7338.32.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2011-04-10 at 14:12 -0300, Ramon de Carvalho Valle wrote:
> However, I and Dan Walsh (who kindly informed me about libvirt) both
> agree that dynamic labeling is more secure than manual labeling using
> MLS policy, for virtual machine environments.

Can you elaborate on what your concern is there?  If it is merely that
two VMs at the same level are not isolated via the MLS policy, then that
isn't a MLS concern, and you could use TE instead to isolate the VMs of
the same level.

> SELinux mixed policy
> 
> The SELinux mixed policy can have non hierarchical sensitivities that
> have the same behavior of a categorized only environment. Such
> sensitivities should not be included in the default sensitivity
> hierarchy (i.e. s0 to s15). Thus, all rules for these sensitivities
> should be explicitly stated. This allows creating a unique sensitivity
> for virtual machine environments that is not part of the default
> sensitivity hierarchy.

If I understand you correctly, this would require a fundamental change
to the kernel security server and to the policy toolchain.  You would be
changing the SELinux security model, not just tuning the configuration.

> In a non virtualised environment, one physical computer can not dominate
> and/or communicate with a process of another physical computer without
> any sort of well defined communication protocol, which can not infer a
> hierarchy between physical objects and logical objects. Thus, a physical
> computer can not dominate a process of another physical computer (i.e. a
> guest -a process representing a virtual machine- should never dominate a
> process of the host), something that is actually possible in the
> currently available policies.

Technically you can ensure that the qemu processes on the host are
"incomparable" to other host processes either by:
1) Using distinct types in the TE policy so that only very limited
interactions are possible (this is already the case with libvirt/KVM as
I understand it), or
2) Dedicating one category to all host processes and another category to
all qemu processes such that they are always incomparable in the MLS
policy.

That doesn't require a change to the SELinux model, the policy
toolchain, or the kernel security server.

> The main goal of having non hierarchical sensitivities available, or, at
> a minimum, a sensitivity optionally available for use by the virtual
> environment (i.e. sv -which does not belongs to the default hierarchy-),
> is to better represent a physical environment where a physical computer
> (usually) can not be automatically subjected to another physical
> computer that has been compromised.

But in the virtualized environment, a compromise of the qemu process can
in fact lead to compromise of other qemu processes or the host.  And the
security context is for the qemu process, not for the "virtual machine"
per se, where the qemu process is in fact a host OS
subject/abstraction.  

> Host processes (in a non virtualised environment, a process)
> s0-s15:c0-c255
> 
> Host processes representing virtual machines (in a non virtualised
> environment, a physical computer)
> sv0-sv15:c0-c255

If you want to guarantee incomparable labels in the MLS policy, then I
think you can achieve that through clever use of categories, as
described above.  But I think it is simpler to achieve it through the
use of TE types, and largely already done for you.

> The communication between them should be explicitly stated, as they are
> two different types of object in a non virtualised environment (and the
> communication between them only would occur when explicitly stated).

That's largely already the case via the TE policy unless I misunderstand
you.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
