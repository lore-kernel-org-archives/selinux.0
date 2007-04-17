Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HG8a3S011705
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 12:08:36 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3HG8Z6q004368
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 16:08:36 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: FCGlob
Date: Tue, 17 Apr 2007 12:08:20 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588A7153E@exchange.columbia.tresys.com>
In-Reply-To: <ogtslaz5jnj.fsf@oolong.mitre.org>
From: "Christopher Ashworth" <cashworth@tresys.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hullo John,

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of John D. Ramsdell
> Sent: Tuesday, April 17, 2007 7:24 AM
> To: russell@coker.com.au
> Cc: SE-Linux
> Subject: Re: FCGlob
> 
> Russell Coker <russell@coker.com.au> writes:
> 
> > Why would it be desirable to compile FCGlob to regular expressions?
> > Once the performance benefits are proven we might as well go 
> > full-speed ahead.
> 
> I too spent some time thinking about the FCGlob paper.  I 
> believe the reason one wants to be able to translate FCGlob 
> patterns into regular expressions is so that one can 
> implement the comparison function described in the paper as follows:

[...snip...]
 
> It seems to me that finite automata theory is called for. 
> The FCGlob pattern language as described can easily be 
> translated into a regular expression.  A regular expression 
> can be translated into a deterministic finite automata 
> without epsilon transitions.  It is easy to convert this 
> machine into one that recognizes the complement of its 
> language by complementing the set of final states of the 
> machine.  A machine that computes the intersection of two 
> languages can be produced by taking the cross product of the 
> states of the machine for each language.  Finally, it is easy 
> to test if a machine accepts no strings.  These primitives 
> can be used to implement the comparison function as specified.

Ack!  Wait!  Danger!  Will Robinson!  :)

One of the goals for using FCGlob is to avoid everything you just
described.

Since in a subsequent email you said "I have no experience implementing
finite state machines" I assume that what you mean above by all the "it
is easy" bits is that it is easy in theory.  No arguments there.  I
think one of the main points of FCGlob is that it is NOT easy in
practice.  That's why the current file context system uses heuristics
instead of a real sorting algorithm. 

I'm not trying to bash on the idea of using FAs in theory, because a lot
of the points you make are interesting.  But the observation at hand is
that replacing regular expressions in the file context specs would buy
us a lot of improvements--not the least of which is that we wouldn't
have to sort the darn things with a complicated finite automata
mechanism to get proper sorting.

Cheers,
Christopher


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
