Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6AKw2ol031856
 for <selinux@tycho.nsa.gov>; Fri, 10 Jul 2015 16:58:05 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux fixes for 4.2 (#2)
Date: Fri, 10 Jul 2015 16:57:59 -0400
Message-ID: <2425876.jW3AmBWBpN@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Another day, another SELinux patch.  Who knows, maybe we'll get lucky nothing 
will break over the weekend, although I'm not sure I'm that lucky.  Anyway, as 
discussed on the related threads, a small but pretty important patch that we 
want to get into 4.2 as soon as we can; I think the thread was pretty self 
explanatory, but if you have any questions let me know.

Thanks,
-Paul

---
The following changes since commit 3324603524925c7727207027d1c15e597412d15e:

  selinux: don't waste ebitmap space when importing NetLabel categories
           (2015-07-09 14:20:36 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 892e8cac99a71f6254f84fc662068d912e1943bf:

  selinux: fix mprotect PROT_EXEC regression caused by mm change
           (2015-07-10 16:45:29 -0400)

----------------------------------------------------------------
Stephen Smalley (1):
      selinux: fix mprotect PROT_EXEC regression caused by mm change

 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 312537d..692e3cc8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3271,7 +3271,8 @@ static int file_map_prot_check(struct file *file, 
unsigned long prot, int shared
 	int rc = 0;
 
 	if (default_noexec &&
-	    (prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
+	    (prot & PROT_EXEC) && (!file || IS_PRIVATE(file_inode(file)) ||
+				   (!shared && (prot & PROT_WRITE)))) {
 		/*
 		 * We are making executable an anonymous mapping or a
 		 * private file mapping that will also be writable.

-- 
paul moore
security @ redhat
