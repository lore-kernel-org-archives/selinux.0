Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07855
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 08:53:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA22200
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 12:52:05 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA22195
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 12:52:05 GMT
Date: Tue, 25 Sep 2001 08:52:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Conan Callen <ccallen@windowpane.com>
cc: selinux@tycho.nsa.gov
Subject: Re: selinux & gnome
In-Reply-To: <Pine.LNX.4.33.0109202235000.15881-100000@localhost.localdomain>
Message-ID: <Pine.SOL.3.95.1010925085000.18877E-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 20 Sep 2001, Conan Callen wrote:

> The only problem so far has nothing to do with selinux itself but Im
> hoping someone on this list can give me a pointer. Im not sure which
> network device to select during the menuconfig (xconfig) step. I have a Linksys
> Ether PCI Lan Card II. If anyone knows the required selection it would be
> very helpful.

Sorry, I'm not familiar with this card.  But I'm assuming that the card
was recognized when you installed RedHat 7.1 originally, so you should
be able to determine the driver by looking at the 'dmesg' output or
/var/log/messages after booting the ordinary RedHat 7.1 kernel.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
