Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA22942
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2001 02:32:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA04841
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2001 06:30:35 GMT
Received: from mail.windowpane.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by jazzswing.ncsc.mil  with ESMTP id GAA04837
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2001 06:30:34 GMT
Received: from ip57.gte1.rb1.bel.nwlink.com (ip57.gte1.rb1.bel.nwlink.com [209.20.131.57])
	by mail.windowpane.com (Postfix) with ESMTP id 4D06A8044
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2001 22:49:32 -0700 (PDT)
Date: Thu, 20 Sep 2001 22:49:31 -0700 (PDT)
From: Conan Callen <ccallen@windowpane.com>
To: <selinux@tycho.nsa.gov>
Subject: selinux & gnome
Message-ID: <Pine.LNX.4.33.0109202235000.15881-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I finally finished building my selinux gui dev machine. It appears to be
working fine. I have been working up to tackling the file_contexts
file, it was a bit overwhelming at first (along with a crash course on
tripwire, iptables, etc).

The only problem so far has nothing to do with selinux itself but Im
hoping someone on this list can give me a pointer. Im not sure which
network device to select during the menuconfig (xconfig) step. I have a Linksys
Ether PCI Lan Card II. If anyone knows the required selection it would be
very helpful.

Just in case anyone on this list did not see it already, there is an
article on selinux in Sept 2001 issue of Linux Magizine. Theres also a
good article on iptables for anyone caught in that learning curve.

Conan Callen
Windowpane


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
