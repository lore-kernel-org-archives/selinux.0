Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA09824
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 13:50:14 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA29495
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 18:47:57 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA29489
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 18:47:55 GMT
Date: Tue, 3 Dec 2002 13:50:08 -0500
From: forrest whitcher <fw@fwsystems.com>
To: selinux@tycho.nsa.gov, openafs-info@openafs.org
Subject: Kernel Oops from afsd under the selinux kernel
Message-Id: <20021203135008.2511a9ad.fw@fwsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



I'm getting the following Oops running on a redhat 7.1 system with the
LSM/selinux patches. kernel 2.4.19. The system runs well in enforcing
mode (however this test is in non-enforcing mode because I can't really 
do the policy changes until I have a working afsd.

afsd works ok on a 2.4.19 kernel running with essentially the same 
kernel config.

After doing extensive printk() and running afsd under strace I've not
yet been able to figure out what NULL pointer dereference is at issue.


Summary:

afsd calls mount and never returns (segfault) as follows

if ((mount("AFS", cacheMountDir, MOUNT_AFS, 0, NULL))<0)


The SElinux function inode_doinit() is entered and seems to this 
with the value 0xc4922000 --- exactly where it exits I'm not to 
sure at this point, -- probably need to compile this with 
optimisation off but numerous printk's ca lines 648-765 of
security/selinux/hooks.c haven't found what I'm looking for
yet (I suppose I need to compile this with optimizations
off)

Any ideas on what might be going on here?

forrest


ksymoops gives this:

ksymoops 2.4.8 on i686 2.4.19-selinux.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-selinux/ (default)
     -m /usr/src/linux/System.map (default)



Unable to handle kernel NULL pointer dereference at virtual address 00000020
c017a351
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c017a351>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000282
eax: c1e970c4   ebx: 00000000   ecx: 00000004   edx: c2ae7f64
esi: c486dce3   edi: c4922000   ebp: c21a2c00   esp: c22b7e64
ds: 0018   es: 0018   ss: 0018
Process afsd (pid: 750, stackpage=c22b7000)
Stack: 00000282 00000001 c028cac4 c02e768b 00000246 0000004b c4922000 c486dce3 
       c02562f1 c21a2c00 c017a22b c4922000 c0256460 c02edca0 c486dce3 c02562f1 
       00000005 c21a2c00 c10e7500 c486ee2c c1e9c000 c017d0af c21a2c00 c21a2c00 
Call Trace:    [<c486dce3>] [<c017a22b>] [<c486dce3>] [<c486ee2c>] [<c017d0af>]
  [<c0138305>] [<c486ee2c>] [<c0138469>] [<c486ee2c>] [<c0138493>] [<c017bc74>]
  [<c01483c5>] [<c01486bb>] [<c01484dc>] [<c0148a1c>] [<c01087fb>]
Code: 80 7b 20 00 0f 85 16 03 00 00 80 bf 10 01 00 00 00 0f 84 90 


>>EIP; c017a351 <inode_doinit+11/340>   <=====

>>eax; c1e970c4 <_end+1b86ce8/450cc24>
>>edx; c2ae7f64 <_end+27d7b88/450cc24>
>>esi; c486dce3 <[libafs-2.4.19-selinux]rcsid+83/140>
>>ebp; c21a2c00 <_end+1e92824/450cc24>
>>esp; c22b7e64 <_end+1fa7a88/450cc24>

Trace; c486dce3 <[libafs-2.4.19-selinux]rcsid+83/140>
Trace; c017a22b <superblock_doinit+14b/160>
Trace; c486dce3 <[libafs-2.4.19-selinux]rcsid+83/140>
Trace; c486ee2c <[libafs-2.4.19-selinux]afs_file_system+0/1c>
Trace; c017d0af <selinux_sb_kern_mount+f/50>
Trace; c0138305 <get_sb_nodev+35/70>
Trace; c486ee2c <[libafs-2.4.19-selinux]afs_file_system+0/1c>
Trace; c0138469 <do_kern_mount+89/140>
Trace; c486ee2c <[libafs-2.4.19-selinux]afs_file_system+0/1c>
Trace; c0138493 <do_kern_mount+b3/140>
Trace; c017bc74 <selinux_capable+14/40>
Trace; c01483c5 <do_add_mount+65/130>
Trace; c01486bb <do_mount+18b/1b0>
Trace; c01484dc <copy_mount_options+4c/a0>
Trace; c0148a1c <sys_mount+7c/c0>
Trace; c01087fb <system_call+33/38>

Code;  c017a351 <inode_doinit+11/340>
00000000 <_EIP>:
Code;  c017a351 <inode_doinit+11/340>   <=====
   0:   80 7b 20 00               cmpb   $0x0,0x20(%ebx)   <=====
Code;  c017a355 <inode_doinit+15/340>
   4:   0f 85 16 03 00 00         jne    320 <_EIP+0x320> c017a671 <inode_doinit+331/340>
Code;  c017a35b <inode_doinit+1b/340>
   a:   80 bf 10 01 00 00 00      cmpb   $0x0,0x110(%edi)
Code;  c017a362 <inode_doinit+22/340>
  11:   0f 84 90 00 00 00         je     a7 <_EIP+0xa7> c017a3f8 <inode_doinit+b8/340>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
