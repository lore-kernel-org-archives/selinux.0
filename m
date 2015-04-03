Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3351TFm020762
 for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2015 01:01:29 -0400
Date: Fri, 3 Apr 2015 13:45:13 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [GIT PULL] SELinux patches for 4.1
In-Reply-To: <3507958.kG4l2LfREA@sifl>
Message-ID: <alpine.LRH.2.11.1504031344190.16304@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <alpine.LRH.2.11.1504022331430.4811@namei.org> <3507958.kG4l2LfREA@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2 Apr 2015, Paul Moore wrote:

> necessary to resolve conflicts.  When I do a test merge into your next branch 
> I see the following:
> 
>   #git pull selinux next
>   From git://git.infradead.org/users/pcmoore/selinux
>    * branch            next       -> FETCH_HEAD
>   Auto-merging security/selinux/selinuxfs.c
>   Merge made by the 'recursive' strategy.
>    security/selinux/avc.c         |  6 ++--
>    security/selinux/selinuxfs.c   |  2 +-
>    security/selinux/ss/avtab.c    | 72 +++++++++++++++++++++++++++++---------
>    security/selinux/ss/avtab.h    |  8 +++--
>    security/selinux/ss/mls.c      | 10 ++----
>    security/selinux/ss/services.c |  6 +---
>    6 files changed, 68 insertions(+), 36 deletions(-)
> 
> The merge diffstat looks as I would expect, the only odd thing is selinuxfs.c, 
> but it looks like that is simply because your next branch doesn't include the 
> error code fix I sent you for v4.0:
> 
>   commit 6436a123a147db51a0b06024a8350f4c230e73ff
>   Author: Joe Perches <joe@perches.com>
>   Date:   Mon Mar 23 18:01:35 2015 -0700
> 
>     selinux: fix sel_write_enforce broken return value
>     
>     Return a negative error value like the rest of the entries in this  
>     function.
>     
>     Cc: <stable@vger.kernel.org>
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
>     [PM: tweaked subject line]
>     Signed-off-by: Paul Moore <pmoore@redhat.com>
> 
> Are you asking because you ran into a problem, or just to check?

Yep, I saw that and some backmerge strangeness.  Did you rebase your tree
after I created a fresh branch?


-- 
James Morris
<jmorris@namei.org>
