Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA13411
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 08:28:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA15220
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:26:56 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
        by jazzband.ncsc.mil  with ESMTP id MAA15216 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 12:26:56 GMT
Date: Wed, 28 Aug 2002 07:28:24 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200208281228.HAA06721@tomcat.admin.navo.hpc.mil>
To: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ipsec access to { sysadm_tty_device_t sysadm_devpts_t }
In-Reply-To: <20020827213114.CD4302F61@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au>:
> 
> I have been having some discussions with Steve about access to { 
> sysadm_tty_device_t sysadm_devpts_t }.  We agree that giving all daemons 
> access to the administrator terminal is a bad idea in concept.
> 
> However some programs seem to require it.  The PCMCIA cardmgr program does 
> not seem to start correctly unless it has such access.
> 
> Now I'm working on ipsec which seems to require { read write ioctl getattr } 
> access to those device types for correct functioning.  As I am just learning 
> about IPSec I'm not in a good position to analyse this in detail, could 
> someone who knows it better please have a look and see if there's something 
> that can be done about it or whether it really needs such access.

Slightly OT/side question:

Which IPSec implementation are you starting with - NIST reference, Free/swan
or a completely new one?

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
