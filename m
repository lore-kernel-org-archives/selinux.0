Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o8F8olfY032012
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2010 04:50:47 -0400
Received: from new1.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o8F8okLv025944
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2010 08:50:46 GMT
From: Roberto Sassu <roberto.sassu@polito.it>
To: selinux@lists.fedoraproject.org, selinux@tycho.nsa.gov
Subject: Fedora UBAC feature
Date: Wed, 15 Sep 2010 10:50:44 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009151050.45071.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all

i want to use UBAC feature in order to isolate an user from each other. 
I created two users user1_u and user2_u mapped respectively to user1 and user2, and 
i assigned them the role user_r.
Then i created two directories 'a' and 'b' labeled respectively user1_u:object_r:user_home_t:s0 
and user2_u:object_r:user_home_t:s0. What i'm expecting is that user1 can access 'a' and not 'b', 
viceversa for user2, but user1 is allowed to access both directories.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
