Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1MlbXZ001424
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 17:47:37 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1MlafG012746
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 22:47:37 GMT
Date: Mon, 1 Nov 2004 22:58:20 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
Subject: Re: dynamic context transitions
Message-ID: <20041101225820.GP9643@lkcl.net>
References: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com> <1099342548.21386.239.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099342548.21386.239.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 03:55:48PM -0500, Stephen Smalley wrote:
> On Mon, 2004-11-01 at 13:28, Chad Hanson wrote:
> > Let me try to give some background.
> > 
> > The ability for a process to perform actions at multiple MLS labels exists
> > whether dynamic transitions exist or not. Privilege bracketing does limit
> > the use and permits removal of the ability from the process.
> > 
> > MLS level transitions will need to be controlled via new permissions on the 
> > process class (mls_upgrade and mls_downgrade).  

 mls_upgrade and mls_downgrade are, i presume, functions that
 are similar in effect to seteuid(), yes?

 that being the case, i put it to you to consider mls_upgrade
 and mls_downgrade to be a bad idea, and a security hazard, in the same
 way that seteuid is.

 namely, that [as has likely been described in great detail
 to avoid allowing seteuid to work its way into selinux]
 there is too much information leakage in a single process.

 any process which uses either mls_upgrade or mls_downgrade must contain
 within it [usually by accident] resources that are being passed over to
 the other context after the mls change.

 by exec()'ing a process, that just simply cannot occur: the
 most you pass over is the command-line arguments, environment
 variables and um... according to man exec that's it.  [oh, and
 man execve says it respects setuid and setgid bits on an executable.]



 i put it to you that it would be far better to have exec_mls_upgrade()
 and exec_mls_downgrade() which exec() new programs - in a new
 [multi-level] security context - and to redesign applications around
 these proposed functions.

 ... or is that defeating the entire principle of / need for MLS in some
 way that i can't quite yet fathom?
 
 :) :)

 e.g. if you _do_ implement exec_mls_up/downgrade() then you
 can actually express that simply as a domain_auto_trans()
 and an exec()?

 which _actually_ means that you really should abandon MLS altogether
 and rewrite your applications to use selinux TE instead?

 ... i'm just following a logical progression here, but i feel i must
 have missed something.  clues anyone?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
