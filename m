Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88LqsrT007732
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 17:52:54 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88Lqrfe005960
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 21:52:53 GMT
Date: Wed, 8 Sep 2004 23:04:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Patch to make udev/tmpfs work and changes from colin  walters for dbus.
Message-ID: <20040908220401.GF7717@lkcl.net>
References: <413E1DE0.9050905@redhat.com> <1094645825.20215.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094645825.20215.33.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 08, 2004 at 08:17:05AM -0400, Stephen Smalley wrote:
> On Tue, 2004-09-07 at 16:45, Daniel J Walsh wrote:
> > Adding
> > 
> > restorecon /dev /dev/null
> > restorecon /dev/*
> 
> Adding them where?  If you do this from /sbin/init immediately after the
> initial policy load, 

 oh.
 
 that's a good idea.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
