Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA11978
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 13:11:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA17411
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 18:11:13 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id SAA17407
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 18:11:12 GMT
Date: Fri, 30 Mar 2001 13:10:28 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Kris Odland <kodland@blackhole.cc.ndsu.nodak.edu>
cc: "NSA Linux (E-mail)" <selinux@tycho.nsa.gov>
Subject: Re: Error in tools/build-apps
In-Reply-To: <Pine.LNX.4.30.0103301149010.27433-100000@blackhole.cc.ndsu.nodak.edu>
Message-ID: <Pine.SOL.3.95.1010330130543.2543A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hubertus Franke just reported the same problem.  There
is an error in the syscalls msgread program that demonstrates
the msgrcv_secure system call.  msgread.c should use 
'struct ipcmsgbuf' rather than 'struct msgbuf' for buf. 
I'm not sure about the warning you are getting for the
function prototypes in ipc_secure.h.  ipc_secure.h includes
sys/msg.h, and on RedHat 6.1 and 6.2, sys/msg.h defines struct
msgbuf as a template for the struct to be used as the argument
for msgsnd and msgrcv.  Has that changed in RedHat 7.0?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

On Fri, 30 Mar 2001, Kris Odland wrote:

> Hi, I am attempting to install this on a rh7 box and the kernel compiled
> without any problems.  I get this error twice in the build-apps script
> when it is building the syscalls programs.
> In file included from msgread.c:17:
> ../../include/ipc_secure.h:19: warning: `struct msgbuf' declared inside
> parameter list
> ../../include/ipc_secure.h:19: warning: its scope is only this definition
> or declaration, which is probably not what you want.
> ../../include/ipc_secure.h:23: warning: `struct msgbuf' declared inside
> parameter list
> msgread.c: In function `main':
> msgread.c:35: storage size of `buf' isn't known
> make[1]: *** [msgread.o] Error 1
> 
> Everything else seems to compile fine except this.  Is there something I
> missed?
> 
> Kris


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
