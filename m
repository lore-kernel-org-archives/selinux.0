Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7B4GMHa012723
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2003 00:16:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7B4F4OD015238
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2003 04:15:04 GMT
Received: from hotmail.com (bay8-f125.bay8.hotmail.com [64.4.27.125])
	by jazzswing.ncsc.mil  with ESMTP id h7B4F3KO015235
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2003 04:15:03 GMT
From: "Timmy Jones" <zapperlink@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: SELinux network issue.
Date: Sun, 10 Aug 2003 21:16:19 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F125Ql2D4TlFaB0004b0a9@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greetings,

I am currently working with selinux 2.4 and running it side by side with 
RH9. I had ran into a issue after several attempts to fix the problem have 
come to a conclusion that it would be best to see if any of you have faced 
this issue. I did a somewhat generic SELinux install and was able to boot 
safely into RH9. I however had problems accessing the internet thru it. My 
network card is a Broadcom 4400 which works fine with linux. I was able to 
contact my router via web access and to that extent it was ok. However when 
testing internet against a website eg: www.google.com I had failed to access 
the site along with many other popular sites. I investigated this further by 
monitoring the traffic. I noticed It did a DNS request for www.google.com 
and sent me back the ip address..  however after the ip sent out..... 
silence.  I thought well.. something might be blocking this right. I killed 
iptables and ipchains... knowing already they should be set null to begin 
with. Also I had thought that it sounds like a router issue however, in 
windows XP all works fine. Im not sure if there is something in SE that is 
disabling this or what but if anyone has any suggestions or solutions it 
would be appreciated. Thanks in advance.

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
