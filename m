Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6SFGZaP012928
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 11:16:35 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux fix for 3.16-rcX
Date: Mon, 28 Jul 2014 11:16:33 -0400
Message-ID: <1696874.XicgDe8Om8@sifl>
In-Reply-To: <2092564.8lACVUTXtn@sifl>
References: <2092564.8lACVUTXtn@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, July 15, 2014 10:38:19 PM Paul Moore wrote:
> Hi James,
> 
> A single fix for the upcoming 3.16 release.  This patch is worth pushing up
> for 3.16, despite the late stage of the release, because without this patch
> SELinux systems with the latest version of cryptsetup may not be able to
> access their encrypted volumes (more details in the patch description) which
> could prevent the system from booting properly, users accessing their home
> directories, etc.
> 
> The patch is fairly minor and passes the SELinux testsuite.

Hello again,

Below is a revert for the patch above, while it fixed AF_ALG, it killed 
Bluetooth so we need to revert it.  I'll fix AF_ALG in a future patch.

---
The following changes since commit 4da6daf4d3df5a977e4623963f141a627fd2efce:

  selinux: fix the default socket labeling in sock_graft() (2014-07-10  
           10:17:48 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-3.16

for you to fetch changes up to 2873ead7e46694910ac49c3a8ee0f54956f96e0c:

  Revert "selinux: fix the default socket labeling in sock_graft()"     
          (2014-07-28 10:46:07 -0400)

----------------------------------------------------------------
Paul Moore (1):
      Revert "selinux: fix the default socket labeling in sock_graft()"

 include/linux/security.h |  5 +----
 security/selinux/hooks.c | 13 ++-----------
 2 files changed, 3 insertions(+), 15 deletions(-)

-- 
paul moore
security and virtualization @ redhat
