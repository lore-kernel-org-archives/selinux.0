Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KGQPRb020362
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:26:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KGQMAR009378
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:26:22 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
        by jazzband.ncsc.mil  with SMTP id i4KGQKHn009371 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:26:21 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 20 May 2004 16:26:20 -0000
Date: Thu, 20 May 2004 16:23:43 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: start of patch to dpkg's start-stop-daemon
Message-ID: <20040520162343.GL8810@lkcl.net>
References: <20040520084306.GL24597@lkcl.net> <200405210132.17391.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405210132.17391.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 21, 2004 at 01:32:17AM +1000, Russell Coker wrote:
> On Thu, 20 May 2004 18:43, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > it's a patch to dpkg 1.10.21's utils/start-stop-daemon.c
> > which causes a context switch just before
> > the setuid/setgid calls.
> 
> What is the benefit in that?
 
 uhm...

 mmm...
 
 it's easier than breaking pre-existing /etc/init.d/* scripts where 
 people expect the -u option to act as it should?

 in other words, the benefit in patching start-stop-daemon is to
 provide legacy transition support.

 i _really_ don't want the -u option on my custom /etc/init.d/custom
 script to suddenly start running the daemon as root.

 as an inexperienced SE/Linux user i might not _know_ that i have to
 write a domain_auto_trans() rule in the /etc/selinux policy.

 therefore all of a sudden, by upgrading to SE/Linux i suddenly have
 my -u option effectively ignored.

 under which circumstances, what you are saying is that
 because the script will run as system_u:system_r:initrc_t,
 and because that context will not have (shouldn't have!)
 permission to do anything outrageous, my startup script will
 break.

 well, that's better than nothing (an "i can't... " is a LOT
 better than "i didn't know it could...") , but it's still a pain.

 
 so, the benefit is: not so much pain.

 is that a good enough reason?

 sincerely,

 l.


> start-stop-daemon is designed to be run from a /etc/init.d/* script.  That 
> script will run as system_u:system_r:initrc_t and there will be a 
> domain_auto_trans() rule to cause the daemon to be started as 
> system_u:system_r:whatever_t.
> 
> start-stop-daemon is also run from cron jobs, in that case it will run as 
> system_u:system_r:system_crond_t (in which case the program it runs will have 
> any appropriate domain transition automatically), or it will run as the cron 
> domain for the daemon (IE the script that calls start-stop-daemon has a 
> domain transition *) and again it doesn't need to do anything special.
> 
> *)  domain_auto_trans() rules that allow script execution to have more privs 
> than the calling code is bad.  But having the script execute with less privs 
> is OK (not great but OK).
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
