Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBEF8LLS006350
	for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2012 10:08:21 -0500
Received: by mail-ee0-f53.google.com with SMTP id c50so2428783eek.12
        for <selinux@tycho.nsa.gov>; Fri, 14 Dec 2012 07:07:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201212142326.DDG90674.SFHFMOOVLFJtQO@I-love.SAKURA.ne.jp>
References: <50C8AFD1.1070905@schaufler-ca.com>
	<1355330026.3527.44.camel@localhost>
	<50C8B919.2060102@schaufler-ca.com>
	<201212132106.AFI82338.QMFHFLSJOtOOFV@I-love.SAKURA.ne.jp>
	<CACLa4psaVNf8-WvSX9F6oj3zyyJJpvK80RvQVGAmjH7SiQUAqA@mail.gmail.com>
	<201212142326.DDG90674.SFHFMOOVLFJtQO@I-love.SAKURA.ne.jp>
Date: Fri, 14 Dec 2012 10:07:30 -0500
Message-ID: <CACLa4ps9Fh0PxAscHbsnOXngRqSSSuZdvnETfcdz8We=UbXHBw@mail.gmail.com>
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

On Fri, Dec 14, 2012 at 9:26 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:

> Are you worrying about breakage that taskattr runs as a child process until
> taskattr utility is implemented as a shell's built-in function like echo ?
> Then, we can have migration period.
>
> I don't see much difference because scripts programmers have to convert their
> scripts anyway...

Please no. We already have that utility, it's called 'cat' and 'echo'
and everyone already knows them and has them installed.  If you want
to interact with a C program, it's super easy to write a library
function that deals with a file interface.  Maybe it's a poor
argument, but a file interface is the unix way to do things.  Its just
what people expect.  Forcing some new utility on them only makes it
harder.

You might be able to implement a prctl interface for your LSM, if you
really think there is some value, but I doubt it.  I'd expect others
to want you to either use netlink or ioctl rather than prctl.

In any case, I support /proc/pid/attr/[LSM]/[LSM_FILES]

> Kees Cook wrote:
>> Like Eric, I prefer directories. It complicates things slightly
>> because then LSMs can't be named "current", etc...
>
> LSMs can't be named ".", "..", "/" etc...

I think these restrictions sound most reasonable.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
