Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBKHXmIi015727
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 12:33:48 -0500 (EST)
Received: from hawaii.grays-systems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBKHXoeP021759
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 17:33:50 GMT
Received: (from nick@localhost)
	by hawaii.grays-systems.com (8.13.1/8.13.1/Submit) id iBKHXppu019833
	for selinux@tycho.nsa.gov; Mon, 20 Dec 2004 11:33:51 -0600
Subject: Two machines, two differenct conditions.
From: Nick Gray <nick-lists@austin.rr.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 11:33:51 -0600
Message-Id: <1103564031.25938.81.camel@hawaii.grays-systems.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a laptop which I have been using for testing and a server which I
have been testing loads on. They are both configured pretty much the
same.

On the laptop I can do this

cat /dev/null > /var/log/messages. 

On the server I get permission denied.

The DACs are root:root 600 and the label is user_u:object_r:var_t.

Anyone have any ideas what would cause the inconsistency.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
