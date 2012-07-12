Message-ID: <1342124808.8057.74.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: build failure for SE Android 4.1.1_r1
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Thu, 12 Jul 2012 16:26:48 -0400
In-Reply-To: <1342124588.8057.72.camel@moss-pluto.epoch.ncsc.mil>
References: 
	<33006C99F5A5194A9B7A7715DFA3E38365079ECF@ALA-MBB.corp.ad.wrs.com>
	 <1342124588.8057.72.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-12 at 16:23 -0400, Stephen Smalley wrote:
> On Thu, 2012-07-12 at 20:01 +0000, Radzykewycz, T (Radzy) wrote:
> > Not sure whether this is something I'm doing wrong, but I had a build problem with the JellyBean branch.  I'm using toro, but I think it's probably the same otherwise.
> > 
> > In build, the most recent commit in my tree is:
> > 
> > commit 30f604e06e91cb640e8d94b768b598aef3780338
> > Author: Joshua Brindle <jbrindle@tresys.com>
> > Date:   Wed Jun 20 11:58:02 2012 -0400
> > 
> >     add selinux-network.sh to SELINUX_DEPENDS for SELinux network labeling
> >     
> >     Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
> > 
> >  core/Makefile |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > The problem is that nothing is available in my tree to install selinux-network.sh.  Just reverting that change makes it build.
> 
> I believe that's one of the issues I fixed in our seandroid-4.1.1 branch
> today.

To be precise, that was a problem with the local_manifest.xml file - I
hadn't specified the version of sepolicy to use, so it was using
android-4.1.1_r1 for that as well, which was the version tagged in AOSP
rather than the master version in our tree.  So you have to grab the
updated manifest and re-sync.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
