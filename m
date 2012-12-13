Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBDGVTGE003014
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 11:31:36 -0500
Message-ID: <50CA02FA.4020508@schaufler-ca.com>
Date: Thu, 13 Dec 2012 08:31:54 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>
CC: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
References: <50C8A757.3050907@schaufler-ca.com> <1355327754.3527.37.camel@localhost> <50C8AFD1.1070905@schaufler-ca.com> <1355330026.3527.44.camel@localhost> <50C8B919.2060102@schaufler-ca.com> <201212132106.AFI82338.QMFHFLSJOtOOFV@I-love.SAKURA.ne.jp> <CACLa4psaVNf8-WvSX9F6oj3zyyJJpvK80RvQVGAmjH7SiQUAqA@mail.gmail.com>
In-Reply-To: <CACLa4psaVNf8-WvSX9F6oj3zyyJJpvK80RvQVGAmjH7SiQUAqA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/2012 8:12 AM, Eric Paris wrote:
> On Thu, Dec 13, 2012 at 7:06 AM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Casey Schaufler wrote:
>>>       /proc/.../attr/current
>>>       /proc/.../attr/selinux.current
>>>       /proc/.../attr/apparmor.current
>>>       /proc/.../attr/keycreate
>>>       /proc/.../attr/selinux.keycreate
>>>
>> Can we use prctl() interface instead of /proc/$pid/attr/$lsmname.$type ?
>> I simply don't want to see flood of entries when "find /proc/" runs. ;-)
>>
>> prctl() can tell the caller whether specified LSM is enabled/presented or not
>> via its return value.
> I don't much care for or understand Casey's reason for using selinux.*
> instead of selinux/*

I asked opinions and all I heard were crickets. It's an easy change.
Does anyone else have a preference?

> but at least it means we can interact with these
> interfaces in a shell.  prctl() means you can't use tools like cat or
> echo.  Everything has to be a utility.  That just does not seem as
> nice for admins.

Most programming is being done in scripting languages these days.
Eric is correct. It is much more sensible to burden the C programmer
than the HTML5 programmer. For many, many reasons.

> In my opinion you want to do things pragmatically, use a library, and
> if you want to do things as a human, use the tools that already exist.
>
> -Eric
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
