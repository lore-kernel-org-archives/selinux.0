Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4BDYQ3G023068
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 09:34:26 -0400
Received: from mail-1.ar.gonicus.de (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4BDYOPB010112
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 13:34:24 GMT
Received: from localhost.localdomain (localhost [127.0.0.2])
	by mail-1.ar.gonicus.de (Postfix) with ESMTP id 70E7EC0E0F46
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 15:34:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.2])
	by mail-1.ar.gonicus.de (Postfix) with ESMTP id 4F2AAC074E2F
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 15:34:22 +0200 (CEST)
Received: from localhost ([127.0.0.2])
	by localhost (mail-1.ar.gonicus.de [127.0.0.2]) (amavisd-new, port 10024)
	with ESMTP id cQjW404rH5rM for <selinux@tycho.nsa.gov>;
	Mon, 11 May 2009 15:34:17 +0200 (CEST)
Received: from dyn-187.local (p508F01A3.dip0.t-ipconnect.de [80.143.1.163])
	by mail-1.ar.gonicus.de (Postfix) with ESMTP id B9287C074E2F
	for <selinux@tycho.nsa.gov>; Mon, 11 May 2009 15:34:17 +0200 (CEST)
To: selinux@tycho.nsa.gov
Subject: Nodecon configuration question
From: Thomas Bludau <selinux-thomas@gonicus.de>
Date: Mon, 11 May 2009 15:34:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905111534.16145.selinux-thomas@gonicus.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

i've a question for limiting network-access on my selinux installation. The 
system which one i'm using is a debian lenny with the default policys and a 
selfmade creation of java.pp and wine.pp. 

Now i would limit the access for the wine programms to 5 or 6 ip addresses 
from the local network. 

That is what i was trying:
At the first step i changed the inaddr_any_node_t type in the corenetwork.te 
file to one of my needed ip addresses to test if it would work with a minimal 
configuration change.
like this:

type inaddr_any_node_t alias node_inaddr_any_t, node_type;
nodecon 10.10.10.10 255.255.255.255 
gen_context(system_u:object_r:inaddr_any_node_t,s0)

Typed a "make" and copied the base.pp into 
the /etc/selinux/default/modules/active/ directory.

In the selfmade wine.te configuration i typed following:

allow wine_t inaddr_any_node_t:tcp_socket node_bind;

Every time i finished the make i reboot the system with the new base.pp. The 
wine configuration is alway this one i want to have. ("semodule -l | grep 
wine" shows the right version)

But after starting a wine programm f.e. putty.exe it cant get a right 
connection to the test-host. Everytime i get the message from putty: Unable 
to open connection to 10.10.10.10 Network error: Permission denied"

I think something is not right in my configuration or in my train of 
thoughts.. 

I would be very happy if someone can give me a food for thought.

Greetings
Thomas Bludau

-- 
Thomas Bludau <selinux-thomas@GONICUS.de> (Senior Consultant)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
