Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01157
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 11:47:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA26554
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 16:47:38 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA26550
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 16:47:38 GMT
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11380
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 11:47:38 -0500 (EST)
Date: Tue, 13 Mar 2001 11:47:37 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200103131647.LAA05924@coalstack.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: performance questions?
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Doug Needham wrote:
> I do have a question has anyone done any performance analysis?
> 

We have done some perforance testing using lmbench, UnixBench and test
involving kernel compile times. We've tried to measure the overhead of
the controls, the value of access vector cache, and the cost of
computing real access decisions. Overall the results were pretty
encouraging, especially since we made no real effort to optimize for
performance. So I treat our results as upper bounds on what is
possible. We are preparing a paper for this years Freenix track at
Usenix technical that includes a discussion of the results.

> In other words do things like postgres, apache, and samba take a performance
> hit when running under the 
> selinux kernel? 

There is always going to be a performance hit for security. We have to
accept that. Nothing is for free. With that said, however, we have been
running SELinux for a while and there is no perceivable impact on
users. We don't run any of the applications that you mention though. 

--
Pete Loscocco, NSA
pal@epoch.ncsc.mil

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
