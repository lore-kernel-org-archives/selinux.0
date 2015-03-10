From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] checkpolicy: Fix precedence between number and filesystem
 tokens.
Date: Tue, 10 Mar 2015 12:44:11 -0400
Message-Id: <1426005851-5474-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When the FILESYSTEM token was added to support filesystem names that
start with a digit (e.g. 9p), it was given higher precedence than
NUMBER and therefore all values specified in hex (with 0x prefix)
in policy will incorrectly match FILESYSTEM and yield a syntax error.
This breaks use of iomem ranges in Xen policy and will break ioctl
command ranges in a future SELinux policy version.  Switch the
precedence.  This does mean that you cannot currently have a filesystem
with a name that happens to be 0x followed by a hexval but hopefully
that isn't an issue.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/policy_scan.l | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
index 3a73962..648e1d6 100644
--- a/checkpolicy/policy_scan.l
+++ b/checkpolicy/policy_scan.l
@@ -242,8 +242,8 @@ LOW				{ return(LOW); }
 "/"({alnum}|[_\.\-/])*	        { return(PATH); }
 \"({alnum}|[_\.\-\+\~\: ])+\"	{ return(FILENAME); }
 {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*	{ return(IDENTIFIER); }
-{alnum}*{letter}{alnum}*        { return(FILESYSTEM); }
 {digit}+|0x{hexval}+            { return(NUMBER); }
+{alnum}*{letter}{alnum}*        { return(FILESYSTEM); }
 {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
 {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
-- 
1.9.3
