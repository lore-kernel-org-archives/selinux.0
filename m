Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RFtHrT003133
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 11:55:17 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6RFtFup007431
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 15:55:16 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 27 Jul 2004 15:55:00 -0000
Date: Tue, 27 Jul 2004 17:06:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts.
Message-ID: <20040727160605.GG3392@lkcl.net>
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 26, 2004 at 12:12:03PM -0400, Stephen Smalley wrote:
> On Sat, 2004-07-24 at 19:11, Luke Kenneth Casson Leighton wrote:
> > i'd like to propose an extension to the SE/Linux system: it's quite
> > straightforward and it could possibly be implemented in the macro
> > system - maybe, maybe not.
> > 
> > the ultimate aim is to help simplify the production of policies.
> > 
> > the idea is simple: to be able to have more than one context, and
> > to be able to make auditing decisions based on more than one context.
> 
> Not a good idea, and not necessary.  You can encode the entire call
> chain in a single security context using the domain transitions, 

 well, not entirely - not dynamically, anyway: at least i do not
 believe so.

 i thought originally that it would be possible to do what i envisaged
 with m4, by extending the policy language.


> and can
> then unwind as desired.  Fortunately, it sounds like the kdeinit problem
> is easily solved anyway.

 i also seek to limit the programs that a KDE user may run.

 if there is a simple way to do that which does not involve writing
 policy files for each and every single KDE program i intend to restrict
 users to use, i would be interested to hear it.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
