Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3CE25Rb008440
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 10:02:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3CE24mw011828
	for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 14:02:04 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i3CE234w011625 for <selinux@tycho.nsa.gov>; Mon, 12 Apr 2004 14:02:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: David Caplan <dac@tresys.com>
Subject: Re: Sepcut Relabel problem
Date: Tue, 13 Apr 2004 00:00:39 +1000
Cc: Valdis.Kletnieks@vt.edu, Mark Shakespeare <mshakes@llnl.gov>,
   selinux@tycho.nsa.gov, selinuxdev <selinux-dev@tresys.com>
References: <p06100503bc98ecccb8c1@[128.115.96.64]> <200404071008.i37A8d9U011172@turing-police.cc.vt.edu> <407429A6.5090606@tresys.com>
In-Reply-To: <407429A6.5090606@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404130000.39971.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 Apr 2004 02:17, David Caplan <dac@tresys.com> wrote:
> The "rm" line appears to have been added relatively recently to the
> relabel target.  My guess is that the rationale was that many of the
> files in /tmp were no longer labeled correctly after a relabel because
> most of them would have been created via a file transition rule (and
> thus a relabel would change them all to incorrect/default labels, most
> likely denying access to the files anyway if the system were in
> enforcing mode).

Your guess is correct.  Correctly labelling all the files in /tmp is virtually 
impossible.  Leaving existing entries in /tmp as file_t does not work as many 
programs use fixed file names (of course that's usually a bad idea, but 
that's another discussion) and won't work if the file names exist and can't 
be unlinked.

There are two solutions to this problem, one is to have your system clean /tmp 
on reboot (as is done in Debian).  The other is to have a relabel clean 
out /tmp.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
