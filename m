Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8E4UELa005036
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 00:30:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8E4UDmw017131
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 04:30:13 GMT
Received: from digitasaru.net (h1ab.lcom.net [216.51.237.171])
        by jazzband.ncsc.mil  with ESMTP id h8E4UC9d017128 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 04:30:12 GMT
Received: from trelane by digitasaru.net with local (Exim 4.20)
	id 19yOWV-0001dC-RA
	for selinux@tycho.nsa.gov; Sat, 13 Sep 2003 23:30:07 -0500
Date: Sat, 13 Sep 2003 23:30:07 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: selinux@tycho.nsa.gov
Subject: New Potential Research Area for SELinux
Message-ID: <20030914043007.GD5651@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

A new potential area for SELinux to research is sandboxing native code
  and system spoofing (emulation, if you prefer).
While this is already done to an extent in some systems (e.g. Gentoo's
  portage system can "sandbox"), usually through a special kernel code
  and/or playing with dynamic linking (e.g. making programs load special
  libraris), to my knowledge.  The problem with playing with dynamic linking
  is apparent if you consider sandboxing statically linked applications.
  The problem with special kernel code is that you have to play around in
  the kernel itself, which requires root access and isn't always feasible
  (e.g. in Windows).  This also requires rules to be handed down by the
  administrator; users cannot control what the programs can and cannot do
  without special workarounds.
A much more robust sandboxing solution can be created when you go to the
  chip emulation layer.  If you have a virtual PC (e.g. VirtualPC for the
  Mac or bochs (iirc)), you can intercept system calls and modify or reject
  them as desired.  The most obvious application of this is permitting or
  denying file access, specifically writing files or dealing with networking
  (to prevent the next Blaster).  You can also modify just about anything
  desired, so the system spoofing part comes in here; you could, for
  instance, copy another system's /proc entries to make a program think it's
  running on a different machine or play with password/user lookup routines
  to fool a program.  Essentially, a user can tell the emulator how to set up
  an environment.  The original kernel will allow or deny things in the end,
  but the user can further restrict what her programs may do, without the
  administrator needing to intervene (which makes a degree of sense).
The biggest drawback to such a scheme is the overhead of emulating a whole
  system.  A much faster solution would be to create a virtual machine
  type system, like VMWare.  My knowlege in this area is quite hazy, but
  it is my understanding that the Linux kernel has hooks to allow a process
  to act as a virtual machine if the underlying hardware allows, and that
  interrupts and traps can then be, well, trapped and redirected or modified.
  This would be much faster than complete emulation, at the cost of extra
  work to ensure the security of the system.
Hope I'm not too far off my rocker; I think this would be an excellent
  system for running untrusted code (or even "trusted" code. ;)  Examples
  which immediately come to mind are executable email attachments and
  networked collaboration/p2p environments (part of my netshard project,
  which is part of what gave me the idea in the first place).
Sorry if someone's already thought of this.  I'd work on it, but I have
  about five active projects on the table already, and I have to succeed
  in grad school at the same time.  ;)

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"That is the key to the real monopoly in Redmond. _They_ control your data.
 Their products have the content needed to do your work locked up in their
 semantics, and their binary formats. Before we can start creating a bold
 new world, we've got to free the hostage content."  --Jody Goldberg, on /.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
