Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83KgcrT010695
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 16:42:39 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83KgbUQ001710
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 20:42:38 GMT
Date: Fri, 3 Sep 2004 21:53:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] file contexts "alternate" keyword
Message-ID: <20040903205348.GA4084@lkcl.net>
References: <20040903165723.GA31857@lkcl.net> <1094240841.29689.6.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094240841.29689.6.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 03, 2004 at 09:47:21PM +0200, Erich Schubert wrote:
> Hi,
> 
> > # this line ONLY gets activated if the mozilla helper program specifies
> > # the keyword to use it.
> > HOME_DIR/downloads/.+      ROLE_home_t mozillahelperdownloadpasswordwasvalid
> 
> How do you find out later on if this was the case (for example on
> relabel?)
 
 mmmm.... good point!

 scratch that idea then.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
