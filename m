Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9VJMhWt021183
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 14:22:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9VJMNC7024938
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 19:22:23 GMT
Received: from lyta.coker.com.au (nat-pool-bos.redhat.com [66.187.230.200])
	by jazzswing.ncsc.mil  with ESMTP id h9VJMNuw024934
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 19:22:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: user's access to files in their own home directory
Date: Sat, 1 Nov 2003 06:17:43 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310310610.14859.russell@coker.com.au> <20031030234711.GA31194@snoopy.apana.org.au>
In-Reply-To: <20031030234711.GA31194@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311010617.43597.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 31 Oct 2003 10:47, Brian May wrote:
> > So far in writing the policy I have allowed the user full access to files
> > in their own home directory, with the exception of gpg where secrecy
> > requires that the user's processes often be denied read access.
> >
> > I would like some feedback on how people feel about having files/dirs
> > under a user's home directory that they can't unlink or rename.
>
> This would seem to imply a useability/security tradeoff that is
> dependant on the security requirements of the computer.
>
> However, what files/dirs are you thinking of?

Maildir
www/web/public_html
.ssh
.gnupg (already done)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
