Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBDGCnGF001495
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 11:12:50 -0500
Received: by mail-ee0-f53.google.com with SMTP id c50so1584793eek.12
        for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 08:12:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201212132106.AFI82338.QMFHFLSJOtOOFV@I-love.SAKURA.ne.jp>
References: <50C8A757.3050907@schaufler-ca.com>
	<1355327754.3527.37.camel@localhost>
	<50C8AFD1.1070905@schaufler-ca.com>
	<1355330026.3527.44.camel@localhost>
	<50C8B919.2060102@schaufler-ca.com>
	<201212132106.AFI82338.QMFHFLSJOtOOFV@I-love.SAKURA.ne.jp>
Date: Thu, 13 Dec 2012 11:12:42 -0500
Message-ID: <CACLa4psaVNf8-WvSX9F6oj3zyyJJpvK80RvQVGAmjH7SiQUAqA@mail.gmail.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@parisplace.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Dec 13, 2012 at 7:06 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Casey Schaufler wrote:

>>       /proc/.../attr/current
>>       /proc/.../attr/selinux.current
>>       /proc/.../attr/apparmor.current
>>       /proc/.../attr/keycreate
>>       /proc/.../attr/selinux.keycreate
>>

> Can we use prctl() interface instead of /proc/$pid/attr/$lsmname.$type ?
> I simply don't want to see flood of entries when "find /proc/" runs. ;-)
>
> prctl() can tell the caller whether specified LSM is enabled/presented or not
> via its return value.

I don't much care for or understand Casey's reason for using selinux.*
instead of selinux/* but at least it means we can interact with these
interfaces in a shell.  prctl() means you can't use tools like cat or
echo.  Everything has to be a utility.  That just does not seem as
nice for admins.

In my opinion you want to do things pragmatically, use a library, and
if you want to do things as a human, use the tools that already exist.

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
