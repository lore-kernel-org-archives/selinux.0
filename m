Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13219
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 12:20:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA10384
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 16:20:14 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA10380
	for <selinux@tycho.nsa.gov>; Thu, 23 May 2002 16:20:11 GMT
Date: Fri, 24 May 2002 02:19:50 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: boot.msg
In-Reply-To: <3CECB29D.391E0E55@dr-baldeweg.de>
Message-ID: <Mutt.LNX.4.44.0205240216460.23338-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 May 2002, Carsten Grohmann wrote:

> Hi !
> 
> I found in my boot.msg follow lines:
> 
> Security Scaffold v1.0.0 initialized
> AVC:  allocated 14760 bytes during initialization.
> SELinux:  module inserted
> SELinux:  Starting in permissive mode
> There is already a security framework initialized, register_security
> failed.
> Failure registering capabilities with the kernel
> selinux_register_security:  Registering secondary module capability
> Capability LSM initialized
> 
> Is it OK with the "failed" in line 5? 
> 

Yes, this is normal, as the SELinux module is already loaded.  The 
capabilities module is then stacked explicitly by SELinux.


- James
-- 
James Morris
<jmorris@intercode.com.au>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
