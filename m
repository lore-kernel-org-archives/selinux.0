Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SEQ5rT010244
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 10:26:05 -0400 (EDT)
Received: from smtp811.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6SEPVMt016573
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 14:25:31 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp811.mail.ukl.yahoo.com with SMTP; 28 Jul 2004 14:25:59 -0000
Date: Wed, 28 Jul 2004 15:37:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: David Caplan <dac@tresys.com>
Cc: Valdis.Kletnieks@vt.edu, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts.
Message-ID: <20040728143700.GA3333@lkcl.net>
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil> <20040727160605.GG3392@lkcl.net> <200407271940.i6RJebSp032388@turing-police.cc.vt.edu> <20040727212836.GA21236@lkcl.net> <41079D11.40600@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41079D11.40600@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 28, 2004 at 08:33:21AM -0400, David Caplan wrote:
> Luke Kenneth Casson Leighton wrote:
> > 
> > yes, sort-of: more that i only wish to limit what programs a user
> > can run (and what programs _those_ programs can run).
> >
> 
> That seems pretty straightforward using transition rules.
> 
> > in particular, i want to stop people from being able to use the
> > "Run" capability of Konqueror, etc.  STOP, not have the popup coming
> > up with "are you sure you want to run this program?".
> >
> 
> You may not have to worry about that if you've defined, via policy, what 
> the user (i.e., the domain they are in when running Konqueror, etc.) is 
> allowed to run.
> 
> >
> > setting up a kdeusers group, chgrp'ing the allowed programs
> > to that group, and setting permissions to 0660 is what i really
> > need...
> >
> 
> 0660 is -rw-rw----, I think you meant 0550, -r-xr-x---, right?
 
 oh, duh, yes.

> > ... but i wondered if there was a way to do that same thing in
> > SE/Linux...
> >
> > ... _without_ writing a whole stack of policies, one per program.
> >
> 
> That's your real issue.  You can accomplish the equivalent (of your 
> chgrp scenario) by defining a domain for all the allowed user programs 
> and causing a domain transition whenever a user (in your limited user 
> domain) executes an allowed program.  Then you only have to write a 
> policy that covers the needs of the set of allowed user applications. 

 yes, and that basically duplicates the entire set of user_t ...
 but for kde_user_t.

 i _really_ don't want to have to rewrite / copy and-then-maintain
 a duplicated set of user_t macros which are identical in _all_ respects
 to user_t except %s/user_t/kde_user_t/g


 that was the whole point of recommending a multiple-context
 thing: _adding_ kde_user_t to be "carried along" by a domain
 transition from user_t to kde_user_t _plus_ user_t through the
 execution of startkde, and then adding a few policy rules to
 allow kde_user_t _plus_ user_t permission to execute a few
 choice executables (those and only those "on the list").


> That gets you the equivalent (actually it's possibly a _little_ better 
> because you limited the permissions to only what the group needs and you 
> removed excess permissions that the user may have had when they enter 
> the new domain).

 

> What you really _need_ is a whole stack of policies so that each program 
> is limited to only what it needs.  

 yes.

> It's up to you to determine if your 
> intended environment requires the effort to do that. 

 not really, not right now! :)

 anyway, it's been made clear that a multiple policy idea is not
 desirable: it's quite a seriously large change to the design of
 selinux.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
