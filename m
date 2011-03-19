Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p2JEeUIs016752
	for <selinux@tycho.nsa.gov>; Sat, 19 Mar 2011 10:40:30 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p2JEeS1l017118
	for <selinux@tycho.nsa.gov>; Sat, 19 Mar 2011 14:40:29 GMT
Subject: Re: SE Linux use - was: Question: and the policy grows...
From: Guido Trentalancia <guido@trentalancia.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201103191052.04191.russell@coker.com.au>
References: <1300369855.30425.14.camel@tesla.lan>
	 <201103190133.46695.russell@coker.com.au>
	 <1300463112.17276.16.camel@tesla.lan>
	 <201103191052.04191.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 19 Mar 2011 15:37:15 +0100
Message-ID: <1300545435.3034.4.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Russell !

On Sat, 19/03/2011 at 10.52 +1100, Russell Coker wrote:
> On Sat, 19 Mar 2011, Guido Trentalancia <guido@trentalancia.com> wrote:
> > I do not agree with you. MAC policy development requires knowledge of
> > the whole underlying OS including very silly details about location of
> > files (and including very silly details such as tiny differences in
> > different distributions).
> 
> Most of the policy is developed by people who don't have a good knowledge of 
> other distributions.  They develop for the distribution they support and let 
> other people support their own distributions.
> 
> Knowing how the entire OS works is necessary for the people who architect the 
> policy, that is pretty much only Tresys and NSA employees at the moment.
> 
> Writing policy to suit an uncommon configuration of an application is usually 
> a matter of just relabeling files and putting the output of audit2allow into a 
> .te file, it's not particularly difficult.
> 
> > Developing SELinux userspace mostly requires
> > knowledge of libc, libselinux and friends (which have extensive
> > documentation as info and man pages as opposed to very short embedded
> > comments for interfaces in the .if files). Developing SELinux kernel is
> > probably something in between the two things when it comes to
> > difficulty, at least in my perception.
> 
> Developing kernel code requires long build times and it's hard to debug (Linus 
> has long been resistant to kernel debuggers).  Bugs in kernel code often crash 
> the system which makes it difficult to diagnose them and may require some 
> effort to get the system working again.
> 
> Developing library code isn't so simple either, a bug in libselinux or 
> libsepol could make init fail which would also be more challenging than the 
> usual debugging session.
> 
> A policy error that makes the system unbootable can be resolved by booting 
> with enforcing=0 and then reading audit messages.
> 
> Also when doing user-space development you have to deal with the different 
> programming styles of all the different applications and lots of shared object 
> issues.  Debugging pam modules is one thing that's really not fun, setuid 
> programs can't be ptraced and the pam interface isn't the easiest thing to 
> work with.
> 
> > Writing C code is easier at least for me. And testing C code is easier
> > at least for me. For example the C compiler gives much more meaningful
> > warnings and messages. And you've got the debugger as well !
> 
> Nowadays most sysadmins aren't C coders.

Meaningful thoughts, perhaps some of them would fit at the bottom of the
FAQ @selinuxproject.org as an intermediate level type of question ? It
gives an idea of the main difficulties that should be faced when
approaching development.

Regards,

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
