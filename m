Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA29813
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 18:35:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA18338
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 22:35:25 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzband.ncsc.mil  with ESMTP id WAA18334
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 22:35:24 GMT
Received: from fwsystems.com (localhost [127.0.0.1]) by mozart.fwsystems.com (AIX4.3/UCB 8.8.8/8.8.8) with ESMTP id SAA56520 for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 18:35:38 -0400
Message-ID: <3B5CA6BA.955EDD95@fwsystems.com>
Date: Mon, 23 Jul 2001 18:35:38 -0400
From: Forrest Whitcher <fw@fwsystems.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Kerberos configuration?; running <- vmware; running afs < selinux
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


1.
I will be shortly sitting down to work out a kerberos_t domain
to run under selinux. If anyone's already done or started this
I'd be glad to know about it first! 

2.
I've been running under a dev-mode selinux kernel on real hardware
as well as inside a vmware VM with good results so far.

3.
I'm afraid this one may be non-trival to solve. After getting a
working AFS under the vanilla RH62 k2.2.19, I took a stab at 
running under selinux.

That runs but does not work, at the time of starting the afs
client. The expected "avc: denied {mounton} messages post, AFS
prints a diagnostic indicating "Can't mount AFS on /afs".

 (I haven't tried the server side yet, that will probably
be a simpler matter).

AFS patches the kernel with an insmod;  in the process of building
the patch the build broke over #includes which reached into the flask
header files, where in turn flask's .h's assumed a src build directory
was in the -I directives. I worked-around by adding an appropriate
-I pointing to where I'd built the selinux kernel, simple enough, 
however AFS is probably making some assumptions about the kernel
that are no longer valid < selinux.

I'm in the middle of trying to dig into the sources and figure out
what's breaking, I'll post it here if I make any headway.

forrest

-- 
Forrest Whitcher    Principal      FW Systems

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
