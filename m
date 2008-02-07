Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m17HRgG5007329
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 12:27:42 -0500
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m17HRdMl025040
	for <selinux@tycho.nsa.gov>; Thu, 7 Feb 2008 17:27:40 GMT
Subject: Re: SELinux and Linux user mapping
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080206115102.GA19285@bobek.pm.i.cz>
References: <1202238356.2672.26.camel@vogon> <1202240861.7533.64.camel@gorn>
	 <20080206115102.GA19285@bobek.pm.i.cz>
Content-Type: text/plain; charset=utf-8
Date: Thu, 07 Feb 2008 18:26:25 +0100
Message-Id: <1202405185.2683.4.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-02-06 at 12:51 +0100, Václav Ovsík wrote:
> Hi,
> 
> On Tue, Feb 05, 2008 at 02:47:40PM -0500, Christopher J. PeBenito wrote:
> > On Tue, 2008-02-05 at 20:05 +0100, Stefan Schulze Frielinghaus wrote:
> > > Since my last upgrade to refpolicy-20071214 whenever I try to login with
> > > my username I'm in the default role (user).
> > > 
> > > $ semanage login -l
> > > [...]
> > > stefan	staff_u
> > > 
> > > But:
> > > 
> > > $ id
> > > uid=1000(stefan) gid=1000(stefan) groups=1000(stefan)
> > > context=user_u:user_r:user_t
> > > 
> > > I tried to login locally and remote via ssh. No AVCs are generated or
> > > whatever. Did I miss something? That's really strange. Did something
> > > change in the past?
> > > 
> > > Also other users are always logged in as user_u and not e.g. staff_u
> > > (enforcing or permissive mode does not change anything).
> > > I'm using Debian (testing).
> > 
> > I believe debian is using the openssh that has a broken configure script
> > (4.7) which improperly detects getseuserbyname() (it doesnt do -lselinux
> > on the compile test thus it always fails).  Debian might possibly be
> > using an old pam patch that doesn't use getseuserbyname().  But these
> > behavior changes wouldn't be tied to a policy change, unless you
> > previously had selinux users which corresponded to your linux user and
> > they were removed with the new policy.
> 
> Yes, that is right. I'm experimenting with Debian stable. Openssh in
> stable 4.3p2 is ok, 4.7 from unstable fails. With pam 0.99.9 mapping
> works through local login and ssh ok. I have repository with some
> SELinux staff available already, but must write some instructions about
> it (probably some page on wiki.debian.org?). There are packages taken
> from Sid sometimes updated with newer versions (SELinux staff is taken
> from upstream subversion). Some packages are simply backports from Sid.
> 
> If you want, you can try:
> 
> deb http://linux.i.cz/debian selinux-etch main
> 
> Everything is highly experimental :).
> There is no refpolicy deb. The refpolicy needs changes, so I simply
> takes refpolicy from subversion
> 
> http://oss.tresys.com/repos/refpolicy/trunk

Yeah the problem seems to be with pam and openssh. At the weekend I will
try another debian-stable machine including your repository.

Thanks for clarification!

-Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
