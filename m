Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA01110
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2001 08:05:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA20122
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2001 13:05:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA20118
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2001 13:05:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: 2.4.13?
Date: Thu, 1 Nov 2001 14:01:04 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0111010710350.18915-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0111010710350.18915-100000@raven>
MIME-Version: 1.0
Message-Id: <20011101130105.18C0B5B26@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 1 Nov 2001 13:22, Stephen Smalley wrote:
> > Are you planning to release a 2.4.13 patch for selinux any time soon?
> >
> > I am wondering whether I should delay my work and wait for it or whether
> > I should apply the 2.4.12 patch to 2.4.13 and keep going...
>
> We updated internally to lsm-2001_10_24 against 2.4.13 back when it came
> out, but the NSA didn't make a new release, probably because we had just
> released on 10/16 and new stable versions seem to be rather frequent right
> now.

Actually stable releases aren't coming out very often at the moment.  Quite 
unstable releases with stable version numbers are coming out often.  :(

> Looks like 2.4.14 might be out soon, so I would expect us to wait
> for it.  If you really need a patch for 2.4.13 now, let me know - as I
> recall, you'll need a patch to the SELinux module to add a new hook
> defined by lsm-2001_10_24.

Thanks for the offer, I'll resume work on 2.4.12 then.  For most of what I'm 
doing it doesn't matter too much what version I use.

However if you plan some changes to the way the packaging works (changes to 
makefiles, directory locations, etc) for 2.4.14 then I'd be interested in a 
pre-2.4.14 version.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
