Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA08927
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2002 16:52:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA13693
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2002 21:49:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA13683
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2002 21:49:47 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Vance <cvance@tislabs.com>
Subject: Re: new policy
Date: Thu, 5 Dec 2002 22:51:47 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0212051206030.25186-100000@zorg.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0212051206030.25186-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <200212052251.47349.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Dec 2002 18:08, Chris Vance wrote:
> On Tue, 3 Dec 2002, Russell Coker wrote:
> > diff -ruN /tmp/policy/domains/program/hwclock.te
> > ./domains/program/hwclock.te --- /tmp/policy/domains/program/hwclock.te  
> >    2002-12-03 15:56:40.000000000 +0
> > 100
> > +++ ./domains/program/hwclock.te        2002-08-21 20:22:44.000000000
> > +0200 @@ -45,3 +45,5 @@
> >  allow hwclock_t ptyfile:chr_file rw_file_perms;
> >  ifdef(`gnome-pty-helper.te', `allow hwclock_t sysadm_gph_t:fd use;')
> >
> > +# hwclock needs to search file_t directories when run from rc.sysinit on
> > RH8 +allow hwclock_t file_t:dir search;
> >
> > For the above change that's recently committed, shouldn't it have
> > ifdef(`rpm.te', around it?
>
> I'm just curious why you think this is necessary?  If anything I would
> have thought something more along the lines of ifdef(`hwclock.te',...)

Having ifdef(`hwclock.te' makes no sense inside the hwclock.te file.

> would be appropriate.  Neither are really specific to RH systems, and the
> permission itself isn't that critical.

If something is specific to a particular distribution then it should be 
surrounded by an appropriate ifdef.  Otherwise the policy for all 
distributions bloats causing wasted disk space everywhere.  If you want to 
put SE Linux on devices such as iPaq's then you don't want to be doing such 
things.

Actually there's probably quite a few things that are Debian specific in the 
main policy because I'm writing lots of policy and no-one is checking whether 
it's the same way in other distributions.  We should probably work on these 
things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
