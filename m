Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JE7KRb010396
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 10:07:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JE4tB2015712
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:04:55 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4JE4bwi015560
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:04:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Date: Thu, 20 May 2004 00:05:52 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040519074242.GK7348@lkcl.net>
In-Reply-To: <20040519074242.GK7348@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405200005.52165.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 May 2004 17:42, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> is this pretty much all that's required???  compared to the 2.4 stuff
> it's like tiny.

In addition to the issues Steve mentioned, there is (or was) another problem.  
There were compilation problems with the SE Linux headers last time I tried 
to compile kdm.  As kdm is in the middle of a huge package that takes ages to 
compile I hadn't got around to trying to compile it recently.  In your 
message you didn't mention whether you successfully compiled the code with 
the patch in question.  Does it compile?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
