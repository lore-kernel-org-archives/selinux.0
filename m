Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i719tBrT006084
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 05:55:11 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i719sb52019323
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 09:54:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Nikolay" <nikolay@alexandrov.ws>
Subject: Re: Hi. Read below.
Date: Sun, 1 Aug 2004 19:55:06 +1000
Cc: selinux@tycho.nsa.gov
References: <200408010111.i711BglX013539@zombie.ncsc.mil>
In-Reply-To: <200408010111.i711BglX013539@zombie.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408011955.06067.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 1 Aug 2004 14:10, "Nikolay" <Nikolay@alexandrov.ws> wrote:
> Hello, I'm new to the mail list and to the SE linux project.
> Last night I read some pieces of the patched kernel and here is my idea:
> Correct me if I'm wrong (which is quite possible:) but I think that when
> new process is created the memory is not cleared (until it is written to?)

When a new process is create by fork() it has the same memory as it's parent, 
regardless of which UID is used.  When a process calls one of the exec(3) 
family of system calls it's entire address space is replaced by the new 
executable and all data space is cleared.  This is why SE Linux domain 
transitions are only permitted at exec time.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
