Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAGDhRIi000091
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:43:27 -0500 (EST)
Received: from smtp-bedford-dr.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAGDhTFO010323
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 13:43:29 GMT
Received: from smtp-bedford-dr.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford-dr.mitre.org (8.11.6/8.11.6) with SMTP id iAGDhUg06072
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:43:30 -0500
Received: from smtp-bedford-dr.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford-dr.mitre.org (Postfix) with ESMTP id 8D2014F8E1
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:43:30 -0500 (EST)
Received: from linus.mitre.org (rcf-smtp.mitre.org [129.83.10.1])
	by smtp-bedford-dr.mitre.org (8.11.6/8.11.6) with ESMTP id iAGDhUH06046
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:43:30 -0500
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by linus.mitre.org (8.12.10/8.12.10) with ESMTP id iAGDhUVt008157
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:43:30 -0500 (EST)
To: selinux@tycho.nsa.gov
Subject: Re: polgen and strace
References: <87fz3ajhex.fsf@glaurung.internal.golden-gryphon.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 16 Nov 2004 08:43:30 -0500
In-Reply-To: <87fz3ajhex.fsf@glaurung.internal.golden-gryphon.com>
Message-ID: <ogty8h16ha5.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Manoj Srivastava <manoj.srivastava@stdc.com> writes:

>         While poking around in polgen (in preparation for packaging
>  it for Debian), I noticed that it has the full set of sources for
>  strace!

The strace that is part of polgen has been changed so that when one
specifies the -X option, it adds security context information to its
output.  This added output is essential to the analysis that follows.

Polgen 0.8 has a version of strace based on version 4.5.6.  Late last
week, I noticed Polgen's strace died a horrible death when tracing
Java programs.  I found out that the standard 4.5.6 release has the
same problem, but the version that comes with FC3 works.

I have a new version of SE Linux enhanced strace based on version
4.5.8 in my CVS repository, and this version allows us to analyze Java
programs.  Let me simply say, there is a lot going on in a Java VM!
People interested in policies that implement the principle of least
privileges have a lot to do.  A new polgen release that includes this
improvement is coming soon.

> 	Would polgen work with a vanilla strace? Are there plans for
> pushing strace changes upstream?

Polgen would not work with vanilla strace.  We have offered the
changes to the strace maintainers, but have not received a word one
way or the other as to their interest in supporting the -X option.  

> 	I might be able to get strace patched, though, if the patches
> were not too intrusive., but I was not able to find a canonical
> location for strace patches.

I can make up the patch, but I'm not sure it would help.

By the way, the polgen program strace2tsv transforms strace output
into tab separated values.  It should be useful to anyone analyzing
strace output with another program.  It works with vanilla strace too.
Polgen has a manual page for this program.

What does one do to package polgen for Debian?  Is there something I
can add to the polgen sources that would facilitate this process.  I
don't know much about Debian packaging, so hand holding is in order.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
