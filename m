Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBAE6qaU009655
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2012 09:06:52 -0500
Received: by mail-ee0-f53.google.com with SMTP id c50so1632858eek.12
        for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2012 06:06:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201212081318.AFJ18222.FtMFFVQOHSLOOJ@I-love.SAKURA.ne.jp>
References: <CAGXu5j+jLx9y=MfBumy5sy8C=goWdicZ9dngqZVe2mjP=LoU3w@mail.gmail.com>
	<50C1448F.90404@schaufler-ca.com>
	<50C15380.7030304@canonical.com>
	<201212072351.DBH43251.MFFHLOFQtVSJOO@I-love.SAKURA.ne.jp>
	<50C25E74.1050807@canonical.com>
	<201212081318.AFJ18222.FtMFFVQOHSLOOJ@I-love.SAKURA.ne.jp>
Date: Mon, 10 Dec 2012 09:06:19 -0500
Message-ID: <CACLa4pvsgnOzyhOPBSyQZF0+pXQ7wPyXg7yXHhjzpYLua7fzmA@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@parisplace.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Dec 7, 2012 at 11:18 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> John Johansen wrote:

> (1) Start LSM stacking with a limitation that only one LSM module can use
>     /proc/pid/attr/* interface.
>
> (2) Introduce /proc/pid/attributes interface which contains all of the content
>     of /proc/pid/attr/* with the name of each LSM module
>     (i.e. $type $lsmname $value format).
>     The content looks like
>
>       $ cat /proc/pid/attributes
>       current smack current_foo
>       prev smack prev_foo
>       exec smack exec_foo
>       fscreate smack fscreate_foo
>       keycreate smack keycreate_foo
>       sockcreate smack sockcreate_foo
>       current apparmor current_bar
>       prev apparmor prev_bar
>       exec apparmor exec_bar
>       fscreate apparmor fscreate_bar
>       keycreate apparmor keycreate_bar
>       sockcreate apparmor sockcreate_bar
>
>     and the operation for -Z option looks like
>
>       awk ' { if ($1 == "current" ) print $2"="$3; } ' /proc/pid/attributes
>
>     . When writing, the operation looks like
>
>       $ echo 'current smack new_current_foo' > /proc/self/attributes

That sounds great as a toy used as nothing but a developer to play
with, but text file processing kind of sucks to do pragmatically.  How
often do you want to see another process's sockcreate, vs current?
Every time we want to know the current smack label we'd have to
process sockcreate for apparmor and all of the rest of this text file?
 No thank you.  We could make such a text file for admins if there is
a need, but I'd much rather see /proc/pid/attr/[LSM]/* than most of
these proposals.  Have 1 presenting LSM which uses /proc/pid/attr/*
and if people want to stack they gotta move to a new interface...

> (4) Add WARN_ONCE() upon accessing /proc/pid/attr/* in order to tell that
>     /proc/pid/attr/* interface was replaced by /proc/self/attributes interface.
>
> (5) Remove /proc/pid/attr/ and remove the limitation that only one LSM module
>     can use /proc/pid/attr/* interface.

Not sure this is a ever possible.  akpm runs really really really old
userspace and gets mighty pissed at me if I break anything to do with
SELinux.

> (6) Eventually, userspace tools will forget about /proc/pid/attr/* .

[....]

> Keeping old and new interfaces within the same filesystem makes it easier for
> userspace tools to check and fall back.

Tools don't care.  Heck, most tools ALREADY look at /proc/pid/attr/*
and /sys/fs.  Seems like a moot point.

> Centralizing information to /proc/pid/attributes would be more suitable for
> handling a per-pid data than separated interfaces which the -Z option have to
> know the location and protocol for each LSM module's (e.g. selinuxfs, smackfs)
> mount point.

/proc/pid/ is definitely a better place than [lsm]fs.  Things like ps
-Z need to know the context of other pids, not just self.  So we at
least agree that a replacement interface needs to be in /proc.

My opinion is that ps -Z should NOT be responsible in any way for
parsing files.  It should make library calls to get answers about
LSMs.  It might need to make 1 library call per LSM but that library
should understand how to retrieve the information it needs and every
library shouldn't be re-parsing the same text file over and over
again...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
