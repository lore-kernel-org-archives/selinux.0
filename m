Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJVvXZ011040
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:31:58 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TJUcMb022217
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 19:30:38 GMT
Subject: Re: policy for resmgrd
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20040930130757.GD2773@cip.ifi.lmu.de>
References: <20040926204642.GC2529@jmh.mhn.de>
	 <200409292136.42039.russell@coker.com.au>
	 <20040930130757.GD2773@cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1099078242.12321.94.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 15:30:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Thu, 2004-09-30 at 09:07, Thomas Bleher wrote:
> * Russell Coker <russell@coker.com.au> [2004-09-29 14:43]:
> > On Mon, 27 Sep 2004 06:46, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> > wrote:
> > > Resmgrd is a daemon which is used on SuSE Linux to mediate access to
> > > devices. Clients can ask resmgrd to open a specific device, resmgrd
> > > checks if the app has appropriate permission and opens the device on
> > > behalf of the client. Resmgrd should probably be a userspace SELinux
> > > enforcer, but for now the attached policy allows it to work on a SELinux
> > > system.
> > 
> > allow resmgrd_t self:unix_dgram_socket { connect create write };
> > 
> > I suggest that the above be replace by:
> > 
> > allow resmgrd_t self:unix_dgram_socket create_socket_perms;
> > 
> > There's no real reason to restrict it's unix domain socket access to itself.
> 
> Agreed.
> New version of the patch attached.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
