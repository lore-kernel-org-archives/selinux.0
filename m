Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBG35xxb000747
	for <selinux@tycho.nsa.gov>; Sat, 15 Dec 2012 22:05:59 -0500
Message-ID: <50CD3AA9.3050008@schaufler-ca.com>
Date: Sat, 15 Dec 2012 19:06:17 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
CC: Eric Paris <eparis@parisplace.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
References: <50C8A757.3050907@schaufler-ca.com> <1355327754.3527.37.camel@localhost> <50C8AFD1.1070905@schaufler-ca.com> <1355330026.3527.44.camel@localhost> <50C8B919.2060102@schaufler-ca.com> <201212132106.AFI82338.QMFHFLSJOtOOFV@I-love.SAKURA.ne.jp> <CACLa4psaVNf8-WvSX9F6oj3zyyJJpvK80RvQVGAmjH7SiQUAqA@mail.gmail.com> <50CA02FA.4020508@schaufler-ca.com> <CAGXu5jJf4NEvs6TjVCBxgd9e8cGwag_-viEntgTBUq85fULr8w@mail.gmail.com>
In-Reply-To: <CAGXu5jJf4NEvs6TjVCBxgd9e8cGwag_-viEntgTBUq85fULr8w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/2012 9:13 AM, Kees Cook wrote:
> On Thu, Dec 13, 2012 at 8:31 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 12/13/2012 8:12 AM, Eric Paris wrote:
>>> On Thu, Dec 13, 2012 at 7:06 AM, Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> Casey Schaufler wrote:
>>>>>       /proc/.../attr/current
>>>>>       /proc/.../attr/selinux.current
>>>>>       /proc/.../attr/apparmor.current
>>>>>       /proc/.../attr/keycreate
>>>>>       /proc/.../attr/selinux.keycreate
>>>>>
>>>> Can we use prctl() interface instead of /proc/$pid/attr/$lsmname.$type ?
>>>> I simply don't want to see flood of entries when "find /proc/" runs. ;-)
>>>>
>>>> prctl() can tell the caller whether specified LSM is enabled/presented or not
>>>> via its return value.
>>> I don't much care for or understand Casey's reason for using selinux.*
>>> instead of selinux/*
>> I asked opinions and all I heard were crickets. It's an easy change.
>> Does anyone else have a preference?
> Like Eric, I prefer directories. It complicates things slightly
> because then LSMs can't be named "current", etc...

I have been digging at the code and "selinux.current" is a whole
lot simpler than "selinux/current". fs/proc/base.c is where to look
at the code. For now I'm sticking with my original plan. If someone
cares enough to suggest an implementation, I'm wide open to it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
