Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8KHijs8005037
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 13:44:45 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so4094628ywg.8
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:44:40 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com.
 [209.85.219.176])
 by smtp.gmail.com with ESMTPSA id o193-v6sm4393982ywd.84.2018.09.20.10.44.37
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Sep 2018 10:44:37 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y12-v6so1054125ybj.11
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 10:44:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b977e081-4402-f31d-e219-f9716ea7a83b@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <b977e081-4402-f31d-e219-f9716ea7a83b@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Sep 2018 10:44:36 -0700
Message-ID: <CAGXu5jJRQzWF=C_kmOpZ8XcUzAhkoZnNi7a7KzEHJtFhMNd+3Q@mail.gmail.com>
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
Subject: Re: [PATCH v3 15/16] LSM: Infrastructure management of the
 ipc security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> LSM: Infrastructure management of the ipc security blob
>
> Move management of the kern_ipc_perm->security and
> msg_msg->security blobs out of the individual security
> modules and into the security infrastructure. Instead
> of allocating the blobs from within the modules the modules
> tell the infrastructure how much space is required, and
> the space is allocated there.

Maybe split this up too? (SELinux and Smack need tweaks?)

-Kees

-- 
Kees Cook
Pixel Security
