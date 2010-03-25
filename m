Subject: Re: svirt on MLS has strange AVC.
From: Eric Paris <eparis@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley
 <sds@tycho.nsa.gov>,
        SELinux <selinux@tycho.nsa.gov>, paul.moore@hp.com
In-Reply-To: <20100323114422.GC364@redhat.com>
References: <4BA7E4BF.1040002@redhat.com>
	 <1269301672.2911.31.camel@localhost> <4BA8A771.8060502@redhat.com>
	 <20100323114422.GC364@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Mar 2010 22:42:39 -0400
Message-ID: <1269484959.2925.9.camel@dhcp235-240.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-03-23 at 11:44 +0000, Daniel P. Berrange wrote:
> On Tue, Mar 23, 2010 at 07:35:13AM -0400, Daniel J Walsh wrote:
> > On 03/22/2010 07:47 PM, Eric Paris wrote:
> > >On Mon, 2010-03-22 at 17:44 -0400, Daniel J Walsh wrote:
> > >   
> > >>time->Mon Mar 22 17:31:49 2010
> > >>type=SYSCALL msg=audit(1269293509.223:4753): arch=c000003e syscall=1
> > >>success=no exit=-13 a0=11 a1=1d2a9c8 a2=10 a3=fffffff2 items=0 ppid=1
> > >>pid=28549 auid=0 uid=107 gid=107 euid=107 suid=107 fsuid=107 egid=107
> > >>sgid=107 fsgid=107 tty=(none) ses=7 comm="qemu-kvm"
> > >>exe="/usr/libexec/qemu-kvm" subj=system_u:system_r:svirt_t:s0:c1 
> > >>key=(null)
> > >>type=AVC msg=audit(1269293509.223:4753): avc:  denied  { write } for
> > >>pid=28549 comm="qemu-kvm" path="socket:[4417531]" dev=sockfs ino=4417531
> > >>scontext=system_u:system_r:svirt_t:s0:c1
> > >>tcontext=system_u:system_r:svirt_t:s0-s15:c0.c1023 
> > >>tclass=unix_stream_socket
> > >>
> > >>I have Static Virtualization working on an MLS box except for this
> > >>strange AVC.
> > >>
> > >>This looks like the kernel is confused?  I believe that all svirt
> > >>processes are running as s0:c1 and yet this AVC indicates svirt_t:s0.c1
> > >>is trying to write to a unix_stream_socket running as
> > >>svirt_t:s0-s15:c0.c1023.
> > >>
> > >># ps -eZ | grep virt
> > >>system_u:system_r:virtd_t:s0-s15:c0.c1023 27344 ? 05:34:47 libvirtd
> > >>system_u:system_r:svirt_t:s0:c1 28549 ?        00:00:01 qemu-kvm
> > >>
> > >>Could the kernel be getting confused in to thinking libvirtd is svirt_t?
> > >>
> > >># ls -lZ /proc/28549/fd/ | grep 4417531
> > >>lrwx------. qemu qemu system_u:system_r:svirt_t:s0:c1  17 ->
> > >>socket:[4417531]
> > >>
> > >>   lsof | grep 4417531
> > >>qemu-kvm  28549      qemu   17u     unix 0xffff88003e1f7900       0t0
> > >>4417531 /var/lib/libvirt/qemu/xguest.monitor
> > >>
> > >># lsof /var/lib/libvirt/qemu/xguest.monitor
> > >>COMMAND    PID USER   FD   TYPE             DEVICE SIZE/OFF    NODE NAME
> > >>qemu-kvm 28549 qemu    3u  unix 0xffff88003a853000      0t0 4417518
> > >>/var/lib/libvirt/qemu/xguest.monitor
> > >>qemu-kvm 28549 qemu   17u  unix 0xffff88003e1f7900      0t0 4417531
> > >>/var/lib/libvirt/qemu/xguest.monitor
> > >>
> > >>So it looks like we have a process that is running as both labels?
> > >>     
> > >This is a check between the type of the process and that of the socket
> > >itself, not between 2 processes.  So, the type of the socket is wrong.
> > >Just as a question, what does ls -lZ /var/lib/libvirt/qemu/ show?
> > >c0-c1023 for xguest.monitor?  What created that socket?  Did they get it
> > >correct?  (I admit it looks correct on my F13ish system)
> > >
> > >-Eric
> > >
> > >   
> > The socket file is labeled svirt_var_run_t and has the correct level.
> > 
> > I believe the socket file was created by qemu.  Dan can you confirm this.
> 
> Yes, these sockets are created by QEMU when it starts. libvirt just gives
> it the path at which to create the socket.
> 
> >  # ls -lZa /var/lib/libvirt/qemu/
> > drwx------. qemu qemu system_u:object_r:svirt_var_run_t:s0-s15:c0.c1023 .
> > drwxr-xr-x. root root system_u:object_r:virt_var_lib_t:s0 ..
> > srwxr-xr-x. qemu qemu system_u:object_r:svirt_var_run_t:s0:c1 xguest.monitor

And then libvirt attaches to the other end?

In any case, doing some digging the problem (where we first end up with
this crazy context with the type of svirt_t but the MLS label of
libvirt) is in selinux_socket_unix_stream_connect().  We never saw this
in MCS because we don't have constraints on unix domain sockets in
targetted/MCS policy.  At this hour of the night my brain isn't running
well enough nor is my networking foo strong enough to understand exactly
which object is supposed to be labeled what where, but it has to be
something with the call to security_sid_mls_copy().

I'll certainly be looking at this again in the morning.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
