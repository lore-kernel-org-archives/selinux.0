Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIDNhIi012984
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 08:23:43 -0500 (EST)
Received: from smtp-bedford-dr.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIDNknl023658
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 13:23:46 GMT
Received: from smtp-bedford-dr.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford-dr.mitre.org (8.11.6/8.11.6) with SMTP id iAIDNlN26794
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 08:23:47 -0500
Received: from smtp-bedford-dr.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford-dr.mitre.org (Postfix) with ESMTP id 298864F8E1
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 08:23:47 -0500 (EST)
Received: from linus.mitre.org (linus.mitre.org [129.83.10.1])
	by smtp-bedford-dr.mitre.org (8.11.6/8.11.6) with ESMTP id iAIDNlR26776
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 08:23:47 -0500
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by linus.mitre.org (8.12.10/8.12.10) with ESMTP id iAIDNkVt002023
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 08:23:46 -0500 (EST)
To: selinux@tycho.nsa.gov
Subject: Re: polgen and strace
References: <87fz3ajhex.fsf@glaurung.internal.golden-gryphon.com>
	<ogty8h16ha5.fsf@divan.mitre.org>
	<87r7msv0bd.fsf@glaurung.internal.golden-gryphon.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 18 Nov 2004 08:23:46 -0500
In-Reply-To: <87r7msv0bd.fsf@glaurung.internal.golden-gryphon.com>
Message-ID: <ogtwtwjxpct.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Manoj Srivastava <manoj.srivastava@stdc.com> writes:

> 	I see. However, I could still try to get the patch accepted by
>  Debian, which would be good. Oh, and Debian's strasce is also 4.5.8
>  at this point.
> 
> >> I might be able to get strace patched, though, if the patches were
> >> not too intrusive., but I was not able to find a canonical location
> >> for strace patches.
> 
> > I can make up the patch, but I'm not sure it would help.
> 
> 	A clean patch would make the task of convincing the Debian
>  strace maintainer a lot easier.

I have made the patch available to all at 

http://simp.mitre.org/selinux

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
