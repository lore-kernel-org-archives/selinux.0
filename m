Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9NMNtXZ025224
	for <selinux@tycho.nsa.gov>; Sat, 23 Oct 2004 18:23:55 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9NMNsdS007156
	for <selinux@tycho.nsa.gov>; Sat, 23 Oct 2004 22:23:55 GMT
Date: Sat, 23 Oct 2004 23:34:49 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@verbum.org>
Cc: SELinux@tycho.nsa.gov
Subject: Re: [patch] allow hald to read selinux config
Message-ID: <20041023223449.GJ4986@lkcl.net>
References: <1098558352.8447.33.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098558352.8447.33.camel@x-infinity.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Oct 23, 2004 at 03:05:52PM -0400, Colin Walters wrote:
> This patch is needed because HAL 0.4.0 now determines whether or not
> SELinux is enabled, and if it is applies the removable media context to
> mounted filesystems. 
 
 HOORAY, whoopee!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
