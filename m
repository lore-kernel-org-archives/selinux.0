Date: Fri, 30 Mar 2001 12:08:01 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Hubertus Franke <frankeh@us.ibm.com>
cc: SELinux@tycho.nsa.gov, Pratap Pattnaik <0xL33Ez@northrelay02.pok.ibm.com>
Subject: Re: SE Linux problems on 7.0 and some other BUGS we found
In-Reply-To: <OFB0DBAF92.C33932D5-ON85256A1F.0054E91F@pok.ibm.com>
Message-ID: <Pine.SOL.3.95.1010330120018.23186I-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The message generated while building the policy configuration
isn't an error, just a warning about overriding a rule.  In
the short term, we could mention it in the INSTALL file
so people won't worry about it.

We can add a 'make depend' for syscalls to the build-apps script.
We'll also fix the bug in the example msgread program.  That program,
like the other programs in syscalls, is just an example of how to
use the new system calls.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



On Fri, 30 Mar 2001, Hubertus Franke wrote:

> 
> Here are few PROBLEMS and BUGS we found that need fixing,
> (at least for 7.0 kernels).
> 
> 
> We reinstalled RH7.0 on our machine.
> We applied recent "bind" fix to fend of recent worm daemons.
> We replaced gcc with kgcc (people using RH7.0 have complaint about that).
> Initial problems reported regarding missing stddef.h files
> were related to this compiler mixups.
> 
> 
> 
> -----------------
> ./tools/build-kernel:
> 
>         make initpolicy
> 
> warning about the statement ending on line 22456 (token ';'): conflicting
> rule for (polyadm_t, poly_t:dir):  default was polyadm_home_t, is now
> poly_t
> 
> still builds though ....  !!!!!
> 
> ------------------
> ./tools/build-apps
> 
> (a) first problem
> make[1]: *** No rule to make target
> `/usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h', needed
> by `unix_stream_server.o'.  Stop.
> make[1]: *** No rule to make target
> `/usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/include/stddef.h', needed
> by `unix_stream_server.o'.  Stop.
> 
>         FIX:   cd syscalls; make depend
>           suggest you put this somewhere in the initial setup (??)
>           our directories are named slightly different hence the hickup.
> 
> 
> 
> 
> (a) second problem:  THIS IS A BUG.
> ./syscalls/msgread/msgread.c #35:
>      msgread.c:35: storage size of `buf' isn't known
> 
>      looking at the code, this actually exposes a BUG:
>      You need to specify
>           "struct ipcmsgbuf buf"  instead of       "struct msgbuf buf"
>      not doing so provides a smaller buffer during the later msgrcv_secure
>      Surprised the code didn't barf.
>      Take a look at msgwrite.c, there it's done correctly
> 
> 
> Now its building....... will try running now.
> 
> 
> 
> Hubertus Franke
> Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
> , OS-PIC (Chair)
> email: frankeh@us.ibm.com
> (w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003
> 
> 
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
