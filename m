Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0B0lTcn013157
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2013 19:47:35 -0500
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
	<50EE9733.2060409@canonical.com>
Date: Thu, 10 Jan 2013 16:46:46 -0800
In-Reply-To: <50EE9733.2060409@canonical.com> (John Johansen's message of
	"Thu, 10 Jan 2013 02:25:55 -0800")
Message-ID: <87lic0sg09.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v12 0/9] LSM: Multiple concurrent LSMs
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

John Johansen <john.johansen@canonical.com> writes:

> On 01/09/2013 05:28 AM, James Morris wrote:
>> On Tue, 8 Jan 2013, John Johansen wrote:
>> 
>>>> I'd say we need to see the actual use-case for Smack and Apparmor being 
>>>> used together, along with at least one major distro committing to support 
>>>> this.
>>>>
>>>>
>>> Ubuntu is very interested in stacking
>> 
>> Which modules?
>> 
> Well Yama which has now been special cased, and in the past there has been
> discussion about other special case LSMs like case is proposing for module
> loading. There has been interest around both selinux + apparmor and
> smack + apparmor. I am not sure of all of the use cases that have lead to
> such question but some of them have been around containers, with say
> selinux on the host and apparmor in the container, or visa versa.

When a distro is run in a container it is desirable to be able to run
the distro's security policy in that container.  Ideally this will get
addressed by being able to do some level of per user namespace stacking.
Say selinux outside and apparmor inside a container.

I think this would take a little more work than what Casey has currently
devised but I am hopeful an additional layer of stacking can be added
after Casey has merged the basic layer of stacking.

Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
