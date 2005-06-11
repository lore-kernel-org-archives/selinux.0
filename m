Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5B1KggA024429
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 21:20:42 -0400 (EDT)
Received: from web31603.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j5B1D0fM018651
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 01:13:00 GMT
Message-ID: <20050611011302.16457.qmail@web31603.mail.mud.yahoo.com>
Date: Fri, 10 Jun 2005 18:13:01 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Restorecon script 
To: "'SELinux'" <selinux@tycho.nsa.gov>
Cc: selinux-dev@tresys.com
In-Reply-To: <200506110009.j5B09XXa016042@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Valdis.Kletnieks@vt.edu wrote:

> You'd *THINK* that a simple 'export
> TMPDIR=/tmp/$USER' would fix everything,
> but NOOOOO.. ;)

The Unix MLS systems demonstrated that
this simple notion was a bit naive. Some
of the commonly used applications pre-date
environment variables (which came along
quite late in the evolution of Unix) and
have never really been happy with them.
Others intentionally eschew them for any
number of reasons that made sense at the
time.

I know, "in the Linux world, everything
get rewritten". Some habits appear to die
hard.

> (I wonder if Chad Seller's polyinstantation patches
> to build a small tree of
> /tmp mounts per user, combined with fscontext=
> mounts, would do any good...

If the experience of MLS on Unix is any guide
(I know that not everyone is convinced) then
yes, they will help in many cases. Most uses
of /tmp really don't care where files end up.
Alas, some do, and retraining everyone to do
it correctly has yet to take hold, even with
30 years of trying.

X11 puts it's UDS in /tmp to make running as
an unprivileged user easier. You could say that
a polyinstatiated /tmp does exactly the right
thing for X11. Unless you have a setuid
application. Or want to allow multiple users
or contexts to create windows.

On Unix MLS systems MLS X servers (there are
several) usually punt on the UDS issue 
(shared memory transports as well) and accept
only IP socket connections. But then, they use
labeled network protocols (CIPSO and/or TSIX)
to make that work right.

There does not appear to be a magic bullet
for this problem. PolyTmp helps, library
repairs can help, and fixing applications can
help. So long as the /tmp culture remains,
and there's no reason to expect it to die,
it will be a challenge to the humble
(and arrogant) system designer.

Oh, and the YahooMail spell checker wants to
replace "polyinstantiate" with "polyunsaturate".
In Trix we called 'em "moldy" directories, a
whimsical pronunciation of MLD. Must be Friday.



Casey Schaufler
casey@schaufler-ca.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
