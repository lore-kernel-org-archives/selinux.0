Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAUNQiAI016632
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2012 18:26:44 -0500
Received: by mail-lb0-f181.google.com with SMTP id ge1so992024lbb.12
        for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2012 15:25:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50B930F5.5000705@schaufler-ca.com>
References: <50B930F5.5000705@schaufler-ca.com>
Date: Fri, 30 Nov 2012 18:25:54 -0500
Message-ID: <CACLa4psgaBetYvqgqZR29nBoVtLepyph5B=hwqf0iTtVFirQTg@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@parisplace.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 There are
>    cases where the existing LSMs wanted the call
>    last, and those have been addressed as well.

Is this just SELinux and mmap_min_addr?  I didn't look at the code,
but if this make it any better or worse, you can reverse them.  We
don't have some requirement to audit it, I just thought it was a good
idea and don't much care if you revert to 'normal'

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
