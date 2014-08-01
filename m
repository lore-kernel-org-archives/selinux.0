Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s71FSenZ030376
 for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2014 11:28:40 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux patches for 3.17
Date: Fri, 01 Aug 2014 11:28:36 -0400
Message-ID: <25128076.T1yg0xqlTP@sifl>
In-Reply-To: <3135081.Nfbulyq9MG@sifl>
References: <3135081.Nfbulyq9MG@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, July 18, 2014 03:37:19 PM Paul Moore wrote:
> Hi James,
> 
> Here are the SELinux patches for 3.17.  A total of eight patches, none
> particularly controversial: a few cleanups, a few bug fixes, and a minor
> tweak to reduce the SELinux overhead during boot...

Hi James,

A late addition to the SELinux patches for 3.17.  Normally I would just wait 
for the next release, but these patches are pretty significant (marked for 
stable as well) so I think they merit the late add.  I just posted the patches 
yesterday with an explanation so I won't bother repeating myself here since 
they are still likely fresh in your inbox.

I did a quick test pull and everything applies cleanly on top of the linux-
security #next tree.

Thanks,
-Paul

---
The following changes since commit 615e51fdda6f274e94b1e905fcaf6111e0d9aa20:

  selinux: reduce the number of calls to synchronize_net() when flushing
           caches (2014-06-26 14:33:56 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux next

for you to fetch changes up to 4fbe63d1c773cceef3fe1f6ed0c9c268f4f24760:

  netlabel: shorter names for the NetLabel catmap funcs/structs
            (2014-08-01 11:17:37 -0400)

----------------------------------------------------------------
Paul Moore (4):
      netlabel: fix a problem when setting bits below the previously
                lowest bit
      netlabel: fix the horribly broken catmap functions
      netlabel: fix the catmap walking functions
      netlabel: shorter names for the NetLabel catmap funcs/structs

 include/net/netlabel.h        |  94 ++++++------
 net/ipv4/cipso_ipv4.c         |  47 +++---
 net/netlabel/netlabel_kapi.c  | 327 +++++++++++++++++++++++++++-----------
 security/selinux/ss/ebitmap.c | 133 +++++++----------
 security/selinux/ss/ebitmap.h |   8 +-
 security/smack/smack_access.c |  11 +-
 security/smack/smack_lsm.c    |   6 +-
 security/smack/smackfs.c      |  14 +-
 8 files changed, 366 insertions(+), 274 deletions(-)

-- 
paul moore
security and virtualization @ redhat
