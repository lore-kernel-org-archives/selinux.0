Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02050
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2002 14:47:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA02724
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2002 19:46:33 GMT
Received: from sendmail (savages.net [208.170.193.18] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id TAA02719
	for <selinux@tycho.nsa.gov>; Thu, 10 Jan 2002 19:46:32 GMT
Message-ID: <3C3DEE61.6020809@pcez.com>
Date: Thu, 10 Jan 2002 11:41:21 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: audit policy tag?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is the a policy tag that would allow a audit trail?   I see a audit on 
failure, but I would like to see audit trail on success also.  I would 
assume success audit would require a tag
audit zot_t zot_t:file read
when executating in zot_t domain a read of a zot_t file would write 
something to the log.

Also is there a way to redirect the log to something other than syslog?

Shaun  


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
