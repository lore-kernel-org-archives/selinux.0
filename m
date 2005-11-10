Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAAHKFMA002776
	for <selinux@tycho.nsa.gov>; Thu, 10 Nov 2005 12:20:15 -0500 (EST)
Received: from kokytos.rz.ifi.lmu.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAAHDg7H029820
	for <selinux@tycho.nsa.gov>; Thu, 10 Nov 2005 17:13:43 GMT
Date: Thu, 10 Nov 2005 18:13:43 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Goo GGooo <googgooo@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Problems with policy-1.26
Message-ID: <20051110171343.GI15226@europium.cip.ifi.lmu.de>
References: <ef5305790511060406x26fb2221mff3168b980b68f27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <ef5305790511060406x26fb2221mff3168b980b68f27@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Goo GGooo <googgooo@gmail.com> [2005-11-06 13:20]:
> Hi all,

> I have downloaded selinuc 1.26 and am trying to use it with
> linuxkernel 2.6.12.6. Unfortunately I have problems with policy-1.26.
> Whendoing "make install" I'm constantly getting complaints about
> missing/etc/libuser.conf:

Indeed, /etc/libuser.conf is missing from SUSE; I did not notice before
because I don't use genhomedircon. You can fix genhomedircon to work on
SUSE (I think it can get the relevant info from /etc/default/useradd),
or you can just borrow the file from Fedora (see eg
http://wftp.tu-chemnitz.de/pub/linux/fedora-core/development/i386/Fedora/RPMS/libuser-0.54.1-1.i386.rpm )

Good Luck!
Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
