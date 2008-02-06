Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m16BpTqm011311
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 06:51:29 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m16BpSQr011378
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 11:51:28 GMT
Date: Wed, 6 Feb 2008 12:51:02 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: SELinux and Linux user mapping
Message-ID: <20080206115102.GA19285@bobek.pm.i.cz>
References: <1202238356.2672.26.camel@vogon> <1202240861.7533.64.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1202240861.7533.64.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Tue, Feb 05, 2008 at 02:47:40PM -0500, Christopher J. PeBenito wrote:
> On Tue, 2008-02-05 at 20:05 +0100, Stefan Schulze Frielinghaus wrote:
> > Since my last upgrade to refpolicy-20071214 whenever I try to login with
> > my username I'm in the default role (user).
> > 
> > $ semanage login -l
> > [...]
> > stefan	staff_u
> > 
> > But:
> > 
> > $ id
> > uid=1000(stefan) gid=1000(stefan) groups=1000(stefan)
> > context=user_u:user_r:user_t
> > 
> > I tried to login locally and remote via ssh. No AVCs are generated or
> > whatever. Did I miss something? That's really strange. Did something
> > change in the past?
> > 
> > Also other users are always logged in as user_u and not e.g. staff_u
> > (enforcing or permissive mode does not change anything).
> > I'm using Debian (testing).
> 
> I believe debian is using the openssh that has a broken configure script
> (4.7) which improperly detects getseuserbyname() (it doesnt do -lselinux
> on the compile test thus it always fails).  Debian might possibly be
> using an old pam patch that doesn't use getseuserbyname().  But these
> behavior changes wouldn't be tied to a policy change, unless you
> previously had selinux users which corresponded to your linux user and
> they were removed with the new policy.

Yes, that is right. I'm experimenting with Debian stable. Openssh in
stable 4.3p2 is ok, 4.7 from unstable fails. With pam 0.99.9 mapping
works through local login and ssh ok. I have repository with some
SELinux staff available already, but must write some instructions about
it (probably some page on wiki.debian.org?). There are packages taken
from Sid sometimes updated with newer versions (SELinux staff is taken
from upstream subversion). Some packages are simply backports from Sid.

If you want, you can try:

deb http://linux.i.cz/debian selinux-etch main

Everything is highly experimental :).
There is no refpolicy deb. The refpolicy needs changes, so I simply
takes refpolicy from subversion

http://oss.tresys.com/repos/refpolicy/trunk

Cheers
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
