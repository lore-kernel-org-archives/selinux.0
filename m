Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8NNCue2008364
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 19:12:56 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8NNCuNk005978
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 23:12:56 GMT
Received: from localhost (localhost [127.0.0.1])
	by tundra.namei.org (8.13.1/8.13.1) with ESMTP id m8NNCtYk032341
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 19:12:55 -0400
Date: Wed, 24 Sep 2008 09:12:55 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Subject: How to find SELinux policy type?
Message-ID: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a programmatic way to determine the type of SELinux policy 
configured on a system? (e.g. "targeted")

I've looked in the SELinux userspace and SETools repositories but not 
found a library call to do this.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
