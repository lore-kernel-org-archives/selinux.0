Subject: Re: avc: denied null
From: Dominick Grift <domg472@gmail.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4A14BE43.7070505@tycho.nsa.gov>
References: <1242641994.470.5.camel@notebook2.grift.internal>
	 <1242651013.29973.197.camel@localhost.localdomain>
	 <1242651553.1057.0.camel@notebook2.grift.internal>
	 <4A1374D5.6080504@tycho.nsa.gov>
	 <1242817716.14664.3.camel@notebook2.grift.internal>
	 <4A14BE43.7070505@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 21 May 2009 22:15:03 +0200
Message-Id: <1242936903.3383.6.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-05-20 at 22:36 -0400, Eamon Walsh wrote:

> If you're willing to compile the X server from source, you could apply
> the attached patch and use gdb to attach to the running X server (this
> has to be done over an ssh connection). 
> 
> Break on the SELinuxNullPermissionHappened function and reproduce the
> GLXMakeCurrent avc, hopefully the breakpoint will fire and you can get a
> backtrace.
> 
> Also there is another patch that will fix the x_device null avc's
> (attached).
> 
I tried it again this time with some hints from eparis. It got me a little bit further:

(gdb) break SELinuxNullPermissionHappened
Breakpoint 1 at 0x7f86941f9370: file xselinux.c, line 433.
(gdb) continue
Continuing.

Program received signal SIGPIPE, Broken pipe.
0x00000030040d67ab in writev () from /lib64/libc.so.6
(gdb) bt
#0  0x00000030040d67ab in writev () from /lib64/libc.so.6
#1  0x00000000004eedec in _XSERVTransSocketWritev (
    ciptr=<value optimized out>, buf=0x7fff9c426f00, size=1)
    at /usr/include/X11/Xtrans/Xtranssock.c:2184
#2  0x00000000004ea85d in FlushClient (who=<value optimized out>, 
    oc=<value optimized out>, __extraBuf=<value optimized out>, 
    extraCount=<value optimized out>) at io.c:899
#3  0x00000000004eb301 in FlushAllOutput () at io.c:649
#4  0x0000000000446d75 in Dispatch () at dispatch.c:456
#5  0x000000000042d0d5 in main (argc=<value optimized out>, 
    argv=0x7fff9c427198, envp=<value optimized out>) at main.c:397
(gdb) quit
The program is running.  Quit anyway (and detach it)? (y or n) y
LND: Sending signal 13 to process 2456
Detaching from program: /usr/bin/Xorg, process 2456




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
