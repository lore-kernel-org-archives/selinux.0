Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6PClDrT019958
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 08:47:13 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6PCkiVH010334
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 12:46:44 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 25 Jul 2004 12:47:03 -0000
Date: Sun, 25 Jul 2004 13:58:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephan Kulow <coolo@kde.org>
Cc: kde-devel@kde.org, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: what is kdeinit for?
Message-ID: <20040725125806.GQ3437@lkcl.net>
References: <20040725091356.GF3437@lkcl.net> <200407251351.36853.coolo@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407251351.36853.coolo@kde.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

stephan, thank you for responding.

at least it's something to try, even if it's accumulatively going
to make the system walk like a duck.

the prospect of hacking kdeinit to make it "invisible" to SE/Linux
is not something i really want to do "right now".

the issue is that every (any) executable in SE/Linux can be given
a different security context, and each security context can have
associated with it different permissions e.g. "allow konqueror the right
to read all files /usr/lib/kde3/kong_*" where the default starts off
as "allow absolutely nothing at all".

there is also something called a domain_auto_trans which means
"if you are running this program, and you do an execve to run
 another program, then automatically "transition" to this new
 context".

this is to control what applications another application can run.

so, i can add a domain_auto_trans(konqueror_exec_t, kdesu_exex_t, kdesu_t)
which means "if you are running konqueror, and you attempt to kdesu
something, then transition _out_ of the konqueror security context
_into_ the kdesu context".

if you have a program kdeinit that optimises loading by running
everything via libraries, then kdeinit ITSELF must be given the
permissions to do EVERYTHING that the individual programs would be
allowed.

i.e. it's a complete pain in the arse! :)

the solution is to hack some code into kdeinit to "fake" the
transition that occurs when one program executes another.

i.e. whenever kdeinit pseudo-executes a program, you "pretend" that
it has transitioned into that program's security context.

the trouble is that it needs to be special-cased, just in case
someone does this KDE_IS_PRELINKED thing.

so you have to write TWO SE/Linux security policies, one for when
KDE_IS_PRELINKED is used, and one where kdeinit is specially hacked
up.

yuk :)

so i want to _test_ kdeinit not being used, to see what it's like
with my own eyes.

okay.

first impressions are that the virtual memory used by applications
fired up from kdeinit is LESS than that used by the application
on its own.  in some cases by like... 3mbytes.

i DO notice a delay at the end of the startup sequence: it's several
seconds.  it could be because i am looking for one.

i DO NOT notice a significant delay running kmix, let's exit it
from the systray, try it again...

well, other than ksmoothdock doing an irritating thing of running
it "docked" so that i have to click it twice, once to get it to
systray and second time to get it to actually open, i don't notice
a significant performance hit.


so, well... first impressions are that it makes no significant
perceptible difference.

is there anything that i can try that you know of that will
DEFINITELY make a big difference?

and, also, am i measuring the right things, here?

i have to make a decision between 128mb and 256mb of ram on an
AMD 1.7ish processor, and so far, having 3mbyte less per kdeinit'd
application makes the 128mb ram option that much more attractive.

l.




On Sun, Jul 25, 2004 at 01:51:36PM +0200, Stephan Kulow wrote:

> Am Sonntag 25 Juli 2004 11:13 schrieb Luke Kenneth Casson Leighton:
> > hi,
> >
> > i am involved in setting up Debian / SE/Linux and kdeinit is becoming
> > a problem in writing security policies.
> >
> > if russell is correct, and kdeinit is only a hack to avoid loading
> > shared objects, then how may i remove it from KDE?
> >
> > has anyone done _recent_ tests to determine whether overall kdeinit
> > is a benefit or if it decreases performance on modern hardware?
> >
> > comments in the kinit/README file are massively out-of-date, referring
> > to, as russell says, P3 500s.
> >
> Amazing how one can say "less than 1 second" and make it sound as if 
> it's not annoying to wait a second for something to happen (remember it's less 
> than 4000 seconds an hour). While I don't understand the implications it has 
> for SELinux, for most parts of KDE it's just an optimization and it's 
> possible to disable that - e.g. in setting $KDE_IS_PRELINKED before starting 
> KDE. 
> 
> Greetings, Stephan

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
