Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KHQvRb020976
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 13:26:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KHOVB2012230
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:24:31 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4KHOUwi012227
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:24:30 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 20 May 2004 17:26:53 -0000
Date: Thu, 20 May 2004 17:24:08 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <rcoker@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040520172408.GA17932@lkcl.net>
References: <20040519074242.GK7348@lkcl.net> <1085057380.521.70.camel@moss-spartans.epoch.ncsc.mil> <20040520145258.GF8810@lkcl.net> <200405210139.49261.rcoker@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405210139.49261.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, May 21, 2004 at 01:39:49AM +1000, Russell Coker wrote:
> On Fri, 21 May 2004 00:52, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> >  i _do_ notice in permissive / audit mode that kdeinit attempts to
> >  do an su:
> 
> Which program was it?  Almost every KDE program runs as kdeinit as an attempt 
> at optimising load performance.
 
 okay, it's kconsole, which execs commands.

 it's actually possible to configure KDE to use something - anything -
 via the "Exec" config option ... uhmmm.. track track track...
 /usr/share/apps/konsole/shell.desktop

 so in theeoorry, it should be possible to specify a wrapper command
 under which the command will be exec'd (in this case "su something")

 e.g. runcon?

 oo.  *wobble*.  don't know what to doo.

 ... clues, anyone?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
