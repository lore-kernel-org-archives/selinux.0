Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07346
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 10:03:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA05519
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 14:01:47 GMT
Received: from coffeesaur2.evoserve.com (postfix@evoworks.evoserve.com [210.16.10.5])
        by jazzband.ncsc.mil  with ESMTP id OAA05515 for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 14:01:46 GMT
Received: from evoworks.evoserve.com (localhost [127.0.0.1])
	by coffeesaur2.evoserve.com (Postfix) with ESMTP id 60D71812E4
	for <selinux@tycho.nsa.gov>; Tue, 30 Apr 2002 22:02:49 +0800 (PHT)
To: selinux@tycho.nsa.gov
Subject: cant login after running avc_toggle
Date: Tue, 30 Apr 2002 22:02:49 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
Message-Id: <20020430140249.60D71812E4@coffeesaur2.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

after i run avc_toggle I am logged out. 
a login prompt appears and i try to login. 
after asking for the password the login prompt appears again.
the audit messages show that bash dont have permissions to use vc.
How should this be fixed? im confused. /bin/bash has the type
shell_exec_t. How do I allow bash to use vcs'? I cant see a bash domain
anywhere.  

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
