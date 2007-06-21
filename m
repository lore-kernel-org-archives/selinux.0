Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5L7a3Oc009703
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 03:36:03 -0400
Received: from mailgate1.arcor-ip.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5L7a2br021354
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 07:36:02 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate2.cs.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id 0F08A5F6643
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 09:36:01 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id C584D13DC4
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 07:36:00 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 22408-01 for <selinux@tycho.nsa.gov>;
 Thu, 21 Jun 2007 09:35:54 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id 8E8B313DD6
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 09:35:49 +0200 (CEST)
Message-ID: <467A2A30.2070905@brunel.de>
Date: Thu, 21 Jun 2007 09:35:12 +0200
From: Daniel Gil Mayol <daniel.gil-mayol@brunel.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Services running into vserver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello my name is Daniel and I have a question related with the services 
running into a vserver.

I have read that for Red Hat Enterprise Linux (v. 4), due to a SELinux 
bug the dbus can't send audit messages (here is the link: 
http://rhn.redhat.com/errata/RHBA-2006-0049.html ).

I have the services dns and dhcp running in a vserver and the system 
doesn't work as expected but no audit messages are logged (I suppose 
that these both services uses dbus (messagebus) and don't send denied 
messages to audit system). Can I get audit messages without update the 
selinux policy (fix the bug)? Obviously, without place the services out 
of the vserver :)

I'm writing also test scripts for checking that the services running in 
the SELinux system are properly protected. All the services running into 
the vserver has a common security context, it means, there is no 
difference for dns or dhcp services. Should I write an special test 
script only for the vserver, enter into the vserver with "[root@mypc ~]# 
vserver VSERVER_NAME enter" and run the script?

Thanks,

Daniel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
