Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1O79ARb021710
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 02:09:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1O799QQ018473
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 07:09:09 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i1O78eP0018407 for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 07:08:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: identity
Date: Tue, 24 Feb 2004 18:07:12 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200402231535.26738.russell@coker.com.au> <200402241054.45407.russell@coker.com.au> <200402240308.i1O38Nu6011811@turing-police.cc.vt.edu>
In-Reply-To: <200402240308.i1O38Nu6011811@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402241807.12390.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Feb 2004 14:08, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 24 Feb 2004 10:54:45 +1100, Russell Coker said:
> > If it's a plain text field that's set by the login process then an identd
> > lookup could be performed, and any other data that seems relevant could
> > be included.
>
> (Mostly for the archives, in case a newbie trawls up the thread...)
>
> If I'm running an identd server, it's not so you can make authentications
> decisions based on it.  It's so that if I have a multi-user system, and one
> of my users misbehaves, you can give me the string my machine sent you and
> then I'll know which of my users I need to beat the snot out of. ;)
>
> And of course, if my box is compromised or under the control of an
> adversary, the "authentication" provided by identd is "trust me"....

The same thing applies to IP addresses.  This is why I suggested just having 
it as essentially a comment.  It wouldn't be used for authentication, just 
for tracking the apparent cause of any problems.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
