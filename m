Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7U9N7rT003534
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 05:23:07 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7U9MJAE014135
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 09:22:19 GMT
Date: Mon, 30 Aug 2004 10:34:14 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and kde
Message-ID: <20040830093414.GA3712@lkcl.net>
References: <20040823234320.GC12720@lkcl.net> <20040824085633.GD11911@rom.cip.ifi.lmu.de> <20040824144947.GC4698@lkcl.net> <200408300327.02313.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408300327.02313.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 30, 2004 at 03:27:02AM +1000, Russell Coker wrote:
> On Wed, 25 Aug 2004 00:49, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > Yes, I do.
> > > All machines here are using KDE without problems. My policy is currently
> > > based on Fedora policy 1.15.7-something (haven't come around to updating
> > > for a while). I don't do CD burning here, so no comment on that, but
> > > everything else should work[0].
> > > What problems are you seeing?
> >
> >  well, a lot of sysadm_chkpwd_t stuff, i'm seeing audit messages
> >  after logging in on a console as a user that are indicative of
> >  the tty not being returned to the correct context...
> 
> A change to PAM is needed to fix most of that.  New Debian packages have to be 
> compiled with the same code as has been in the Red Hat pam packages for a 
> while.  The problem is a lack of time.
 
 ah, okay: as long as i know.  [e.g., console ttys don't get
 relabelled on exit, such that they are the wrong security context
 for the next login... ]

 okay.

 so which packages are these, so i can give it a shot?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
