Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2Q0lpRM013084
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2008 20:47:52 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2Q0lbIU004462
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 00:47:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Stone <mstone@debian.org>
Subject: Re: Bug#472590: ls in Debian/Unstable
Date: Wed, 26 Mar 2008 08:24:15 +1100
Cc: Jim Meyering <jim@meyering.net>, 472590@bugs.debian.org,
        SE-Linux <selinux@tycho.nsa.gov>
References: <200803251523.34329.russell@coker.com.au> <87tziu96yz.fsf@rho.meyering.net> <20080325173116.GQ2626@mathom.us>
In-Reply-To: <20080325173116.GQ2626@mathom.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803260824.17731.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 March 2008 04:31, Michael Stone <mstone@debian.org> wrote:
> if (acl) then '+'
> else if (selinux) then '.'

Should there be some special marking of files with both a SE Linux context and 
an ACL?

Pity that they didn't choose an "a" to mark an ACL which would then permit 
using "A" for ACL + MAC.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
