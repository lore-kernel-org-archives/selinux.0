Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OLu6rT001147
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 17:56:06 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OLtKMZ008694
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 21:55:21 GMT
Received: from lkcl.net (th-pm02-10.ndirect.co.uk [195.7.225.202])
	by open.hands.com (Postfix) with ESMTP id 133E6BF88
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 22:53:28 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzjPL-0008FR-LJ
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 23:04:47 +0100
Date: Tue, 24 Aug 2004 23:04:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and kde
Message-ID: <20040824220447.GC12140@lkcl.net>
References: <20040823234320.GC12720@lkcl.net> <20040824085633.GD11911@rom.cip.ifi.lmu.de> <20040824144947.GC4698@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040824144947.GC4698@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 03:49:47PM +0100, Luke Kenneth Casson Leighton wrote:
> On Tue, Aug 24, 2004 at 10:56:33AM +0200, Thomas Bleher wrote:
> > * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-08-24 02:42]:
> > > ... does anyone ever actually _use_ strict selinux policy enforcing
> > > and successfully run kde under it??
> > 
> > Yes, I do.
> > All machines here are using KDE without problems. My policy is currently
> > based on Fedora policy 1.15.7-something (haven't come around to updating
> > for a while). I don't do CD burning here, so no comment on that, but
> > everything else should work[0].
> > What problems are you seeing?
>  

 things like this:

 +allow user_t xdm_tmp_t:file { ioctl write };
 +   #EXE=/usr/bin/konqueror  PATH=/tmp/xerr-sez-:0   :  ioctl


 and this:

 +allow user_t user_home_dir_t:file { read unlink };
 +   #EXE=/usr/bin/kaffeine  NAME=.fonts.cache-1   :  read
 +   #EXE=/usr/bin/kaffeine  NAME=.fonts.cache-1   :  unlink


 and these:

 +allow user_t user_t:process { setrlimit };
 +   #EXE=/bin/dash   :  setrlimit
 +
 +allow user_t user_t:capability { setuid };
 +   #EXE=/usr/bin/artswrapper   :  setuid

 
 for sound to work, these must be added.

 for "shutdown and restart" to be added to the menu,
 access to write to /var/run in order to create xdmctl
 and the sockets therein is necessary to be added to xdm_t.


 it's just... so much extra crud i was getting a bit confused.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
