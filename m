Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7C5w2Bb015730
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 01:58:02 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7C5vk9N009541
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 05:57:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@namei.org>
Subject: Re: [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based virtualization
Date: Tue, 12 Aug 2008 15:57:46 +1000
Cc: Casey Schaufler <casey@schaufler-ca.com>, libvir-list@redhat.com,
        selinux@tycho.nsa.gov
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <489FC2F9.7090905@schaufler-ca.com> <alpine.LRH.1.10.0808111824290.5543@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808111824290.5543@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Message-Id: <200808121557.50355.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 11 August 2008 19:31, James Morris <jmorris@namei.org> wrote:
> I suspect you misunderstood an important aspect of this in that we are
> targeting Linux-based virtualization, where the VMs are running inside
> Linux processes.  In this case, the isolation depends on DAC in the host,
> and the idea behind sVirt is to apply MAC security to these VMs and their
> resources.
>
> Currently, all such VMs run with the same security label, and all of the
> resources accessed (e.g. disk images) have the same labels.

http://en.wikipedia.org/wiki/NetTop

So it's basically a free implementation of NetTop?

> > >  an
> > >     issue which may be ameliorated with the application of Mandatory
> > >     Access Control (MAC) security in the host system.
> >
> > Ok. I've been using VMs for 30 years and MAC for 20, and to my mind
> > the only way this statement can possibly be true is if both the MAC
> > system and the VM system are inadequate to their respective tasks.
>
> I'm not sure how you come to the conclusion that the MAC system must be
> inadequate, but this scheme does attempt to improve the robustness of
> isolation between Linux-based VMs.

I think that Casey's idea is that if someone breaks the VM separation then you 
lose it all.  For separation based on UML there are obvious benefits to 
having different labels for processes and files so that if someone cracks the 
UML kernel then they end up with just a regular user access on the Linux 
host.  Which of course they could then try to crack with any of the usual 
local-root exploits.

For separation based on Xen if someone cracks the hypervisor then you lose 
everything.

For KVM (which seems to be the future of Linux virtualisation) I don't know 
enough to comment.

> We're applying the idea of containing applications in the face of
> potential flaws and misconfiguration to the case of applications which
> happen to be VMs.  In this sense, it is not different to containing any
> other form of application (e.g. a flaw in the VM might be exploited by
> malicious code).

VMWare has it's own device drivers.  Surely someone who wanted to attack a 
VMWare based system would go for the drivers which have the ability to 
override any other protection mechanisms.

But I think that constraining the user-space code (as done in NetTop) does 
provide significant benefits.

> Again, keep in mind that we're talking about Linux-based virtualization,
> where the VM is literally just another application running in the host OS.

So by "Linux-based" you mean in contrast to Xen which has the Xen kernel (not 
Linux) running on the hardware?

> I don't understand what needs to be backed here.  Currently, MAC is not
> used to separate different Linux-based VMs, and by integrating MAC
> support, people will be able to further utilize MAC.

One thing that should be noted is the labelled network benefits.  If you had 
several groups of virtual servers running at different levels and wanted to 
prevent information leaks then having SE Linux contexts and labelled 
networking could make things a little easier.

I have had some real challenges in managing firewall rules for Xen servers.  
My general practice is to try and make sure that there is no real need for 
firewalls between hosts on the same hardware (not that I want it this way - 
it's what technical and management issues force me to).

So for example if I have an ISP Xen server running virtual machines for a 
number of organisations I make sure that they are either all within a similar 
trust boundary (IE affiliated groups) or all mutually untrusting (IE other IP 
addresses in the same net-block are treated the same as random hosts on the 
net).

> > >       o Increased protection of the host from untrusted VM guests (e.g.
> > >         for VM hosting providers, grid/cloud servers etc.).
> >
> > I can see where someone who is not familiar with VMs might think
> > this is plausible, but looking at the interfaces and separation provided
> > by VMs makes it pretty clear that this isn't even a belts and braces
> > level of extra protection.
>
> I disagree.
>
> VMs are software, and all software has bugs.  If you can break out of the
> VM in Linux-based virtualization, you can probably get to all of the other
> VMs on the system (they are running in the same DAC and MAC contexts).
>
> Applying distinct labels allows MAC policy to be enforced by the host
> kernel so that such breaches are contained within the isolated host VM
> process.
>
> Or are you saying that you don't think hypervisors can be broken out of ?

The issue is whether the hypervisor you care about can be broken out of in 
that way.  It seems that if someone can break out of Xen then you just lose.  
For KVM I don't know the situation, do you have a good reference for how it 
works?

http://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine

The above web page says that KVM is all based in the kernel, in which case why 
would it be any more resilient than Xen?

> > >       o Consolidating access to multiple networks which require strong
> > >         isolation from each other (e.g. military, government, corporate
> > >         extranets, internal "Chinese wall" separation etc.)
> >
> > The VMs provide this. Isolation is easy. Sharing is what's hard.
>
> Again, it's important to understand that these VMs are merely Linux
> processes and are only currently afforded the same level of isolation as
> standard DAC.

How does the "VMs are merely Linux processes" fit with the description of KVM?  
Or are you talking about some other virtualisation system?

My virtualisation experience of recent times has only been Xen sys-admin.

> > >       o Forensic analysis of disk images, binaries, browser scripts
> > >         etc. in a highly isolated VM, protecting both the host system
> > >         and the integrity of the components under analysis.
> >
> > You're just restating "stronger isolation".
>
> Yes, but these are use-cases.   They are condensed into requirements
> further on.

Are there any tools that do forensics in a sensible way?

Some time ago in a conversation with someone who uses forensics tools 
professionally I was shocked to discover that his tools didn't even do 
anything basic like storing SHA hashes of all the data.  It seems to me that 
if the state of the art doesn't even use cryptographically secure hashes to 
preserve the trail of evidence then we can probably forget about any of the 
advanced stuff.

> > OK, I get the picture. You really want to run VMs under SELinux.
> > Go wild, but I think you are significantly overstating the value
> > and creating a project where a a little bit of policy work ought
> > to handle all but the most extreme cases.
>
> The proof of concept code is indeed simple policy/labeling changes,
> although we want to ensure that we fully understand the requirements, and
> implement a flexible and generally useful scheme.

http://www.nsa.gov/seLinux/list-archive/0409/thread_body53.cfm#8690

Actually we had proof of concept for some of this with VMWare almost four 
years ago.  If NetTop isn't enough of a proof of concept...

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
