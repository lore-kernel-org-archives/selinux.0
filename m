Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA11529
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 08:26:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB6DQXI08288
	for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 13:26:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gB6DQWf08284 for <selinux@tycho.nsa.gov>; Fri, 6 Dec 2002 13:26:32 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Wayne Salamon <wsalamon@tislabs.com>
Subject: Re: new policy
Date: Fri, 6 Dec 2002 14:26:07 +0100
Cc: Chris Vance <cvance@tislabs.com>, <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0212060724020.27022-100000@vox.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0212060724020.27022-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <200212061426.07762.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Dec 2002 13:33, Wayne Salamon wrote:
> On Thu, 5 Dec 2002, Russell Coker wrote:
> > If something is specific to a particular distribution then it should be
> > surrounded by an appropriate ifdef.  Otherwise the policy for all
> > distributions bloats causing wasted disk space everywhere.  If you want
> > to put SE Linux on devices such as iPaq's then you don't want to be doing
> > such things.
>
>   No, the policies should be separate, in my opinion. Creating strong,
> static couplings between pieces of the policy that have no logical
> connection is bad. It's a variant of using data as meta-data, which has
> caused more problems than (put your favorite bad thing here).

Which are the pieces of policy that have no logical connection?

Where exactly is the data-as-metadata issue?

> > Actually there's probably quite a few things that are Debian specific in
> > the main policy because I'm writing lots of policy and no-one is checking
> > whether it's the same way in other distributions.  We should probably
> > work on these things.
>
>   Yes, by keeping them out of the supported, RedHat policy that is part of
> the distribution. Otherwise, we need a reliable means of detecting what
> system we are on in order to build the policy. Checking the existence of a
> policy piece you think is only on one type of system isn't the solution.

Sure you could remove dpkg.te from the CVS.  But that wouldn't make the 
distributed policy RH only.  There's policy for many daemons in there that I 
wrote which has not been greatly tested under RH.  Someone would have to 
spend some serious amounts of effort testing and analysing the policy to 
determine which bits are Debian specific.

What do you think of Brian's work on XML for policy?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
