Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RLc6rT005948
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 17:38:06 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6RLbamJ014923
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 21:37:36 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 27 Jul 2004 21:38:05 -0000
Date: Tue, 27 Jul 2004 22:49:11 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts.
Message-ID: <20040727214911.GA23371@lkcl.net>
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil> <20040727160605.GG3392@lkcl.net> <200407271940.i6RJebSp032388@turing-police.cc.vt.edu> <20040727212836.GA21236@lkcl.net> <200407272123.i6RLNcp9016219@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407272123.i6RLNcp9016219@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jul 27, 2004 at 05:23:38PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 27 Jul 2004 22:28:36 BST, Luke Kenneth Casson Leighton said:
> 
> >  yes, sort-of: more that i only wish to limit what programs a user
> >  can run (and what programs _those_ programs can run).
> > 
> >  in particular, i want to stop people from being able to use the
> >  "Run" capability of Konqueror, etc.  STOP, not have the popup coming
> >  up with "are you sure you want to run this program?".
> 
> Do these users have anything resembling shell access? If they can get an xterm
> or an editor open, they can run the program *anyhow*....
 
 no, xterm will not be on the list of programs they can run :)

 when i say it'll be a list of programs that they can run i MEAN
 if it ain't on the list it ain't gonna run.

 i.e. it's mandatory access control, 

> Probably easier to do the kdeuser group and start chgrp'ing, than to try to fight THAT
> war.
> 
> Or see how hard it would be to create a patch to Konqueror to disable the
> button, and see if you can push it upstream...

 there are more places, there are more programs.

 other programs, such as ksmoothdock, such as Basket, such as kxdocker,
 such as KMenu being edited and people manually putting programs onto
 their menus.

 all of these things i just don't wanna know about _how_ they are run:
 if they ain't on the list, splat.

 make a user a member of kdeusers + chgrp-to-kdeusers + 0660 on all
 exes in the "allowed list" is my "fallback" position.

 i'd just rather it wasn't the only position.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
