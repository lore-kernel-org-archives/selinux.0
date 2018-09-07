To: selinux@tycho.nsa.gov
References: <000000000000038dab0575476b73@google.com>
Cc: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>,
 eparis@parisplace.org, linux-kernel@vger.kernel.org,
 paul@paul-moore.com, peter.enderborg@sony.com, sds@tycho.nsa.gov,
 syzkaller-bugs@googlegroups.com
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
Date: Sat, 8 Sep 2018 01:42:58 +0900
MIME-Version: 1.0
In-Reply-To: <000000000000038dab0575476b73@google.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH] selinux: Add __GFP_NOWARN to allocation at
 str_read()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

syzbot is hitting warning at str_read() [1] because len parameter can
become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
this case.

[1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
---
 security/selinux/ss/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e9394e7..f4eadd3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	if ((len == 0) || (len == (u32)-1))
 		return -EINVAL;
 
-	str = kmalloc(len + 1, flags);
+	str = kmalloc(len + 1, flags | __GFP_NOWARN);
 	if (!str)
 		return -ENOMEM;
 
-- 
1.8.3.1
