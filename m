Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SKuVrT014336
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 16:56:31 -0400 (EDT)
Received: from d10systems.homelinux.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6SKuUXs015292
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 20:56:30 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by d10systems.homelinux.com (Postfix) with ESMTP id 3A4F837141
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 16:55:38 +0000 (UTC)
Date: Wed, 28 Jul 2004 16:55:38 +0000 (UTC)
From: Dhruv Gami <dgami@uncc.edu>
Reply-To: dgami@uncc.edu
To: selinux@tycho.nsa.gov
Subject: Dominance rules
Message-ID: <Pine.LNX.4.58.0407281623110.18839@d10systems.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Everyone,

I had been playing with role dominance, and seem to be unable to get it to 
work. From what I understood, dominance rules basically grant the same 
permissions to the dominating role as were given to the dominating role.

I set up a test system in the following way:

1. created 2 new roles, X_r and Y_r
2. in rbac, i wrote 'dominance { role X_r; role Y_r; }'
3. i also allowed transition by 'allow X_r Y_r;'
4. then i gave a certain permission, like permission to run 'ping' to role 
Y_r by adding these to the policy:
	role Y_r types ping_t;
	allow Y_t Y_t:capability { net_raw setuid };
	allow Y_t Y_t:rawip_socket { create getopt read setopt write };

Now, doing this allows a user 'paul' in Y_r:Y_t context 
to ping around, but it does not allow another user 'max' in X_r to ping. 

Am I doing something wrong here, or missing something, or is dominance not 
working as expected ?

regards,
Gami

-- 
Dhruv Gami
http://d10systems.com/gami


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
