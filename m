Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA10269
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 13:46:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA07543
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 17:44:58 GMT
Received: from mail.windowpane.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by jazzswing.ncsc.mil  with ESMTP id RAA07539
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 17:44:57 GMT
Received: from ip57.gte1.rb1.bel.nwlink.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by mail.windowpane.com (Postfix) with ESMTP id 479B7804E
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 10:04:38 -0700 (PDT)
Date: Tue, 25 Sep 2001 10:04:36 -0700 (PDT)
From: Conan Callen <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: selinux & gnome
In-Reply-To: <Pine.SOL.3.95.1010925085000.18877E-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.LNX.4.33.0109250958540.15881-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


This was a real mystery. There are three versions of the Ether PCI Lan
Card II. Linux had incorrectly detected it as a later verison
during the orginal installation and because I was not plugged into the
network, and didnt check this out.

I have the oldest version which is ne2000 compatible. I selected
ne2000 in xconfig, rebuilt the kernel, it works fine now.

Conan

 >
> On Thu, 20 Sep 2001, Conan Callen wrote:
>
> > The only problem so far has nothing to do with selinux itself but Im
> > hoping someone on this list can give me a pointer. Im not sure which
> > network device to select during the menuconfig (xconfig) step. I have a Linksys
> > Ether PCI Lan Card II. If anyone knows the required selection it would be
> > very helpful.
>
> Sorry, I'm not familiar with this card.  But I'm assuming that the card
> was recognized when you installed RedHat 7.1 originally, so you should
> be able to determine the driver by looking at the 'dmesg' output or
> /var/log/messages after booting the ordinary RedHat 7.1 kernel.
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
