Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t32LIdPi029296
 for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2015 17:18:39 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux patches for 4.1
Date: Thu, 02 Apr 2015 17:18:30 -0400
Message-ID: <3507958.kG4l2LfREA@sifl>
In-Reply-To: <alpine.LRH.2.11.1504022331430.4811@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <alpine.LRH.2.11.1504022331430.4811@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, April 02, 2015 11:32:02 PM James Morris wrote:
> On Wed, 1 Apr 2015, Paul Moore wrote:
> > Hi James,
> > 
> > Five patches this time around: three patches to improve and enlarge the
> > the
> > avtab hash table, one to cleanup some MLS label import code, and one to
> > cleanup some of the avc code.  All of the patches are pretty small and
> > straightforward.  The two cleanup patches are trivially understandable and
> > the avtab code is well documented.
> > 
> > As usual, all patches pass the SELinux testsuite.
> > 
> > Enjoy,
> > -Paul
> > 
> > ---
> > 
> > The following changes since commit 
6436a123a147db51a0b06024a8350f4c230e73ff:
> >   selinux: fix sel_write_enforce broken return value
> >   
> >            (2015-03-25 16:55:06 -0400)
> > 
> > are available in the git repository at:
> >   git://git.infradead.org/users/pcmoore/selinux upstream
> > 
> > for you to fetch changes up to 9b43e04b188a1f715429604cca32b846e5a48cd2:
> >   Merge branch 'next' into upstream in preparation for v4.1
> >   (2015-04-01 22:24:51 -0400)
> 
> Is this branch downstream from my -next?

It should be, although likely an older version as I try not to pull unless 
necessary to resolve conflicts.  When I do a test merge into your next branch 
I see the following:

  #git pull selinux next
  From git://git.infradead.org/users/pcmoore/selinux
   * branch            next       -> FETCH_HEAD
  Auto-merging security/selinux/selinuxfs.c
  Merge made by the 'recursive' strategy.
   security/selinux/avc.c         |  6 ++--
   security/selinux/selinuxfs.c   |  2 +-
   security/selinux/ss/avtab.c    | 72 +++++++++++++++++++++++++++++---------
   security/selinux/ss/avtab.h    |  8 +++--
   security/selinux/ss/mls.c      | 10 ++----
   security/selinux/ss/services.c |  6 +---
   6 files changed, 68 insertions(+), 36 deletions(-)

The merge diffstat looks as I would expect, the only odd thing is selinuxfs.c, 
but it looks like that is simply because your next branch doesn't include the 
error code fix I sent you for v4.0:

  commit 6436a123a147db51a0b06024a8350f4c230e73ff
  Author: Joe Perches <joe@perches.com>
  Date:   Mon Mar 23 18:01:35 2015 -0700

    selinux: fix sel_write_enforce broken return value
    
    Return a negative error value like the rest of the entries in this  
    function.
    
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Joe Perches <joe@perches.com>
    Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
    [PM: tweaked subject line]
    Signed-off-by: Paul Moore <pmoore@redhat.com>

Are you asking because you ran into a problem, or just to check?

-- 
paul moore
security @ redhat
