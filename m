Subject: Re: Policy devel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: godinezj@gmail.com
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <39e231050509011823c39f6a9@mail.gmail.com>
References: <39e231050509011823c39f6a9@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 09:55:16 -0400
Message-Id: <1125669316.16388.56.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-01 at 18:23 -0700, Javier Godinez wrote:
> I am not sure is this is the place to ask policy development noobee
> questions, but here is my problem.
> 
> The process:
> 
>   /usr/sbin/vmware-serverd
> 
> running in vmware_serverd_t spawns the processes:
> 
>   /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
>   /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
>   /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
>   /usr/lib/vmware/bin/vmware-vmx -C /vms/0/vm.vmx
> 
> in the vmware_serverd_t, is there a way of making vmware-vmx spawn
> into another domain, but this other domain must be dependant on the
> domain of the file that is passed to it (/vms/X/vm.vmx)?

You could do that by doing a setexeccon() in the program.  Of course,
the catch is that since this is vmware, you can't change the code.  One
chance (I'm not familiar with GSX) is if GSX uses a script to start up
the VMs, then you could insert setexeccon (the command line tool) into
the script when it starts the VMs.  That command line tool doesn't exist
all distros, so you might need to get it out of the attic in sourceforce
libselinux CVS.  In both cases you need some logic to figure out which
context to use.  Then in the policy you need something like:

can_setexec(vmware_serverd_t)
domain_trans(vmware_serverd_t,vmware_vm_exec_t,vmware_vm0_t)
domain_trans(vmware_serverd_t,vmware_vm_exec_t,vmware_vm1_t)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
