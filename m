Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA12440
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 04:53:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA01887
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 08:51:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA01878
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 08:51:34 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, Tracy R Reed <treed@ultraviolet.org>
Subject: Re: SE Linux on Debian
Date: Wed, 2 Oct 2002 10:52:04 +0200
Cc: selinux@tycho.nsa.gov
References: <20021001153638.J5416@ultraviolet.org> <20021001232715.A28686@ultraviolet.org> <20021002092056.A4475@lemuria.org>
In-Reply-To: <20021002092056.A4475@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210021052.04154.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2 Oct 2002 09:20, Tom wrote:
> On Tue, Oct 01, 2002 at 11:27:15PM -0700, Tracy R Reed wrote:
> > Ah. Actually they were in
> >
> > /usr/share/selinux/policy/current/
> >
> > and
> >
> > /usr/share/selinux/policy/default/
> >
> > What's the difference? But I removed them and now the policy compiles.
> > Yeay!  Thanks for the help.
>
> That's just some symlinking, I believe.

No.  /usr/share/selinux/policy/default/ is the files shipped in the Debian 
package (use "dpkg -L selinux-policy-default" to see this).  
/usr/share/selinux/policy/current/ is the files that are actually in use, and 
the symlink /etc/selinux points to it.

There's no symlinks under /usr/share/selinux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
