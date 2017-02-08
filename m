Message-ID: <1486559831.10548.4.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: fix off-by-one in setprocattr
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andy Lutomirski <luto@amacapital.net>, Paul Moore <paul@paul-moore.com>
Cc: SELinux-NSA <selinux@tycho.nsa.gov>, "security@kernel.org"
 <security@kernel.org>
Date: Wed, 08 Feb 2017 08:17:11 -0500
In-Reply-To: <CALCETrVAAJSOaWaoZCBJVDnBP7QhG8U52HfP6xXeieHNRWQGvw@mail.gmail.com>
References: <1485881644-17740-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhTnCN1EoX-TAwtC6MUbf1K5LUDF1Dz2VemCs90f+idc+w@mail.gmail.com>
 <CALCETrVAAJSOaWaoZCBJVDnBP7QhG8U52HfP6xXeieHNRWQGvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-02-07 at 15:30 -0800, Andy Lutomirski wrote:
> On Tue, Feb 7, 2017 at 2:43 PM, Paul Moore <paul@paul-moore.com>
> wrote:
> > 
> > On Tue, Jan 31, 2017 at 11:54 AM, Stephen Smalley <sds@tycho.nsa.go
> > v> wrote:
> > > 
> > > SELinux tries to support setting/clearing of /proc/pid/attr
> > > attributes
> > > from the shell by ignoring terminating newlines and treating an
> > > attribute value that begins with a NUL or newline as an attempt
> > > to
> > > clear the attribute.  However, the test for clearing attributes
> > > has
> > > always been wrong; it has an off-by-one error, and this could
> > > further
> > > lead to reading past the end of the allocated buffer since commit
> > > bb646cdb12e75d82258c2f2e7746d5952d3e321a ("proc_pid_attr_write():
> > > switch to memdup_user()").  Fix the off-by-one error.
> > > 
> > > Even with this fix, setting and clearing /proc/pid/attr
> > > attributes
> > > from the shell is not straightforward since the interface does
> > > not
> > > support multiple write() calls (so shells that write the value
> > > and
> > > newline separately will set and then immediately clear the
> > > attribute,
> > > requiring use of echo -n to set the attribute), whereas trying to
> > > use
> > > echo -n "" to clear the attribute causes the shell to skip the
> > > write() call altogether since POSIX says that a zero-length write
> > > causes no side effects. Thus, one must use echo -n to set and
> > > echo
> > > without -n to clear, as in the following example:
> > > $ echo -n unconfined_u:object_r:user_home_t:s0 >
> > > /proc/$$/attr/fscreate
> > > $ cat /proc/$$/attr/fscreate
> > > unconfined_u:object_r:user_home_t:s0
> > > $ echo "" > /proc/$$/attr/fscreate
> > > $ cat /proc/$$/attr/fscreate
> > > 
> > > Note the use of /proc/$$ rather than /proc/self, as otherwise
> > > the cat command will read its own attribute value, not that of
> > > the shell.
> > > 
> > > There are no users of this facility to my knowledge; possibly we
> > > should just get rid of it.
> 
> I'm not sure which facility you're referring to here, but setpriv(1)
> uses /proc/self/attr/current and /proc/self/attr/exec.

No, I just meant the weird hacks to support setting and clearing from
the shell, which has never been used to my knowledge.  Setting and
clearing from programs, preferably via the libselinux helper functions,
has always been fine and is in widespread use.
