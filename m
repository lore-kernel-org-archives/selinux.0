Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA11745
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 02:22:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id GAA04103
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 06:21:04 GMT
Received: from coffeesaur2.evoserve.com (evoworks.evoserve.com [210.16.10.5])
        by jazzband.ncsc.mil  with ESMTP id GAA04099 for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 06:21:03 GMT
Received: from evoworks.evoserve.com (evoworks.evoserve.com [210.16.10.5])
	by coffeesaur2.evoserve.com (Postfix) with ESMTP id 28540816AF
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2002 14:22:16 +0800 (PHT)
Message-ID: <3D098B97.7030903@evoworks.evoserve.com>
Date: Fri, 14 Jun 2002 14:22:15 +0800
From: Debian User <rogelio@evoworks.evoserve.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: uclibc and selinux
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Works very well. Are there legal problems if I merge libsecure into 
uclibc? Its easier incorporating selinux into embedded linux.

How about incremental policy updates? So the policy does not have to 
contain all possible policies needed in a system?
Also whats the best way to isolate users from each other when the passwd 
file contains only "root" and "user" accounts?


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
