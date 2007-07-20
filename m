Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KLtRwN029563
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 17:55:27 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6KLtRKP029467
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 21:55:27 GMT
Received: by py-out-1112.google.com with SMTP id d32so2241462pye
        for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 14:55:27 -0700 (PDT)
Message-ID: <25a1d91b0707201455i5e28d7a3lebeba025a2b8d1cf@mail.gmail.com>
Date: Fri, 20 Jul 2007 17:55:26 -0400
From: "David Windsor" <dwindsor@gmail.com>
To: "Anthony Liguori" <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [RFC][PATCH 00/01]qemu VM entrypoints
Cc: "David Windsor" <dwindsor@tresys.com>,
        kvm-devel <kvm-devel@lists.sourceforge.net>,
        "Joshua Brindle" <jbrindle@tresys.com>,
        selinux <selinux@tycho.nsa.gov>, qemu-devel <qemu-devel@nongnu.org>
In-Reply-To: <46A1151F.7020502@codemonkey.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <C2C68600.366D%dwindsor@tresys.com>
	 <46A1151F.7020502@codemonkey.ws>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/20/07, Anthony Liguori <anthony@codemonkey.ws> wrote:
> David Windsor wrote:
> > Hi,
> >
> > After a bit more discussion about integrating SELinux and KVM, it seems that
> > there is little interest in adding enforcement hooks to KVM as it stands.
> > Once KVM gets some type of inter-vm communication mechanism, MAC hooks will
> > probably be added in that space.
> >
>
> First, a patch like this has to go to qemu-devel.
>
Understood.  This patch started out as a patch to KVM, but eventually
found its way into userspace/qemu.

> > Until then, there seems to be interest in adding MAC controls to control VM
> > management operations, such as migrating VMs, or saving/resuming VMs.
> >
>
> Why is this interesting?  Is it common to modify applications like this
> to have additional selinux hooks?  Can you give examples?
>
This is interesting because currently there are only DAC controls on
the loading of virtual hard disks into a qemu virtual machine.
Further, this patch proposes additional SELinux functionality for
transitioning the qemu process into the correct TE domain prior to
launching the VM.

The use case this patch addresses is that of an administrator wanting
to use KVM/qemu on a server to provide services for subnets of
computers.  It is important here to ensure that if the server is
compromised, a qemu process on this compromised server can only use
virtual disks permitted by policy, otherwise entire subnets of
computers could be exposed to rogue VMs.

If the qemu process attempting to load the virutal disk does not
possess the file:read permission on the virtual disk file, access will
be denied right there.  However, if the process can read the disk
file, this patch proposes an additional control to see if the virtual
disk can be used as an entrypoint to the new, target domain.  If the
vm:entrypoint permission is granted by policy, the qemu process would
transition to the new domain.

As it stands, this patch does not perform any transitions upon loading
a virtual disk.  I think that a transition based on the label of the
requesting process and the label of the virtual disk is appropriate
here.  Does anyone else have any thoughts about this?

> What makes QEMU/KVM special such that it requires userspace selinux hooks?
>
qemu itself is special in that it is a userspace backend that is
widely used with KVM, and the SELinux functionality proposed by this
patch is significant.  Hopefully this answers your question
adequately.

> Regards,
>
> Anthony Liguori
>
> > One particular aspect of VM management which may be nice to control via
> > SELinux is the loading of a virtual hard disk into a VM.  Currently,
> > administrators would have to rely on file permissions to control which files
> > could be used as a virtual hard disks.  The semantics of file permissions do
> > not accomplish what is needed here.  A domain needs to explicitly get
> > permission from the policy to both use a file as a virtual disk and to use
> > the contents of that virtual disk as an "entrypoint" to the new, virtual
> > machine of a different integrity level.
> >
> > Since there is no SELinux permission for this, I have created the vm {
> > entrypoint } object class/permission pair to represent this type of access.
> > Policy for allowing domain user_t to load a virtual disk of type
> > qemu_virtdisk_t would look something like:
> >
> > allow user_t qemu_virtdisk_t:file r_file_perms;
> > type_change user_t qemu_virtdisk_t:vm vm_user_t;
> > allow qemu_virtdisk_t user_vm_t:vm entrypoint;
> >
> > Please note that this patch will only check the entrypoint permission, and
> > does not actually facilitate transitioning on the type of the virtual disk.
> > I want some comments before continuing with this approach.
> >
> > When loading a virtual disk into a VM, qemu would consult the policy to see
> > essentially three things: if the current process is allowed to read the
> > virtual disk file, what the type of the VM should be after loading the disk,
> > and if the virtual disk is in fact allowed to serve as an entrypoint to the
> > target domain.
> >
> > One problem with this approach is that loading a VM is not an exec-based
> > operation.  Dynamic transitions could be used, but could possibly be avoided
> > by altering the patch to fork, then re-exec in the target domain.
> >
> > This patch applies cleanly to kvm-userspace trunk.
> >
> > Thoughts?
> >
> >
> > -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2005.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > _______________________________________________
> > kvm-devel mailing list
> > kvm-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/kvm-devel
> >
> >
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
