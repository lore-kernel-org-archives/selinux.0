Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j53EZTgA000755
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 10:35:29 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j53ET4jH001555
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 14:29:04 GMT
Date: Fri, 3 Jun 2005 15:37:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Labeling confusion with apt-get/dpkg
Message-ID: <20050603143731.GA16399@lkcl.net>
References: <20050603131809.GI8365@lkcl.net> <20050603134210.76808.qmail@web33204.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050603134210.76808.qmail@web33204.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 03, 2005 at 06:42:10AM -0700, Roger Brunell wrote:
> 
> 
> --- Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> 
> > On Fri, Jun 03, 2005 at 05:18:34AM -0700, Roger Brunell wrote:
> > > Chalk this up to inexperience, but I am confused, I think.
> > > I used apt-get to install tcsh on my system. 
> > 
> >  you need to use se_apt-get, a wrapper around apt-get
> >  that places apt-get into the right security domain or somethingorother
> >  i forget what
> >
> 
> Ok; I tried that, so-so results, the full console is far below, but the essence
> is here:
> 
> root@flattop:/# se_apt-get tcsh
> cannot find your entry in the passwd file.
> authentication failed.
> 
> Is the auth procedure RedHat-centric?  I am running Debian based.

can you run strace -o log.txt -ff se_apt-get install tcsh for me,
please, then post the logs ON A WEB SITE DO NOT ATTACH THEM TO THE LIST
and let me know where the url is?

cheers,

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
