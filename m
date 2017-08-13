To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Alexey Dobriyan <adobriyan@gmail.com>, Daniel Jurgens
 <danielj@mellanox.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Junil Lee <junil0814.lee@lge.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
Date: Sun, 13 Aug 2017 16:43:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 0/4] SELinux: Fine-tuning for some function
 implementations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 13 Aug 2017 16:25:43 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  Delete eight unnecessary variable assignments
  Adjust jump targets in ebitmap_read()
  Delete an unnecessary return statement in ebitmap_destroy()
  Adjust five checks for null pointers

 security/selinux/selinuxfs.c   |  1 -
 security/selinux/ss/avtab.c    |  2 --
 security/selinux/ss/ebitmap.c  | 53 +++++++++++++++++++-----------------------
 security/selinux/ss/policydb.c | 10 ++------
 4 files changed, 26 insertions(+), 40 deletions(-)

-- 
2.14.0
