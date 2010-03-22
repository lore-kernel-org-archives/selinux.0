Subject: Re: svirt on MLS has strange AVC.
From: Eric Paris <eparis@redhat.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4BA7E4BF.1040002@redhat.com>
References: <4BA7E4BF.1040002@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Mar 2010 19:47:52 -0400
Message-ID: <1269301672.2911.31.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-03-22 at 17:44 -0400, Daniel J Walsh wrote:
> time->Mon Mar 22 17:31:49 2010
> type=SYSCALL msg=audit(1269293509.223:4753): arch=c000003e syscall=1 
> success=no exit=-13 a0=11 a1=1d2a9c8 a2=10 a3=fffffff2 items=0 ppid=1 
> pid=28549 auid=0 uid=107 gid=107 euid=107 suid=107 fsuid=107 egid=107 
> sgid=107 fsgid=107 tty=(none) ses=7 comm="qemu-kvm" 
> exe="/usr/libexec/qemu-kvm" subj=system_u:system_r:svirt_t:s0:c1 key=(null)
> type=AVC msg=audit(1269293509.223:4753): avc:  denied  { write } for  
> pid=28549 comm="qemu-kvm" path="socket:[4417531]" dev=sockfs ino=4417531 
> scontext=system_u:system_r:svirt_t:s0:c1 
> tcontext=system_u:system_r:svirt_t:s0-s15:c0.c1023 tclass=unix_stream_socket
> 
> I have Static Virtualization working on an MLS box except for this 
> strange AVC.
> 
> This looks like the kernel is confused?  I believe that all svirt 
> processes are running as s0:c1 and yet this AVC indicates svirt_t:s0.c1 
> is trying to write to a unix_stream_socket running as 
> svirt_t:s0-s15:c0.c1023.
> 
> # ps -eZ | grep virt
> system_u:system_r:virtd_t:s0-s15:c0.c1023 27344 ? 05:34:47 libvirtd
> system_u:system_r:svirt_t:s0:c1 28549 ?        00:00:01 qemu-kvm
> 
> Could the kernel be getting confused in to thinking libvirtd is svirt_t?
> 
> # ls -lZ /proc/28549/fd/ | grep 4417531
> lrwx------. qemu qemu system_u:system_r:svirt_t:s0:c1  17 -> 
> socket:[4417531]
> 
>   lsof | grep 4417531
> qemu-kvm  28549      qemu   17u     unix 0xffff88003e1f7900       0t0    
> 4417531 /var/lib/libvirt/qemu/xguest.monitor
> 
> # lsof /var/lib/libvirt/qemu/xguest.monitor
> COMMAND    PID USER   FD   TYPE             DEVICE SIZE/OFF    NODE NAME
> qemu-kvm 28549 qemu    3u  unix 0xffff88003a853000      0t0 4417518 
> /var/lib/libvirt/qemu/xguest.monitor
> qemu-kvm 28549 qemu   17u  unix 0xffff88003e1f7900      0t0 4417531 
> /var/lib/libvirt/qemu/xguest.monitor
> 
> So it looks like we have a process that is running as both labels?

This is a check between the type of the process and that of the socket
itself, not between 2 processes.  So, the type of the socket is wrong.
Just as a question, what does ls -lZ /var/lib/libvirt/qemu/ show?
c0-c1023 for xguest.monitor?  What created that socket?  Did they get it
correct?  (I admit it looks correct on my F13ish system)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
