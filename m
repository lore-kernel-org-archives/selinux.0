Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9QGrKHB017172
	for <selinux@tycho.nsa.gov>; Fri, 26 Oct 2012 12:53:20 -0400
Message-ID: <508ABFE8.7070708@schaufler-ca.com>
Date: Fri, 26 Oct 2012 09:52:56 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: keescook@chromium.org, jmorris@namei.org,
        linux-security-module@vger.kernel.org, john.johansen@canonical.com,
        selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v5.1] LSM: Multiple concurrent LSMs
References: <201210242225.EFC43782.FLFQMHOOVFJOSt@I-love.SAKURA.ne.jp> <201210250650.HAJ18213.FMtVQOFHJOLOFS@I-love.SAKURA.ne.jp> <CAGXu5jKdLnDCpDzteY1v3aStAxAezdOykKUN1gDt69BZcBvwEA@mail.gmail.com> <201210252116.DBJ56717.tVFFLJOOOSQHFM@I-love.SAKURA.ne.jp> <201210252128.EGC12919.OFtFSMHQOOVLFJ@I-love.SAKURA.ne.jp> <201210270127.BJF52683.QtMFVOFOLJSFOH@I-love.SAKURA.ne.jp>
In-Reply-To: <201210270127.BJF52683.QtMFVOFOLJSFOH@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/26/2012 9:27 AM, Tetsuo Handa wrote:
> This is what I think we can optimize.

I think that I have worked out a list based scheme
that will address the performance concerns. I hope to
have a version ready in the next few days. There is a
lot of typing involved.

> Only compile tested. This may not boot.
>
> Calls to common cap functions (e.g. cap_bprm_set_creds()) are not yet
> eliminated from each LSM modules. Common cap functions can be now eliminated from
> each LSM modules because these common cap functions are called from security/security.c
> (though I think I've made several mistakes while optimizing).

I don't know that we can do that in every case, but I'll look.

> Revived register_security() so that individual LSM modules can determine
> whether that module is listed on the activation list or not; and can take
> appropriate action (probably call panic()) if registration failed when that
> module is listed on the activation list.
>
> Updated register_security() to allow control of LSM hook call ordering.
> Revived CONFIG_DEFAULT_SECURITY so that Linux distributors can specify
> list of LSM modules which should be enabled by default (e.g. "selinux",
> "apparmor,yama") while compiling other LSM modules which are not enabled
> unless explicitly specified by security= kernel boot parameter.

I will definitely try to incorporate this.

> What do you think?

I am going to hold off on specific comments until I've decided
on the merits of my list based scheme, which will eliminate the
composer_ops array.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
