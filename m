Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20306
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 09:20:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA14375
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 13:18:36 GMT
Received: from smails.tresys.com ([66.200.42.5])
        by jazzband.ncsc.mil  with ESMTP id NAA14371 for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 13:18:36 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'SE Linux'" <selinux@tycho.nsa.gov>
Cc: <treed@ultraviolet.org>, <pkarger@us.ibm.com>, <jaegert@us.ibm.com>,
        <russell@coker.com.au>
Subject: RE: IBM's Multics paper (let's not confuse assurance and mandatory security)
Date: Wed, 11 Sep 2002 09:21:00 -0400
Message-ID: <002b01c25996$22812290$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020909163557.K20187@ultraviolet.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I for one would like to thank Tracy for bringing this topic to the list;
it's is a central topic and should not shunted off this list.

I suggest that readers try to separate the ideas of "mandatory security"
mechanisms and "assurance" of correctness and completeness.   To their
credit, I do not believe that any of the SE Linux papers, and I
personally know that none of the SE Linux developers (despite Steve's
comments earlier), have asserted that SE Linux was a high-assurance OS
implementation. Perhaps the one fault with Roger and Paul's paper is
that it might leave the reader with that impression.  I believe SE Linux
was offered as an open-source implementation of DTE (and optionally MLS)
mandatory mechanisms, and was not offered as an example of a
high-assurance OS implementation.

If the reader is interested in making Linux/Unix easier to "harden" and
strengthen, then I endorse exploration of SE Linux (as we are doing).
Type-enforcement mechanisms are a good foundation for strong security,
and while there is great complexity in security policies, continued work
towards managing security policies will help us gain some control over
that complexity.  I do believe that a SE Linux, once complete and
reasonably tested and analyzed, provides a much better platform for
hardened applications than vanilla Linux/Unix.

However, if the reader is interested in high-assurance OSes, then I
strongly recommend reading Roger and Paul's papers (and all those they
reference!).  Don't fool yourself into believing that the addition of
mandatory security equates to high-assurance (or even "medium"
assurance).  As they aptly point out, Multics didn't even achieve the
definition of high-assurance, and its fundamental protection mechanisms
far exceed anything in Unix-like kernels.  I will even say that the one
Unix-like OS that also achieved a "medium" assurance B2 rating like
Multics (Trusted XENIX, for which I'll admit significant involvement),
paled in comparison to Multics protection robustness, and in many
people's opinion, lowered the bar of what is "medium" assurance.  And
neither of these were high-assurance.  Even some of the attempts to use
mainstream micro-kernels as baselines for high assurance (e.g., TMach,
which I'll also admit significant participation, and later DTMach, a
direct antecedent to SE Linux I believe), did not in my opinion approach
levels of assurance beyond Multics, despite claims at the time.

So I would like to offer two points of encouragement:

1. For all those Linux/Unix folks trying to make their system more
security robust, let's keep working on SE Linux and make it better.  The
type-enforcement mechanisms gives me great hope that we can
significantly increase the security strength of a large percentage of
computer systems in the near future.

2. For all those trying to solve extremely sensitive data sharing
problems (e.g., multiple levels of classified national secrets), then go
into SE Linux with open eyes.  It certainly has more potential than
vanilla Unix/Linux, or even the compartmented-mode workstations you may
be used to, but it is not high, or even medium assurance, and not likely
to have a chance of even medium robustness any time soon (if at all).
So at a minimum, understand these assurance weaknesses and recognize the
residual risks and take appropriate counter-measures.  And perhaps even
consider re-starting some high-assurance research if we can convince
ourselves of a chance of success this time.

Frank Mayer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
