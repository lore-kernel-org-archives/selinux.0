Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOGxwIi021165
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 11:59:58 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOGwNgi028122
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 16:58:27 GMT
Date: Wed, 24 Nov 2004 17:10:24 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: xen 2.0 - adding selinux permissions
Message-ID: <20041124171024.GD14100@lkcl.net>
References: <20041123220352.GF5146@lkcl.net> <1101303556.22014.56.camel@moss-spartans.epoch.ncsc.mil> <20041124150927.GP5146@lkcl.net> <1101308769.22014.136.camel@moss-spartans.epoch.ncsc.mil> <20041124154936.GB14100@lkcl.net> <1101311675.22014.165.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1101311675.22014.165.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 24, 2004 at 10:54:35AM -0500, Stephen Smalley wrote:
> On Wed, 2004-11-24 at 10:49, Luke Kenneth Casson Leighton wrote:
> >  okay, regarding the second argument to avc_has_perm(),
> >  i asked the nice xen developers if it'd be possible to
> >  associate a sid with each virtual machine.
> > 
> >  i mean, if nothing else, it's a matter of grabbing the
> >  number (id) of the xen machine being contacted and faking up
> >  a sid - sprintf(sid, "xen_vm_%d_t", xen_id);
> > 
> >  which is pretty yuk.
> > 
> >  how would i go about _not_ hacking something like that up?
> > 
> >  how would it be possible for the xen master machine to create
> >  a sid per xen machine?  xen_vm_0_t, xen_vm_1_t etc.
> 
> I'm not clear on how you intend to use these distinct security contexts
> (and let's not confuse them with SIDs), particularly for the management
> interface.  You are applying a check as to whether a given process on
> the master can perform a given control operation; in what case would you
> need to distinguish on a per-VM basis?
 
  example:

 a certain user is allowed to shut down and restart the virtual
 machine which is running the SQL server.

 but they most certainly must NOT be allowed to shut down
 the xen master machine, because if they did that, _all_ of the
 virtual machines would be shut down as well.

 another user is allowed access to the console of oh i dunno,
 a virtual machine running a curses-based sales / invoicing
 system (which incidentally accesses the SQL server of another
 virtual machine, above).


> Now, if you want to control interactions among the VMs or access by a VM
> to a resource, that is another matter, 

 yes, i would envisage that being an option - at some later date.

> but I'm not clear that is going
> to be visible to SELinux at all.  

 ?

> IIUC, with NetTop/VMWare, there was a
> process on the host OS for each VM and the host OS was used for access
> to files, devices, etc, so SELinux on the host could associate a
> different domain with each of those processes and control their access
> to files, devices, etc.  But I don't think the situation is the same
> with Xen.

 the way that xen works, shared memory is used as an inter-vm
 communication mechanism, where xen is running in x86 ring
 0, and it arbitrates / manages that communication.
 
 btw everything else (all guest OSes) run in x86 ring 1
 (or 2 or 3 if the guest OS is so inclined).

 there is no locking on that shared memory, such that it becomes
 necessary to have a single application running on one of the VMs (and
 the xen developers have naturally chosen the first xen domain to do
 that) and that application, called xend, manages the locking.

 so i think i am right in saying that it would be necessary
 for each guest OS to enforce the access to that shared
 memory section.

 which is one of the reasons why it is very necessary to let selinux
 have a say in what is allowed to start up new xen guest OSes.
 
 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
