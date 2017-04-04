Subject: [PATCH 0/3] SELinux: Fine-tuning for two function implementations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Message-ID: <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
Date: Tue, 4 Apr 2017 13:10:07 +0200
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Apr 2017 13:02:03 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Return directly after a failed memory allocation in policydb_index()
  Return an error code only as a constant in sidtab_insert()
  Use an other error code for an input validation failure in sidtab_insert()

 security/selinux/ss/policydb.c | 15 +++++----------
 security/selinux/ss/sidtab.c   | 27 ++++++++++-----------------
 2 files changed, 15 insertions(+), 27 deletions(-)

-- 
2.12.2
