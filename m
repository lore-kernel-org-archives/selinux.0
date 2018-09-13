Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8D0PDoN007476
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 20:25:14 -0400
Received: by mail-yb1-f194.google.com with SMTP id k5-v6so2554054ybo.10
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 17:24:36 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com.
 [209.85.219.180])
 by smtp.gmail.com with ESMTPSA id o193-v6sm1642898ywd.84.2018.09.12.17.24.32
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Sep 2018 17:24:32 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id e18-v6so2567578ybq.5
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 17:24:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <70b7f8cf-bfb1-1ec3-e4d4-5d2da632b52b@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <70b7f8cf-bfb1-1ec3-e4d4-5d2da632b52b@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Sep 2018 17:24:31 -0700
Message-ID: <CAGXu5jLnRbEy8h5QVVF=D-qu1Yt=vv5do5+_YVHe2asP84ShJA@mail.gmail.com>
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
Subject: Re: [PATCH 08/10] Smack: Abstract use of inode security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the inode->i_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
