Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i284b7Rb003761
	for <selinux@tycho.nsa.gov>; Sun, 7 Mar 2004 23:37:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i284ZP6Q001951
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 04:35:25 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i284Z85t001941
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 04:35:24 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id C4EB961C85
	for <selinux@tycho.nsa.gov>; Mon,  8 Mar 2004 15:35:24 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 08254-04 for <selinux@tycho.nsa.gov>;
	Mon, 8 Mar 2004 15:35:23 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 9B70461C7D
	for <selinux@tycho.nsa.gov>; Mon,  8 Mar 2004 15:35:23 +1100 (EST)
Date: Mon, 8 Mar 2004 15:35:22 +1100
To: selinux@tycho.nsa.gov
Subject: Brad Spender and Debian play machine
Message-ID: <20040308043522.GA4760@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: russell@coker.com.au (Russell Coker)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Brad Spender of the GR Security project has claimed that my Debian SE Linux
play machine was cracked.  A quick inspection didn't show any evidence of a
crack, but as it's almost impossible to find a backdoor on a machine without
booting from known good media I have not looked in detail.  To fully investigate
this I will have to remove the machine from the co-location center.

Brad states that he will provide evidence within 24 hours, I am eagerly looking
forward to this.

In any case I may put the Debian machine off-line for a while.  Most of my
work is on Fedora now and I don't think that two play machines offers any
significant benefit over one.

<Method> hey rjc
<Method> [22:04] <spender> btw, the debian selinux box was hacked
<Method> [22:04] <spender> the reason? bad configuration
<Method> please tell me that isn't true
<rjc> Method: Evidence?
<Method> rjc: spender says someone named 'stealth' compromised it
<Method> [22:09] <Method> spender: do you care to tell rjc that his demo machine was cracked since he's unaware?
<Method> [22:10] <spender> he's aware
<Method> [22:10] <spender> i can pull up an email from stealth
<rjc> Method: Interesting that Spender thinks he can determine what I know and what I don't.
<rjc> Method: I would like to know what they claim to have done, and any evidence of it.
<Method> indeed
<Method> want me to paste that request?
<rjc> Method: Lots of people claim to have cracked it, it happens almost daily.
<rjc> Method: Yes.
<Method> that is exactly what i said
<Method> lol
<Method> [22:12] <spender> fine, i'll paste the email from stealth
<Method> [22:12] <spender> and also forward it to bugtraq
<Method> [22:12] <spender> so coker doesn't forget next time
<rjc> Method: So when's this email going to appear?
<Method> oh
<Method> excuses
<Method> [22:14] * Method is waiting
<Method> [22:14] <spender> hmm
<Method> [22:14] <spender> it must have been over ircs
<Method> [22:14] <spender> no matter, i'll have him email me
<Method> [22:14] <spender> i'll be here tomorrow
<rjc> Method: As a precaution I've taken the Debian play machine off-line until this matter is resolved.
<Method> :\
<Method> do you think there is anything behind his claims?
<rjc> pebenito: Well he had better provide evidence for his claims within 24 hours.  This incident will make the rounds of all the usual security mailing lists and possibly get some media attention.  It's going to be embarassing for at least one of us.
<rjc> Method: Running an open root machine is something that the NSA people don't recommend.  There is a possibility of a config error, a lack of applying some kernel patch, etc.  I take this as a very serious matter.
<rjc> Method: May I quote you in an email to the SE Linu list?
<Method> quote me saying what?
<rjc> Method: Passing on spender's claims.
<Method> go for it


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
