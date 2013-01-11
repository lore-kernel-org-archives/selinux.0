Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0B1E0Dn014447
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2013 20:14:00 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: John Johansen <john.johansen@canonical.com>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <50EB7C50.3070605@schaufler-ca.com>
	<20130108140159.83c07fa6a680e355f024970f@canb.auug.org.au>
	<50EB9A5E.1080306@schaufler-ca.com>
	<alpine.LRH.2.02.1301081942030.24212@tundra.namei.org>
	<50EC8447.1000301@canonical.com>
	<alpine.LRH.2.02.1301100028160.5423@tundra.namei.org>
	<50EE9733.2060409@canonical.com> <87lic0sg09.fsf@xmission.com>
	<50EF6368.6070504@canonical.com>
Date: Thu, 10 Jan 2013 17:13:02 -0800
In-Reply-To: <50EF6368.6070504@canonical.com> (John Johansen's message of
	"Thu, 10 Jan 2013 16:57:12 -0800")
Message-ID: <87d2xcsesh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v12 0/9] LSM: Multiple concurrent LSMs
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

John Johansen <john.johansen@canonical.com> writes:

>> When a distro is run in a container it is desirable to be able to run
>> the distro's security policy in that container.  Ideally this will get
>> addressed by being able to do some level of per user namespace stacking.
>> Say selinux outside and apparmor inside a container.
>> 
>> I think this would take a little more work than what Casey has currently
>> devised but I am hopeful an additional layer of stacking can be added
>> after Casey has merged the basic layer of stacking.
>> 
> Right the general case will take more, but doing things like selinux on
> the outside and apparmor inside are doable right now. And we are working
> on supporting stacked apparmor policy right now so apparmor outside and
> a different apparmor policy inside will be doable soon.

Cool.  For stacked apparmor how are you deciding which tasks get which
policy?  Is this based on user namespaces or something else?

Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
