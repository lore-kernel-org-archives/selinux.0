Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5TIF0MM002284
	for <selinux@tycho.nsa.gov>; Sun, 29 Jun 2008 14:15:00 -0400
Received: from mho-01-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5TIExMr023348
	for <selinux@tycho.nsa.gov>; Sun, 29 Jun 2008 18:14:59 GMT
Received: from adsl-71-155-178-116.dsl.austtx.sbcglobal.net ([71.155.178.116] helo=[192.168.20.230])
	by mho-01-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1KD1QR-00055W-7F
	for selinux@tycho.nsa.gov; Sun, 29 Jun 2008 18:14:59 +0000
Message-Id: <5B8DD16C-FED5-45C9-8032-9760F2C165C9@nall.com>
From: Joe Nall <joe@nall.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: X in enforcing mode
Date: Sun, 29 Jun 2008 13:14:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In order to get firefox, evolution and xterm to run under twm with the  
X object manager in enforcing/mls at a single level I had to add the  
following user policy:

         allow $1_t $1_rootwindow_t:x_drawable { get_property getattr  
read override hide send destroy remove_child };
         allow $1_t $1_xserver_t:x_resource write;

Where $1 is user

xinit was started by hand at init 3.

Not being an X guy, I don't really understand what I just allowed.  
Does this make sense?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
