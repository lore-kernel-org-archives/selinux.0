Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HBNjoS027521
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 07:23:45 -0400
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HBNipA002472
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 11:23:44 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.12.11.20060308/8.12.11) with SMTP id l3HBNipq011217
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 07:23:44 -0400
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id A0BAFBF9C
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 07:23:44 -0400 (EDT)
To: russell@coker.com.au
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: FCGlob
References: <200704172007.54844.russell@coker.com.au>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 17 Apr 2007 07:23:44 -0400
In-Reply-To: <200704172007.54844.russell@coker.com.au>
Message-ID: <ogtslaz5jnj.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> writes:

> Why would it be desirable to compile FCGlob to regular expressions?
> Once the performance benefits are proven we might as well go
> full-speed ahead.

I too spent some time thinking about the FCGlob paper.  I believe the
reason one wants to be able to translate FCGlob patterns into regular
expressions is so that one can implement the comparison function
described in the paper as follows:

   A comparison function that receives two patterns as parameters and
   returns the set relationship. Possible set relationships between
   the set of paths pattern A matches and the set of paths pattern B
   matches are: subset, superset, disjoint and ambiguous.

It seems to me that finite automata theory is called for.  The FCGlob
pattern language as described can easily be translated into a regular
expression.  A regular expression can be translated into a
deterministic finite automata without epsilon transitions.  It is easy
to convert this machine into one that recognizes the complement of its
language by complementing the set of final states of the machine.  A
machine that computes the intersection of two languages can be
produced by taking the cross product of the states of the machine for
each language.  Finally, it is easy to test if a machine accepts no
strings.  These primitives can be used to implement the comparison
function as specified.

Finite state machines can be designed so they have more interesting
outputs other than just accept or reject.  In particular, each state
can be associated with a set of security contexts.  A rejecting state
would be associated with the empty set, and an unambiguous state would
be associated with a singleton set.

If you look at the problem as a whole, it seems to me it is possible
to build one finite state machine for a file context that tests if a
pathname matches all the patterns at the same time, and produces a set
of security contexts as its answer.  Given a large number of patterns,
this approach should be very efficient as the input would be traversed
just once.  The only down side is one would have to invest the time to
generate this special purpose machine.

I happened to notice a relevant paper.  The translation of a regular
expression to a deterministic finite automata, typically starts by
translating it to a non-deterministic finite automata with epsilon
transitions.  For this step, the following paper may be helpful: "A
Simple Way to Construct NFA with Fewer States and Transitions" by
Guangming Xing.

Finally, I noticed that the library gfsm appears to export functions
that perform the operations described above.  I have never used the
gfsm library, so I cannot attest to its quality.

John



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
