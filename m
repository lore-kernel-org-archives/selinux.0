Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8P8EJsJ022745
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 04:14:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8P8EJCG003433
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 08:14:19 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8P8EHqJ003430 for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 08:14:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Date: Thu, 25 Sep 2003 18:14:09 +1000
References: <F5441DDE18FFD9418974338018C522B718BDB0@na1fcm61.dearborn.ford.com> <20030924221157.GS21997@vnl.com> <20030925084613.H11866@lemuria.org>
In-Reply-To: <20030925084613.H11866@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309251814.09701.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Sep 2003 16:46, Tom wrote:
> That's also why others don't see that access. On Debian, for example,
> it defaults to /var/empty
>
> You might want to define a special type for the empty dir, so you can
> move it around and don't have to give sshd access to all of /var

I don't think it really needs a separate type.  Only search access should be 
required, and search access for /var is necessary to even get to
/var/empty...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
