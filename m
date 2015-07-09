Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t69NuwEb017056
 for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2015 19:56:59 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux fixes for 4.2
Date: Thu, 09 Jul 2015 19:56:52 -0400
Message-ID: <10193986.g5qmVsbCGZ@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

A small SELinux patch to fix an annoying problem when importing NetLabel 
category bitmaps.  Due to a bit of dumb luck it really isn't an issue for the 
majority of people running 64-bit systems, but for the 32-bit NetLabel crowd 
(single digits perhaps?) it can be a real problem.

Please merge for the next 4.2-rc release.

Thanks,
-Paul

---
The following changes since commit 9fc2b4b436cff7d8403034676014f1be9d534942:

  selinux: fix setting of security labels on NFS (2015-06-05 14:21:48 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 3324603524925c7727207027d1c15e597412d15e:

  selinux: don't waste ebitmap space when importing NetLabel categories
           (2015-07-09 14:20:36 -0400)

----------------------------------------------------------------
Paul Moore (1):
      selinux: don't waste ebitmap space when importing NetLabel categories

 security/selinux/ss/ebitmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index afe6a26..57644b1 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -153,6 +153,12 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 		if (offset == (u32)-1)
 			return 0;
 
+		/* don't waste ebitmap space if the netlabel bitmap is empty */
+		if (bitmap == 0) {
+			offset += EBITMAP_UNIT_SIZE;
+			continue;
+		}
+
 		if (e_iter == NULL ||
 		    offset >= e_iter->startbit + EBITMAP_SIZE) {
 			e_prev = e_iter;

-- 
paul moore
security @ redhat
