Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NKuKrT013022
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 16:56:20 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NKuJUk003670
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 20:56:19 GMT
Date: Thu, 23 Sep 2004 22:07:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: start_udev
Message-ID: <20040923210726.GB5940@lkcl.net>
References: <200409240339.57966.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409240339.57966.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

any chance that script could be pushed upstream so that debian can use
it and stop creating those same symlinks from /etc/init.d/udev?

On Fri, Sep 24, 2004 at 03:39:57AM +1000, Russell Coker wrote:
> In Fedora there is a shell script named /sbin/start_udev.  This script is run 
> from rc.sysinit to setup sym-links etc on a tmpfs /dev.  In the most strict 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
