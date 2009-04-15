Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3FAn4AS023339
	for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2009 06:49:04 -0400
Received: from rv-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3FAn3pQ015227
	for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2009 10:49:04 GMT
Received: by rv-out-0708.google.com with SMTP id k29so2715970rvb.54
        for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2009 03:49:03 -0700 (PDT)
Message-ID: <49E5BB6A.5090505@gmail.com>
Date: Wed, 15 Apr 2009 14:48:10 +0400
From: Fedor Sakharov <teo.montekki@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: dynamic context transitions from kernel space
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Is it possible to somehow use the setcon() from the kernel space? Or is 
there any other way of changing the current context of the process from 
kernel? I need this for building a module that would monitor the 
execution of app and switch it's rights depending on the current branch 
of code being executed.

Fedor Sakharov

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
