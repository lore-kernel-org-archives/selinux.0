Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7C9w1Xp032161
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 05:58:02 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7C9w0FJ025325
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 09:58:01 GMT
Date: Tue, 12 Aug 2008 19:57:19 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Russell Coker <russell@coker.com.au>
cc: Casey Schaufler <casey@schaufler-ca.com>, libvir-list@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based
 virtualization
In-Reply-To: <200808121557.50355.russell@coker.com.au>
Message-ID: <alpine.LRH.1.10.0808121906120.13656@tundra.namei.org>
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <489FC2F9.7090905@schaufler-ca.com> <alpine.LRH.1.10.0808111824290.5543@tundra.namei.org> <200808121557.50355.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Aug 2008, Russell Coker wrote:

> having different labels for processes and files so that if someone cracks the 
> UML kernel then they end up with just a regular user access on the Linux 
> host.  Which of course they could then try to crack with any of the usual 
> local-root exploits.
> 
> For separation based on Xen if someone cracks the hypervisor then you lose 
> everything.
> 
> For KVM (which seems to be the future of Linux virtualisation) I don't know 
> enough to comment.

KVM uses a modified version of Qemu where guests run as Linux processes.

There are some useful documents here:
http://kvm.qumranet.com/kvmwiki/Documents

(The OLS paper especially).


> So by "Linux-based" you mean in contrast to Xen which has the Xen kernel (not 
> Linux) running on the hardware?

Yes.

> > I don't understand what needs to be backed here.  Currently, MAC is not
> > used to separate different Linux-based VMs, and by integrating MAC
> > support, people will be able to further utilize MAC.
> 
> One thing that should be noted is the labelled network benefits.  If you had 
> several groups of virtual servers running at different levels and wanted to 
> prevent information leaks then having SE Linux contexts and labelled 
> networking could make things a little easier.
> 
> I have had some real challenges in managing firewall rules for Xen servers.  
> My general practice is to try and make sure that there is no real need for 
> firewalls between hosts on the same hardware (not that I want it this way - 
> it's what technical and management issues force me to).
> 
> So for example if I have an ISP Xen server running virtual machines for a 
> number of organisations I make sure that they are either all within a similar 
> trust boundary (IE affiliated groups) or all mutually untrusting (IE other IP 
> addresses in the same net-block are treated the same as random hosts on the 
> net).

Thanks for the insights -- we expect to address the virtual networking 
aspect in some way.

> The issue is whether the hypervisor you care about can be broken out of in 
> that way.  It seems that if someone can break out of Xen then you just lose.  
> For KVM I don't know the situation, do you have a good reference for how it 
> works?
> 
> http://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine
> 
> The above web page says that KVM is all based in the kernel, in which case why 
> would it be any more resilient than Xen?

KVM uses a kernel module to utilize the virt hardware (which Qemu 
interfaces with via /dev/kvm), but the guest runs in a userspace process.

I'm not comparing which is more resilient.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
