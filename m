Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q438wglV031683
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2012 04:58:42 -0400
Received: by lbbgk8 with SMTP id gk8so1193789lbb.12
        for <selinux@tycho.nsa.gov>; Thu, 03 May 2012 01:58:42 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 3 May 2012 16:58:42 +0800
Message-ID: <CAO-AVB4KaNM=V97rPjgTDr_x5QuXvyAZnoBv8WJWZDG+2a6RpA@mail.gmail.com>
Subject: Can't login the embedded linux with seliux support
From: casinee app <appcasinee@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

hello,
i build a linux system with selinux support for my embedded device. It
now can login as the root user automatically when it is powered on.
Then i copy the fiels( shadow ,group and passwd) in my PC linux system
to the embedded system, and add the login to it. But after i input the
username and pass word, it output like this :

login:root
password:
login:Can’t get SID for root

The output comes from the file  login.c in busybox, how can i sovle
this problem?
Does this problem comes from the error in my policy? or the lib
related to the selinux?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
