Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA03023
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 13:48:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA29774
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 18:47:55 GMT
Received: from jsmith.org (pool-141-158-43-243.phil.east.verizon.net [141.158.43.243])
	by jazzswing.ncsc.mil  with ESMTP id SAA29770
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 18:47:54 GMT
Subject: Message
From: Justin Smith <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 04 Dec 2001 13:45:28 -0500
Message-Id: <1007491528.3571.4.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm not sure what I did wrong with the declaration of postgres_t  and
ipchains_t :



I got the messages

security:  context system_u:system_r:postgres_t is invalid
security:  context system_u:system_r:ipchains_t is invalid



-- 
______________________________________________________________________
Time blows wildly against my door       | Justin R. Smith
Stirring discarded sorrows      	| Department of Mathematics and
Like dead leaves of summers past        |     Computer Science
Memories of forgotten lore          	| Drexel University
Making way for new tomorrows         	| Philadelphia, PA 19104
New hopes, new fears,                   |
         and new ways that last         | Office: (215) 895-1847
URL: http://vorpal.mcs.drexel.edu       | Fax:    (215) 895-1582



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
