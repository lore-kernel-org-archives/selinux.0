Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQ3sRRb017736
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 22:54:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAQ3sQqY021880
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 03:54:26 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAQ3sO0o021876 for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 03:54:25 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Still no authentication from new debian packages
Date: Wed, 26 Nov 2003 14:54:14 +1100
References: <20031125140255.GI2718@vnl.com> <20031125205010.GA2174@rom.cip.informatik.uni-muenchen.de> <20031125231100.GQ2718@vnl.com>
In-Reply-To: <20031125231100.GQ2718@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311261454.14965.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Nov 2003 10:11, Dale Amon <amon@vnl.com> wrote:
> > I also appended the line
> >         session required pam_selinux.so
> > to /etc/pam.d/{login,ssh}
>
> That is worth a look also. But I think Russell might

That is the right answer.  An updated login or ssh package is no longer 
needed.

I have to automate this somehow, unfortunately Debian policy prohibits 
interfering with the configuration files of another package.  Maybe I'll have 
to do a diversion.

> I suspect I'll be annoying Russ with trivia for
> quite some time.

No probs.  Tell me the problems and I'll fix them as fast as possible.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
