Date: Fri, 25 Jan 2002 09:22:12 -0800
From: Paul Krumviede <pwk@acm.org>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tislabs.com>
Subject: Re: network and module problems
Message-ID: <86648203.1011950532@localhost>
In-Reply-To: <1011976523.2215.4.camel@phobos>
References: <1011976523.2215.4.camel@phobos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Friday, 25 January, 2002 11:35 -0500 Timothy Wood 
<timothy@hallcomp.com> wrote:

> On Fri, 2002-01-25 at 10:03, Paul Krumviede wrote:
>> --On Friday, 25 January, 2002 09:36 -0500 Timothy Wood
>> <timothy@hallcomp.com> wrote:
>>
>> are you running this inside a VMware virtual machine? i had to create
>> a policy file for that environment (which is yet to be tested with the
>> latest release; i'll send it to the list once that happens). the VMware
>> dualconf script instantiates /etc/modules.conf (and some other
>> files for X11) as a symlink to the appropriate "real" file depending
>> on whether one boots the guest OS as a virtual machine or on the
>> real hardware.
>>
>> -paul
>
> Yes, I am running it in a VM.  I just looked at the context of the
> modules files in /etc and noticed they were different, probably because
> I installed the VMware tools after I relabled the files.

the VMware dualconf init script creates symlinks during the bootup,
so until i (or someone else) puts it into its own domain, the symlinks
get labelled with the etc_runtime_t type. this will happen every time
at boot; relabeling by running setfiles doesn't seem like a good solution.
installing the VMware tools creates /etc/modules.conf.{vm, org} and
these should be labelled with the modules_conf_t type.

> I did a make
> relabel and I can insmod things now but the lo and eth0 interfaces still
> never raise.  What I still don't see is how the lo interface never loads
> because as far as I know the lo interface doesn't have a module.  I'm
> sifting through dmesg once again, a little more closely this time, and
> I"m seeing a lot of wierd things.  Someone tell me if all this looks
> right.
>
> (right after journalled loads)
> kernel: There is already a security framework initialized,
> register_security failed.
> kernel: Failure registering capabilities with the kernel
> kernel: selinux_register_security:  Registering secondary module
> capability
> localhost kernel: Capability LSM initialized

i see this on correctly running systems... but i have wondered about
the failure message.

> kernel: pcnet32_probe_pci: found device 0x001022.0x002000
> kernel: PCI: Enabling device 00:11.0 (0001 -> 0003)
> kernel: PCI: Assigned IRQ 10 for device 00:11.0
> keytable: Loading system font: succeeded
> kernel: ioaddr=0x001080 resource_flags=0x000101
> kernel: eth0: PCnet/PCI II 79C970A at 0x1080, 00 50 56 4a 80 ad
> kernel: pcnet32: pcnet32_private lp=c1151000 lp_dma_addr=0x1151000
> assigned IRQ 10
> kernel: pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de

looks normal.

> kernel: task_precondition:  assigning context system_u:system_r:kernel_t
> to pid 1 exe=none
> kernel: task_precondition:  assigning context system_u:system_r:kernel_t
> to pid 1 exe=none

looks normal.

> kernel: avc:  denied  { read } for  pid=74 exe=/sbin/insmod
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:insmod_t
> tcontext=system_u:object_r:modules_conf_t tclass=lnk_file

this is what i would expect to see as one reboots a virtual
machine after relabelling (dualconf hasn't run yet, so the
symbolic link hasn't been newly created and thus has the
previous label).

> kernel:
> kernel: avc:  denied  { read } for  pid=108 exe=/sbin/depmod
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:depmod_t
> tcontext=system_u:object_r:modules_conf_t tclass=lnk_file
> kernel:
> kernel: avc:  denied  { read } for  pid=110 exe=/bin/grep
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:modules_conf_t tclass=lnk_file

and all of these are, i think, artifacts of the VMware dualconf
construct.

> kernel: task_precondition:  assigning context system_u:system_r:init_t
> to pid 2 exe=none
> kernel: task_precondition:  assigning context system_u:system_r:kernel_t
> to pid 3 exe=none
> kernel: task_precondition:  assigning context system_u:system_r:kernel_t
> to pid 4 exe=none
> kernel: task_precondition:  assigning context system_u:system_r:kernel_t
> to pid 5 exe=none
> kernel: task_precondition:  assigning context system_u:system_r:kernel_t
> to pid 6 exe=none
> kernel: task_precondition:  assigning context system_u:system_r:init_t
> to pid 7 exe=none

these look normal.

> kernel: avc:  denied  { read } for  pid=220 exe=/usr/sbin/updfstab
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:fsadm_t
> tcontext=system_u:object_r:modules_conf_t tclass=lnk_file

> kernel: avc:  denied  { read } for  pid=220 exe=/usr/sbin/updfstab
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:fsadm_t
> tcontext=system_u:object_r:modules_conf_t tclass=lnk_file

> kernel: avc:  denied  { unlink } for  pid=251 exe=/bin/rm
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:modules_conf_t tclass=lnk_file

> kernel: avc:  denied  { unlink } for  pid=253 exe=/bin/rm
> path=/etc/X11/X dev=08:01 ino=102038 scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:etc_t tclass=lnk_file

more artifacts of VMware...

> kernel: avc:  denied  { read } for  pid=268 exe=/sbin/insmod
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:kmod_t
> tcontext=system_u:object_r:etc_runtime_t tclass=lnk_file

the dualconf script has run, so /etc/modules.conf was
created anew, and thus has the etc_runtime_t type. this
and the following message are thus also VMware related.

> kernel: avc:  denied  { read } for  pid=329 exe=/sbin/insmod
> path=/etc/modules.conf dev=08:01 ino=213709
> scontext=system_u:system_r:insmod_t
> tcontext=system_u:object_r:etc_runtime_t tclass=lnk_file

> network: Setting network parameters:  succeeded
> ifup: Cannot send dump request: Connection refused

> now I tried doing a tail -f on /var/log/messages and then switching to
> another VT to raise both the lo and eth0 interfaces and nothing was
> logged but I still get that dump request refused message.  Could the
> selinux be blocking the device from being opened or something?

not if you are running in permissive mode.

> I'm going to download this new version, but should I just get the patch
> and apply it to the current version I have or what?

i'd suggest getting a working kernel with your current selinux
version. if all else fails, i can probably send you a .config file
from a running redhat 7.2 system that does run in a VMware
virtual machine.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
