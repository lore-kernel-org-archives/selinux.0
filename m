Date: Fri, 12 Apr 2002 14:55:04 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Sung Kim <hunkim@cse.ucsc.edu>
cc: SELinux@tycho.nsa.gov
Subject: Re: Compile error with Download 2.4 LSM-based Prototype (stable,
 recommended)
In-Reply-To: <Pine.GSO.4.44.0204112038440.17711-100000@sundance.cse.ucsc.edu>
Message-ID: <Mutt.LNX.4.44.0204121454290.31181-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 11 Apr 2002, Sung Kim wrote:

> Hello,
> 
> I tried to install 2.4 LSM-based Prototype (stable, recommended).
> But I've got these error messages.
> 
> make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/selopt'
> gcc -D__KERNEL__ -I/usr/src/lsm-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -I../include -I.. -DKBUILD_\BASENAME=queue  -c -o queue.o queue.c
> queue.c: In function `__selopt_queue_dequeue':
> queue.c:98: warning: implicit declaration of function `nf_reinject'
> 

Can you please send your .config file?


- James
-- 
James Morris
<jmorris@intercode.com.au>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
