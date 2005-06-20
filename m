Message-ID: <20050620204106.99967.qmail@web31603.mail.mud.yahoo.com>
Date: Mon, 20 Jun 2005 13:41:06 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: dumb newbie questions
To: SELinux@tycho.nsa.gov
In-Reply-To: <20050620192124.GG8451@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Luke Kenneth Casson Leighton <lkcl@lkcl.net>
wrote:


>  i _would_ agree with you... if it wasn't for this:
> 
>  * that security in unix is glaringly deficient;

Careful there, son. You're talking to someone
who's spent the past 15 years in the forefront
of the effort to address this issue. It has been
10 years since this statement was true.

>  * that application developers are notoriously
> ignorant of security issues;

This is true. More to the point, developers
of applications that manipulate or enforce
policy, or that should and don't often are
ignorant of the facilities available to them.

>  * that languages like c and c++ and processors like
> the x86 _invite_ security issues.

Careful there, it's a poor workman who
blames his tools. Further, in today's
world it's not the underlying system that
is typically at fault, it's the lack of
security design at the higher levels.

>  and that this is true _irrespective_ of whether
> selinux exists or not.

I've agreed some, and disagreed some, but
in either case, the presence of SELinux makes
very little difference.

>  yes?

Let's go with 65% yes

>  i think this can be said (i invite people to
> disagree).
> 
>  based on the above three statements (*) being true,
> it can be concluded
>  that when you introduce selinux, the expectation
> for ordinary
>  applications developers to "get it right" simply
> becomes an absolute
>  nonsense.

One of two things has to be true. Either:
1. Developers need to be able to get it right
  - or -
2. SELinux policy developers have to understand
   the applications the are writing policy for
   to the same level as the application developers.

>  the mere _introduction_ of security-aware selinux
> developers and the
>  use of a formally structured policy makes it
> possible to draw
>  application developers' attention to security
> deficiencies in their
>  programs, and they can then be invited to fix them.

Should the application development community
accept SELinix policy as the standard of
good taste you will have an argument of merit.
As you point out, understanding is the key.
If developers understand SELinux policy well
enough to accept the judgements proclaimed
by the application of said policy I would
suggest that they are perfectly qualified to
write it themselves.

>  a [possibly too] simple example is that of the
> debian
>  initscripts, one of which attempted to do a touch
> on /etc
>  in order to detect whether /etc/mtab could
> potentially be
>  written to [instead of doing touch on /etc/mtab
> itself!]

This is an example of a programming flaw.
Most security problems we see today are
programming flaws.

 
>  because selinux "strict" policy quite rightly bans
> all but
>  appropriate programs to have write permission to
> /etc (and
>  this particular initscript most certainly ain't one
> of those
>  programs!), the entire behaviour of the debian
> initscripts
>  (in this case, mounting and managing the initial
> filesystem
>  partitions!) went off down a different path,
> causing some
>  quite serious recovery problems.
> 
>  the solution was NOT to "fix selinux" but instead
> the solution
>  was to fix the initscript.

Which was true, SELinux or no.

>  ... but would that have been detected if it wasn't
> for the strictness
>  of selinux being Mandatory Access Control, such
> that an avc message
>  comes up?

Well, this is the open source world. Many eyes.
 
>  of course it wouldn't have been.

Horsefeathers.


>  there are plenty other (better) examples.

Of course there are. And there are a whole
bunch SELinux isn't going to find, too. And
once SELinux is used to find all the problems,
and they get fixed, we can turn SELinux off
because it's unnecessary. Right?



Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
