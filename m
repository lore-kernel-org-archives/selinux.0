Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA12246
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 00:11:19 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id EAA29741
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 04:09:51 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
        by jazzband.ncsc.mil  with ESMTP id EAA29737 for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 04:09:50 GMT
Received: from evoworks.evoserve.com (localhost [127.0.0.1])
	by coffeesaur2.evoserve.com (Postfix) with ESMTP id CF93D814D2
	for <selinux@tycho.nsa.gov>; Sat,  6 Jul 2002 12:07:22 +0800 (PHT)
To: selinux@tycho.nsa.gov
Subject: problem with "-" in libraries
Date: Sat, 06 Jul 2002 12:07:22 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
Message-Id: <20020706040722.CF93D814D2@coffeesaur2.evoserve.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Im developing a policy for a cramfs based selinux system. I cant specify the 
contexts for libraries with a "-" in the names like "libpthread-0.9.11.so". 
Checkpolicy does not accept such names int genfs_contexts. I am trying to work 
around this by recompiling everything using modified library names. Can the 
checkpolicy compiler be modified to accept this names? 

Is there a way to make a setfiles like program for genfs_contexts? Im 
considering writing software to that. 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
