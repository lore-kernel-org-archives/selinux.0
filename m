Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RLHWrT005803
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 17:17:34 -0400 (EDT)
Received: from smtp811.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6RLH1mJ014128
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 21:17:02 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp811.mail.ukl.yahoo.com with SMTP; 27 Jul 2004 21:17:31 -0000
Date: Tue, 27 Jul 2004 22:28:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts.
Message-ID: <20040727212836.GA21236@lkcl.net>
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil> <20040727160605.GG3392@lkcl.net> <200407271940.i6RJebSp032388@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407271940.i6RJebSp032388@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, Jul 27, 2004 at 03:40:37PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 27 Jul 2004 17:06:06 BST, Luke Kenneth Casson Leighton said:
> 
> >  i also seek to limit the programs that a KDE user may run.
> > 
> >  if there is a simple way to do that which does not involve writing
> >  policy files for each and every single KDE program i intend to restrict
> >  users to use, i would be interested to hear it.
> 
> Are there KDE programs that don't require anything but user permissions, but
> that you want to restrict anyhow?
 
 yes, sort-of: more that i only wish to limit what programs a user
 can run (and what programs _those_ programs can run).

 in particular, i want to stop people from being able to use the
 "Run" capability of Konqueror, etc.  STOP, not have the popup coming
 up with "are you sure you want to run this program?".


 setting up a kdeusers group, chgrp'ing the allowed programs
 to that group, and setting permissions to 0660 is what i really
 need...

 ... but i wondered if there was a way to do that same thing in
 SE/Linux...

 ... _without_ writing a whole stack of policies, one per program.

 a macro i could write that would let me do this:
 
 allow_user_kde_access(konqueror_exec_t)
 allow_user_kde_access(k3b_exec_t)

 with all that that implies.

 or, to simply set all the allowed kde executables into
 kde_user_exec_t type, and set this on /usr/bin/konqueror,
 /usr/bin/k3b, /usr/bin/koffice etc.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
