From: Inamdar Sharif <isharif@nvidia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
CC: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: RE: [PATCH] Extend checkpolicy pathname matching.
Date: Mon, 18 Jul 2016 09:29:14 +0000
Message-ID: <e9ad0ee8d6894e8493bb099ad2e9b753@bgmail101.nvidia.com>
References: <1468511275-23946-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1468511275-23946-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

Thanks Stephen. That works.

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Thursday, July 14, 2016 9:18 PM
To: selinux@tycho.nsa.gov
Cc: Inamdar Sharif; seandroid-list@tycho.nsa.gov; Stephen Smalley
Subject: [PATCH] Extend checkpolicy pathname matching.

checkpolicy currently imposes arbitrary limits on pathnames used in genfscon and other statements.  This prevents specifying certain paths in /proc such as those containing comma (,) characters.

Generalize the PATH, QPATH, and FILENAME patterns to support most legal pathnames.

For simplicity, we do not support pathnames containing newlines or quotes.

Reported-by: Inamdar Sharif <isharif@nvidia.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/policy_scan.l | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l index 22da338..2f7f221 100644
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

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
