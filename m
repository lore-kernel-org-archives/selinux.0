Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4GBuqqn024804
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 07:56:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 40mCb82XmxzJmrc
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 11:56:52 +0000 (UTC)
Received: from UPDC3CPA11_EEMSG_MP27.eemsg.mil (unknown [192.168.18.22])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 40mCb716HpzJmrp
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 11:56:51 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
 Netfilter Devel List <netfilter-devel@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Integrity Measurement Architecture <linux-integrity@vger.kernel.org>,
 SElinux list <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 David Howells <dhowells@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Date: Wed, 16 May 2018 07:55:45 -0400
Message-Id: <12a849e41468d761e0782c733e58db47d83b0d16.1526430313.git.rgb@redhat.com>
In-Reply-To: <cover.1526430313.git.rgb@redhat.com>
References: <cover.1526430313.git.rgb@redhat.com>
In-Reply-To: <cover.1526430313.git.rgb@redhat.com>
References: <cover.1526430313.git.rgb@redhat.com>
Subject: [PATCH ghak81 V3 1/3] audit: use new audit_context access
 funciton for seccomp_actions_logged
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On the rebase of the following commit on the new seccomp actions_logged
function, one audit_context access was missed.

commit cdfb6b341f0f2409aba24b84f3b4b2bba50be5c5
("audit: use inline function to get audit context")

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index cbab0da..f3d3dc6 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2497,7 +2497,7 @@ void audit_seccomp_actions_logged(const char *names, const char *old_names,
 	if (!audit_enabled)
 		return;
 
-	ab = audit_log_start(current->audit_context, GFP_KERNEL,
+	ab = audit_log_start(audit_context(), GFP_KERNEL,
 			     AUDIT_CONFIG_CHANGE);
 	if (unlikely(!ab))
 		return;
-- 
1.8.3.1
