Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8ODkYsJ018221
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 09:46:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8ODiod0023336
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 13:44:50 GMT
Received: from dymwsm18.mailwatch.com (dymwsm18.mailwatch.com [204.253.83.220])
	by jazzswing.ncsc.mil  with ESMTP id h8ODinVY023315
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 13:44:49 GMT
Received: from mwsc0215.mw4.mailwatch.com (mwsc0215.mw4.mailwatch.com [204.253.83.251])
	by dymwsm18.mailwatch.com (8.12.9/8.12.9) with ESMTP id h8ODkQBm019040
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 09:46:26 -0400
Received: from fmpo1.azell.com (fmpo1.azell.com [136.1.7.9])
	by dymwsm10.mailwatch.com (8.12.9/8.12.9) with ESMTP id h8ODkQwL003027
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 09:46:26 -0400
Message-ID: <F5441DDE18FFD9418974338018C522B718BDAC@na1fcm61.dearborn.ford.com>
From: "Inger, Slav (S.B.)" <vinger@ford.com>
To: "'russell@coker.com.au'" <russell@coker.com.au>,
   "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: Sample SELinux policy that's equivalent to standard root?
Date: Wed, 24 Sep 2003 09:46:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Wednesday, September 24, 2003 9:22 AM
To: Inger, Slav (S.B.); 'selinux@tycho.nsa.gov'
Subject: Re: Sample SELinux policy that's equivalent to standard root?

> The domain sysadm_t has 99% of the ability that "root" has on a non-SE 
> machine, of course you need to have both UID=0 and context 
> something:sysadm_r:sysadm_t to get full access.
> 
> Adding the ability to directly read /etc/shadow, block devices, and the few 
> things that are denied to sysadm_t is easy enough.  However in many cases 
> programs that you run will automatically transition to other domains which 
> have less access.  For example fdisk has no access files on a file system.  
> So if you want to do "fdisk < /root/commands > /tmp/output" then it will not 
> work.
> 
> Why would you want things to be other than they are in the default policy?


Because, like I said in the earlier message, I'd like to start with full root permissions and tighten up, instead of doing it the other way around.  Basically, I'd like to put together a quick POC where I'd like to demonstrate that while SE root can do everything a regular root can, several files and processes will be off limits to root.  Enabling 99% of typical root functionality manually is turning out to be a time consuming process.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
