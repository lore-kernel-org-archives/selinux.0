Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HHpf5v018709
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 13:51:41 -0400
Received: from smtp-mclean.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HHpdC3020164
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 17:51:40 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.12.11.20060308/8.12.11) with SMTP id l3HHpc4p031903
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 13:51:38 -0400
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (Postfix) with ESMTP id A820F1BE39
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 13:51:38 -0400 (EDT)
To: "Christopher Ashworth" <cashworth@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Subject: Re: FCGlob
References: <6FE441CD9F0C0C479F2D88F959B01588A7153E@exchange.columbia.tresys.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 17 Apr 2007 13:51:38 -0400
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588A7153E@exchange.columbia.tresys.com>
Message-ID: <ogtzm56khxx.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Christopher Ashworth" <cashworth@tresys.com> writes:

> Ack!  Wait!  Danger!  Will Robinson!  :)

I'm laughing.  I watched first runs of that show.  I hope your arms
were flailing as you wrote that text.

> Since in a subsequent email you said "I have no experience
> implementing finite state machines" I assume that what you mean
> above by all the "it is easy" bits is that it is easy in theory.

This is correct.  It could be easy in practice, I just don't know.

> That's why the current file context system uses heuristics instead
> of a real sorting algorithm.

The paper states that an FCGlob prototype would require creating:

   A comparison function that receives two patterns as parameters and
   returns the set relationship. Possible set relationships between
   the set of paths pattern A matches and the set of paths pattern B
   matches are: subset, superset, disjoint and ambiguous.

I speculated that finite automata is required to implement the
comparison function as specified.  Do you have an alternative
algorithm that meets the above specification?  I don't recall seeing
one in the paper.

> But the observation at hand is that replacing regular expressions in
> the file context specs would buy us a lot of improvements.

As I said at the meeting, I like the idea of using file globbing
syntax as I agree with your assertion they are less error prone.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
