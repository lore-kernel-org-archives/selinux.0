Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7NL4NB1028029
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 17:04:23 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7NL4MiZ020740
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2007 21:04:22 GMT
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <78E57BD4-C55B-4107-9272-A8CE9DF9F861@nall.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: SE Linux <selinux@tycho.nsa.gov>
From: Joe Nall <joe@nall.com>
Subject: setsockcreate 
Date: Thu, 23 Aug 2007 16:04:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Should setsockcreate appear in the mls process write constraints in  
policy/mls?

joe

mlsconstrain process { sigkill sigstop signal setsched setpgid setcap  
setexec setfscreate setcurrent ptrace share }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
