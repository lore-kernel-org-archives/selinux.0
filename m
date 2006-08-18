Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7IAbt1I005954
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 06:37:55 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7IAbern028737
	for <selinux@tycho.nsa.gov>; Fri, 18 Aug 2006 10:37:40 GMT
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Russell Coker <russell@coker.com.au>
Subject: install vs. matchpathcon(8) [Re: justifying --context=CTX (-Z) ...
In-Reply-To: <44DE134A.3030104@redhat.com> (Daniel J. Walsh's message of "Sat,
	12 Aug 2006 13:43:38 -0400")
References: <87mzabgyrk.fsf@rho.meyering.net>
	<1155308294.8018.59.camel@localhost.localdomain>
	<87irkzfcgr.fsf@rho.meyering.net> <44DE134A.3030104@redhat.com>
From: Jim Meyering <meyering@redhat.com>
Date: Fri, 18 Aug 2006 12:37:52 +0200
Message-ID: <87d5ay72in.fsf_-_@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh <dwalsh@redhat.com> wrote:
> Jim Meyering wrote:
>>>> BTW, what makes install so special that it needs to call matchpathcon?
>>>> Can it accomplish the same goal via "chcon ...;
>>>> install --preserve-context ..."?
...
>> Thanks for explaining.
>> If install really needs -Z, I'd prefer to drop its internal
>> use of matchpathcon.
>>
> -Z implies that the builder of the application knows the security
> context for all possible environemnts.  Matchpatchcon asks the system
> how a file in a certain path should be labeled.  They are very different
> things.
>
> Two different machines running the same install could/should have
> different end file context.  For example a strict policy machine might
> label firefox, mozilla_exec_t, while a targeted might label it bin_t.

[Oh!  I see I never send this reply. ]

I'm inclined to keep upstream GNU install minimalist.  So if there's
a way to accomplish this task without embedding the specialized
matchpathcon-related code, I have to ask "why embed?".  If by adding
only -Z (or providing an fscon program), I don't absolutely need to
include the matchpathcon-calling code in install.c, then I'd rather not.

For example, can't one use the matchpathcon _program_ like this?

  install -Z $(matchpathcon -n $bindir/SOME_EXECUTABLE) SOME_EXECUTABLE $bindir

This seems better, since it'd work any version of install:

  fscon -Z $(matchpathcon -n $bindir/SOME_EXECUTABLE) \
    install SOME_EXECUTABLE $bindir

Obviously, that's more verbose than we'd prefer, but an
selinux-specific wrapper script could do the job transparently.
Then, the only change would be to build via "make INSTALL=install-con".

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
