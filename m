Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7MKUf3E008414
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2008 16:30:41 -0400
Received: from mail.wrs.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7MKUFjf001430
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2008 20:30:16 GMT
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m7MKUevT000901
	for <selinux@tycho.nsa.gov>; Fri, 22 Aug 2008 13:30:40 -0700 (PDT)
Message-ID: <48AF21C3.9020506@windriver.com>
Date: Fri, 22 Aug 2008 16:29:55 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: PAM security transitions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been messing around with various modules and installations and I've 
come across a strange PAM problem. Without any SELinux support in 
pam.d/login, root's shell gets system_r:local_login_t

But then using: pam_selinux.so close/open, root's shell gets 
root:staff_r:system_chkpwd_t

I have another installation with the same pam config, but it gets the 
correct root:sysadm_r:sysadm_t context. This system uses a different policy.

Trying to debug this. Any ideas why one of my boxes gets the wrong 
domain after login?

Vikram

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
