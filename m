Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2PLTFlE023381
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 17:29:15 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2PLTEYg024097
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 21:29:14 GMT
From: Jim Meyering <jim@meyering.net>
To: russell@coker.com.au
Cc: Michael Stone <mstone@debian.org>, 472590@bugs.debian.org,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#472590: ls in Debian/Unstable
In-Reply-To: <200803260824.17731.russell@coker.com.au> (Russell Coker's
	message of "Wed, 26 Mar 2008 08:24:15 +1100")
References: <200803251523.34329.russell@coker.com.au>
	<87tziu96yz.fsf@rho.meyering.net> <20080325173116.GQ2626@mathom.us>
	<200803260824.17731.russell@coker.com.au>
Date: Tue, 25 Mar 2008 22:28:28 +0100
Message-ID: <873aqe8pdv.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker <russell@coker.com.au> wrote:

> On Wednesday 26 March 2008 04:31, Michael Stone <mstone@debian.org> wrote:
>> if (acl) then '+'
>> else if (selinux) then '.'
>
> Should there be some special marking of files with both a SE Linux context and
> an ACL?
>
> Pity that they didn't choose an "a" to mark an ACL which would then permit
> using "A" for ACL + MAC.

What if it has an ACL, a MAC, *and* some chattr-style attribute?
Á  ;-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
