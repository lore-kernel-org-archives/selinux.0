Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9LDe1sa004546
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 09:40:01 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] SELinux updates for 3.12
Date: Mon, 21 Oct 2013 09:39:56 -0400
Message-ID: <1587641.zEKSTAkKTO@sifl>
In-Reply-To: <alpine.LRH.2.02.1310210947360.24529@tundra.namei.org>
References: <2307607.HXDCGv9Ccf@sifl> <alpine.LRH.2.02.1310210947360.24529@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, October 21, 2013 09:49:54 AM James Morris wrote:
> On Thu, 17 Oct 2013, Paul Moore wrote:
> > Hi James,
> > 
> > Here are a collection of SELinux updates that should be included in 3.12.
> > This request contains mostly various cleanup patches with a few bugfixes
> > and performance improvements thrown in for good measure.  The bulk of
> > these patches were inherited from Eric's old tree, hence the merge/pull
> > in the log.
> > 
> > Lastly, all of these patches have been in linux-next for some time now,
> > and
> > they all pass the SELinux testsuite with flying colors.
> > 
> > Enjoy,
> > -Paul
> > 
> > ---
> > 
> > The following changes since commit 6e4664525b1db28f8c4e1130957f70....
> >   Linux 3.11 (2013-09-02 13:46:10 -0700)
> > 
> > are available in the git repository at:
> >   git://git.infradead.org/users/pcmoore/selinux
> 
> Why is no branch specified?

Why does a branch need to be specified?  The changes live in master and my 
understanding was that if a branch was not explicitly listed then master 
should be used.

> git-pull fails in any case.

Can you be more explicit?  It works for me ...

# git pull git://git.infradead.org/users/pcmoore/selinux
remote: Counting objects: 238, done.
remote: Compressing objects: 100% (38/38), done.
remote: Total 199 (delta 169), reused 189 (delta 161)
Receiving objects: 100% (199/199), 31.38 KiB | 0 bytes/s, done.
Resolving deltas: 100% (169/169), completed with 38 local objects.
>From git://git.infradead.org/users/pcmoore/selinux
 * branch            HEAD       -> FETCH_HEAD
Auto-merging security/selinux/include/xfrm.h
Auto-merging security/selinux/hooks.c
Auto-merging security/security.c
Auto-merging security/capability.c
Auto-merging include/linux/security.h
Auto-merging MAINTAINERS
Merge made by the 'recursive' strategy.
 MAINTAINERS                         |   3 +-
 include/linux/security.h            |  26 ++-
 security/capability.c               |  15 +-
 security/security.c                 |  13 +-
 security/selinux/hooks.c            | 146 +++++++-----
 security/selinux/include/objsec.h   |   4 +-
 security/selinux/include/security.h |  13 +-
 security/selinux/include/xfrm.h     |  45 ++--
 security/selinux/netlabel.c         |   6 +-
 security/selinux/netnode.c          |   2 +
 security/selinux/selinuxfs.c        |   4 +-
 security/selinux/ss/ebitmap.c       |  20 +-
 security/selinux/ss/ebitmap.h       |  10 +-
 security/selinux/ss/mls.c           |  22 +-
 security/selinux/ss/mls_types.h     |   2 +-
 security/selinux/ss/policydb.c      |   3 +-
 security/selinux/ss/services.c      |  66 ++++--
 security/selinux/xfrm.c             | 453 +++++++++++++++-------------------
 18 files changed, 452 insertions(+), 401 deletions(-)

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
