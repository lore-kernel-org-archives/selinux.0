Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3AEOSRb000620
	for <selinux@tycho.nsa.gov>; Sat, 10 Apr 2004 10:24:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3AEMRUZ015813
	for <selinux@tycho.nsa.gov>; Sat, 10 Apr 2004 14:22:27 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i3AEMPmT015791
	for <selinux@tycho.nsa.gov>; Sat, 10 Apr 2004 14:22:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Rogelio Serrano <rogelio@smsglobal.net>
Subject: Re: booting in enforcing mode
Date: Sun, 11 Apr 2004 00:22:59 +1000
Cc: selinux@tycho.nsa.gov
References: <e0167eb7cd051c9258cc85cdf1a3e788@debian>
In-Reply-To: <e0167eb7cd051c9258cc85cdf1a3e788@debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404110022.59557.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 10 Apr 2004 17:10, Rogelio Serrano <rogelio@smsglobal.net> wrote:
> I can boot in enforcing mode now but there seem to be too many
> denials in my log. Which denials can be considered harmless? i
> can see a lot of ioctl, sys_tty_config and getattr.

Show us a sample of the messages.

When determining whether the denials are harmless it's usually a matter of the 
scontext and tcontext.

As for sys_tty_config, in the transition to kernel 2.6.x the handling of this 
changed and lots of applications need it.  I've considered having the 
daemon_base_domain() macro allow or dontaudit it.  Most applications that 
request it don't seem to really need it (they work fine without it).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
