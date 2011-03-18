Subject: Re: SE Linux use - was: Question: and the policy grows...
From: Guido Trentalancia <guido@trentalancia.com>
To: russell@coker.com.au
Cc: jwcart2@tycho.nsa.gov, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201103190133.46695.russell@coker.com.au>
References: <1300369855.30425.14.camel@tesla.lan>
	 <201103181024.18303.russell@coker.com.au>
	 <1300454589.2438.1.camel@moss-lions.epoch.ncsc.mil>
	 <201103190133.46695.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Mar 2011 16:45:12 +0100
Message-ID: <1300463112.17276.16.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 19/03/2011 at 01.33 +1100, Russell Coker wrote:
> On Sat, 19 Mar 2011, James Carter <jwcart2@tycho.nsa.gov> wrote:
> > > NSA people:  How many subscribers are there to this list outside .gov?
> > >
> > > 
> > 
> > 887
> > 
> > There are 30 people who have posted 10 or more messages in the last
> > year.
> 
> On Sat, 19 Mar 2011, "Christopher J. PeBenito" <cpebenito@tresys.com> wrote:
> > > Tresys people:  How many subscribers to the refpolicy list are outside
> > > .gov?
> > 
> > 95

You see Russell, I wasn't too wrong on that (apologies again for
misspelling your first name). SELinux should not be considered. My
original message was posted on refpolicy and was only about policy
development ("this list").

> Any theories as to why are there almost 10* more people on the main list?
> 
> It seems to me that policy development is easier to get involved with than all 
> other types of SE Linux development, and it's more required.  One can do a lot 
> of SE Linux work without touching any of the C code, but it's not possible to 
> do much outside the distribution defaults without writing some policy.

I do not agree with you. MAC policy development requires knowledge of
the whole underlying OS including very silly details about location of
files (and including very silly details such as tiny differences in
different distributions). Developing SELinux userspace mostly requires
knowledge of libc, libselinux and friends (which have extensive
documentation as info and man pages as opposed to very short embedded
comments for interfaces in the .if files). Developing SELinux kernel is
probably something in between the two things when it comes to
difficulty, at least in my perception.

Writing C code is easier at least for me. And testing C code is easier
at least for me. For example the C compiler gives much more meaningful
warnings and messages. And you've got the debugger as well !

At the very least policy development is more tedious in my opinion.

But all of this is subject to personal attitudes and other similar
factors.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
