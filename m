Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7KGmqLa023143
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2003 12:48:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7KGmkfF012295
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2003 16:48:46 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h7KGmiHd012242 for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2003 16:48:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ripin Natani" <ripinfs@hotmail.com>, "selinux" <selinux@tycho.nsa.gov>
Subject: Re: "Unable to mount root fs on unknown-block(0,0)"
Date: Thu, 21 Aug 2003 02:48:28 +1000
References: <BAY8-DAV65gIXre2awF00029870@hotmail.com>
In-Reply-To: <BAY8-DAV65gIXre2awF00029870@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308210248.28168.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Aug 2003 00:09, Ripin Natani wrote:
> I also updated the mkinitrd (now i have the 3.4.42 version). Does that have
> the patch ? Btw I did not find any documentation in linux2.6/README about
> the patch for the mkinitrd script. ( I hope i looked at the right README
> !!! ).
> The system is still giving the same error !
> Also I am resending the .config file.

The .config file you attached still has the CONFIG_SECURITY options turned off 
which means that either you attached the wrong .config file or you did not 
compile a SE Linux kernel.

If the .config file is the correct file then it indicates that the problem is 
a general 2.6 kernel issue not a SE Linux issue, in which case this list 
probably isn't going to be the best source of advice on the matter.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
