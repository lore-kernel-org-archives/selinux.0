Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7THRDrT000616
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 13:27:13 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7THQMwc029747
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 17:26:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: selinux and kde
Date: Mon, 30 Aug 2004 03:27:02 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823234320.GC12720@lkcl.net> <20040824085633.GD11911@rom.cip.ifi.lmu.de> <20040824144947.GC4698@lkcl.net>
In-Reply-To: <20040824144947.GC4698@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408300327.02313.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Aug 2004 00:49, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > Yes, I do.
> > All machines here are using KDE without problems. My policy is currently
> > based on Fedora policy 1.15.7-something (haven't come around to updating
> > for a while). I don't do CD burning here, so no comment on that, but
> > everything else should work[0].
> > What problems are you seeing?
>
>  well, a lot of sysadm_chkpwd_t stuff, i'm seeing audit messages
>  after logging in on a console as a user that are indicative of
>  the tty not being returned to the correct context...

A change to PAM is needed to fix most of that.  New Debian packages have to be 
compiled with the same code as has been in the Red Hat pam packages for a 
while.  The problem is a lack of time.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
