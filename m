Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OFpVrT027900
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:51:32 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OFpTCV008213
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:51:30 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 6D72DBF28
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 16:51:30 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 10106-04-4 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 16:51:21 +0100 (BST)
Received: from lkcl.net (th-pm01-16.ndirect.co.uk [195.7.225.80])
	by open.hands.com (Postfix) with ESMTP id C4462BF2D
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 16:51:20 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzccN-00035J-Pm
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 15:49:47 +0100
Date: Tue, 24 Aug 2004 15:49:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and kde
Message-ID: <20040824144947.GC4698@lkcl.net>
References: <20040823234320.GC12720@lkcl.net> <20040824085633.GD11911@rom.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040824085633.GD11911@rom.cip.ifi.lmu.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 10:56:33AM +0200, Thomas Bleher wrote:
> * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-08-24 02:42]:
> > ... does anyone ever actually _use_ strict selinux policy enforcing
> > and successfully run kde under it??
> 
> Yes, I do.
> All machines here are using KDE without problems. My policy is currently
> based on Fedora policy 1.15.7-something (haven't come around to updating
> for a while). I don't do CD burning here, so no comment on that, but
> everything else should work[0].
> What problems are you seeing?
 
 well, a lot of sysadm_chkpwd_t stuff, i'm seeing audit messages
 after logging in on a console as a user that are indicative of
 the tty not being returned to the correct context...

 ... but in general, i'm just surprised that i have an 1,800 line
 diff file [last updated from cvs, roughly around 1.14].

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
