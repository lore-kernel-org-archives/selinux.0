Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA24637
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 05:40:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id JAA12584
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 09:39:18 GMT
Received: from ducks.huff20may77.us ([63.147.7.154])
	by jazzswing.ncsc.mil  with ESMTP id JAA12580
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 09:39:17 GMT
Subject: Re: Message from Secure Computing
From: "Edward J. Huff" <edward.huff@acm.org>
To: Brian May <bam@snoopy.apana.org.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20020728073112.GF7217@snoopy.apana.org.au>
References: 
	<72222DC86846D411ABD300A0C9EB08A1015243CF@csoc-mail-box.csoconline.com>
	<1027833846.15983.127.camel@ducks.huff20may77.us>
	<20020728073112.GF7217@snoopy.apana.org.au>
Content-Type: text/plain
Date: 28 Jul 2002 05:38:08 -0400
Message-Id: <1027849088.15983.413.camel@ducks.huff20may77.us>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2002-07-28 at 03:31, Brian May wrote:
> On Sun, Jul 28, 2002 at 01:24:06AM -0400, Edward J. Huff wrote:
> > patent rights.  The copyright owner (Linus Torvalds in this case) has
> 
> find  /usr/src/linux -type f | xargs grep -i copyright
> 
> You will see that Linus Torvalds isn't the only copyright holder...
> 
> I believe that the license could not be changed without permission of
> each and every one of the numerous copyright holders. Unless of course
> you get rid of the code in question.
> 
> Its not just individuals either, I see a number of references to HP,
> IBM, and Silicon Graphics here. That is with only a quick 5 second
> glance.

Right.  There is no question of changing the license.  The question is
who would sue to enforce the license, and who would be sued.  I guess
any one of those copyright holders could sue.  My point is, SCC is not
one of them.  Neither would SCC be a defendant.  The defendants would
have to be the NSA and you and me.  In any case, SCC would not be a
party to any dispute over the copyrights to SE Linux.

My other point is that so long as SCC says it is OK for people to use SE
Linux (and modified versions of SE Linux, so long as they are
distributed under the GPL), they are granting a revocable license, and
the GPL does not require that patent licenses be irrevocable.  It only
requires that distribution stop should be license be revoked.  Since SCC
isn't distributing SE Linux, SCC doesn't have to stop.  And since there
is a license at present, there is no grounds for copyright action
against people who are distributing SE Linux.

It appears to me that the lawyers at SCC have actually done their job in
writing that document.  It is the PR people who failed, miserably.

And of course, the other people who have failed are your senators and
congressmen.  Write to them about this example of the absurdity of
software patents.  Explain how you were blindsided by the sudden
discovery that the patent license could be revoked at will.  Ask them to
enact a blanket license of all software patents for GPL'ed code.

-- Ed Huff


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
