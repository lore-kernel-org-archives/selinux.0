Date: Fri, 12 Apr 2002 08:38:24 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Sung Kim <hunkim@cse.ucsc.edu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Compile error with Download 2.4 LSM-based Prototype (stable,
 recommended)
In-Reply-To: <Pine.GSO.4.44.0204112038440.17711-100000@sundance.cse.ucsc.edu>
Message-ID: <Pine.GSO.4.33.0204120834330.21729-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Apr 2002, Sung Kim wrote:

> I tried to install 2.4 LSM-based Prototype (stable, recommended).
> But I've got these error messages.
>
> make[3]: Entering directory `/usr/src/lsm-2.4/security/selinux/selopt'
> gcc -D__KERNEL__ -I/usr/src/lsm-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -I../include -I.. -DKBUILD_\BASENAME=queue  -c -o queue.o queue.c
> queue.c: In function `__selopt_queue_dequeue':
> queue.c:98: warning: implicit declaration of function `nf_reinject'

Did you enable Network Packet Filtering (NetFilter) under the Networking
Options submenu?  This option should be set by default in your defconfig
file if you followed the installation procedure from selinux/README.

> My gcc version is 3.0.2 and tried in Linux hunkim.cse.ucsc.edu 2.4.17 #1 SMP Fri Jan 4 14:46:58 EST 2002 i686 unknown.
> I set all possible security options.

You should only have set the Capabilities Support, the IP Networking
Support, the NSA SELinux Support, and the NSA SELinux Development Module
security options, as discussed in selinux/README.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
