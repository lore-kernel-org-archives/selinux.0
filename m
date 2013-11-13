From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 04/05] Add -P semodule option to man page
Date: Wed, 13 Nov 2013 10:43:47 -0500
Message-Id: <1384357428-21732-2-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1384357428-21732-1-git-send-email-dwalsh@redhat.com>
References: <1384357428-21732-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---
 policycoreutils/semodule/semodule.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 35277e9..2a91697 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -59,6 +59,9 @@ do not reload policy after commit
 .B  \-h,\-\-help        
 prints help message and quit
 .TP
+.B \-P,\-\-preserve_tunables
+Preserve tunables in policy
+.TP
 .B  \-v,\-\-verbose     
 be verbose
 
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
