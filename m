Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5AMkRb003719
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 05:22:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB5AMjRV020309
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 10:22:46 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hB5AMhta020301 for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 10:22:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Stephen" <mridion@hotmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: Debian Servers
Date: Fri, 5 Dec 2003 21:22:30 +1100
References: <EE5290A8F55F0C4B943C5940B6D73C8B442483@pusmde04.mt.pweh.com> <20031203195604.GC3442@hydra.joerghoh.de> <BAY1-DAV46Zim80P5hl00003221@hotmail.com>
In-Reply-To: <BAY1-DAV46Zim80P5hl00003221@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312052122.30528.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 5 Dec 2003 20:21, "Stephen" <mridion@hotmail.com> wrote:
> Wouldn't you be able to restrict execute access to unconfigured files and
> therefore the attacker couldnt launch the exploit code in the first place?

Yes, that can be done.  But preventing execution of files in user home 
directories is a significant functionality loss, I doubt that it would be 
possible to have the machines in question be usable if configured in such a 
manner.

Also if running a machine in such a manner all that the attacker would need to 
do is to exploit one binary to launch the attack.  Most binaries aren't 
considered as important to system security and aren't audited for such bugs.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
