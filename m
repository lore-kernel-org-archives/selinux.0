Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANLrBIi015583
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 16:53:12 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANLr9au005594
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 21:53:14 GMT
Received: from lkcl.net (host81-153-247-118.range81-153.btcentralplus.com [81.153.247.118])
	by open.hands.com (Postfix) with ESMTP id B1514BF76
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 21:53:00 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CWilM-0001Vb-Sa
	for selinux@tycho.nsa.gov; Tue, 23 Nov 2004 22:03:52 +0000
Date: Tue, 23 Nov 2004 22:03:52 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: xen 2.0 - adding selinux permissions
Message-ID: <20041123220352.GF5146@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i'm considering doing some mods on xen 2.0's management interface,
if i can justify the work.

at present, the xen "master", which is the first virtual machine fired up,
is allowed access to the xen control system (running in x86 ring 0) via
/proc/xen.

some ioctl commands represent things like "start a new virtual machine",
"stop one", "suspend this session to disk" that sort of thing.

then, what the xen developers have done is to write a web
interface (using twisted python *gibber*) which presents
virtually unrestricted (*gibber*) access to that /proc/xen
interface on port 8000, using HTTP.

then there is a command xm which connects to port 8000 and issues
commands over the network port.

apparently it is possible to implement authentication with
the twisted python framework, so it's not _all_ bad - plus,
if you're running a cluster, security restrictions just... get
in the way!!!


what i would _like_ to do is:

- take out the HTTP access and merge the xm http client with the xend
  http server.

- add in some new selinux security ids representing the xen commands
  (create virtual machine, list virtual machines, shutdown a machine,
   suspend-a-session-to-disk, etc.)

- write an selinux policy restricting the xm command to be the only
  thing that is allowed to perform those operations.


so: is this a practical proposition?

i've looked at security/selinux/hooks.c - is it a simple matter of, say,
copying the file ioctl command?

should i be adding a new function to the LSM function table, examining
the xen ioctl kernel call and calling the new security function in the
xen ioctl?

if i add a new function to the LSM function table, then presumably that
means that someone could write a linux "capabilities" function too, yes?

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
