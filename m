Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06495
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 08:07:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA19462
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 12:06:08 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA19458
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 12:06:07 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: latest policy patch
Date: Fri, 18 Oct 2002 14:07:40 +0200
References: <200210170017.38299.russell@coker.com.au> <20021017231011.GD15699@snoopy.apana.org.au> <20021018082000.D25703@lemuria.org>
In-Reply-To: <20021018082000.D25703@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210181407.40199.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 18 Oct 2002 08:20, Tom wrote:
> On Fri, Oct 18, 2002 at 09:10:11AM +1000, Brian May wrote:
> > One suggestion with selinux-policy-default:
> >
> > Installing the new policy should be optional when installing the Debian
> > package. Perhaps with a config option /etc/selinux-policy.conf (maybe)
> > or an extra question (but I am not a fan of all of these questions...).
>
> Yes, please. It could simply check if a policy is already installed,
> and if so, ask "should I update your policy?" just like every other
> debian package does before changing config files. It could then
> automatically step over all the files that I choose not to have the
> first time, to reduce the number of questions asked.

OK.  I'll make an upgrade ask you "update yes/no/never".

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
