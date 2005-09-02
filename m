Subject: Re: Policy devel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: godinezj@gmail.com, SELinux@tycho.nsa.gov
In-Reply-To: <1125669316.16388.56.camel@sgc.columbia.tresys.com>
References: <39e231050509011823c39f6a9@mail.gmail.com>
	 <1125669316.16388.56.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 10:02:55 -0400
Message-Id: <1125669775.21817.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-02 at 09:55 -0400, Christopher J. PeBenito wrote:
> On Thu, 2005-09-01 at 18:23 -0700, Javier Godinez wrote:
> > I am not sure is this is the place to ask policy development noobee
> > questions, but here is my problem.
> > 
> > The process:
> > 
> >   /usr/sbin/vmware-serverd
> > 
> > running in vmware_serverd_t spawns the processes:
> > 
> >   /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
> >   /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
> >   /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
> >   /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
> > 
> > in the vmware_serverd_t, is there a way of making vmware-vmx spawn
> > into another domain, but this other domain must be dependant on the
> > domain of the file that is passed to it (/vms/X/vm.vmx)?
> 
> You could do that by doing a setexeccon() in the program.  Of course,
> the catch is that since this is vmware, you can't change the code.  One
> chance (I'm not familiar with GSX) is if GSX uses a script to start up
> the VMs, then you could insert setexeccon (the command line tool) into
> the script when it starts the VMs.  That command line tool doesn't exist
> all distros, so you might need to get it out of the attic in sourceforce
> libselinux CVS.  In both cases you need some logic to figure out which
> context to use.  Then in the policy you need something like:
> 
> can_setexec(vmware_serverd_t)
> domain_trans(vmware_serverd_t,vmware_vm_exec_t,vmware_vm0_t)
> domain_trans(vmware_serverd_t,vmware_vm_exec_t,vmware_vm1_t)

Just to clarify, setexeccon(1) was removed because runcon(1) in
coreutils provides the same functionality with a richer interface.
The libselinux example utils were pruned to minimize such duplication,
and Red Hat further stripped what they install because several of those
utils are primarily debugging tools.  But runcon(1) should always be
available.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
