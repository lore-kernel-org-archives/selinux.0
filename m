Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0BJZvVT002455
	for <selinux@tycho.nsa.gov>; Fri, 11 Jan 2013 14:35:57 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
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
	<50F05656.5060301@schaufler-ca.com>
Date: Fri, 11 Jan 2013 11:35:11 -0800
In-Reply-To: <50F05656.5060301@schaufler-ca.com> (Casey Schaufler's message of
	"Fri, 11 Jan 2013 10:13:42 -0800")
Message-ID: <87d2xb3440.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v12 0/9] LSM: Multiple concurrent LSMs
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler <casey@schaufler-ca.com> writes:

>> When a distro is run in a container it is desirable to be able to run
>> the distro's security policy in that container.  Ideally this will get
>> addressed by being able to do some level of per user namespace stacking.
>> Say selinux outside and apparmor inside a container.
>>
>> I think this would take a little more work than what Casey has currently
>> devised but I am hopeful an additional layer of stacking can be added
>> after Casey has merged the basic layer of stacking.
>
> Would that be per-container LSM lists? I hadn't thought about
> doing that, and don't know how you might implement it, but I
> suppose it could work.

Essentially per-container LSM lists.  The semantics would be that
first you perform the global LSM list checks, and then you perform
the container LSM list checks (with additional layers if containers are
nested).  For LSM modules that depend on security labels I think there
would be a conflict that would prevent nesting.

This is already implemented for capabilities.  Something is already
happening with apparmor.

In practice it may just be a matter of getting the LSMs to be aware of
the containers rather than having per container LSM lists.  Especially
as all of the hooks are called every time for every LSM.

The important part is that the effect be nested policy.  Having nested calls
is likely to be unnecessary and inefficient if there is much nesting of
containers going on.

Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
