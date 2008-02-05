Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m15KDkLr029442
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 15:13:46 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m15KDiZ6003930
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 20:13:45 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: SELinux and Linux user mapping
Date: Tue, 5 Feb 2008 14:47:40 -0500
Message-ID: <1202240861.7533.64.camel@gorn>
In-Reply-To: <1202238356.2672.26.camel@vogon>
References: <1202238356.2672.26.camel@vogon>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stefan Schulze Frielinghaus" <stefan@seekline.net>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-05 at 20:05 +0100, Stefan Schulze Frielinghaus wrote:
> Since my last upgrade to refpolicy-20071214 whenever I try to login with
> my username I'm in the default role (user).
> 
> $ semanage login -l
> [...]
> stefan	staff_u
> 
> But:
> 
> $ id
> uid=1000(stefan) gid=1000(stefan) groups=1000(stefan)
> context=user_u:user_r:user_t
> 
> I tried to login locally and remote via ssh. No AVCs are generated or
> whatever. Did I miss something? That's really strange. Did something
> change in the past?
> 
> Also other users are always logged in as user_u and not e.g. staff_u
> (enforcing or permissive mode does not change anything).
> I'm using Debian (testing).

I believe debian is using the openssh that has a broken configure script
(4.7) which improperly detects getseuserbyname() (it doesnt do -lselinux
on the compile test thus it always fails).  Debian might possibly be
using an old pam patch that doesn't use getseuserbyname().  But these
behavior changes wouldn't be tied to a policy change, unless you
previously had selinux users which corresponded to your linux user and
they were removed with the new policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
