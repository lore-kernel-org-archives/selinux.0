Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA06276
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 19:26:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA02971
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 23:24:56 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id XAA02967 for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 23:24:54 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Albert <christopher.albert@sympatico.ca>
Subject: Re: expect
Date: Sun, 27 Oct 2002 01:26:28 +0200
References: <200210262252.30567.russell@coker.com.au> <200210270007.51472.russell@coker.com.au> <3DBB2043.2010709@sympatico.ca>
In-Reply-To: <3DBB2043.2010709@sympatico.ca>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200210270126.28664.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Excellent!  That's what I need!

On Sun, 27 Oct 2002 01:07, Chris Albert wrote:
> maybe what you want is:
>
> /tmp/testit
> #!/usr/bin/expect
> eval spawn -noecho $argv
>
> And then run:
>
> ./testit.sh ls -a -l /tmp
>
>
> Chris

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
