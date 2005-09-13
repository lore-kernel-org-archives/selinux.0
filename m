Subject: Re: error building file_contexts
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: antoine <antoine@nagafix.co.uk>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1126617433.29303.25.camel@moss-spartans.epoch.ncsc.mil>
References: <1126563533.13869.5.camel@localhost>
	 <1126617433.29303.25.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 09:48:09 -0400
Message-Id: <1126619290.18007.22.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 09:17 -0400, Stephen Smalley wrote:
> On Mon, 2005-09-12 at 23:18 +0100, antoine wrote:
> > Hi list,
> > 
> > Anyone knows how to figure out where this error is coming from:
> > # make
> >  * Creating policy.conf
> >  * Policy version: 19
> >  * Kernel version: 19
> >  * Compiling and installing policy.19
> > /usr/bin/checkpolicy:  loading policy configuration
> > from /etc/security/selinux/src/policy.conf
> > security:  3 users, 5 roles, 658 types, 3 bools
> > security:  55 classes, 57721 rules
> > /usr/bin/checkpolicy:  policy configuration loaded
> > /usr/bin/checkpolicy:  writing binary representation (version 19)
> > to /etc/security/selinux/policy.19
> >  * Building file_contexts
> > Traceback (most recent call last):
> >   File "/usr/sbin/genhomedircon", line 468, in ?
> >     oldgenhomedircon(cmds[0], cmds[1])
> >   File "/usr/sbin/genhomedircon", line 187, in oldgenhomedircon
> >     if re.search(regex, potential, 0):
> >   File "/usr/lib/python2.3/sre.py", line 137, in search
> >     return _compile(pattern, flags).search(string)
> >   File "/usr/lib/python2.3/sre.py", line 230, in _compile
> >     raise error, v # invalid expression
> > sre_constants.error: nothing to repeat
> > make: *** [file_contexts/file_contexts] Error 1
> > 
> > (non-enforcing mode makes no difference)
> > * kernel 2.6.13.1
> > * libselinux 1.24
> > * libsepol 1.6
> 
> You didn't mention the particular policycoreutils version (which
> provides /usr/sbin/genhomedircon) or policy version (although I suppose
> that is specific to Gentoo).  It looks like your policy Makefile is
> still invoking genhomedircon using the old syntax (hence the call to
> oldgenhomedircon), which is deprecated, although it should still work.
> >From the error message, I assume that regex is not a legal regex at that
> point.

I've heard one other report of this error.  It was reported to only when
running genhomedircon as a regular user.  I haven't had a chance to look
into this.

As for genhomedircon, yes, Gentoo still uses the old syntax, as we still
use a single file_contexts file, not the separate files used in Fedora,
and also still use /etc/security.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
