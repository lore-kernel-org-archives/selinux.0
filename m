Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7989grT023180
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 04:09:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7989dIn016019
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 08:09:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Alexis Wagner <venon@fugusec.net>
Subject: Re: net_contexts
Date: Mon, 9 Aug 2004 18:09:34 +1000
Cc: selinux@tycho.nsa.gov
References: <4116C9FA.3030203@fugusec.net>
In-Reply-To: <4116C9FA.3030203@fugusec.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408091809.34772.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Aug 2004 10:48, Alexis Wagner <venon@fugusec.net> wrote:
>  From what I have understood, every configuration files are concatenated
> when we compiled the policy.

Yes.

> So, if for some reasons, i want to define net_contexts related elements
> in another file, will it be ok ?

No.  Some parts of the file are order sensitive, net_contexts is one of them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
