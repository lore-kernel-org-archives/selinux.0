Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2SLlYgZ001143
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 17:47:34 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2SLlWCe007621
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 21:47:32 GMT
From: Jim Meyering <jim@meyering.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: bug-coreutils@gnu.org, selinux@tycho.nsa.gov
Subject: Re: coreutils: selinux is nearly ready: status
In-Reply-To: <1175102007.29300.90.camel@sgc> (Christopher J. PeBenito's
	message of "Wed, 28 Mar 2007 17:13:27 +0000")
References: <87y7nh4v29.fsf@rho.meyering.net> <1175102007.29300.90.camel@sgc>
Date: Wed, 28 Mar 2007 23:47:31 +0200
Message-ID: <87lkhhjb0s.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
> On Thu, 2007-02-01 at 19:00 +0100, Jim Meyering wrote:
>> I've been spending little bits of time over the last few months getting
>> coreutils' SELinux into shape.  These changes started off based on Red
>> Hat patches from six months ago.  Initially it was all in a mercurial
>> repository based on a snapshot of coreutils CVS.  Then coreutils
>> development switched to git, and only recently have I merged most of
>> the hg-based deltas into the new repository.  It's on a branch named
>> "selinux".
>>
>> Here is the current state:
>>
>>   http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=shortlog;h=selinux
>>
>> Here are some of the remaining tasks:
>>
>>   - add runcon (should be quick)
>>   - add many more SELinux-specific tests
>>   - fix at least one test (tests/cp/cp-a-selinux is in-progress
>>       and known to fail -- but I know a couple ways to fix it)
>>   - documentation
>>   - make sure that any newer selinux-related changes from Red Hat
>>       (or any other distribution) are included
>
> Any updates on this?

Funny you should ask now.  A few hours ago I released what should be
the final pre-SELinux snapshot of upstream coreutils:

    http://meyering.net/cu/coreutils-6.9+.tar.gz

Tomorrow, I expect to merge the changes from the selinux branch onto
the trunk.  Then, those will start appearing in snapshots, and eventually
in coreutils-6.10.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
