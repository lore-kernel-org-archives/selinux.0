Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M2okTw032537
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 22:50:47 -0400
Received: by mail-yb1-f193.google.com with SMTP id w7-v6so6254153ybm.7
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:50:44 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com.
 [209.85.219.181])
 by smtp.gmail.com with ESMTPSA id o128-v6sm4998723ywe.110.2018.09.21.19.50.40
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Sep 2018 19:50:41 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id w7-v6so6254119ybm.7
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 19:50:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f08b4c79-f283-3625-f461-71a4628655ef@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <f08b4c79-f283-3625-f461-71a4628655ef@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 21 Sep 2018 19:50:39 -0700
Message-ID: <CAGXu5jLKMG15hex6ko=E-YCMRRsmd22KdjzrRXH_FRMqwmchkw@mail.gmail.com>
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
Subject: Re: [PATCH v4 08/19] Infrastructure management of the cred
 security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Sep 21, 2018 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the cred security blob out of the
> security modules and into the security infrastructre.
> Instead of allocating and freeing space the security
> modules tell the infrastructure how much space they
> require.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

When combined with my series, this gets slightly simpler:
- the double init call and the "finished" stuff goes away
- debugging output is controlled by "lsm.debug" param instead of a CONFIG

Regardless, for the overall logic, calculating the sizes, etc:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
