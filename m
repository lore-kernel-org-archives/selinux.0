Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA06094
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 18:08:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA00972
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 22:06:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA00968 for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 22:06:10 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Albert <christopher.albert@sympatico.ca>
Subject: Re: expect
Date: Sun, 27 Oct 2002 00:07:51 +0200
Cc: selinux@tycho.nsa.gov
References: <200210262252.30567.russell@coker.com.au> <3DBB09DF.2020303@sympatico.ca>
In-Reply-To: <3DBB09DF.2020303@sympatico.ca>
MIME-Version: 1.0
Message-Id: <200210270007.51472.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 26 Oct 2002 23:32, Chris Albert wrote:
> Russell Coker wrote:
> >I want to run an expect script as:
> >script program param1 param2 ...

OK, I think I didn't make it clear what I want to do.  Say I want to run ls 
with a variety of parameters, I save the following as /tmp/testit:

#!/usr/bin/expect

spawn /bin/ls [lrange $argv 0 end]
interact


Then I type the following command:
/tmp/testit -l -a /tmp

I want the same result as "ls -l -a /tmp" but I don't get it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
