Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4ICxHRb000964
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 08:59:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4ICxFAR017030
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 12:59:15 GMT
Received: from gadolinium.btinternet.com (gadolinium.btinternet.com [194.73.73.111])
        by jazzband.ncsc.mil  with ESMTP id i4ICxEHn017027 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 12:59:14 GMT
Received: from [81.130.181.235] (helo=lkcl.net)
	by gadolinium.btinternet.com with esmtp (Exim 3.22 #25)
	id 1BQ4Be-00035d-00
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 13:59:14 +0100
Received: from highfield ([192.168.0.223]:34147 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQ4EQ-0007g0-OC
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 13:02:06 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQ494-0001JQ-Cj
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 12:56:34 +0000
Date: Tue, 18 May 2004 12:56:33 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518125633.GA24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040518104026.GC24333@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 10:40:28AM +0000, Luke Kenneth Casson Leighton wrote:

> help, help, i discovered the existence of allow2audit, and _finally_
> i now have a tool that i can use to understand avc messages in terms
> of audit permissions: hooray!
> 
> would someone mind advising me which of these is reasonable/safe
> to allow, or should i just bung them all in and see what happens?

well i tried the bung-it-in-and-see approach, and i got a build error
due to some global policy violations at make policy time because
of this (and one other):

> allow hotplug_t etc_runtime_t:file { relabelfrom relabelto };

... but what is even stranger is that even though i add in these
things into a new package (i called it domains/programs/localstuff.te)
the avc messages _still don't go away_.

i watched the make policy, it read the newly created file
(localstuff.te) and the stuff is in policy.conf.

what am i doing wrong?

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
