Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FFHfI4018687
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 11:17:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4FFHLl5011279
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 15:17:21 GMT
Received: from torexch1.mykotronx.com (host-65-119-11-194.mykotronx.com [65.119.11.194] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id h4FFHGNc011270
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 15:17:20 GMT
Message-ID: <FD2221F5E1A8184DB61AFCE064C395F1C920C3@torexch1.mykotronx.com>
From: CNGUYEN <CNguyen@mykotronx.com>
To: "'Russell Coker'" <russell@coker.com.au>,
   SE Linux
	 <selinux@tycho.nsa.gov>
Subject: RE: memory used by SE Linux
Date: Thu, 15 May 2003 08:01:10 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Excellent! Great work.

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Thursday, May 15, 2003 7:58 AM
To: SE Linux
Subject: Re: memory used by SE Linux


BCC'd to you and sent to the list for general reference.

On Fri, 16 May 2003 00:52, anonymous wrote:
> Can we use this ARM SELinux port on Xscale processors?

Absolutely.  I do all my work on Xscale machines, the price/performance
ratio 
of other ARM machines doesn't seem to be nearly as good so Xscale is the one

to go for.

I expect my code not to operate on all ARM platforms, but as I haven't
tested 
it on anything other than Xscale I can't be certain.

Also whenever I produce binaries they will be for Xscale, I don't think it's

beneficial for me to produce binaries that I can't properly test.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
