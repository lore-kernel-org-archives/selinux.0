Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i56AosrT028987
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 06:50:54 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i56AopRQ004432
	for <selinux@tycho.nsa.gov>; Sun, 6 Jun 2004 06:50:51 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 6 Jun 2004 10:50:52 -0000
Date: Sun, 6 Jun 2004 10:48:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [patch]
Message-ID: <20040606104814.GF9675@lkcl.net>
References: <20040605161213.GA5998@lkcl.net> <200406061814.50731.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406061814.50731.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 06, 2004 at 06:14:50PM +1000, Russell Coker wrote:
> On Sun, 6 Jun 2004 02:12, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > patch to exim4 to get it to change its name when it execve's on:
> >
> > - transport (-MC)
> > - smtp in
> > - alias (-bi)
> > - initial daemon startup
> 
> From a quick inspection it appears that you missed some calls to 
> child_exec_exim(), for example the "exim -q" operation when starting exim.
 
 oh, drat :)

 thanks - that's the sort of thing i needed to know.

 ... ah, yes, you're right!  _sometimes_ it does an execv inside
 child_exec_exim and sometimes it doesn't.  *sigh*.



> > i don't know if it's possible to create domain auto transitions
> > on a symlink, but if it _was_ then the policy files could,
> > i imagine, have file_contexts for exim4_mc_exec_t etc just on
> > the symlinks.
> 
> No, domain_auto_trans() rules only apply to the executables and to script 
> files (but generally don't do transitions on scripts).
> 
> For SE Linux we need small executables that will exec exim4 with the same 
> parameters to give the domain transition.

 ack.

 i haven't changed any of the parameters, so you'd still get
 exim-bi -bi ... and exim-MC -MC .... etc.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
