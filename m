Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8CNAaA7029264
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 19:10:36 -0400
Received: by mail-yb1-f196.google.com with SMTP id k5-v6so2492734ybo.10
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 16:10:30 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com.
 [209.85.161.51])
 by smtp.gmail.com with ESMTPSA id d6-v6sm707884ywa.85.2018.09.12.16.10.26
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Sep 2018 16:10:27 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id l9-v6so409516ywc.11
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 16:10:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <39bcaa18-4c53-f386-5e89-8903a49a3256@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <39bcaa18-4c53-f386-5e89-8903a49a3256@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Sep 2018 16:10:25 -0700
Message-ID: <CAGXu5jLBwipu9WD41rQvdTjoM=+3gigrA3sp1s1gFv8C_U0nRg@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, LKLM <linux-kernel@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 03/10] SELinux: Abstract use of cred security
 blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Like smack, this seems to be largely:

s/$identifier->security/selinux_cred($identifier)/
s/current_security()/selinux_cred(current_cred())/

Is that right? The one __task_cred() use seemed to be fully contained
under rcu read lock.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
