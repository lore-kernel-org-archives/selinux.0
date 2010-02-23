Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1NGEBMk005657
	for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2010 11:14:11 -0500
Received: from cirrus.hsolutions.ch (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1NGERul026526
	for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2010 16:14:28 GMT
Received: from [192.168.32.120] (unknown [78.234.64.238])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by cirrus.hsolutions.ch (Postfix) with ESMTPSA id 01EB27C0003
	for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2010 17:14:40 +0100 (CET)
Message-ID: <4B83FED0.208@hsolutions.ch>
Date: Tue, 23 Feb 2010 17:14:08 +0100
From: Denis BUCHER <dbucherml@hsolutions.ch>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: No such file or directory: '/etc/selinux/targeted/contexts/files/file_contexts.homedirs'
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear all,

I got the following error while I just wanted to change the homedir of a 
user. I hope it's the right place to ask ? (Nothing found on the web)

# usermod -d <path> <user>

/usr/sbin/genhomedircon: [Errno 2] No such file or directory: 
'/etc/selinux/targeted/contexts/files/file_contexts.homedirs'
usermod: warning: unable to relabel the homedir (...)

But homedir was changed anyway...

Just to let you know... (?)

Denis

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
