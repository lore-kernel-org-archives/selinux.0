Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s53MRhIN015894
 for <selinux@tycho.nsa.gov>; Tue, 3 Jun 2014 18:27:43 -0400
Received: by mail-qa0-f41.google.com with SMTP id dc16so5875985qab.28
 for <selinux@tycho.nsa.gov>; Tue, 03 Jun 2014 15:27:44 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Masahiro Yamada <yamada.m@jp.panasonic.com>
Subject: Re: [PATCH] selinux,
 kbuild: remove unnecessary $(hostprogs-y) from clean-files
Date: Tue, 03 Jun 2014 18:27:41 -0400
Message-ID: <5995003.J2pCs3i8WU@sifl>
In-Reply-To: <20140603144739.321C.AA925319@jp.panasonic.com>
References: <1397702546-25349-1-git-send-email-yamada.m@jp.panasonic.com>
 <5709743.58aAPSG601@sifl> <20140603144739.321C.AA925319@jp.panasonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov, linux-kbuild@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, June 03, 2014 02:47:39 PM Masahiro Yamada wrote:
> Hi Paul Moore,

Hello.

> On Thu, 17 Apr 2014 21:41:53 -0400 Paul Moore <paul@paul-moore.com> wrote:
> > On Thursday, April 17, 2014 11:42:26 AM Masahiro Yamada wrote:
> > > Files added to hostprogs-y are cleaned. (See scripts/Makefile.clean)
> > > Adding them to clean-files is redundant.
> > > 
> > > Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
> > > ---
> > > 
> > >  scripts/selinux/genheaders/Makefile | 1 -
> > >  scripts/selinux/mdp/Makefile        | 2 +-
> > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > Acked-by: Paul Moore <paul@paul-moore.com>
> 
> It looks like this patch was not included into
> GIT-PULL of "SELinux patches for 3.16".
> 
> Is it possible to apply this and send another pull request?

My apologies, I thought the kbuild people were going to merge this patch; this 
is why I sent my Acked-by instead of a note that I've merged the patch.  
Considering that this patch doesn't actually fix any runtime problems and it 
hasn't been in any of the different "next" trees, I think it is best to wait 
until 3.17 for this patch.

I've added this patch to my queue of patches to be added to the SELinux #next 
branch after the 3.16 merge window closes.

Thanks again for the patch, I'm sorry that we didn't get it merged sooner.

-- 
paul moore
www.paul-moore.com
