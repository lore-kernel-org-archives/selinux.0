Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s557IjPC029101
 for <selinux@tycho.nsa.gov>; Thu, 5 Jun 2014 03:18:46 -0400
Date: Thu, 05 Jun 2014 16:18:23 +0900
From: Masahiro Yamada <yamada.m@jp.panasonic.com>
To: Paul Moore <paul@paul-moore.com>, Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH] selinux,
 kbuild: remove unnecessary $(hostprogs-y) from clean-files
In-Reply-To: <5995003.J2pCs3i8WU@sifl>
References: <20140603144739.321C.AA925319@jp.panasonic.com>
 <5995003.J2pCs3i8WU@sifl>
Message-Id: <20140605161823.9579.AA925319@jp.panasonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: selinux@tycho.nsa.gov, linux-kbuild@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Paul, Michal,

On Tue, 03 Jun 2014 18:27:41 -0400
Paul Moore <paul@paul-moore.com> wrote:

> On Tuesday, June 03, 2014 02:47:39 PM Masahiro Yamada wrote:
> > Hi Paul Moore,
> 
> Hello.
> 
> > On Thu, 17 Apr 2014 21:41:53 -0400 Paul Moore <paul@paul-moore.com> wrote:
> > > On Thursday, April 17, 2014 11:42:26 AM Masahiro Yamada wrote:
> > > > Files added to hostprogs-y are cleaned. (See scripts/Makefile.clean)
> > > > Adding them to clean-files is redundant.
> > > > 
> > > > Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
> > > > ---
> > > > 
> > > >  scripts/selinux/genheaders/Makefile | 1 -
> > > >  scripts/selinux/mdp/Makefile        | 2 +-
> > > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > Acked-by: Paul Moore <paul@paul-moore.com>
> > 
> > It looks like this patch was not included into
> > GIT-PULL of "SELinux patches for 3.16".
> > 
> > Is it possible to apply this and send another pull request?
> 
> My apologies, I thought the kbuild people were going to merge this patch; this 
> is why I sent my Acked-by instead of a note that I've merged the patch.  
> Considering that this patch doesn't actually fix any runtime problems and it 
> hasn't been in any of the different "next" trees, I think it is best to wait 
> until 3.17 for this patch.
> 
> I've added this patch to my queue of patches to be added to the SELinux #next 
> branch after the 3.16 merge window closes.
> 
> Thanks again for the patch, I'm sorry that we didn't get it merged sooner.

No worries.

Michal, could you apply this patch to kbuild.git#kbuild, please?


Best Regards
Masahiro Yamada
