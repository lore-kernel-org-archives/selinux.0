Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n13GSKZQ011478
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2009 11:28:20 -0500
Received: from qw-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n13GPCjK015764
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2009 16:25:13 GMT
Received: by qw-out-1920.google.com with SMTP id 5so671814qwc.30
        for <selinux@tycho.nsa.gov>; Tue, 03 Feb 2009 08:28:19 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 3 Feb 2009 10:28:19 -0600
Message-ID: <cadfc0e40902030828v41f836eag84d5aaa0fa7bb899@mail.gmail.com>
Subject: odd policy behavior
From: Xavier Toth <txtoth@gmail.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have an app that wasn't working in enforcing but there are no AVCs.
So I did 'semodule -DB' to see if there were any dontaudit denials and
restarted the app. The problem is that the app then ran fine. So I
tried load_policy which had no affect and 'semodule -B' which makes it
work. Any ideas what could be happening? I've verified with 'semodule
--list' that the module is loaded prior to doing the 'semodule -B'.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
