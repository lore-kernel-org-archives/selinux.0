Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBCGOSWq020670
	for <selinux@tycho.nsa.gov>; Wed, 12 Dec 2012 11:24:31 -0500
Message-ID: <50C8AFD1.1070905@schaufler-ca.com>
Date: Wed, 12 Dec 2012 08:24:49 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        john.johansen@canonical.com, keescook@chromium.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
References: <50C65DE2.5090909@schaufler-ca.com>  <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp>  <50C751D3.60409@schaufler-ca.com>  <201212122159.CEC09839.HMOFtQFLJSVFOO@I-love.SAKURA.ne.jp>  <50C8A757.3050907@schaufler-ca.com> <1355327754.3527.37.camel@localhost>
In-Reply-To: <1355327754.3527.37.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/12/2012 7:55 AM, Eric Paris wrote:
> On Wed, 2012-12-12 at 07:48 -0800, Casey Schaufler wrote:
>
> How about asking every LSM to implement a new 'enable' function.  If the
> LSM is not 'present' only the new 'enable' function can be used.  If the
> LSM is present either the legacy enable function every LSM uses today or
> the new enable function can be used.  Thus even if you build the kernel
> with stacking, you cannot enable a non-present LSM unless the tools have
> been updated.

I'm sorry, but I am having trouble understanding what you're suggesting.

>
> I'd envision for SELinux it would mean that we would disable/not
> expose/whatever /sys/fs/selinux/load when SELinux was not present.  And
> we'd have a new /sys/fs/selinux/new_load which could be used in its
> place.
>
> Thoughts?
>
> -Eric
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
