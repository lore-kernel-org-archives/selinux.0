Message-ID: <3E036FCE.7070407@ieee.org>
Date: Fri, 20 Dec 2002 14:30:22 -0500
From: Martin Robb <MartinRobb@ieee.org>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: nfsd kernel NULL pointer dereference
Content-Type: multipart/mixed;
 boundary="------------010005040109090909080700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010005040109090909080700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,

I am running the selinux-2002102211 package against the 2.4.19 kernel 
patched with lsm-2.4-2002102211.  The system seems basically functional 
in non-enforcing mode, but my nfs service is hanging, and in fact the 
system is hanging on a shutdown.  In the system log I get:

Unable to handle kernel NULL pointer dereference in ...

I'm attaching the relevant lines from the system log.  I don't claim to 
totally follow the dump, but it appears to me that 
selinux_file_permission() is getting called with a null struct file 
pointer -- ultimately by nfsd and apparently through vfs_readdir().

FWIW, the system in question is built from scratch using kickstart and 
the selinux kernel and utilities become part of a larger rpm.  I did 
have to go through some contortions to get the ~600 files that selinux 
installs under / to install elsewhere, but things appear to be working 
other than this nfsd issue so I don't think that is the source of the 
problem.  The production version of this system has been using an 
LSM-patched 2.4.14 kernel without selinux, and has been quite stable 
with no NFS problems.

Any thoughts on the source of this problem?

Thanks and happy holidays,
Martin Robb





--------------010005040109090909080700
Content-Type: text/plain;
 name="low-diode.kerneNULL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="low-diode.kerneNULL"

Dec 20 12:01:14 low-diode kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010 
Dec 20 12:01:14 low-diode kernel:  printing eip: 
Dec 20 12:01:14 low-diode kernel: c0186388 
Dec 20 12:01:14 low-diode kernel: *pde = 00000000 
Dec 20 12:01:14 low-diode kernel: Oops: 0000 
Dec 20 12:01:14 low-diode kernel: CPU:    0 
Dec 20 12:01:14 low-diode kernel: EIP:    0010:[selinux_file_permission+216/688]    Not tainted 
Dec 20 12:01:14 low-diode kernel: EFLAGS: 00010202 
Dec 20 12:01:14 low-diode kernel: eax: 00000000   ebx: cea23eb0   ecx: ce66fb80   edx: cea2b2a0 
Dec 20 12:01:14 low-diode kernel: esi: 00000002   edi: cea22000   ebp: cea23eb0   esp: cea23dd4 
Dec 20 12:01:14 low-diode kernel: ds: 0018   es: 0018   ss: 0018 
Dec 20 12:01:14 low-diode kernel: Process nfsd (pid: 574, stackpage=cea23000) 
Dec 20 12:01:14 low-diode kernel: Stack: ce66fb80 c0138421 ce66fb80 00000004 00000000 cea22000 ce65d7e0 ce66fb80  
Dec 20 12:01:14 low-diode kernel:        00000004 cf1ed860 cf1ed860 c016c3f4 ceaa1000 ce65d7e0 00000044 cea22000  
Dec 20 12:01:14 low-diode kernel:        cea2a490 00000000 cea2a480 00000202 cea23e40 cea23e88 ceaf81fc cea23eb0  
Dec 20 12:01:14 low-diode kernel: Call Trace:    [permission+65/80] [fh_verify+1012/1056] [nfsd_open+41/432] [nfssvc_encode_entry+0/176] [vfs_readdir+47/144] 
Dec 20 12:01:14 low-diode kernel:   [nfssvc_encode_entry+0/176] [nfsd_readdir+167/416] [nfssvc_encode_entry+0/176] [nfsd_proc_readdir+182/224] [nfssvc_encode_entry+0/176] [nfsd_dispatch+183/384] 
Dec 20 12:01:14 low-diode kernel:   [svc_process+819/1264] [nfsd+455/768] [kernel_thread+38/48] [nfsd+0/768] 
Dec 20 12:01:14 low-diode kernel:  
Dec 20 12:01:14 low-diode kernel: Code: 8b 40 10 39 42 14 0f 84 74 01 00 00 8d 6c 24 60 31 c0 b9 06  
Dec 20 12:03:17 high-diode kernel: 
Dec 20 12:03:17 high-diode kernel: avc:  denied  { read } for  pid=6713 exe=/usr/bin/tail path=/diode dev=03:06 ino=22 scontext=root:user_r:user_t tcontext=root:object_r:file_t tclass=file
Dec 20 12:03:17 high-diode kernel: 

--------------010005040109090909080700--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
