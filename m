Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m27FnQ1d011944
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 10:49:26 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m27FnPId017255
	for <selinux@tycho.nsa.gov>; Fri, 7 Mar 2008 15:49:25 GMT
Cc: jwcart2@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Message-Id: <D0A88599-46C2-4E2B-9207-2B95462B5FC3@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <47D148AF.1090606@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/1] refpolicy: Do not want to transition to sysadm_t when upstart runs a shell
Date: Fri, 7 Mar 2008 09:49:01 -0600
References: <1204837907.13547.36.camel@moss-lions.epoch.ncsc.mil> <96B901A6-B8BE-474E-B7D0-71164D8A64BF@nall.com> <47D148AF.1090606@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mar 7, 2008, at 7:52 AM, Daniel J Walsh wrote:

>>
> Looks like it.  I think leaving making it initrc_t would fix most of
> your avc messages.

It certainly changed them. Here is the of the changing init_t to  
initrc_t


#============= init_t ==============
allow init_t self:unix_dgram_socket sendto;
allow init_t shell_exec_t:file { read execute execute_no_trans };

#============= initrc_t ==============
allow initrc_t lvm_control_t:chr_file write;

#============= insmod_t ==============
allow insmod_t kernel_t:process setsched;

#============= sysadm_t ==============
allow sysadm_t cpu_device_t:chr_file write;
allow sysadm_t self:udp_socket listen;
allow sysadm_t var_log_t:file append;

and the denials

[root@rawhide ~]# grep denied /var/log/messages
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925519.436:3):  
avc:  denied  { execute } for  pid=502 comm="init" name="bash"  
dev=sda2 ino=24084497 scontext=system_u:system_r:init_t:s0- 
s15:c0.c1023 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925519.437:4):  
avc:  denied  { read } for  pid=502 comm="init" name="bash" dev=sda2  
ino=24084497 scontext=system_u:system_r:init_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925519.437:5):  
avc:  denied  { execute_no_trans } for  pid=502 comm="init" path="/bin/ 
bash" dev=sda2 ino=24084497 scontext=system_u:system_r:init_t:s0- 
s15:c0.c1023 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925522.258:6):  
avc:  denied  { setsched } for  pid=616 comm="modprobe"  
scontext=system_u:system_r:insmod_t:s0-s15:c0.c1023  
tcontext=system_u:system_r:kernel_t:s15:c0.c1023 tclass=process
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925527.696:7):  
avc:  denied  { write } for  pid=1307 comm="multipath.stati"  
name="control" dev=tmpfs ino=5337  
scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:lvm_control_t:s0 tclass=chr_file
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925529.532:8):  
avc:  denied  { execute } for  pid=1445 comm="init" name="bash"  
dev=sda2 ino=24084497 scontext=system_u:system_r:init_t:s0- 
s15:c0.c1023 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925529.532:9):  
avc:  denied  { read } for  pid=1445 comm="init" name="bash" dev=sda2  
ino=24084497 scontext=system_u:system_r:init_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925529.532:10):  
avc:  denied  { execute_no_trans } for  pid=1445 comm="init" path="/ 
bin/bash" dev=sda2 ino=24084497 scontext=system_u:system_r:init_t:s0- 
s15:c0.c1023 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925529.612:11):  
avc:  denied  { sendto } for  pid=1445 comm="telinit"  
path=002F636F6D2F7562756E74752F75707374617274  
scontext=system_u:system_r:init_t:s0-s15:c0.c1023  
tcontext=system_u:system_r:init_t:s0-s15:c0.c1023  
tclass=unix_dgram_socket
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925529.798:12):  
avc:  denied  { setsched } for  pid=1474 comm="modprobe"  
scontext=system_u:system_r:insmod_t:s0-s15:c0.c1023  
tcontext=system_u:system_r:kernel_t:s15:c0.c1023 tclass=process
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925529.975:13):  
avc:  denied  { write } for  pid=1491 comm="microcode_ctl"  
name="microcode" dev=tmpfs ino=5796  
scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
tcontext=system_u:object_r:cpu_device_t:s0 tclass=chr_file
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925540.061:16):  
avc:  denied  { listen } for  pid=2051 comm="rpcbind" lport=955  
scontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023  
tcontext=system_u:system_r:sysadm_t:s0-s15:c0.c1023 tclass=udp_socket
Mar  7 15:32:21 rawhide kernel: type=1400 audit(1204925541.097:17):  
avc:  denied  { append } for  pid=2152 comm="rsyslogd" name="secure"  
dev=sda2 ino=2621494 scontext=system_u:system_r:sysadm_t:s0- 
s15:c0.c1023 tcontext=system_u:object_r:var_log_t:s15:c0.c1023  
tclass=file

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
