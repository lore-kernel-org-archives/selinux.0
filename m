Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r09DSgmf000374
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2013 08:28:42 -0500
Date: Thu, 10 Jan 2013 00:28:30 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: John Johansen <john.johansen@canonical.com>
cc: Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v12 0/9] LSM: Multiple concurrent LSMs
In-Reply-To: <50EC8447.1000301@canonical.com>
Message-ID: <alpine.LRH.2.02.1301100028160.5423@tundra.namei.org>
References: <50EB7C50.3070605@schaufler-ca.com> <20130108140159.83c07fa6a680e355f024970f@canb.auug.org.au> <50EB9A5E.1080306@schaufler-ca.com> <alpine.LRH.2.02.1301081942030.24212@tundra.namei.org> <50EC8447.1000301@canonical.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Jan 2013, John Johansen wrote:

> > I'd say we need to see the actual use-case for Smack and Apparmor being 
> > used together, along with at least one major distro committing to support 
> > this.
> > 
> >
> Ubuntu is very interested in stacking

Which modules?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
