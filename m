Date: Wed, 16 Jan 2002 09:43:46 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Bognar Attila <attila@ebizlab.hit.bme.hu>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: Redhat 7.2 + selinux-2001121010.tgz
In-Reply-To: <004201c19e14$b4bc7a30$ca00a8c0@foka>
Message-ID: <Pine.GSO.4.33.0201160941220.7787-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 15 Jan 2002, Bognar Attila wrote:

> I just installed a fresh Redhat 7.2 to test SELinux, and tried to put selinux-2001121010 on it. I followed the step-by-step guide in the readme file, however when compiling (linking):
>
> make[2]: Entering directory `/usr/src/selinux/utils/util-linux-2.11f/text-utils'
> cc -O -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes -I/usr/include/ncurses -DNCH=0 -I/usr/include/slang -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\" -DMOREHELPFILE=\"/usr/share/misc/more.help\" -s more.o ../lib/xstrncpy.o -o more
> more.o: In function `my_putstring':
> more.o(.text+0xa): undefined reference to `putp'

Looks like you are missing the termcap library.  On my RH7.2 system,
this library is owned by the libtermcap-devel-2.0.8-28 package.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
