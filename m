Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAHHr6Ii008145
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2004 12:53:06 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAHHr8A9026274
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2004 17:53:08 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-17) with ESMTP id iAHHhNU0010606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2004 11:43:37 -0600
To: selinux@tycho.nsa.gov
Subject: Re: polgen and strace
References: <87fz3ajhex.fsf@glaurung.internal.golden-gryphon.com>
	<ogty8h16ha5.fsf@divan.mitre.org>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Wed, 17 Nov 2004 11:43:02 -0600
In-Reply-To: <ogty8h16ha5.fsf@divan.mitre.org> (John D. Ramsdell's message
 of
	"16 Nov 2004 08:43:30 -0500")
Message-ID: <87r7msv0bd.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 16 Nov 2004 08:43:30 -0500, John D Ramsdell <ramsdell@mitre.org> said: 

> Manoj Srivastava <manoj.srivastava@stdc.com> writes:
>> While poking around in polgen (in preparation for packaging it for
>> Debian), I noticed that it has the full set of sources for strace!

> The strace that is part of polgen has been changed so that when one
> specifies the -X option, it adds security context information to its
> output.  This added output is essential to the analysis that
> follows.

>> Would polgen work with a vanilla strace? Are there plans for
>> pushing strace changes upstream?

> Polgen would not work with vanilla strace.  We have offered the
> changes to the strace maintainers, but have not received a word one
> way or the other as to their interest in supporting the -X option.

	I see. However, I could still try to get the patch accepted by
 Debian, which would be good. Oh, and Debian's strasce is also 4.5.8
 at this point.

>> I might be able to get strace patched, though, if the patches were
>> not too intrusive., but I was not able to find a canonical location
>> for strace patches.

> I can make up the patch, but I'm not sure it would help.

	A clean patch would make the task of convincing the Debian
 strace maintainer a lot easier.

> What does one do to package polgen for Debian?  Is there something I
> can add to the polgen sources that would facilitate this process.  I
> don't know much about Debian packaging, so hand holding is in order.

	Oh, there is no technical issue with regards to packaging
 strace itself, the problem lies in integration into the Debian
 distribution, and adherence to debian technical policy. 

	manoj
-- 
Any given program, when running, is obsolete.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
