Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBKLBB7M029485
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2007 16:11:11 -0500
Received: from fg-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBKLB7TF009981
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2007 21:11:08 GMT
Received: by fg-out-1718.google.com with SMTP id 16so12070fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2007 13:11:03 -0800 (PST)
Message-ID: <cadfc0e40712201311x36f4625at123b9e9712b14c56@mail.gmail.com>
Date: Thu, 20 Dec 2007 15:11:03 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: MLS and dbus-daemon related avcs
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dbus-daemon is running at UNCLASSIFIED-SystemHigh. A number of
processes running at UNCLASSIFIED (my seuers default level) are trying
to use dbus and getting mls constraint avcs. I'm not that familar with
dbus but I was thinking of changing its init script to runcon it at
level UNCLASSIFIED or will that just mess up other things?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
