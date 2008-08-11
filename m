Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7B4fgwc025222
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 00:41:42 -0400
Received: from smtp103.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7B4ffcY019005
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 04:41:41 GMT
Message-ID: <489FC2F9.7090905@schaufler-ca.com>
Date: Sun, 10 Aug 2008 21:41:29 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: libvir-list@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based virtualization
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> This is to announce the formation of the sVirt project, which aims to 
> integrate SELinux and Linux-based virtualization (KVM et al).
>
> The idea has been discussed a few times over the last year or so, and in 
> recent weeks, a few Fedora folk (such as Dan Walsh, Daniel Berrange and 
> myself) have put together some requirements and had some preliminary 
> technical discussions.
>
> The requirements document and initital technical considerations are 
> included below inline for review and discussion.
>
> In a nutshell, we'd like to be able to apply distinct security labels to 
> individual VM instances and their resources, so that they can be isolated 
> from each other via MAC policy.  We want this to "just work" when 
> configuring and managing VMs via the libvirt toolchain, e.g. provide a 
> simple option during VM creation to make the VM "isolated", and have the 
> toolchain do all the labeling and policy configuration behind the scenes. 
> Greater detail may be found in the requirements document.
>
> If you wish to contribute, please reply to this email with any 
> enhancements to the requirements, technical ideas, issues etc.  I'd 
> suggest joining the libvir-list (in the to: line) if not already on it, as 
> that is where the integration work is expected to happen.
>
> There's also a wiki page:
> http://selinuxproject.org/page/SVirt
>
>
> ------------------------------------------------------------------------
>
>                                                             11 Aug 2008
>
>     sVirt: Integration of SELinux and Linux-based Virtualization
>        
>            Requirements and Design Considerations v1.0
>
>
> 1.  Introduction
>
>     This document establishes a set of functional and technical
>     requirements for integrating SELinux with Linux-based
>     virtualization (i.e. Linux-as-hypervisor schemes such as KVM/Qemu
>     amd lguest).
>     
>     Note that non-Linux hypervisor models such as Xen are not covered
>     explicitly in this document, although may be afforded some MAC
>     coverage due to shared infrastructure (e.g. libvirt).  Non-Linux
>     hypervisor models may considered further at a later stage.
>     
>     Also, while this document focuses on SELinux as the MAC scheme,
>     consideration should be given to ensuring support for other
>     label-based MAC schemes.
>
>
> 1.1  Rationale
>
>     With increased use of virtualization, one security benefit of
>     physically separated systems -- strong isolation -- is reduced,

This issue can always be readily resolved by going back to physically
separated hardware. The strength of isolation of a virtual machine
mechanism is one of the important characteristics that should be
considered when it is chosen over a hardware isolation scheme, but
the systems available today appear to do a pretty good job on this,
so I would like to see some evidence of this claim before accepting
it as a primary premise.

>  an
>     issue which may be ameliorated with the application of Mandatory
>     Access Control (MAC) security in the host system.    
>   

Ok. I've been using VMs for 30 years and MAC for 20, and to my mind
the only way this statement can possibly be true is if both the MAC
system and the VM system are inadequate to their respective tasks.


>     Integration of MAC with virtualization will also help increase the
>     overall robustness and security assurance of both host and guest
>     systems.  Many threats arising from flaws in the VM environment, or
>     misconfiguration, may be mitigated through tighter isolation and
>     specific MAC policy enforcement.
>   

You are not going to solve any problems of misconfiguration this way,
you are just going to make the environment more complicated and prone
to misconfiguration.

>     
>     By incorporating MAC support into the virtualization toolchain and
>     documentation, users will also be able to make more use of the MAC
>     security capabilities provided by the OS.
>   

Would you back this assertion? VMs seem no better a vehicle for MAC
integration than user sessions in any way that I can see.

>
> 1.2  Use-cases
>
>     The following use-cases have been identified:
>     
>       o Providing virtualized services with a level of isolation
>         similar to that previously afforded by physical separation.
>   

As I mentioned before, this doesn't seem to make any sense. I can
see the value in running a MAC system under a VM in limited cases,
but the other way around does not seem particularly rational.

>       o Increased protection of the host from untrusted VM guests (e.g.
>         for VM hosting providers, grid/cloud servers etc.).
>   

I can see where someone who is not familiar with VMs might think
this is plausible, but looking at the interfaces and separation provided
by VMs makes it pretty clear that this isn't even a belts and braces
level of extra protection.

>       o Increased protection of VM guests from each other in the event
>         of host flaws or misconfiguration.  Some protection may also be
>         provided against a compromised host.
>         
>   

Flaws and misconfiguration will not be helped by this.

>       o Consolidating access to multiple networks which require strong
>         isolation from each other (e.g. military, government, corporate
>         extranets, internal "Chinese wall" separation etc.)
>   

The VMs provide this. Isolation is easy. Sharing is what's hard.

>       o Strongly isolating desktop applications by running them in
>         separately labeled VMs (e.g. online banking in one VM and World
>         of Warcraft in another; opening untrusted office documents in
>         an isolated VM for view/print only).
>         
>   

And how does a MAC environment help this when we still barely have
SELinux X11 limping along?

>       o Forensic analysis of disk images, binaries, browser scripts
>         etc. in a highly isolated VM, protecting both the host system
>         and the integrity of the components under analysis.
>   

You're just restating "stronger isolation".

>       o Isolated test environments, preventing e.g. simulated trades
>         from entering a production system, leakage of sensitive
>         customer data to internal networks etc.
>
>   

You're just restating "stronger isolation".

>       o General ability to specify a wide range of high-level security
>         goals for virtualization through flexible MAC policy.
>   

What does that mean in this context? How is it useful? Usually
by the time someone decides that they need to use physical separation
or that they can simulate it with VMs they've already decided that
fancy software schemes like MAC are insufficient, and that's often
because the MAC system (SELinux or B&L) is too hard to set up for
their uses.

>  
>
> 2. Current Situation
>
>     SELinux is already able to provide general MAC protection to
>     Linux-based virtualization, such as protecting the integrity and
>     confidentiality of disk images and providing strong isolation of
>     Linux hypervisor processes from the rest of the system.
>     
>     There is, however, no explicit support for Linux-based
>     virtualization in SELinux, and all VMs currently run in the same
>     security context.  Thus, there is no MAC isolation applied between
>     VMs.
>
>   

You can run them with different MLS values, can't you?

> 3. Functional Security Requirements
>
>     3.1  Strong isolation between active VMs
>     
>     Running different VMs with different MAC labels allows stronger
>     isolation between VMs, reducing risks arising from flaws in or
>     misconfiguration of the VM environment.  For example, the threat of
>     a rogue VM exploiting a flaw in KVM could be greatly reduced if it
>     is isolated from other VMs by MAC security policy.
>   

You can run them with different MLS values, can't you?

>
>     3.2  Improved control over access to VM resources
>   

....

OK, I get the picture. You really want to run VMs under SELinux.
Go wild, but I think you are significantly overstating the value
and creating a project where a a little bit of policy work ought
to handle all but the most extreme cases.

DAC, MAC, Containers, VMs, and separate hardware are all mechanisms
for providing (in ascending order) measures of isolation. It makes
sense to tighten a DAC system by adding MAC, or running a MAC system
under a VM, but to each the sort of isolation it is good at.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
