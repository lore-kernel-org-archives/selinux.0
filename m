Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6ON13rT018208
	for <selinux@tycho.nsa.gov>; Sat, 24 Jul 2004 19:01:03 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6ON0YUX000839
	for <selinux@tycho.nsa.gov>; Sat, 24 Jul 2004 23:00:34 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 24 Jul 2004 23:00:51 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BoV0V-0000AG-Ii
	for selinux@tycho.nsa.gov; Sat, 24 Jul 2004 22:28:43 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BoVgI-0001FQ-L9
	for selinux@tycho.nsa.gov; Sun, 25 Jul 2004 00:11:54 +0100
Date: Sun, 25 Jul 2004 00:11:54 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [idea] multiple contexts.
Message-ID: <20040724231154.GE3437@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i'd like to propose an extension to the SE/Linux system: it's quite
straightforward and it could possibly be implemented in the macro
system - maybe, maybe not.

the ultimate aim is to help simplify the production of policies.

the idea is simple: to be able to have more than one context, and
to be able to make auditing decisions based on more than one context.

extensions
----------

domain_auto_trans(user_t, kdeinit_exec_t, +kde_user_t);

note the plus sign: this means "whenever a user executes the executable
program kdeinit, then instead of transitioning TO the kde_user_t
context, they get an EXTRA context kde_user_t".

domain_auto_trans(kde_user_t&user_t, skype_exec_t, skype_t);

note the use of _two_ contexts: this means "whenever a user who
is in BOTH the kde_user AND the user context, executes the
skype VoIP application, they transition to the skype_t context".

implications
------------

in other words, this has the effect of limiting users to only
be able to run certain KDE applications.

in a really simple and straightforward manner.

the alternative is that i will have to write a set of policy files
on a per-KDE-application basis.

and i'll have to deal with them walking through kdeinit, which is
a pain.

if there was a means to "attach" a second context which was unaffected
and carried over "through" other execve system calls, it'd be
possible to "pick it up" on the other side of the execve'd use of
"kdeinit".

exim4 would also, i believe, be a doddle, and i do not believe it
would need the hacks to exim4 to make it call different binary
names for different functions.

second contexts could be "attached" to the exim4_exec_t - a
sendmail_something_t context which would "activate" allow rules
based on allow exim4_exec_t&sendmail_something_t, .... instead of
just allow exim4_exec_t .....

implementations
---------------

i thought it might be possible to use pre-processing macro
expansion to do the same job as hacking the selinux source code.

fortunately, my subconscious disabused me of that notion over the
last two days, and threw up the kdeinit and the exim4 examples
as cases which could be solved by multiple-contexts.

... alternatively, yes, actually, thinking about it: the idea
recommended by russell which is to exec to an alternate binary
that then execs to the same binary *IS* a multiple-context
"shim".

in case you missed it, exim4 is a single binary which frequently
execve's to itself with new arguments: e.g. to open up a transport
it does execve("exim4", "-M", ...) and stuff.

russell's idea was to replace exim4 in the above example with
exim4-M, and then to write a SEPARATE policy file for a binary
named exim4-M.

that exim4-M is a one-liner that calls execve to exim4 with its
argv[] arguments is, to exim4, irrelevant: the effect of going
via a different binary IS that exim4 "picks up" an extra context.


... now, i sure as heck don't wanna go through that with kdeinit.

to solve the same issue for kdeinit, i would have to write and
compile STACKS of these little binaries, and would have to do
something like find and double-check the locations where kdeinit
is called (including third party applications), prefix the
name of the program being called with kdeinit, execve to that
binary (/usr/bin/kdeinit-konqueror, /usr/bin/kdeinit-kdesktop,
/usr/bin/kdeinit-ksmserver), which would then execve all its
char *argv[] arguments _back_ to kdeinit, and write an SELinux
policy for every single new little program kdeinit-konqueror
kdeinit-khotkeys kdeinit-kio_file THE WORKS.

there are OVER A HUNDRED programs beginning with k, most of which
are kde ones, and that's not even with the full kde suite installed
(i use fvwm) and precious few of the optional packages.

without this "multiple contexts" idea in place, it's a stacking big
task with no "default" to fall back on - that i can think of.


i feel certain that there are other areas where this "multiple contexts"
idea will have other benefits, to simplify auditing and enhance
selinux.

i know it's a bit like unix groups, only you can't do file permission
checks in POSIX based on being in _more_ than one group, so it's
actually a lot more powerful a concept.

i also feel, intuitively, that it might help with the issues involving
users.  i cannot _begin_ to comprehend what that is about, but i
see a lot of messages six weeks ago indicating that there appears
to be a history of problems as the number of users increases on
an selinux system [at least, that's what it looked like] ...

but i see no solutions.

would "multiple contexts" help at all?

l.



-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
