Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PFc2nh024298
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 11:38:02 -0400
Received: from py-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6PFbxJ2015940
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 15:38:00 GMT
Received: by py-out-1112.google.com with SMTP id n25so2515369pyg
        for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 08:36:20 -0700 (PDT)
Message-ID: <46ffa45f0607250834n4f7eec8dwcee09d808ffb2a6d@mail.gmail.com>
Date: Tue, 25 Jul 2006 10:34:16 -0500
From: "Aleks Kissinger" <aleks0@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Bare bones SELinux Policy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been doing a little bit of SELinux policy hacking, and as a
starting point, I wrote a tiny (600-line) allow-everything policy.  As
I had to jump through some hoops to get this working, I thought maybe
some of you out there could benefit from it.

On Fedora 5 (and probably older), unzip the attchment in
'/etc/selinux', set SELINUXTYPE=simple in '/etc/selinux/config', and
run make load in '/etc/selinux/simple/src'.  Reboot.

If you have any comments, suggestions, or improvements, I'd love to hear them.

Thanks,
Aleks Kissinger
Center for Information Security
University of Tulsa

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
