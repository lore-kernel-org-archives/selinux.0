Cc: SE Linux <selinux@tycho.nsa.gov>
Message-Id: <C7642DCA-49A3-4EF2-A989-FAFADA4A9FE1@nall.com>
From: Joe Nall <joe@nall.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1234364409.12067.109.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: mdadm failure in MLS Enforcing
Date: Wed, 11 Feb 2009 10:15:04 -0600
References: <F2BE7671-FBDA-4F31-AEE7-E75BDA1337D2@nall.com> <1234362362.12067.104.camel@localhost.localdomain> <BDF7BFC7-EC7D-41D5-8984-5BC2ABFD7D89@nall.com> <1234364409.12067.109.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 11, 2009, at 9:00 AM, Stephen Smalley wrote:

> On Wed, 2009-02-11 at 08:47 -0600, Joe Nall wrote:
>> On Feb 11, 2009, at 8:26 AM, Stephen Smalley wrote:
>>
>>> On Tue, 2009-02-10 at 22:17 -0600, Joe Nall wrote:
>>>> mdadm runs system_u:system_r:mdadm_t:s0-s15:c0.c1023 during boot  
>>>> and
>>>> can't access block devices that are
>>>> system_u:object_r:fixed_disk_device_t:s15:c0.c1023
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=485006
>>>>
>>>> Posted here instead of fedora-selinux because I don't think it is
>>>> fedora specific.
>>>>
>>>> Boot avcs:
>>>>
>>>> node=test type=AVC msg=audit(1234315341.183:18): avc:  denied
>>>> { read } for  pid=1501 comm="mdadm" name="sdb2" dev=tmpfs ino=508
>>>> scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023
>>>> tcontext=system_u:object_r:fixed_disk_device_t:s15:c0.c1023
>>>> tclass=blk_file
>>>>
>>>>        Was caused by:
>>>>                Policy constraint violation.
>>>>
>>>>                May require adding a type attribute to the domain or
>>>> type to satisfy the constraint.
>>>>
>>>>                Constraints are defined in the policy sources in
>>>> policy/constraints (general), policy/mcs (MCS), and policy/mls  
>>>> (MLS).
>>>>
>>>> node=test type=AVC msg=audit(1234315341.184:19): avc:  denied
>>>> { read } for  pid=1457 comm="mdadm" name=".tmp-9-1" dev=tmpfs
>>>> ino=5859
>>>> scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023
>>>> tcontext=system_u:object_r:device_t:s0 tclass=blk_file
>>>>
>>>>        Was caused by:
>>>>                Missing type enforcement (TE) allow rule.
>>>>
>>>>                You can use audit2allow to generate a loadable  
>>>> module
>>>> to allow this access.
>>>>
>>>> node=test type=AVC msg=audit(1234315341.188:20): avc:  denied
>>>> { getattr } for  pid=1457 comm="mdadm" path="/proc/kcore" dev=proc
>>>> ino=4026531986 scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023
>>>> tcontext=system_u:object_r:proc_kcore_t:s15:c0.c1023 tclass=file
>>>>
>>>>        Was caused by:
>>>>                Policy constraint violation.
>>>>
>>>>                May require adding a type attribute to the domain or
>>>> type to satisfy the constraint.
>>>>
>>>>                Constraints are defined in the policy sources in
>>>> policy/constraints (general), policy/mcs (MCS), and policy/mls  
>>>> (MLS).
>>>>
>>>> so I added this policy:
>>>>
>>>> diff -up serefpolicy-3.5.13/policy/modules/system/raid.fc.orig
>>>> serefpolicy-3.5.13/policy/modules/system/raid.fc
>>>> --- serefpolicy-3.5.13/policy/modules/system/raid.fc.orig	 
>>>> 2009-02-10
>>>> 19:41:17.000000000 -0600
>>>> +++ serefpolicy-3.5.13/policy/modules/system/raid.fc	2009-02-10
>>>> 19:41:31.000000000 -0600
>>>> @@ -2,4 +2,4 @@
>>>> /sbin/mdadm		--	gen_context(system_u:object_r:mdadm_exec_t,s0)
>>>> /sbin/mdmpd		--	gen_context(system_u:object_r:mdadm_exec_t,s0)
>>>>
>>>> -/var/run/mdadm(/.*)?		
>>>> gen_context(system_u:object_r:mdadm_var_run_t,s0)
>>>> +/var/run/mdadm(/.*)?		
>>>> gen_context(system_u:object_r:mdadm_var_run_t,mls_systemhigh)
>>>> diff -up serefpolicy-3.5.13/policy/modules/system/raid.te.orig
>>>> serefpolicy-3.5.13/policy/modules/system/raid.te
>>>> --- serefpolicy-3.5.13/policy/modules/system/raid.te.orig	 
>>>> 2009-02-10
>>>> 19:33:59.000000000 -0600
>>>> +++ serefpolicy-3.5.13/policy/modules/system/raid.te	2009-02-10
>>>> 19:39:58.000000000 -0600
>>>> @@ -9,6 +9,10 @@ policy_module(raid, 1.7.0)
>>>> type mdadm_t;
>>>> type mdadm_exec_t;
>>>> init_daemon_domain(mdadm_t,mdadm_exec_t)
>>>> +ifdef(`enable_mls',`
>>>> +	init_ranged_daemon_domain(mdadm_t, mdadm_exec_t,mls_systemhigh)
>>>> +')
>>>> +
>>>> role system_r types mdadm_t;
>>>>
>>>> type mdadm_var_run_t;
>>>>
>>>> which does transition to SystemHigh using run_init in permissive,  
>>>> but
>>>> doesn't affect this bug.
>>>>
>>>> Clues?
>>>
>>> I'm not sure what you mean by "doesn't affect this bug".  Did mdadm
>>> transition to systemhigh at boot or not?
>>
>> no
>>
>> That is why I went back and tried the run_init (which did transition)
>> and verified the /var/run/mdadm directory was SystemHigh. I also used
>> seinfo to verify that the patch had bend applied to the running
>> policy. Very confusing.
>
> - Does it transition if in permissive mode at boot?
no

> - Do you get any AVC or SELINUX_ERR messages at boot or upon the
> run_init related to the transition itself?

no

> - Is system_u authorized for systemhigh?
# semanage user -l

                 Labeling   MLS/       MLS/
SELinux User    Prefix     MCS Level  MCS Range                       
SELinux Roles

...
system_u        user       SystemLow  SystemLow-SystemHigh            
system_r
...

There are a few other md* executables in /sbin. Making them  
mdadm_exec_t did not help. Nor did rebuilding the initrd (desperation).

audit from boot through mdadm:

node=jcdx type=AVC msg=audit(1234364775.240:3): avc:  denied   
{ getattr } for  pid=785 comm="plymouthd" path="/var/lib/plymouth/boot- 
duration" dev=dm-0 ino=1368267  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:var_lib_t:s0 tclass=file
node=jcdx type=AVC msg=audit(1234364775.249:4): avc:  denied   
{ write } for  pid=1 comm="init" path="/dev/pts/0" dev=devpts ino=2  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:devpts_t:s15:c0.c1023 tclass=chr_file
node=jcdx type=AVC msg=audit(1234364775.250:5): avc:  denied   
{ write } for  pid=1 comm="init" name="lock" dev=rootfs ino=647  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=dir
node=jcdx type=AVC msg=audit(1234364775.251:6): avc:  denied   
{ remove_name } for  pid=1 comm="init" name="lvm" dev=rootfs ino=648  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=dir
node=jcdx type=AVC msg=audit(1234364775.251:7): avc:  denied   
{ rmdir } for  pid=1 comm="init" name="lvm" dev=rootfs ino=648  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=dir
node=jcdx type=AVC msg=audit(1234364775.252:8): avc:  denied   
{ unlink } for  pid=1 comm="init" name="init" dev=rootfs ino=282  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=file
node=jcdx type=AVC msg=audit(1234364775.253:9): avc:  denied   
{ unlink } for  pid=1 comm="init" name="ld-linux-x86-64.so.2"  
dev=rootfs ino=195 scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=lnk_file
node=jcdx type=AVC msg=audit(1234364775.254:10): avc:  denied   
{ getattr } for  pid=1 comm="init" path="/dev/sdb2" dev=rootfs ino=455  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=blk_file
node=jcdx type=AVC msg=audit(1234364775.255:11): avc:  denied   
{ unlink } for  pid=1 comm="init" name="sdb2" dev=rootfs ino=455  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=blk_file
node=jcdx type=AVC msg=audit(1234364775.255:12): avc:  denied   
{ getattr } for  pid=1 comm="init" path="/dev/tty7" dev=rootfs ino=271  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=chr_file
node=jcdx type=AVC msg=audit(1234364775.255:13): avc:  denied   
{ unlink } for  pid=1 comm="init" name="tty7" dev=rootfs ino=271  
scontext=system_u:system_r:kernel_t:s15:c0.c1023  
tcontext=system_u:object_r:root_t:s0 tclass=chr_file
node=jcdx type=AVC msg=audit(1234364775.368:14): avc:  denied  { read  
write } for  pid=1 comm="init" name="0" dev=devpts ino=2  
scontext=system_u:system_r:init_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:devpts_t:s15:c0.c1023 tclass=chr_file
node=jcdx type=AVC msg=audit(1234364776.568:15): avc:  denied   
{ write } for  pid=809 comm="rc.sysinit" path="/0" dev=devpts ino=2  
scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:devpts_t:s15:c0.c1023 tclass=chr_file
node=jcdx type=SYSCALL msg=audit(1234364776.568:15): arch=c000003e  
syscall=1 success=yes exit=13 a0=1 a1=7f545e2eb000 a2=d  
a3=7f545e2d16f0 items=0 ppid=807 pid=809 auid=4294967295 uid=0 gid=0  
euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295  
comm="rc.sysinit" exe="/bin/bash" subj=system_u:system_r:initrc_t:s0- 
s15:c0.c1023 key=(null)
node=jcdx type=AVC msg=audit(1234364776.825:16): avc:  denied  { use }  
for  pid=831 comm="start_udev" path="/0" dev=devpts ino=2  
scontext=system_u:system_r:udev_t:s0-s15:c0.c1023  
tcontext=system_u:system_r:kernel_t:s15:c0.c1023 tclass=fd
node=jcdx type=AVC msg=audit(1234364778.023:17): avc:  denied   
{ read } for  pid=1468 comm="mdadm" name="sdb1" dev=tmpfs ino=507  
scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:fixed_disk_device_t:s15:c0.c1023  
tclass=blk_file
node=jcdx type=SYSCALL msg=audit(1234364778.023:17): arch=c000003e  
syscall=2 success=yes exit=3 a0=7ffffc6cbc84 a1=80 a2=7ffffc6cbc84  
a3=0 items=0 ppid=1422 pid=1468 auid=4294967295 uid=0 gid=0 euid=0  
suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295  
comm="mdadm" exe="/sbin/mdadm" subj=system_u:system_r:mdadm_t:s0- 
s15:c0.c1023 key=(null)
node=jcdx type=AVC msg=audit(1234364778.023:18): avc:  denied   
{ read } for  pid=1465 comm="mdadm" name=".tmp-9-1" dev=tmpfs ino=5935  
scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:device_t:s0 tclass=blk_file
node=jcdx type=SYSCALL msg=audit(1234364778.023:18): arch=c000003e  
syscall=2 success=yes exit=3 a0=7fffe4476f54 a1=0 a2=1 a3=7f31dc4546f0  
items=0 ppid=1463 pid=1465 auid=4294967295 uid=0 gid=0 euid=0 suid=0  
fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="mdadm"  
exe="/sbin/mdadm" subj=system_u:system_r:mdadm_t:s0-s15:c0.c1023  
key=(null)
node=jcdx type=AVC msg=audit(1234364778.023:19): avc:  denied   
{ mount } for  pid=1190 comm="modprobe" name="/" dev=securityfs ino=1  
scontext=system_u:system_r:insmod_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:security_t:s0 tclass=filesystem
node=jcdx type=AVC msg=audit(1234364778.027:20): avc:  denied   
{ getattr } for  pid=1465 comm="mdadm" path="/proc/kcore" dev=proc  
ino=4026531986 scontext=system_u:system_r:mdadm_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:proc_kcore_t:s15:c0.c1023 tclass=file
node=jcdx type=SYSCALL msg=audit(1234364778.027:20): arch=c000003e  
syscall=4 success=yes exit=0 a0=144b610 a1=7fffe44734d0  
a2=7fffe44734d0 a3=100 items=0 ppid=1463 pid=1465 auid=4294967295  
uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none)  
ses=4294967295 comm="mdadm" exe="/sbin/mdadm"  
subj=system_u:system_r:mdadm_t:s0-s15:c0.c1023 key=(null)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
