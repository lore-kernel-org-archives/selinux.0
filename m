Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v182xqjF021167
 for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2017 21:59:52 -0500
Received: by mail-vk0-f68.google.com with SMTP id t8so11012315vke.0
 for <selinux@tycho.nsa.gov>; Tue, 07 Feb 2017 18:59:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CALCETrVAAJSOaWaoZCBJVDnBP7QhG8U52HfP6xXeieHNRWQGvw@mail.gmail.com>
References: <1485881644-17740-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhTnCN1EoX-TAwtC6MUbf1K5LUDF1Dz2VemCs90f+idc+w@mail.gmail.com>
 <CALCETrVAAJSOaWaoZCBJVDnBP7QhG8U52HfP6xXeieHNRWQGvw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Feb 2017 21:59:32 -0500
Message-ID: <CAHC9VhTaAmbOoVndj-vPACVaGfnWcG0NN_m7uXY0MHJtMAwnSw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix off-by-one in setprocattr
To: Andy Lutomirski <luto@amacapital.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-NSA <selinux@tycho.nsa.gov>,
 "security@kernel.org" <security@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Feb 7, 2017 at 6:30 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Feb 7, 2017 at 2:43 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Tue, Jan 31, 2017 at 11:54 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> SELinux tries to support setting/clearing of /proc/pid/attr attributes
>>> from the shell by ignoring terminating newlines and treating an
>>> attribute value that begins with a NUL or newline as an attempt to
>>> clear the attribute.  However, the test for clearing attributes has
>>> always been wrong; it has an off-by-one error, and this could further
>>> lead to reading past the end of the allocated buffer since commit
>>> bb646cdb12e75d82258c2f2e7746d5952d3e321a ("proc_pid_attr_write():
>>> switch to memdup_user()").  Fix the off-by-one error.
>>>
>>> Even with this fix, setting and clearing /proc/pid/attr attributes
>>> from the shell is not straightforward since the interface does not
>>> support multiple write() calls (so shells that write the value and
>>> newline separately will set and then immediately clear the attribute,
>>> requiring use of echo -n to set the attribute), whereas trying to use
>>> echo -n "" to clear the attribute causes the shell to skip the
>>> write() call altogether since POSIX says that a zero-length write
>>> causes no side effects. Thus, one must use echo -n to set and echo
>>> without -n to clear, as in the following example:
>>> $ echo -n unconfined_u:object_r:user_home_t:s0 > /proc/$$/attr/fscreate
>>> $ cat /proc/$$/attr/fscreate
>>> unconfined_u:object_r:user_home_t:s0
>>> $ echo "" > /proc/$$/attr/fscreate
>>> $ cat /proc/$$/attr/fscreate
>>>
>>> Note the use of /proc/$$ rather than /proc/self, as otherwise
>>> the cat command will read its own attribute value, not that of the shell.
>>>
>>> There are no users of this facility to my knowledge; possibly we
>>> should just get rid of it.
>
> I'm not sure which facility you're referring to here, but setpriv(1)
> uses /proc/self/attr/current and /proc/self/attr/exec.

The bug only is only problematic for /proc/self/attr/fscreate, and my
understanding is that Stephen was only referring to the ability to
clear fscreate.

Regardless, I'm not very keen on removing that capability just yet.

-- 
paul moore
www.paul-moore.com
