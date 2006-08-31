Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7VGfBgv007468
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 12:41:11 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7VGeWi2019774
	for <selinux@tycho.nsa.gov>; Thu, 31 Aug 2006 16:40:33 GMT
Date: Thu, 31 Aug 2006 11:40:06 -0500
From: Klaus Weidner <klaus@atsec.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, russell@coker.com.au,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
Subject: Re: type transitioning script race condition?
Message-ID: <20060831164006.GE12307@w-m-p.com>
References: <20060830223937.GB12307@w-m-p.com> <200608310918.03263.russell@coker.com.au> <44F6539E.7090800@gentoo.org> <1157030632.3106.7.camel@localhost.localdomain> <1157032383.24429.90.camel@twoface.columbia.tresys.com> <20060831154635.GC12307@w-m-p.com> <1157040794.24429.116.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157040794.24429.116.camel@twoface.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 31, 2006 at 12:13:14PM -0400, Joshua Brindle wrote:
> The race is insignificant compared to the environment. The scripts
> cannot clean their own environment because the environment affects the
> interpreters potentially before the script is started (like PATH
> variables specific to the interpreter, or preload like PYTHONSTARTUP
> (run before the script is started).

perl has a couple of features to support suid execution, mainly the
"taint" mode which is activated automatically when it detects that it's
running setuid, and which can be specified on the #! line so that it's
activated race-free by the kernel. In that mode, it ignores variables
like PERLLIB automatically.

I'm not sure how Python handles it, and I'm not disagreeing with you in
general, it *is* very important to clean the environment and I think it's
safest to do this in the wrapper program.

> On Thu, 2006-08-31 at 10:46 -0500, Klaus Weidner wrote:
> > - other environment variables may be dangerous, for example program "foo"
> >   launched indirectly from the script may look at a FOORC variable to
> >   find its config file. In general it's safer to completely wipe the
> >   environment and only retain specific variables from a whitelist.
> 
> applications that use their own environment and are trusted within a
> specific domain are a non-issue, we already trust them to act
> appropriately within the confines we've given.

I think it's more dangerous than that - if you use a blacklist approach
to clean the environment, you're likely to miss variables which
indirectly affect things.

For example, say /usr/sbin/trustedapp is a shell script, and your wrapper
takes care to sanitize all environment variables that the shell cares
about (IFS, PATH, ...). But /usr/sbin/trustedapp contains a perl
one-liner, and you haven't sanitized PERLLIB, PERL5OPT, PERLDB_OPT etc,
so the trusted app ends up running user specified code at its current
privilege level due to that. You'd have to do a lot of analysis to find
all the potentially dangerous options, and it's a lot simpler to use a
whitelist.

> > - make sure that resource limits are reasonable. Another hack involved
> >   setting the max file size to a very low value and calling passwd(1),
> >   which then truncated /etc/shadow due to the limit.
> 
> not sure why this helps.

Well, this example is a denial of service, and I can't think of an
example how to use it to gain privileges, so I agree that it's probably
less critical. But it wouldn't surprise me if people find creative ways
to abuse such limits.

> > These things should be done for all suid/privileged programs, not just
> > scripts, because they may be using system(3) or equivalent to call a
> > program via the shell which could then get contaminated by $IFS or other
> > malicious settings.
> 
> privileged programs already handle this if they are binary (atsecure
> cleanses things that can affect the binary that are out of its control)

atsecure doesn't do anything to protect against indirect effects, for
example if the C app uses system(3) without cleaning IFS and PATH first,
so it's not sufficient to rely on the atsecure mechanism alone. You're
right that it's good protection against things out of the binary's
control, but it's important for it to do the security measures that are
under its control.

-Klaus

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
