Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3BGia3b021852
	for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 12:44:36 -0400
Received: from mail-ew0-f177.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3BGiZPK023941
	for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 16:44:36 GMT
Received: by ewy25 with SMTP id 25so2174883ewy.18
        for <selinux@tycho.nsa.gov>; Sat, 11 Apr 2009 09:44:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F7970D6F-6958-4157-9CD0-2818202619AD@gmail.com>
References: <F7970D6F-6958-4157-9CD0-2818202619AD@gmail.com>
Date: Sat, 11 Apr 2009 18:44:34 +0200
Message-ID: <9e7fde520904110944s212b2e89uc22ddf7e451dc5de@mail.gmail.com>
Subject: Re: strange semanage user|login errors
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think big parts of my selinux installation are broken, i can't do
any management task:

[root@SecLab selinux_fcontext]# semodule -i *pp
libsemanage.validate_handler: MLS range s0 for Unix user user exceeds
allowed range s0:c0.c100 for SELinux user user_u (No such file or
directory).
libsemanage.validate_handler: seuser mapping [user -> (user_u, s0)] is
invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No
such file or directory).
semodule:  Failed

tnx in advance

--
Sebastian Pfaff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
