Subject: Re: Redhat 7.2 + selinux-2001121010.tgz
To: Bognar Attila <attila@ebizlab.hit.bme.hu>
Cc: SELinux@tycho.nsa.gov
Message-ID: <OF2027A31B.41A22DD0-ON85256B43.00509DFC@pok.ibm.com>
From: "Trent Jaeger" <jaegert@us.ibm.com>
Date: Wed, 16 Jan 2002 09:44:12 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi,

I came across this problem as well.  A library is missing in the Makefile
(utils/util-linux-2.11f/text-utils) for building 'more'.

more: more.o $(LIB)/xstrncpy.o
        $(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@ $(LIBTERMCAP)

I added $(LIBCURSES) at the end of this line and 'more' built properly.

Trent.



Bognar Attila <attila@ebizlab.hit.bme.hu>@tycho.nsa.gov on 01/15/2002
05:33:50 PM

Sent by:    owner-selinux@tycho.nsa.gov


To:    SELinux@tycho.nsa.gov
cc:
Subject:    Redhat 7.2 + selinux-2001121010.tgz




Hi all!

I just installed a fresh Redhat 7.2 to test  SELinux, and tried to put
selinux-2001121010 on it. I followed the step-by-step  guide in the readme
file, however when compiling (linking):

make[2]: Entering directory
`/usr/src/selinux/utils/util-linux-2.11f/text-utils'
cc -O  -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -I../lib -Wall
-Wmissing-prototypes  -Wstrict-prototypes -I/usr/include/ncurses -DNCH=0
-I/usr/include/slang  -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\"
-DUSRSBINDIR=\"/usr/sbin\"  -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\"
-DLOCALEDIR=\"/usr/share/locale\"  -DMOREHELPFILE
=\"/usr/share/misc/more.help\" -s more.o ../lib/xstrncpy.o -o  more
more.o: In function `my_putstring':
more.o(.text+0xa): undefined  reference to `putp'
more.o: In function  `my_setupterm':
more.o(.text+0x20): undefined reference to  `setupterm'
more.o: In function `my_tgetnum':
more.o(.text+0x32):  undefined reference to `tigetnum'
more.o: In function  `my_tgetflag':
more.o(.text+0x42): undefined reference to  `tigetflag'
more.o: In function `my_tgetstr':
more.o(.text+0x52):  undefined reference to `tigetstr'
more.o: In function  `my_tgoto':
more.o(.text+0x68): undefined reference to `tparm'
more.o: In  function `initterm':
more.o(.text+0x2cf2): undefined reference to  `PC'
more.o: In function `reset_tty':
more.o(.text+0x3545): undefined  reference to `tputs'
collect2: ld returned 1 exit status
make[2]: ***  [more] Error 1
make[2]: Leaving directory
`/usr/src/selinux/utils/util-linux-2.11f/text-utils'
make[1]: *** [all] Error
make[1]: Leaving directory  `/usr/src/selinux/utils/util-linux-2.11f'
make: *** [xutil-linux] Error
[root@xxx: /usr/src/selinux/utils] #

What do you suggest? (all ncurses related rpms are  installed or what
versions should I install?)

Thanks,

attila







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
