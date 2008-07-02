Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m62KahjQ020357
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2008 16:36:43 -0400
Received: from hs-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m62Kah0V014511
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2008 20:36:43 GMT
Received: by hs-out-0708.google.com with SMTP id k27so168050hsc.2
        for <selinux@tycho.nsa.gov>; Wed, 02 Jul 2008 13:36:42 -0700 (PDT)
Message-ID: <486BE6D8.8040502@gmail.com>
Date: Wed, 02 Jul 2008 15:36:40 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: newrole error relabeling tty
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In rawhide I'm getting the following error from newrole:
Error! Could not set new context for /dev/tty1

The type of the tty in the AVC is user_tty_device_t which gets added to 
user_ttynode and not ttynode which is used by 
term_relabel_all_user_ttys, could this be the problem?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
