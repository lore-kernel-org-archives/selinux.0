From: Jim Meyering <jim@meyering.net>
To: Ondrej Vasik <ovasik@redhat.com>
Cc: bug-coreutils@gnu.org, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
Cc: Ralf.Wildenhues@gmx.de
Subject: Re: should GNU install call matchpathcon by default?
In-Reply-To: <loom.20080521T084737-481@post.gmane.org> (Ondrej Vasik's message
	of "Wed, 21 May 2008 10:05:15 +0000 (UTC)")
References: <87k5ou9trs.fsf@rho.meyering.net>
	<87fxzh7kww.fsf@rho.meyering.net> <87mytjy51a.fsf@rho.meyering.net>
	<1211294250.7486.134.camel@moss-spartans.epoch.ncsc.mil>
	<87mymlosx7.fsf@rho.meyering.net>
	<7e0fb38c0805201444i3c8eacdi5507888442143c6b@mail.gmail.com>
	<877idoocku.fsf@rho.meyering.net>
	<loom.20080521T084737-481@post.gmane.org>
Date: Wed, 21 May 2008 16:26:41 +0200
Message-ID: <8763t7n36m.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ondrej Vasik <ovasik@redhat.com> wrote:
> Jim Meyering <jim <at> meyering.net> writes:
>> In the multi-file case, the pre-patch performance penalty for enabling
>> the ifdef'd-out code would range from probably-immeasurable (for just
>> 2 or 3 files) to infinite, with enough files to make install exhaust
>> virtual memory.
>
> Actually even for 2-3 files (copied to /usr/temp dir) it was measurable.
> On my machine the performance impact is following:
> Setdefaultcontext code if0'd:                      0.0148 s.
> Current patch(matchpathcon_init_prefix just once): 0.0666 s.
> Old setdefaultcontext code:                        0.1702 s.
>
> For 100 files(copied to /usr/temp) it took 4.0342 s. - that's about 35,5 times
> more than with current patch from Jim and 128 times more than with if0'd
> setdefaultcontext code. And of course for more files it goes to infinity.
>
> Problem is that disabled code is causing bugzilla tickets like
> https://bugzilla.redhat.com/show_bug.cgi?id=319231 , so maybe the best solution

Perhaps you mean some other BZ?  That one doesn't involve performance.
To enable the code in question, just define this symbol for install.c:
ENABLE_WHEN_MATCHPATHCON_IS_MORE_EFFICIENT

> to reduce performance impact would be to patch automake to install multiple
> files in one directory at once or something like that - to reduce performance
> impact of the ifdefed code on installation of big portions of files.

That will help, and part of it is already done in upstream automake:

    2008-03-08  Ralf Wildenhues  <Ralf.Wildenhues@gmx.de>

            Use `install' with multiple files at once for some primaries.
            With nobase targets, at most 50 files are installed at once,
            to avoid quadratic string concatenation and line length limits.
            This isn't yet done with base targets.  One hope is that there,
            the typical file name length is lower.  If this turns out to be
            a problem, it should be revisited.

but that doesn't yet help when installing e.g., coreutils' 100 programs,
since the existing code still loops, installing each individually.
In a way, it has to, because with --program-transform-name, it may
have to rename each one.

However, automake *can* (and probably will, now that I've proposed it)
special-case the very common situation in which there is no
--program-transform-name and $(EXEEXT) is empty.  Maybe someone
will propose a patch to do that.  A 30x performance improvement is
worth a small compromise for the common case.

However, the underlying problem still needs to be dealt with:
the outrageous expense of the matchpathcon function.
Is anyone planning to address that?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
