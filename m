Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8S3hXsJ007356
	for <selinux@tycho.nsa.gov>; Sat, 27 Sep 2003 23:43:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8S3hXCG026144
	for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2003 03:43:33 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8S3hUqJ026141 for <selinux@tycho.nsa.gov>; Sun, 28 Sep 2003 03:43:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bill Laut <wlsel@verizon.net>
Subject: Re: Emacs major mode for policy editing
Date: Sun, 28 Sep 2003 13:43:23 +1000
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <1064504193.3885.14.camel@moss-tarheels.epoch.ncsc.mil> <200309272024.54251.russell@coker.com.au> <200309271624.17976.wlsel@verizon.net>
In-Reply-To: <200309271624.17976.wlsel@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309281343.23332.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 28 Sep 2003 06:24, Bill Laut wrote:
> > At this point I should mention that Security Enhanced X is an important
> > development for Linux, it's something that we've been waiting far too
> > long for, and when it's available I'm sure we won't be able to get enough
> > of it.
>
> I couldn't agree with you more.  That's why, for my contribution, I want
> everyone who is interested to review it and tell me where I'm in error, or
> where something could be better designed, so that what I eventually release
> to the group is a polished gem.
>
> I have no ego problems with peer review/criticism whatsoever.

I agree that extensive review is a good thing.  One of the reasons for my work 
on UML and SE Linux is so that images of SE Linux machines can be exchanged 
for review.  I'm sure that exchanging images of Security Enhanced X will 
become a popular past-time for many people.

> That's also why I threw in the reference to "extra homework" in my previous
> post.  For example, this could be a good excuse to go through XFree86 and
> insure that there aren't any unrecognized buffer-overflow vulnerabilities.
> It would be embarassing to say the least to release SE-X, only to have it
> contain exploitable BO vulnerabilities--the very thing that SELinux is
> advertised as protecting against.

Absolutely!  However it should be noted that SE Linux has a very expressive 
configuration language which allows detailed control over what is allowed.  
If an administrator desires Back-Orifice access to their network then the 
Security Enhanced X configuration will surely allow them to enable it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
