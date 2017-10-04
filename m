From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: paul@paul-moore.com, sds@tycho.nsa.gov, eparis@parisplace.org,
 james.l.morris@oracle.com, serge@hallyn.com
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Wed,  4 Oct 2017 20:32:18 +0200
Message-Id: <20171004183218.4786-2-clabbe.montjoie@gmail.com>
In-Reply-To: <20171004183218.4786-1-clabbe.montjoie@gmail.com>
References: <20171004183218.4786-1-clabbe.montjoie@gmail.com>
Subject: [PATCH 2/2] selinux: fix build warning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch make selinux_task_prlimit() static since it is not used
anywhere else.
This fix the following build warning:
security/selinux/hooks.c:3981:5: warning: no previous prototype for 'selinux_task_prlimit' [-Wmissing-prototypes]

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 security/selinux/hooks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8507a56f85e4..b8a022f4b4a7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3977,8 +3977,8 @@ static int selinux_task_getioprio(struct task_struct *p)
 			    PROCESS__GETSCHED, NULL);
 }
 
-int selinux_task_prlimit(const struct cred *cred, const struct cred *tcred,
-			 unsigned int flags)
+static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcred,
+				unsigned int flags)
 {
 	u32 av = 0;
 
-- 
2.13.6
