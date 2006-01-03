Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03GLCXf020204
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 11:21:13 -0500 (EST)
Received: from keep.cflynt.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03GL8ah006272
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 16:21:09 GMT
Received: from clif.cflynt.com (clif.cflynt.com [192.168.9.2])
	by keep.cflynt.com (8.12.10/8.12.10) with ESMTP id k03EQVOM025991
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 09:26:51 -0500
Received: from clif.cflynt.com (localhost.localdomain [127.0.0.1])
	by clif.cflynt.com (8.12.11/8.12.11) with ESMTP id k03EQNwa029463
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 09:26:25 -0500
Received: (from clif@localhost)
	by clif.cflynt.com (8.12.11/8.12.11/Submit) id k03EQMfo029462
	for selinux@tycho.nsa.gov; Tue, 3 Jan 2006 09:26:22 -0500
Date: Tue, 3 Jan 2006 09:26:22 -0500
From: Clif Flynt <clif@cflynt.com>
To: selinux@tycho.nsa.gov
Subject: SELinux & SuSE
Message-ID: <20060103142622.GA29438@clif.cflynt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I need to configure a SuSE workstation to meet NISPOM security standards.

A previous incarnation of this used SNARE, SuSE 9.1, a munged
Fedora core and a lot of luck.  I'm hoping to do something more
out-of-the-box this time.

My belief is that the basics for SELinux are compiled into SuSE.
I could be wrong.

Here's what I've done to bring SELinux up on my test system:

Edited /boot/grub/menu.lst
Changed selinux=0 to selinux=1

Downloaded rpms for SuSE from:

http://www.cip.ifi.lmu.de/~bleher/selinux/suse/rpm-10.0/
rrrr
Installed with:
rpm -Uv --force  *rpm

Got base security policy from:
http://www.cip.ifi.lmu.de/~bleher/arch/selinux/policy/policy--snapshot/policy--

unpacked, did make.
Fails for lack of new netlink class, but installed *something*.

rebooted.
sestatus still returns disabled.
There is no /selinux pseudodirectory

Obviously I'm missing something.  Can someone point me to a simple
How-To for SuSE, or mention what I'm stupidly missing?
  
  Thanks,
  Clif

-- 
.... Clif Flynt ... http://www.cflynt.com ... clif@cflynt.com ...
.. Tcl/Tk: A Developer's Guide (2nd edition) - Morgan Kauffman ..
.....13th Annual Tcl/Tk Conference:  Oct, 2006,  Chicago, IL.....
.............  http://www.tcl.tk/community/tcl2005/  ............



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
