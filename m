Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M36Zfd002916
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 23:06:35 -0400
Received: by mail-yw1-f67.google.com with SMTP id j131-v6so5968124ywc.13
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:06:31 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com.
 [209.85.161.51])
 by smtp.gmail.com with ESMTPSA id m19-v6sm170894ywh.31.2018.09.21.20.06.30
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 20:06:30 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id k66-v6so406894ywa.10
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:06:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e4a7033-a86d-a30f-7420-acd765f90534@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <4e4a7033-a86d-a30f-7420-acd765f90534@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 19:58:15 -0700
Message-ID: <CAGXu5jLqvrvTe+RmNs86H0ud+9AW8wT8yEbbWeYxmisuOKZQxw@mail.gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v4 18/19] LSM: Infrastructure management of the
 ipc security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 21, 2018 at 5:20 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the kern_ipc_perm->security and
> msg_msg->security blobs out of the individual security
> modules and into the security infrastructure. Instead
> of allocating the blobs from within the modules the modules
> tell the infrastructure how much space is required, and
> the space is allocated there.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
