Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25690
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 08:44:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA25104
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 12:42:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA25100
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 12:42:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
Date: Tue, 23 Apr 2002 14:44:06 +0200
References: <Pine.GSO.4.33.0204221825010.5657-100000@raven> <20020423115519.83E491916@lyta.coker.com.au> <20020423142051.A24878@lemuria.org>
In-Reply-To: <20020423142051.A24878@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020423124406.E6870B1A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Apr 2002 14:20, Tom wrote:
> > Think of terminals in Internet Cafe's and University computer labs.
>
> But how does a boot-password offer any protection in these settings?

Simple, if you don't have a password then anyone can enter
"linux init=/bin/bash" at the lilo prompt and take over the machine entirely!

> > > encrypted filesystem being the exception).
> >
> > An encrypted file system is not a magic bullet.  How does the machine
> > with the encrypted file system get it's unlock password?
>
> The same way that it gets the boot password. :)

No.  To boot with the default parameters you don't need a password.  You only 
need a password for maintenance mode.

> > Hosting centers that I am familiar with do not have enough security
> > cameras, and the locks on cabinet doors are easily pickable.  Someone who
> > has authorised access to one company's equipment (authorisation being
> > arranged by unencrypted and unsigned email over a public network) can do
> > whatever they like to other machines.
>
> No security-aware hosting center will let run people around
> unsupervised unless every customer has a steel-cage of his own.

There aren't many security aware hosting centers.

There was one time I accidentally locked my security pass and keys inside the 
hosting room, they let me in without even verifying that there were indeed 
keys and a pass inside the room!  Then the cage in that room was always kept 
unlocked because the key was lost, and a window was open because the 
air-conditioning system was over-loaded.  ;)

> > But that's beside the point.  The fact that some people choose to not use
> > a particular security method does not mean that I will choose to not
> > support it.
>
> I agree. The point was that lilo.conf may or may not be especially
> sensitive, depending on the setup. It may be, but similiar points may
> be made for many other files (/etc/ppp/*.secrets, snmp config files,
> quite a lot of things actually).

So we provide a different type for it and let the users decide who gets 
access to that type.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
