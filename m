Message-ID: <72222DC86846D411ABD300A0C9EB08A101524134@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Sean Rolinson'" <snowdog@bigfoot.com>
Cc: SELinux@tycho.nsa.gov
Subject: RE: Problems compiling: SELinux 200104121417 on Alpha (config/fla
	sh.h: No such file or directory)
Date: Fri, 18 May 2001 08:25:47 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C0DF9E.0C6CAF10"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C0DF9E.0C6CAF10
Content-Type: text/plain;
	charset="iso-8859-1"

I have not run into this problem compiling the kernel. 
I have had troubles compile the kernel before.
I have had the run
make mrproper 
in the kernel top level directory. 
cd /usr/src/slinux/kernel-2.4
make mrproper
cd ..
toosl/build-kernel
 
Let me know if this works. I
 
Also I am very insterested to see how your alpha works. We have a bunch of
them
here.
 
Mark Westerman
mark.westerman@csoconline.com

-----Original Message-----
From: Sean Rolinson [mailto:snowdog@bigfoot.com]
Sent: Thursday, May 17, 2001 4:26 PM
To: SELinux@tycho.nsa.gov
Subject: Problems compiling: SELinux 200104121417 on Alpha (config/flash.h:
No such file or directory)



-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
Hello,
 
I am having a problem compiling SELinux with a 2.4 kernel on an
alpha.  I am using the complete downloaded package,
slinux-200104121417-release.tgz (i.e. NOT the patches).
 
When doing a `make dep; make` I get the following error:
 
gcc -D__KERNEL__ -I/home/snowdog/src/slinux/kernel-2.4/include -Wall
- - -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
- - -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6   -c -o
init/main.o
init/main.c
In file included from
/home/snowdog/src/slinux/kernel-2.4/include/linux/mm.h:4,
                 from
/home/snowdog/src/slinux/kernel-2.4/include/linux/slab.h:14,
                 from
/home/snowdog/src/slinux/kernel-2.4/include/linux/proc_fs.h:9,
                 from init/main.c:18:
/home/snowdog/src/slinux/kernel-2.4/include/linux/sched.h:35:26:
config/flask.h: No such file or directory
 
I saw an article in the archives talking about this
( http://www.nsa.gov/selinux/list-archive/0003.html
<http://www.nsa.gov/selinux/list-archive/0003.html> ), but it said this
shouldn't happen if I was doing a normal kernel build from the
sources, which I was.
 
I then proceeded to do the following:
 
[snowdog@alpha kernel]$ cd flask
[snowdog@alpha flask]$ export TOPDIR=..
[snowdog@alpha flask]$ make
/bin/sh ./mkflask.sh awk security_classes initial_sids
cp flask.h class_to_string.h initial_sid_to_string.h
../include/linux/flask
/bin/sh ./mkaccess_vector.sh awk access_vectors
cp av_inherit.h common_perm_to_string.h av_perm_to_string.h
av_permissions.h ../include/linux/flask
[snowdog@alpha flask]$
 
I assume the above part is normally done during the kernel build.  
 
I then edited the file "include/linux/sched.h" and changed line 35
FROM "#include <config/flask.h>" TO "#include <linux/flask/flask.h>".
 
Finally, I changed to the kernel root directory and typed "make" and
it proceeded to compile the kernel with no additional errors. 
 
Am I doing something wrong or did I miss an important step from the
docs? I read through the docs and didn't see any pre-compile stuff
that needed to be done for the kernel to build properly.
 
The above method is probably not the cleanest or most ideal way to
get this to compile.  Any thoughts or suggestions??
 
Thanks...
 
Sean Rolinson
snowdog@bigfoot.com <mailto:snowdog@bigfoot.com> 
 
-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use < http://www.pgp.com
<http://www.pgp.com> >
 
iQA/AwUBOwRB1gZ8QuEIBpz3EQLdMQCcD4djruOnWsG+Cf8KDsSDBAzR7FIAoNIb
OcCUfouNbR7dwSMAaFfGn4YK
=hSjY
-----END PGP SIGNATURE-----



------_=_NextPart_001_01C0DF9E.0C6CAF10
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 5.00.3314.2100" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>I have 
not run into this problem compiling the kernel. </SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>I have 
had troubles compile the kernel before.</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>I have 
had the run</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>make 
mrproper </SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>in the 
kernel top level directory. </SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>cd 
/usr/src/slinux/kernel-2.4</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>make 
mrproper</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>cd 
..</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=944521811-18052001>toosl/build-kernel</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=944521811-18052001></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>Let me 
know if this works. I</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=944521811-18052001></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>Also I 
am very insterested to see how your alpha works. We have a bunch of 
them</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=944521811-18052001>here.</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=944521811-18052001></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN class=944521811-18052001>Mark 
Westerman</SPAN></FONT></DIV>
<DIV><FONT color=#0000ff face=Arial size=2><SPAN 
class=944521811-18052001>mark.westerman@csoconline.com</SPAN></FONT></DIV>
<BLOCKQUOTE style="MARGIN-RIGHT: 0px">
  <DIV align=left class=OutlookMessageHeader dir=ltr><FONT face=Tahoma 
  size=2>-----Original Message-----<BR><B>From:</B> Sean Rolinson 
  [mailto:snowdog@bigfoot.com]<BR><B>Sent:</B> Thursday, May 17, 2001 4:26 
  PM<BR><B>To:</B> SELinux@tycho.nsa.gov<BR><B>Subject:</B> Problems compiling: 
  SELinux 200104121417 on Alpha (config/flash.h: No such file or 
  directory)<BR><BR></DIV></FONT>
  <DIV><FONT face=Arial size=2>
  <DIV><FONT face=Arial size=2>-----BEGIN PGP SIGNED MESSAGE-----<BR>Hash: 
  SHA1</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>Hello,</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>I am having a problem compiling SELinux with a 
  2.4 kernel on an<BR>alpha.&nbsp; I am using the complete downloaded 
  package,<BR>slinux-200104121417-release.tgz (i.e. NOT the 
  patches).</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>When doing a `make dep; make` I get the following 
  error:</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>gcc -D__KERNEL__ 
  -I/home/snowdog/src/slinux/kernel-2.4/include -Wall<BR>- - -Wstrict-prototypes 
  -O2 -fomit-frame-pointer -fno-strict-aliasing<BR>- - -pipe -mno-fp-regs 
  -ffixed-8 -mcpu=ev5 -Wa,-mev6&nbsp;&nbsp; -c 
  -o<BR>init/main.o<BR>init/main.c<BR>In file included 
  from<BR>/home/snowdog/src/slinux/kernel-2.4/include/linux/mm.h:4,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  from<BR>/home/snowdog/src/slinux/kernel-2.4/include/linux/slab.h:14,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  from<BR>/home/snowdog/src/slinux/kernel-2.4/include/linux/proc_fs.h:9,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  from 
  init/main.c:18:<BR>/home/snowdog/src/slinux/kernel-2.4/include/linux/sched.h:35:26:<BR>config/flask.h: 
  No such file or directory</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>I saw an article in the archives talking about 
  this<BR>(<A 
  href="http://www.nsa.gov/selinux/list-archive/0003.html">http://www.nsa.gov/selinux/list-archive/0003.html</A>), 
  but it said this<BR>shouldn't happen if I was doing a normal kernel build from 
  the<BR>sources, which I was.</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>I then proceeded to do the 
following:</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>[snowdog@alpha kernel]$ cd 
  flask<BR>[snowdog@alpha flask]$ export TOPDIR=..<BR>[snowdog@alpha flask]$ 
  make<BR>/bin/sh ./mkflask.sh awk security_classes initial_sids<BR>cp flask.h 
  class_to_string.h initial_sid_to_string.h<BR>../include/linux/flask<BR>/bin/sh 
  ./mkaccess_vector.sh awk access_vectors<BR>cp av_inherit.h 
  common_perm_to_string.h av_perm_to_string.h<BR>av_permissions.h 
  ../include/linux/flask<BR>[snowdog@alpha flask]$</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>I assume the above part is normally done during 
  the kernel build.&nbsp; </FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>I then edited the file "include/linux/sched.h" 
  and changed line 35<BR>FROM "#include &lt;config/flask.h&gt;" TO "#include 
  &lt;linux/flask/flask.h&gt;".</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>Finally, I changed to the kernel root directory 
  and typed "make" and<BR>it proceeded to compile the kernel with no additional 
  errors. </FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>Am I doing something wrong or did I miss an 
  important step from the<BR>docs? I read through the docs and didn't see any 
  pre-compile stuff<BR>that needed to be done for the kernel to build 
  properly.</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>The above method is probably not the cleanest or 
  most ideal way to<BR>get this to compile.&nbsp; Any thoughts or 
  suggestions??</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>Thanks...</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>Sean Rolinson<BR><A 
  href="mailto:snowdog@bigfoot.com">snowdog@bigfoot.com</A></FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial size=2>-----BEGIN PGP SIGNATURE-----<BR>Version: 
  PGPfreeware 6.5.8 for non-commercial use &lt;<A 
  href="http://www.pgp.com">http://www.pgp.com</A>&gt;</FONT></DIV>
  <DIV>&nbsp;</DIV>
  <DIV><FONT face=Arial 
  size=2>iQA/AwUBOwRB1gZ8QuEIBpz3EQLdMQCcD4djruOnWsG+Cf8KDsSDBAzR7FIAoNIb<BR>OcCUfouNbR7dwSMAaFfGn4YK<BR>=hSjY<BR>-----END 
  PGP SIGNATURE-----<BR></FONT></DIV></FONT></DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C0DF9E.0C6CAF10--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
