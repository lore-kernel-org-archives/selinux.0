Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAIE1tRb011591
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 09:01:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAIE1nqY011772
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 14:01:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAIE1m0o011769 for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 14:01:48 GMT
Subject: Re: capabilities and 2.4 vs 2.6
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200311181400.38347.russell@coker.com.au>
References: <200311181400.38347.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1069164102.6194.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 18 Nov 2003 09:01:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-17 at 22:00, Russell Coker wrote:
> It seems that the meaning of sys_tty_config has changed between 2.4 and 2.6.  
> When comparing a 2.4 kernel running the back-port of the new SE Linux code to 
> 2.6.0-test9 I find that many applications request sys_tty_config in 2.6 that 
> did not in 2.4.  Examples include FreeRADIUS, a bash script from the startup 
> of CIPE, and courier-authdaemon.
> 
> Another issue is that on 2.6 the "atsadc" program from the atsar package now 
> seems to want sys_admin capability, while on 2.4 it did not.  But it seems to 
> work OK without such access (the base functionality works - not sure if I'm 
> missing something).  In any case it may be best to lose a bit of 
> functionality to avoid granting sys_admin...

A number of legacy superuser (suser) checks were finally replaced
with capability (capable) checks in 2.6.  So 2.4 would have just
required euid 0 in those cases, whereas 2.6 is now checking a particular
capability.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
