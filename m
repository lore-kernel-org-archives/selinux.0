Date: Tue, 15 Jan 2002 23:33:50 +0100
From: Bognar Attila <attila@ebizlab.hit.bme.hu>
Subject: Redhat 7.2 + selinux-2001121010.tgz
To: SELinux@tycho.nsa.gov
Message-id: <004201c19e14$b4bc7a30$ca00a8c0@foka>
MIME-version: 1.0
Content-type: multipart/alternative;
 boundary="Boundary_(ID_jl6MrIAN23Dw4XfCHnipUw)"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Boundary_(ID_jl6MrIAN23Dw4XfCHnipUw)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7BIT

Hi all!

I just installed a fresh Redhat 7.2 to test SELinux, and tried to put selinux-2001121010 on it. I followed the step-by-step guide in the readme file, however when compiling (linking):

make[2]: Entering directory `/usr/src/selinux/utils/util-linux-2.11f/text-utils'
cc -O -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -I../lib -Wall -Wmissing-prototypes -Wstrict-prototypes -I/usr/include/ncurses -DNCH=0 -I/usr/include/slang -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\" -DMOREHELPFILE=\"/usr/share/misc/more.help\" -s more.o ../lib/xstrncpy.o -o more
more.o: In function `my_putstring':
more.o(.text+0xa): undefined reference to `putp'
more.o: In function `my_setupterm':
more.o(.text+0x20): undefined reference to `setupterm'
more.o: In function `my_tgetnum':
more.o(.text+0x32): undefined reference to `tigetnum'
more.o: In function `my_tgetflag':
more.o(.text+0x42): undefined reference to `tigetflag'
more.o: In function `my_tgetstr':
more.o(.text+0x52): undefined reference to `tigetstr'
more.o: In function `my_tgoto':
more.o(.text+0x68): undefined reference to `tparm'
more.o: In function `initterm':
more.o(.text+0x2cf2): undefined reference to `PC'
more.o: In function `reset_tty':
more.o(.text+0x3545): undefined reference to `tputs'
collect2: ld returned 1 exit status
make[2]: *** [more] Error 1
make[2]: Leaving directory `/usr/src/selinux/utils/util-linux-2.11f/text-utils'
make[1]: *** [all] Error 1
make[1]: Leaving directory `/usr/src/selinux/utils/util-linux-2.11f'
make: *** [xutil-linux] Error 2
[root@xxx: /usr/src/selinux/utils] #

What do you suggest? (all ncurses related rpms are installed or what versions should I install?)

Thanks,

attila




--Boundary_(ID_jl6MrIAN23Dw4XfCHnipUw)
Content-type: text/html; charset=iso-8859-2
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-2">
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT face=Arial size=2>Hi all!</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>I just installed a fresh Redhat 7.2 to test 
SELinux, and tried to put selinux-2001121010 on it. I followed the step-by-step 
guide in the readme file, however when compiling (linking):</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>make[2]: Entering directory 
`/usr/src/selinux/utils/util-linux-2.11f/text-utils'<BR>cc -O 
-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -I../lib -Wall -Wmissing-prototypes 
-Wstrict-prototypes -I/usr/include/ncurses -DNCH=0 -I/usr/include/slang 
-D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\" -DUSRSBINDIR=\"/usr/sbin\" 
-DLOGDIR=\"/var/log\" -DVARPATH=\"/var\" -DLOCALEDIR=\"/usr/share/locale\" 
-DMOREHELPFILE=\"/usr/share/misc/more.help\" -s more.o ../lib/xstrncpy.o -o 
more<BR>more.o: In function `my_putstring':<BR>more.o(.text+0xa): undefined 
reference to `putp'<BR>more.o: In function 
`my_setupterm':<BR>more.o(.text+0x20): undefined reference to 
`setupterm'<BR>more.o: In function `my_tgetnum':<BR>more.o(.text+0x32): 
undefined reference to `tigetnum'<BR>more.o: In function 
`my_tgetflag':<BR>more.o(.text+0x42): undefined reference to 
`tigetflag'<BR>more.o: In function `my_tgetstr':<BR>more.o(.text+0x52): 
undefined reference to `tigetstr'<BR>more.o: In function 
`my_tgoto':<BR>more.o(.text+0x68): undefined reference to `tparm'<BR>more.o: In 
function `initterm':<BR>more.o(.text+0x2cf2): undefined reference to 
`PC'<BR>more.o: In function `reset_tty':<BR>more.o(.text+0x3545): undefined 
reference to `tputs'<BR>collect2: ld returned 1 exit status<BR>make[2]: *** 
[more] Error 1<BR>make[2]: Leaving directory 
`/usr/src/selinux/utils/util-linux-2.11f/text-utils'<BR>make[1]: *** [all] Error 
1<BR>make[1]: Leaving directory 
`/usr/src/selinux/utils/util-linux-2.11f'<BR>make: *** [xutil-linux] Error 
2<BR>[root@xxx: /usr/src/selinux/utils] #<BR></FONT></DIV>
<DIV><FONT face=Arial size=2>What do you suggest? (all ncurses related rpms are 
installed or what versions should I install?)</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>Thanks,</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>attila</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>&nbsp;</DIV></FONT></BODY></HTML>

--Boundary_(ID_jl6MrIAN23Dw4XfCHnipUw)--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
