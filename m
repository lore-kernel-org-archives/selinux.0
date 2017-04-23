Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3N0rRKU018956
 for <selinux@tycho.nsa.gov>; Sat, 22 Apr 2017 20:53:27 -0400
Received: from mailscan09.yourhostingaccount.com ([10.1.15.9]
 helo=walmailscan09.yourhostingaccount.com)
 by walmailout10.yourhostingaccount.com with esmtp (Exim)
 id 1d25mB-0000gh-OD
 for selinux@tycho.nsa.gov; Sat, 22 Apr 2017 20:53:19 -0400
Received: from [10.114.3.33] (helo=walimpout13)
 by walmailscan09.yourhostingaccount.com with esmtp (Exim)
 id 1d25mB-0003cd-Md
 for selinux@tycho.nsa.gov; Sat, 22 Apr 2017 20:53:19 -0400
Received: from x1-6-50-6a-03-e0-98-fa.cpe.webspeed.dk ([188.181.91.111]:42248
 helo=hackers.mu)
 by walauthsmtp03.yourhostingaccount.com with esmtpa (Exim)
 id 1d25m7-0005kO-JH
 for selinux@tycho.nsa.gov; Sat, 22 Apr 2017 20:53:15 -0400
Date: Sun, 23 Apr 2017 02:53:11 +0200
From: Pirabarlen-Cheenaramen <selven@hackers.mu>
To: selinux@tycho.nsa.gov
Subject: [PATCH] security: hooks : Prevent security to persist in memory (PR
 #31)
Message-ID: <20170423005311.GA29693@hackers.mu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Pirabarlen-Cheenaramen <selven@hackers.mu>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Pirabarlen-Cheenaramen <selven@hackers.mu>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d98550a..9f82908 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4944,7 +4944,7 @@ static int selinux_tun_dev_alloc_security(void **security)
 
 static void selinux_tun_dev_free_security(void *security)
 {
-	kfree(security);
+	kzfree(security);
 }
 
 static int selinux_tun_dev_create(void)
-- 
1.9.1
