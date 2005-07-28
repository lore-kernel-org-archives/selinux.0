Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6SGCNgA022350
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 12:12:25 -0400 (EDT)
Received: from host.we-code.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6SG6ZI0009999
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 16:06:35 GMT
Received: from localhost (localhost [127.0.0.1])
	by host.we-code.com (Postfix) with ESMTP id DD70313C2C4
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 12:06:45 -0400 (EDT)
Received: from host.we-code.com ([127.0.0.1])
 by localhost (host.we-code.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15527-09 for <selinux@tycho.nsa.gov>;
 Thu, 28 Jul 2005 12:06:45 -0400 (EDT)
Received: from [10.0.1.5] (unknown [69.38.128.66])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by host.we-code.com (Postfix) with ESMTP id 1F26B13C13F
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 12:06:45 -0400 (EDT)
Mime-Version: 1.0 (Apple Message framework v733)
Message-Id: <D3543036-7457-4441-AF34-85B0756322C8@tobyjoe.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: selinux@tycho.nsa.gov
From: Toby Boudreaux <selinux@tobyjoe.com>
Subject: FastCGI and SELinux
Date: Thu, 28 Jul 2005 12:06:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, everyone. This is my first post to the list.

I'm running a CentOS 4 server with SELinux and have been having  
problems getting Apache2 and mod_fastcgi to play nicely when SELinux  
is enabled.

I've run all "avc" messages through audit2allow and have modified my  
local.te file and I've gotten the avc messages to disappear.

Unfortunately, mod_fastcgi is still not working when SELinux is enabled.

I'm getting no messages, but when I turn off enforcing, mod_fastcgi  
works perfectly.

I've purchased the O'Reilly book and have read much of it, but I'm  
still uncertain as to what the problem is and how to investigate/ 
address it.

The core problem seems to be that any FastCGI process doesn't write  
data back to the IPC socket Apache is reading. Instead, it dumps the  
entire response into STDERR.

I gather by the lack of "avc" messages that there are no normal  
domain/user conflicts.

I've searched high and low and can't find mention of a way to get  
this to work, aside from disabling SELinux. I chose this OS in part  
*because* of SELinux, so I don't want to disable it :)

Has anyone experienced something similar, and might you be able to  
point a newbie in the right direction?

Thanks,
toby boudreaux



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
