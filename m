Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3OIvsCO023088
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2013 14:58:15 -0400
Received: by mail-qc0-f176.google.com with SMTP id n41so1117185qco.21
        for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2013 11:57:58 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v13 0/9] LSM: Multiple concurrent LSMs
Date: Wed, 24 Apr 2013 14:57:55 -0400
Message-ID: <3554062.6nBMExN24s@sifl>
In-Reply-To: <5176B0F6.7080506@schaufler-ca.com>
References: <5176ABB7.5080300@schaufler-ca.com> <5176B0F6.7080506@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, April 23, 2013 09:04:06 AM Casey Schaufler wrote:
> Subject: [PATCH v13 0/9] LSM: Multiple concurrent LSMs
> 
> Change the infrastructure for Linux Security Modules (LSM)s from a
> single vector of hook handlers to a list based method for handling
> multiple concurrent modules.
> 
> The "security=" boot option takes a comma separated list of LSMs,
> registering them in the order presented. The LSM hooks will be
> executed in the order registered. Hooks that return errors are
> not short circuited. All hooks are called even if one of the LSM
> hooks fails. The result returned will be that of the last LSM
> hook that failed.

...

> The NetLabel, XFRM and secmark facilities are restricted to use
> by one LSM at a time. This is due to limitations of the underlying
> networking mechanisms. The good news is that viable configurations
> can be created. The bad news is that the complexity of configuring
> a system is necessarily increased.

I know we had a good discussion about this a while back and I just wanted to 
hear from you about this current patchset; how does the labeled networking LSM 
assignment work?  Is it first-come-first-served based on the 'security=' 
setting?

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
