Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2SHDIxm021332
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 13:13:18 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2SHDCLB018594
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 17:13:13 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: coreutils: selinux is nearly ready: status
Date: Wed, 28 Mar 2007 13:13:27 -0400
Message-ID: <1175102007.29300.90.camel@sgc>
In-Reply-To: <87y7nh4v29.fsf@rho.meyering.net>
References: <87y7nh4v29.fsf@rho.meyering.net>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Jim Meyering" <jim@meyering.net>
Cc: <bug-coreutils@gnu.org>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-01 at 19:00 +0100, Jim Meyering wrote:
> I've been spending little bits of time over the last few months getting
> coreutils' SELinux into shape.  These changes started off based on Red
> Hat patches from six months ago.  Initially it was all in a mercurial
> repository based on a snapshot of coreutils CVS.  Then coreutils
> development switched to git, and only recently have I merged most of
> the hg-based deltas into the new repository.  It's on a branch named
> "selinux".
> 
> Here is the current state:
> 
>   http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=shortlog;h=selinux
> 
> Here are some of the remaining tasks:
> 
>   - add runcon (should be quick)
>   - add many more SELinux-specific tests
>   - fix at least one test (tests/cp/cp-a-selinux is in-progress
>       and known to fail -- but I know a couple ways to fix it)
>   - documentation
>   - make sure that any newer selinux-related changes from Red Hat
>       (or any other distribution) are included

Any updates on this?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
