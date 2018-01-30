Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0UJ0W91027411
 for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2018 14:00:32 -0500
Received: by mail-pg0-f65.google.com with SMTP id n17so7967607pgf.10
 for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2018 11:00:06 -0800 (PST)
To: Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, stable@vger.kernel.org
References: <20180118215853.228182-1-salyzyn@android.com>
 <1516382386.2560.11.camel@tycho.nsa.gov>
 <1516383672.2560.23.camel@tycho.nsa.gov>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <99c11fa6-ad9a-830c-467e-6a56e78aecf8@android.com>
Date: Tue, 30 Jan 2018 11:00:04 -0800
MIME-Version: 1.0
In-Reply-To: <1516383672.2560.23.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] general protection fault in sock_has_perm
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/19/2018 09:41 AM, Stephen Smalley wrote:
> If we can't safely dereference the sock in these hooks, then that seems
> to point back to the approach used in my original code, where in
> ancient history I had sock_has_perm() take the socket and use its inode
> i_security field instead of the sock.  commit
> 253bfae6e0ad97554799affa0266052968a45808 switched them to use the sock
> instead.

Because of the nature of this problem (hard to duplicate, no clear 
path), I am understandably not comfortable reverting and submitting for 
testing in order to prove this point. It is disruptive because it 
changes several subroutine call signatures.

AFAIK this looks like a user request racing in without reference 
counting or RCU grace period in the callers (could be viewed as not an 
issue with security code). Effectively fixed in 4.9-stable, but broken 
in 4.4-stable.

hygiene, KISS and small, is all I do feel comfortable to submit to 
4.4-stable without pulling in all the infrastructure improvements.

-- Mark

---
  security/selinux/hooks.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 34427384605d..be68992a28cb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4066,6 +4066,8 @@ static int sock_has_perm(struct task_struct *task, 
struct sock *sk, u32 perms)
      struct lsm_network_audit net = {0,};
      u32 tsid = task_sid(task);

+    if (!sksec)
+        return -EFAULT;
      if (sksec->sid == SECINITSID_KERNEL)
          return 0;
