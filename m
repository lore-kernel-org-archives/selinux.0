Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA01779
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 15:22:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA27120
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 19:20:43 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id TAA27116 for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 19:20:42 GMT
Reply-To: <dac@tresys.com>
From: "David Caplan" <dac@tresys.com>
To: <selinux@tycho.nsa.gov>, "Ben McGinnes" <bmcginnes@enternet.com.au>
Subject: RE: Sorry, read this one: Re: SELinux Dumb Questions
Date: Thu, 6 Jun 2002 15:25:35 -0400
Message-ID: <NJEELFKFDFJAACDDMCHCCEGLEBAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20020606060744.J2249@mail.enternet.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has anyone determined which patent(s) is/are relevant?  The closest thing
I've found is a Linux Journal article written by Earl Boebert,
http://www.linuxjournal.com/article.php?sid=4963, entitled "Some Thoughts on
the Occasion of the NSA Linux Release".  He writes that "The NSA release
incorporates an idea called Type Enforcement (TE) that was cooked up by Dick
Kain and [himself] over 15 years ago" (this article is dated Jan. 24, 2001).
There is no mention of a patent, but a search at the US PTO web site,
http://patft.uspto.gov/netahtml/search-bool.html, shows three granted in the
mid eighties to Mr. Boebert, et. al, #4621321, #4701840, and #4713753.  I'm
not sure if any of these are the relevant ones or not, though, after a quick
glance, they appear to be.

There is another Linux Journal article,
http://www.linuxjournal.com/article.php?sid=5105, entitled "Secure Computing
to Develop Type Enforced Tux", dated Feb 23, 2000, which refers to SCC's
"patented security solution for the Linux kernel".  At the end it refers to
the "lingering question" of "the origins of the Type Enforcement
technology."  I'm not sure why this is a "question", but it notes that SCC
used the University of Utah/NSA Flask system/modified kernel "for the
current Type Enforcement/Secure Linux project", and that the origins of Type
Enforcement "may go back as far as the 1970s" referring to PSOS.

David

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Ben McGinnes
> Sent: Wednesday, June 05, 2002 4:08 PM
> To: selinux@tycho.nsa.gov
> Subject: Re: Sorry, read this one: Re: SELinux Dumb Questions
>
[stuff cut]
>
> BTW, has anyone here actually looked at the patent itself and seen
> exactly what it refers to?  Has anyone from Secure Computing mentioned
> any references with the relevant patent authorities so that the rest
> of us can see precisely what they're patent controls?
>
>
> Regards,
> Ben
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
