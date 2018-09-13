Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8D0NtO8007468
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 20:23:56 -0400
Received: by mail-yb1-f194.google.com with SMTP id j8-v6so2555109ybg.9
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 17:23:43 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com.
 [209.85.161.42])
 by smtp.gmail.com with ESMTPSA id b135-v6sm1913742ywh.24.2018.09.12.17.23.40
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Sep 2018 17:23:40 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id x83-v6so468036ywd.4
 for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2018 17:23:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1aa12afc-2e1e-2e89-d422-a471990e0367@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <1aa12afc-2e1e-2e89-d422-a471990e0367@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Sep 2018 17:23:39 -0700
Message-ID: <CAGXu5jLvyCXgtE6-S05kEQqBnZwftRanRTVYJOnBRPJJnOK4Vw@mail.gmail.com>
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
Subject: Re: [PATCH 07/10] SELinux: Abstract use of inode security
 blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 11, 2018 at 9:42 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the inode->i_security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Happily mechanical! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
