Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAUKM8Rb003636
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 15:22:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAUKLTp5022140
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 20:21:29 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAUKLSt0022137
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 20:21:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bastian Blank <bastian@waldi.eu.org>, selinux@tycho.nsa.gov
Subject: Re: policy problems
Date: Mon, 1 Dec 2003 07:22:01 +1100
References: <20031130183701.GA14242@wavehammer.waldi.eu.org>
In-Reply-To: <20031130183701.GA14242@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312010722.01551.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Dec 2003 05:37, Bastian Blank <bastian@waldi.eu.org> wrote:
> i found the following problems with the policy:
> - admins on the local console are not allowed to write to /dev/console
>   background: s390 don't know about vts, so this is the only console.

This is a problem.  Daemons and start scripts want read/write access to /dev/
console at boot time.  We do not want to grant daemons access to the 
administrator's terminal when they are logged in.

One option would be to change the context of /dev/console to tty_device_t 
after the system start scripts are complete, and then change it to 
console_device_t in the very first stages of boot (maybe from init).

Another option is to have the boot scripts write to a pty and then have a 
process proxy the data to /dev/console.

We get the same issues if you setup Red Hat in UML as a getty is provided on
/dev/console by kudzu.

> - noone is allowed to use nfs, maybe you should add some examples.

The problem here is that there is no good support for nfs.  I keep hearing 
rumors about people working on it but nothing concrete.  Does anyone know 
anything?

> - inetd don't get the correct domain. the correct policy, inetd.te is
>   included and the file is labeled correcly but the process remains in
>   initrc_t.

Strange.  Are you sure it had the correct type label at boot time?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
