Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8OIjisJ019770
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 14:45:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8OIitCg006749
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 18:45:38 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8OEIs1A022764 for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 14:18:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Inger, Slav (S.B.)" <vinger@ford.com>,
   "'russell@coker.com.au'" <russell@coker.com.au>,
   "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Sample SELinux policy that's equivalent to standard root?
Date: Thu, 25 Sep 2003 00:18:48 +1000
References: <F5441DDE18FFD9418974338018C522B718BDAC@na1fcm61.dearborn.ford.com>
In-Reply-To: <F5441DDE18FFD9418974338018C522B718BDAC@na1fcm61.dearborn.ford.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309250018.48101.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Sep 2003 23:46, Inger, Slav (S.B.) wrote:
> > Why would you want things to be other than they are in the default
> > policy?
>
> Because, like I said in the earlier message, I'd like to start with full
> root permissions and tighten up, instead of doing it the other way around. 
> Basically, I'd like to put together a quick POC where I'd like to
> demonstrate that while SE root can do everything a regular root can,
> several files and processes will be off limits to root.  Enabling 99% of
> typical root functionality manually is turning out to be a time consuming
> process.

sysadm_t has 99% of typical root functionality.

Off the top of my head the things that sysadm_t can't do are:
1) fdisk > file

2) direct access to /etc/shadow (all the usual tools work with wrappers).

3) Start daemon with usual scripts (have to use run_init).

4) sysadm_crond_t has little access

What things have been giving you problems?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
