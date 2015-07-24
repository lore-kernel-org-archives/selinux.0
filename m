Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6O8ZsmU010951
 for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2015 04:35:54 -0400
Received: by pdrg1 with SMTP id g1so10459441pdr.2
 for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2015 01:35:52 -0700 (PDT)
Date: Fri, 24 Jul 2015 16:35:48 +0800
From: Jason Zaman <jason@perfinion.com>
To: Petr Lautrbach <plautrba@redhat.com>
Subject: Re: [GIT PULL] policycoreutils: fix PEP8 issues
Message-ID: <20150724083548.GA11791@meriadoc.perfinion.com>
References: <20150717142834.GA20679@meriadoc.Home>
 <55AF977C.9020705@tycho.nsa.gov>
 <20150722143111.GA20676@meriadoc.perfinion.com>
 <55AFAAD5.80108@tycho.nsa.gov> <55B09467.6030807@redhat.com>
 <55B1ECAE.7000905@redhat.com>
 <20150724081344.GA10961@meriadoc.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150724081344.GA10961@meriadoc.perfinion.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 24, 2015 at 04:13:44PM +0800, Jason Zaman wrote:
> On Fri, Jul 24, 2015 at 09:43:42AM +0200, Petr Lautrbach wrote:
> > It seems that there's only seobject.py which needs to be ported to
> > python 3. I would start with the indent conversion as it's needed anyway
> > and then we could provide a patch with python 3 support based on this
> > conversion.
> 
> The following changes since commit d19cda0c80524b57464b3bb74dce1297d017b4b1:
> 
>   Updated libsepol ChangeLog (2015-07-22 11:02:32 -0400)
> 
> are available in the git repository at:
> 
>   https://github.com/perfinion/selinux.git reformat
> 
> for you to fetch changes up to 789d0ebbf9fa448b09917ccd0adff91d72e9f5c1:
> 
>   policycoreutils: Fix PEP8 issues (2015-07-24 16:07:13 +0800)
> 
> ----------------------------------------------------------------
> Jason Zaman (1):
>       policycoreutils: Fix PEP8 issues
> 
> 
> I re-did the changes on top of the current master and updated that
> branch. this is the new commit to pull.
> 
> All the files now follow PEP8 style (ie tabs are 4 spaces) so future
> commits should follow that too.

After seobject.py is converted, I see a few issues with
policycoreutils/sepolicy/sepolicy/*.

The easy stuff 2to3 handles, but it looks like there will need to be
some changes to the C module, I've got it building by adding some
#defines for PyInt_AsLong and the like. I am not that familiar with the
C-Python stuff so it might not be done the right way.

-- Jason
