Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA18412
	for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2001 09:00:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA12378
	for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2001 14:00:11 GMT
Received: from grov.dyndns.org (adsl-209-158-236-20.cptl.adsl.bellatlantic.net [209.158.236.20])
	by jazzswing.ncsc.mil  with ESMTP id OAA12374
	for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2001 14:00:05 GMT
Received: (from jpelna@localhost)
	by grov.dyndns.org (8.9.3/8.9.3) id IAA27719
	for selinux@tycho.nsa.gov; Thu, 15 Mar 2001 08:41:07 -0500
Date: Thu, 15 Mar 2001 08:41:07 -0500
From: jpelna <jpelna@bellatlantic.net>
To: selinux@tycho.nsa.gov
Subject: filtering (was Re: Thoughts on the list...)
Message-ID: <20010315084107.A27348@bellatlantic.net>
References: <Pine.SOL.3.95.1010306105403.22613B-100000@clipper.gw.tislabs.com> <OE39NY1SWoBDyseVwrb00001d32@hotmail.com> <3A9ABC5E00001800@mx1.opnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A9ABC5E00001800@mx1.opnet.com>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Tue, Mar 13, 2001 at 01:36:55PM -0500, Nicholas Bastin wrote:
> No offense, but can't you just filter on the To: address?  It's reliably
> selinux@tycho.nsa.gov

Actually, if you are going to filter on headers, you want to filter on
 Sender: owner-selinux@tycho.nsa.gov

I have seen messages with selinux@tycho.nsa.gov in the To: Cc: fields,
(as well as messages Bcc'd).  The sender field is consistent in all of them.

-John

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
