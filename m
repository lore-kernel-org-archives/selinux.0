Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5DDRxXn026606
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 09:28:00 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o5DC1AF6007451
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2010 12:01:10 GMT
Received: from [192.168.2.2] (151.64.20.145) by cp-out9.libero.it (8.5.107)
        id 4C0D11BA0093842C for selinux@tycho.nsa.gov; Sun, 13 Jun 2010 01:36:09 +0200
Subject: Display all processes using ps
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 13 Jun 2010 01:36:04 +0200
Message-Id: <1276385764.2972.5.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everybody !

I am logging as root on a remote MLS machine using ssh so the default
role is staff_r. However, I need to execute ps (to display all system
processes, "ps -ax") over ssh. Unfortunately, ps does not show all
processes that are normally displayed when using the sysadm_r role
because it runs in the staff_r role.

What would be the safest way to allow ps over ssh to show all processes
running on the system ?

Thanks for your help.

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
