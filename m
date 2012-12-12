Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCFuZO6018451
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 10:56:35 -0500
Message-ID: <1355327754.3527.37.camel@localhost>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        john.johansen@canonical.com, keescook@chromium.org
Date: Wed, 12 Dec 2012 10:55:54 -0500
In-Reply-To: <50C8A757.3050907@schaufler-ca.com>
References: <50C65DE2.5090909@schaufler-ca.com>
	 <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp>
	 <50C751D3.60409@schaufler-ca.com>
	 <201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp>
	 <50C8A757.3050907@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-12-12 at 07:48 -0800, Casey Schaufler wrote:

How about asking every LSM to implement a new 'enable' function.  If the
LSM is not 'present' only the new 'enable' function can be used.  If the
LSM is present either the legacy enable function every LSM uses today or
the new enable function can be used.  Thus even if you build the kernel
with stacking, you cannot enable a non-present LSM unless the tools have
been updated.

I'd envision for SELinux it would mean that we would disable/not
expose/whatever /sys/fs/selinux/load when SELinux was not present.  And
we'd have a new /sys/fs/selinux/new_load which could be used in its
place.

Thoughts?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
