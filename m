Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA26939
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 10:29:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA15127
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 14:27:15 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by jazzswing.ncsc.mil  with ESMTP id OAA15123
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 14:27:14 GMT
Received: from evoworks.evoserve.com (localhost [127.0.0.1])
	by coffeesaur2.evoserve.com (Postfix) with ESMTP id 5CDA381455
	for <selinux@tycho.nsa.gov>; Fri,  3 May 2002 22:28:55 +0800 (PHT)
To: selinux@tycho.nsa.gov
Subject: context for /dev/.devfsd?
Date: Fri, 03 May 2002 22:28:55 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
Message-Id: <20020503142855.5CDA381455@coffeesaur2.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What should the context be for /dev/.devfsd? I used russels
devfsd-conflet file in my system and half of the avc denials are gone.
I am trying to define a proper type .devfsd.

should it be:

type devfsd_control_t, file_type;? 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
