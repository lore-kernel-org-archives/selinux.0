Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3RNMPI4021643
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 19:22:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3RNMHVf022642
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 23:22:18 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h3RNMF4D022572
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 23:22:16 GMT
Date: Mon, 28 Apr 2003 09:22:12 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Robert Bihlmeyer <robbe@orcus.priv.at>, selinux@tycho.nsa.gov
Subject: Re: broad domains
Message-ID: <20030427232212.GA31146@snoopy.apana.org.au>
References: <87n0ilej7x.fsf@orcus.priv.at> <200304251321.07207.russell@coker.com.au> <87of2r9apb.fsf@orcus.priv.at> <200304280314.59792.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200304280314.59792.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 28, 2003 at 03:14:59AM +1000, Russell Coker wrote:
> The problem is in categorising the games.  There are a huge number of games, 
> they are being written and re-written all the time.  For something that's 
> easy to setup having a single domain for all of them works reasonably well.

Why not just something like:

uses_network(thegame)
uses_tty(thegame)
uses_x_window(thegame)
rw_game_scores(thegame)

(not crossreferenced at all with existing policy)

Atually this raises an issue I have been thinking of lately,
I am not sure I like the uses_network (or whatever it was
called).

Typically a game may need to:

- bind to specific TCP port.
  Receive connections to this TCP port.
  Send/receive data on this TCP port.

- bind to specific UDP port.
  Send/receive data on this UDP port.

- send/receive TCP/UDP data on domain port to DNS server listed in
  /etc/resolv.conf.

But an attacker could also do other stuff that the game doesn't need to
do. Like:

- connect to a computer inside a private network with a port like 137,
139, or another one that is denied access at the firewall, and try to
attack it.

- connect to SMTP port of random computers on outside (or inside)
network and send lots of SPAM. At least some computers inside network
will probably act at relays to the outside world, making it clear where
the SPAM came from...

- act as a relay and relay private DNS domains to an attacker on the
outside world (this in particular may be a problem to fix).

I am not sure if it is possible to solve these issue.

Obviously there is also the issue that it would be silly to run such
a public game on the same network you want to keep secure (it would
probably be better to put it on its own network with a firewall that
disallows outgoing connections for instance), here I am looking for a
potential SE-Linux solution rather then a solution envolving redesign of
the network.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
