Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBJ1KfXf020422
	for <selinux@tycho.nsa.gov>; Sun, 18 Dec 2005 20:20:41 -0500 (EST)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBJ1Kc8w025297
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2005 01:20:38 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 83D5345792
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2005 01:20:38 +0000 (GMT)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper.nagafix.co.uk [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16719-15 for <selinux@tycho.nsa.gov>;
 Mon, 19 Dec 2005 01:20:36 +0000 (GMT)
Received: from [192.168.0.2] (host-84-9-44-68.bulldogdsl.com [84.9.44.68])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 6A7BD45790
	for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2005 01:20:36 +0000 (GMT)
Subject: UML SELinux
From: Antoine Martin <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 01:20:21 +0000
Message-Id: <1134955222.10491.87.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi list,

I thought this would be of interest here:
I have published a filesystem image which can be used to boot a UML
kernel with SELinux support (based on the 'Gentoo 2005.1 SELinux'
profile):
http://uml.nagafix.co.uk/Gentoo-2005.1/
The site includes the (quite simple) instructions on building your own
images. Some pre-built kernels are also available.

And some general information and policy files for the containment of UML
instances:
http://uml.nagafix.co.uk/SELinux/

Any kind of feedback and comments would be much appreciated.

Regards
Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
