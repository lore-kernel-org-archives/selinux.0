Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KFXqRb019823
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 11:33:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KFXdAR005509
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:33:40 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4KFXRHn005421 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 15:33:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: start of patch to dpkg's start-stop-daemon
Date: Fri, 21 May 2004 01:32:17 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040520084306.GL24597@lkcl.net>
In-Reply-To: <20040520084306.GL24597@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405210132.17391.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 May 2004 18:43, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> it's a patch to dpkg 1.10.21's utils/start-stop-daemon.c
> which causes a context switch just before
> the setuid/setgid calls.

What is the benefit in that?

start-stop-daemon is designed to be run from a /etc/init.d/* script.  That 
script will run as system_u:system_r:initrc_t and there will be a 
domain_auto_trans() rule to cause the daemon to be started as 
system_u:system_r:whatever_t.

start-stop-daemon is also run from cron jobs, in that case it will run as 
system_u:system_r:system_crond_t (in which case the program it runs will have 
any appropriate domain transition automatically), or it will run as the cron 
domain for the daemon (IE the script that calls start-stop-daemon has a 
domain transition *) and again it doesn't need to do anything special.

*)  domain_auto_trans() rules that allow script execution to have more privs 
than the calling code is bad.  But having the script execute with less privs 
is OK (not great but OK).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
