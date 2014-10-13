Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9DFvju9005105
 for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2014 11:57:46 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.18 #2
Date: Mon, 13 Oct 2014 11:57:24 -0400
Message-ID: <64243365.FIno1OMc7X@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

One more small SELinux fix that should go into 3.18, if not during the merge 
window then during the -rc period.  Stephen wrote a nice patch description 
which describes the problem, but it basically boils down to a race condition 
that could result in a corrupted SELinux inode security blob/list.  It is a 
pretty difficult thing to reproduce, but the fix is obviously correct and 
rather straightforward.

While I wouldn't expect any problems, for the sake of completeness I ran the 
patch through the SELinux testsuite and it passed with flying colors.

Thanks,
-Paul

P.S. Somewhat related, as should be obvious from the weekend's exchange with 
Linus, I'm not going to be updating/merging the SELinux next branch beyond 
v3.16 unless I start to see problems accepting new patches (either through 
interface or logic changes).

---
The following changes since commit e7387395a07d788f80d011baa8ec6beba2bc747c:

  selinux: normalize audit log formatting (2014-10-06 11:57:25 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-3.18

for you to fetch changes up to 7c66bdc72bc3d792886c42bbab4b214c1fe536e0:

  selinux: fix inode security list corruption (2014-10-06 16:32:52 -0400)

----------------------------------------------------------------
Stephen Smalley (1):
      selinux: fix inode security list corruption

 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
security and virtualization @ redhat
