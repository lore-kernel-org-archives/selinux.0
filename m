Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5J4bYrT021800
	for <selinux@tycho.nsa.gov>; Sat, 19 Jun 2004 00:37:37 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5J4bKVl025443
	for <selinux@tycho.nsa.gov>; Sat, 19 Jun 2004 04:37:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: realtime LSM
Date: Sat, 19 Jun 2004 14:37:14 +1000
Cc: geiger@debian.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200406191437.14088.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://www.joq.us/realtime/

The above URL has a LSM module for real-time control.  I have pasted in the 
README file below to describe what it does.

The INSTALL document states that using CONFIG_SECURITY_SELINUX=y is required, 
this would either be a bug or a misunderstanding AFAIK.  There should not be 
a requirement for SE Linux to be compiled in to use another security module.


		    Realtime Linux Security Module

  Copyright (C) 2003 Torben Hohn
  Copyright (C) 2003, 2004 Jack O'Quin

This Linux Security Module (LSM) enables realtime capabilities.  It
was written by Torben Hohn and Jack O'Quin, who make no warranty
concerning the safety, security or even stability of your system when
using it.  It is provided under the provisions of the GPL (see the
file COPYING in this directory).

This LSM requires a 2.6 kernel.  It might work with a 2.4 kernel that
has the SELinux security hooks installed, but that has not been
tested.  

INSTALL gives a brief description of how to build and install this
program as a kernel module.

Once the LSM has been installed and the kernel for which it was built
is running, the root user can load it and pass parameters as follows:

  # modprobe realtime any=1

  Any program can request realtime privileges.  This allows any local
  user to crash the system by hogging the CPU in a tight loop or
  locking down too much memory.  But, it is simple to administer.  :-)

  # modprobe realtime gid=29

  All users belonging to group 29 and programs that are setgid to that
  group have realtime privileges.  Use any group number you like.

  # modprobe realtime mlock=0

  Grants realtime scheduling privileges without the ability to lock
  memory using mlock() or mlockall() system calls.  This option can be
  used in conjunction with any of the other options.

  # modprobe realtime allcaps=1

  Enables all capabilities, including CAP_SETPCAP.  This is equivalent
  to the 2.4 kernel capabilities patch.  It is needed for root
  programs to assign realtime capabilities to other processes.  This
  option can be used in conjunction with any of the other options.

  The JACK Audio Connection Kit (jackit.sourceforge.net) includes a
  `jackstart' program which uses CAP_SETPCAP to run the JACK daemon
  and its clients with realtime capabilities.

  There are serious security exposures with CAP_SETPCAP.  If an
  attacker manages to subvert some system daemon running with root
  privileges, it can use this capability to deny needed privileges to
  other root processes.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
