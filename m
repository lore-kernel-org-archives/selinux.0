Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i58FY2rT012945
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 11:34:02 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i58FXwIl020946
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 11:33:58 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 8 Jun 2004 15:34:00 -0000
Date: Tue, 8 Jun 2004 15:31:21 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dpkg fails on installing nvidia-glx because /etc/init.d/nvidia-glx start is run
Message-ID: <20040608153120.GP9103@lkcl.net>
References: <20040607231556.GI3305@lkcl.net> <200406080212.i582C1uG013226@turing-police.cc.vt.edu> <20040608083606.GN3305@lkcl.net> <200406081512.i58FCs1D014004@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406081512.i58FCs1D014004@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 08, 2004 at 11:12:54AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 08 Jun 2004 08:36:06 -0000, Luke Kenneth Casson Leighton said:
> 
> >  btw during the install i got "cannot create symbolic link
> >  /usr/X11/lib/ libglx-something to /usr/lib/nvidia-something".
> 
> That's a different problem - you weren't allowed to create a symlink
> in the /usr/X11R6/lib directory for some reason.  Unfortunately,
> it's probably going to be impossible to debug it without seeing the
> exact error message...
 
> >  ... why aren't these files _created_ with the correct permissions?
> 
> There's many potential reasons, most of which boil down to some variant
> of "You weren't allowed to, or the tool didn't know how to".  I'd have to
> double-check what the nvidia installer does, and what the 'make install'
> does, to see what command actually gets invoked to put the *.so into place.
> And then there's the question of what context you were in at the time - under
> SELinux, it's possible to su to UID 0 and *not* be in role sysadm_r (which
> has almost all permissions), or to su to a non-zero UID and still be in sysadm_r.
> 
> 

all thoroughly likely.  i have been having problems running
se_apt-get and se-dpkg (and apt-get and dpkg as well, eep) so
i pick-and-choose: one works, one doesn't, and pick up the
pieces from there.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
