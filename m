Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA05359
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2001 18:29:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA23728
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2001 22:28:43 GMT
Received: from mail.gmx.net (pop.gmx.net [194.221.183.20])
	by jazzband.ncsc.mil  with SMTP id WAA23724
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2001 22:28:42 GMT
Message-ID: <3B65DF9B.922246F3@gmx.de>
Date: Tue, 31 Jul 2001 00:28:44 +0200
From: Martin Stricker <shugal@gmx.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: seperate kernel modules
References: <200107301242.f6UCgs620116@mailgate3.cinetic.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

king killer wrote:
> 1 (or 2 days ago) i read a text how to infiltrate a linux system thru
> modules and here comes my idea.
> the kernel modules themselves shall be separated.
> for example a sound driver does not need to be able to access any
> other io-ports then the ones needed to use sound.

You might want to take a look at HURD, a new micro-kernel based unix
kernel from the GNU project. Here only the most basic functions remain
in the kernel, everything else, i. e. file systems or peripheral
hardware, is handled by so-called servers which run in user space, not
in kernel space. A very interesting approach. For a ready-to-install
distribution see http://www.debian.org/hurd/ .

Best regards,
Martin Stricker
-- 
Homepage: http://www.martin-stricker.de/
Registered Linux user #210635: http://counter.li.org/

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
