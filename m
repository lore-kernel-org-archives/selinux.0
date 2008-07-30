Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6U2mPBx029329
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 22:48:26 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6U2mM5v012000
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2008 02:48:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Paul Moore <paul.moore@hp.com>
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming
Date: Wed, 30 Jul 2008 12:47:59 +1000
Cc: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>, selinux@tycho.nsa.gov
References: <Pine.LNX.4.64L.0807210043160.7451@ruuvi.it.helsinki.fi> <Pine.LNX.4.64L.0807211546530.23634@ruuvi.it.helsinki.fi> <200807210938.31144.paul.moore@hp.com>
In-Reply-To: <200807210938.31144.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807301248.04810.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 21 July 2008 23:38, Paul Moore <paul.moore@hp.com> wrote:
> A few thoughts: others did not object to those variable names when the
> patches were proposed, or at any point prior to this thread, and no one
> besides you and I has commented on this thread.  This is a sign to me
> that the 'idx' variable name is not a significant distraction to the
> community.

One thing that is worth considering is the possibility that idx might be 
better for searching.

Lots of words contain an 'i' character and therefore searching for a variable 
named 'i' in a code base is going to be difficult (automated searching is 
mostly useless, probably the best option is to have your editor highlight 
every instance and visually scan for the ones with are not surrounded by 
brackets, braces, parenthesis, spaces, commas, or whatever else is not 
acceptable in a variable name in the language in question.

Of course if you have a syntax highlighting editor then it might parse enough 
of the language to avoid this (but that isn't always available), and if you 
have a language such as Perl a search for \$i should work reasonably well.

http://etbe.coker.com.au/2008/07/30/variable-names/

But using idx, index, or even names such as "count" which refer to the meaning 
of the program might be more efficient overall.  I've posted some more 
thoughts on this issue at the above URL.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
