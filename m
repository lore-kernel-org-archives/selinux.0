Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB27FXRb012795
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 02:15:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB27FXqY015061
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 07:15:33 GMT
Received: from unicorn.lemuria.org (c152152.adsl.hansenet.de [213.39.152.152])
        by jazzband.ncsc.mil  with ESMTP id hB27FW0o015058 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 07:15:32 GMT
Date: Tue, 2 Dec 2003 08:08:34 +0100
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policy under version control
Message-ID: <20031202080830.E17580@lemuria.org>
References: <20031129132619.GE26960@lukas.schuldei.com> <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil> <20031201202813.I16359@lemuria.org> <200312021430.51186.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312021430.51186.russell@coker.com.au>; from russell@coker.com.au on Tue, Dec 02, 2003 at 02:30:51PM +1100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 02:30:51PM +1100, Russell Coker wrote:
> I also see a need for multiple policy distributions, but I don't think that 
> they will be close enough to each other to enable them to productively be in 
> the same tree.
> 
> Some policy files such as core_macros.te can be in all policies, but most of 
> the .te files won't.
> 
> I think that policies will either be close enough that macros can be used to 
> merge them, or different enough that they can't be kept to gether in any way.

That's exactly where a more modern replacement of 20-year-old CVS would
help. From what I read about arch, it would be well possible to define,
say:

This is Tom's Whatever Policy Repository
all macros and these and these file_contexts and domain/program files
are identical to the upstream policy (*)
these 2 files are different (**)
these 4 files replace their counterparts upstream
these 12 files are new


(*) this definition is very much like a network-aware symlink
(**) very much like a diff, with a built-in pointer to the URL of the
original


I think this'll be very much easier than a dozen people either
maintaining a dozen policies, or keeping a dozen diff sets up to date.

Also, it solves the patch nightmare for users. You go to one place and
issue a checkout command, instead of finding the original, the 5
patches you need, and then fiddling around in how to apply them in what
order to get it all working.


Note: I haven't worked with arch yet except for some testing. I'm just
trying to point out that we could make our lives easier. I volunteer
for setting up an arch repository for a testrun, if there's enough
people interested.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
