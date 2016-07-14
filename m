From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: isharif@nvidia.com, seandroid-list@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] Extend checkpolicy pathname matching.
Date: Thu, 14 Jul 2016 11:47:55 -0400
Message-Id: <1468511275-23946-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

checkpolicy currently imposes arbitrary limits on pathnames used
in genfscon and other statements.  This prevents specifying certain
paths in /proc such as those containing comma (,) characters.

Generalize the PATH, QPATH, and FILENAME patterns to support most
legal pathnames.

For simplicity, we do not support pathnames containing newlines or
quotes.

Reported-by: Inamdar Sharif <isharif@nvidia.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/policy_scan.l | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 22da338..2f7f221 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -249,9 +249,9 @@ high |
 HIGH				{ return(HIGH); }
 low |
 LOW				{ return(LOW); }
-"/"({alnum}|[_\.\-/])*	        { return(PATH); }
-\""/"[ !#-~]*\" 		{ return(QPATH); }
-\"({alnum}|[_\.\-\+\~\: ])+\"	{ return(FILENAME); }
+"/"[^ \n\r\t\f]*	        { return(PATH); }
+\""/"[^\"\n]*\" 		{ return(QPATH); }
+\"[^"/"\"\n]+\"	{ return(FILENAME); }
 {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
 {digit}+|0x{hexval}+            { return(NUMBER); }
 {alnum}*{letter}{alnum}*        { return(FILESYSTEM); }
-- 
2.5.5
