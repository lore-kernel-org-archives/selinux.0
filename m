Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3FRrXZ015276
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 10:27:53 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3FRrJZ026075
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 15:27:53 GMT
Date: Wed, 3 Nov 2004 15:38:21 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chad Hanson <chanson@TrustedCS.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>, selinux@tycho.nsa.gov,
   Frank Mayer <mayerf@tresys.com>
Subject: Re: dynamic context transitions
Message-ID: <20041103153821.GA5061@lkcl.net>
References: <36282A1733C57546BE392885C06185924D9100@chaos.tcs.tcs-sec.com> <1099342548.21386.239.camel@moss-spartans.epoch.ncsc.mil> <20041101225820.GP9643@lkcl.net> <1099403267.31739.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099403267.31739.22.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 02, 2004 at 08:47:48AM -0500, Stephen Smalley wrote:
> On Mon, 2004-11-01 at 17:58, Luke Kenneth Casson Leighton wrote:
> >  e.g. if you _do_ implement exec_mls_up/downgrade() then you
> >  can actually express that simply as a domain_auto_trans()
> >  and an exec()?
> > 
> >  which _actually_ means that you really should abandon MLS altogether
> >  and rewrite your applications to use selinux TE instead?
> > 
> >  ... i'm just following a logical progression here, but i feel i must
> >  have missed something.  clues anyone?
> 
> TE is an access matrix, so it can represent a MLS policy, but the
> resulting representation would be huge for any significant number of MLS
> levels.  

 so, this is again a bit like the "groups" argument - the one
 where the number of bits representing the access matrix could
 go exponential [and impractical]?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
