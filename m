Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB1GZuYL009336
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 11:35:56 -0500
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB1GZEOv020383
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 16:35:14 GMT
From: Jim Meyering <jim@meyering.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: James Antill <jantill@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: coreutils status
In-Reply-To: <1164951221.10331.9.camel@gorn.pebenito.net> (Chris PeBenito's
	message of "Fri, 01 Dec 2006 00:33:41 -0500")
References: <1158623120.31135.2.camel@gorn.pebenito.net>
	<87venkibkl.fsf@rho.meyering.net>
	<1164951221.10331.9.camel@gorn.pebenito.net>
Date: Fri, 01 Dec 2006 17:36:17 +0100
Message-ID: <87odqn375q.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris PeBenito <pebenito@gentoo.org> wrote:
> On Tue, 2006-09-19 at 09:02 +0200, Jim Meyering wrote:
>> Chris PeBenito <pebenito@gentoo.org> wrote:
>> > What is the status of the selinux patches for coreutils going upstream?
>>
>> The code changes are mostly done, but I need more tests
>> and some documentation.
>>
>> The changes are disruptive enough that they won't go in
>> until after the upcoming stable release.
>
> Any updates on this?  I don't see it in CVS, and it looks like there's
> been four stable releases since the above.  Is there a patch that we can
> test?

Exactly!  There have been reasons to make six stable releases
since coreutils-6.0.  But I think it finally does qualify as stable.

Merging those changes is high on my list.
I will probably work on it next week.

Where are the patches?
They're in a mercurial tree that's based off of a snapshot
from CVS, and now that coreutils is using git for version control,
I'll be merging them onto a git branch.  Once that merge is complete,
you should be able to see them here:

  http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=summary

Some pieces will probably make it into gnulib before then.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
