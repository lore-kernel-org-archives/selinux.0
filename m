Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UJIbrT026006
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 15:18:37 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UJHVng004773
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 19:17:32 GMT
Date: Thu, 30 Sep 2004 20:29:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@verbum.org>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Access to xdm_t
Message-ID: <20040930192935.GA6063@lkcl.net>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de> <1096561927.4957.15.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096561927.4957.15.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 30, 2004 at 12:32:07PM -0400, Colin Walters wrote:
> On Wed, 2004-09-29 at 18:32 +0200, Thomas Bleher wrote:
> 
> > If yes, should xdm_t get the attribute privfd?
> 
> Actually even moving the log to /tmp you'll still get programs wanting
> access to the xdm_t fd.  Ideally we would have a little program run in
> its own domain (xdm_launcher_t say) that would simply close all of its
> file descriptors, open up the tmp file itself for logging and exec the
> user session.  

 /usr/bin/startkde for example?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
