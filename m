Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j567iKgA013784
	for <selinux@tycho.nsa.gov>; Mon, 6 Jun 2005 03:44:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j567b0Xi005707
	for <selinux@tycho.nsa.gov>; Mon, 6 Jun 2005 07:37:02 GMT
Subject: dhcp policy
From: Russell Coker <rcoker@redhat.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
Content-Type: text/plain
Date: Sun, 05 Jun 2005 23:26:22 +1000
Message-Id: <1117977983.3225.92.camel@aeon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ifdef(`dhcpd.te', `define(`use_dhcpd')')
ifdef(`dnsmasq.te', `define(`use_dhcpd')')

The above needs to be added to the net_contexts file before the port 67
labeling.  The current policy does not permit a dhcpd to bind to port
67...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
