Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06485
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 07:48:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA16424
	for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 11:46:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id LAA16420 for <selinux@tycho.nsa.gov>; Fri, 13 Sep 2002 11:46:35 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>,
        selinux@tycho.nsa.gov
Subject: Re: lsm on ac kernel
Date: Fri, 13 Sep 2002 13:46:09 +0200
References: <Pine.LNX.4.44.0209130957530.512-100000@coffeesaur>
In-Reply-To: <Pine.LNX.4.44.0209130957530.512-100000@coffeesaur>
MIME-Version: 1.0
Message-Id: <200209131346.09308.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Sep 2002 03:58, Rogelio M. Serrano Jr. wrote:
> Is there an selinux patch against the ac tree?

AFAIK there has never been such a patch.

Also the LSM part of the patch (the part that intercepts most system calls 
etc) is very invasive and tends to conflict with most other kernel patches.

I suggest that you ask on the LSM mailing list, maybe someone has made such a 
patch for their own use that they will be willing to share.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
