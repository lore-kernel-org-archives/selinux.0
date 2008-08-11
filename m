Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7B9WcVL008647
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 05:32:38 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7B9WQHC010659
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 09:32:27 GMT
Date: Mon, 11 Aug 2008 19:31:46 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: libvir-list@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based
 virtualization
In-Reply-To: <489FC2F9.7090905@schaufler-ca.com>
Message-ID: <alpine.LRH.1.10.0808111824290.5543@tundra.namei.org>
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <489FC2F9.7090905@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 10 Aug 2008, Casey Schaufler wrote:

> > 1.1  Rationale
> > 
> >     With increased use of virtualization, one security benefit of
> >     physically separated systems -- strong isolation -- is reduced,
> 
> This issue can always be readily resolved by going back to physically
> separated hardware. The strength of isolation of a virtual machine
> mechanism is one of the important characteristics that should be
> considered when it is chosen over a hardware isolation scheme, but
> the systems available today appear to do a pretty good job on this,
> so I would like to see some evidence of this claim before accepting
> it as a primary premise.

I suspect you misunderstood an important aspect of this in that we are 
targeting Linux-based virtualization, where the VMs are running inside 
Linux processes.  In this case, the isolation depends on DAC in the host, 
and the idea behind sVirt is to apply MAC security to these VMs and their 
resources.

Currently, all such VMs run with the same security label, and all of the 
resources accessed (e.g. disk images) have the same labels.

We are simply proposing a mechanism to allow distinct security labels to 
be applied to these entities, which in the simplest case, will allow MAC 
policy to enforce isolation between them.

> 
> >  an
> >     issue which may be ameliorated with the application of Mandatory
> >     Access Control (MAC) security in the host system.      
> 
> Ok. I've been using VMs for 30 years and MAC for 20, and to my mind
> the only way this statement can possibly be true is if both the MAC
> system and the VM system are inadequate to their respective tasks.

I'm not sure how you come to the conclusion that the MAC system must be 
inadequate, but this scheme does attempt to improve the robustness of 
isolation between Linux-based VMs.

We're applying the idea of containing applications in the face of 
potential flaws and misconfiguration to the case of applications which 
happen to be VMs.  In this sense, it is not different to containing any 
other form of application (e.g. a flaw in the VM might be exploited by 
malicious code).

> >     Integration of MAC with virtualization will also help increase the
> >     overall robustness and security assurance of both host and guest
> >     systems.  Many threats arising from flaws in the VM environment, or
> >     misconfiguration, may be mitigated through tighter isolation and
> >     specific MAC policy enforcement.
> >   
> 
> You are not going to solve any problems of misconfiguration this way,
> you are just going to make the environment more complicated and prone
> to misconfiguration.

I don't think this is valid as an absolute statement.

e.g. by adding distinct labels to VMs and their resources at the toolchain 
level, the admin will not be involved beyond specifying that the VM is to 
be created as an "isolated" instance.  The VMs will simply be running with 
different labels and bound to their own resources with those labels, 
enforced by MAC policy.  If an admin manually launches a VM and 
accidentally specifies an incorrect disk image, MAC policy will prevent 
the VM from accessing the image.

There is nothing characteristically different between this and the general 
rationale for MAC in the OS, e.g. to ensure that a web server can only 
serve appropriately labeled content.

The risk that the MAC system itself could be misconfigured does not change 
with sVirt, although in the proposed scheme, VM labeling will be 
automated.

Again, keep in mind that we're talking about Linux-based virtualization, 
where the VM is literally just another application running in the host OS.


> 
> >         By incorporating MAC support into the virtualization toolchain 
> > and
> >     documentation, users will also be able to make more use of the MAC
> >     security capabilities provided by the OS.
> >   
> 
> Would you back this assertion? VMs seem no better a vehicle for MAC
> integration than user sessions in any way that I can see.

I don't understand what needs to be backed here.  Currently, MAC is not 
used to separate different Linux-based VMs, and by integrating MAC 
support, people will be able to further utilize MAC.

> > 
> > 1.2  Use-cases
> > 
> >     The following use-cases have been identified:
> >           o Providing virtualized services with a level of isolation
> >         similar to that previously afforded by physical separation.
> >   
> 
> As I mentioned before, this doesn't seem to make any sense. I can
> see the value in running a MAC system under a VM in limited cases,
> but the other way around does not seem particularly rational.

Please be specific: in what way is it not rational?

> 
> >       o Increased protection of the host from untrusted VM guests (e.g.
> >         for VM hosting providers, grid/cloud servers etc.).
> >   
> 
> I can see where someone who is not familiar with VMs might think
> this is plausible, but looking at the interfaces and separation provided
> by VMs makes it pretty clear that this isn't even a belts and braces
> level of extra protection.

I disagree.

VMs are software, and all software has bugs.  If you can break out of the 
VM in Linux-based virtualization, you can probably get to all of the other 
VMs on the system (they are running in the same DAC and MAC contexts).  

Applying distinct labels allows MAC policy to be enforced by the host 
kernel so that such breaches are contained within the isolated host VM 
process.

Or are you saying that you don't think hypervisors can be broken out of ?

> >       o Increased protection of VM guests from each other in the event
> >         of host flaws or misconfiguration.  Some protection may also be
> >         provided against a compromised host.
> >           
> 
> Flaws and misconfiguration will not be helped by this.

I don't see why not.  With MAC containment, if, say, a web server on the 
host was compromised, an attacker may be prevented from interfering with 
the VMs running on the system.  This is already true to some extent with 
coarse-grained MAC.

> 
> >       o Consolidating access to multiple networks which require strong
> >         isolation from each other (e.g. military, government, corporate
> >         extranets, internal "Chinese wall" separation etc.)
> >   
> 
> The VMs provide this. Isolation is easy. Sharing is what's hard.

Again, it's important to understand that these VMs are merely Linux 
processes and are only currently afforded the same level of isolation as 
standard DAC.

DAC is of course considered inadequate as a means to protect against a 
range of common threats including software flaws.

Please refer to:
http://www.nsa.gov/selinux/papers/inevitability/

(I know you know this, but not everyone reading this thread is familiar 
with the case for MAC).

> 
> >       o Strongly isolating desktop applications by running them in
> >         separately labeled VMs (e.g. online banking in one VM and World
> >         of Warcraft in another; opening untrusted office documents in
> >         an isolated VM for view/print only).
> >           
> 
> And how does a MAC environment help this when we still barely have
> SELinux X11 limping along?

When they progress to walking.

> 
> >       o Forensic analysis of disk images, binaries, browser scripts
> >         etc. in a highly isolated VM, protecting both the host system
> >         and the integrity of the components under analysis.
> >   
> 
> You're just restating "stronger isolation".

Yes, but these are use-cases.   They are condensed into requirements 
further on.


> >       o General ability to specify a wide range of high-level security
> >         goals for virtualization through flexible MAC policy.
> >   
> 
> What does that mean in this context? How is it useful?

It means going beyond simple isolation and specifying security goals which 
are then mapped to policy.  So, you can design a system in the security 
problem domain, rather, than say, the security model domain (e.g. BLP).  

Note that this is a logical extension of the system aimed at advanced 
users.  In the default case, VMs will simply be isolated from each other 
via MAC.

> Usually by the time someone decides that they need to use physical 
> separation or that they can simulate it with VMs they've already decided 
> that fancy software schemes like MAC are insufficient, and that's often 
> because the MAC system (SELinux or B&L) is too hard to set up for their 
> uses.

That's not my experience, but I guess anything can happen.

> >  
> > 2. Current Situation
> > 
> >     SELinux is already able to provide general MAC protection to
> >     Linux-based virtualization, such as protecting the integrity and
> >     confidentiality of disk images and providing strong isolation of
> >     Linux hypervisor processes from the rest of the system.
> >         There is, however, no explicit support for Linux-based
> >     virtualization in SELinux, and all VMs currently run in the same
> >     security context.  Thus, there is no MAC isolation applied between
> >     VMs.
> > 
> >   
> 
> You can run them with different MLS values, can't you?

There is no explicit support for doing this, and in fact, that is one of 
the things that sVirt will address.  In SELinux, an MLS label is simply 
part of the overall security context.


> OK, I get the picture. You really want to run VMs under SELinux.
> Go wild, but I think you are significantly overstating the value
> and creating a project where a a little bit of policy work ought
> to handle all but the most extreme cases.

The proof of concept code is indeed simple policy/labeling changes, 
although we want to ensure that we fully understand the requirements, and 
implement a flexible and generally useful scheme.

Support for this also needs to be built directly into the virt toolchain 
so that the user is provided with a complete solution, rather than a 
collection of pieces.

> DAC, MAC, Containers, VMs, and separate hardware are all mechanisms
> for providing (in ascending order) measures of isolation. It makes
> sense to tighten a DAC system by adding MAC, or running a MAC system
> under a VM, but to each the sort of isolation it is good at.

So, in the case of a Linux-based VM running as a process in a DAC context, 
we are indeed tightening a DAC system by adding MAC.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
