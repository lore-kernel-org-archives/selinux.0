Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ECVerT017756
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 08:31:40 -0400 (EDT)
Received: from ms-smtp-04.rdc-kc.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5ECVb0G001930
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 12:31:37 GMT
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-04.rdc-kc.rr.com (8.12.8p1/8.12.7) with ESMTP id i5ECTW8Z002208
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 07:29:33 -0500 (CDT)
Date: Mon, 14 Jun 2004 07:31:36 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040614123136.GA16222@yggdrasil.localdomain>
References: <20040609144404.GJ5477@philips.com> <20040613232622.GA13617@yggdrasil.localdomain> <20040614033955.GA14338@yggdrasil.localdomain> <200406142138.23039.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406142138.23039.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 14, 2004 at 09:38:23PM +1000, Russell Coker wrote:
> Actually you do need chkpwd.te, the current SE Linux policy will not allow 
> programs to authenticate against /etc/shadow unless you have chkpwd.te 
> installed.
> 
> I have to change selinux-policy-default to not allow you to deselect 
> chkpwd.te.

OK, that makes sense.  I'm still not sure why inetd.te was required,
but I'm not hugely worried about that one.  I'll be happy to provide
additional information if you want it, of course.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
