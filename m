Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA28577
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 18:05:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA10499
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 23:05:15 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id XAA10495
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2001 23:05:15 GMT
Date: Wed, 21 Feb 2001 18:04:53 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dan DeVries <ddevries2000@yahoo.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Err when ./tools/build-apps
In-Reply-To: <20010221222540.39245.qmail@web9307.mail.yahoo.com>
Message-ID: <Pine.SOL.3.95.1010221174451.25354A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


What platform are you using to build SELinux?

It appears that your build problem is occurring in
utils/procps-2.0.4/watch.c.  Line 215 is 'mvaddstr(0, 0, header)' in 
that file.  mvaddstr is defined in /usr/include/ncurses.h, and 
ultimately expands to include the symbol ERR.  However,
/usr/include/ncurses.h also defines ERR to -1 if it is not
already defined.  So I don't know why your build is failing,
unless your ncurses.h happens to differ.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com

On Wed, 21 Feb 2001, Dan DeVries wrote:

> When installing selinux
> I got the following error when building the apps 
> ...
> watch.c In function 'main'
> watch.c: 215 ERR undeclared first use in this function
> watch.c: 215 (Each undeclared identifier...
> make: *** watch.c Error 1
> um..
> Any Suggestions?
> 
> -Dan


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
