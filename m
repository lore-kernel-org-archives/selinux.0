Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB8HDfY1002570
	for <selinux@tycho.nsa.gov>; Sat, 8 Dec 2007 12:13:41 -0500
Received: from wa-out-1112.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB8HDasw025802
	for <selinux@tycho.nsa.gov>; Sat, 8 Dec 2007 17:13:36 GMT
Received: by wa-out-1112.google.com with SMTP id k22so2146772waf
        for <selinux@tycho.nsa.gov>; Sat, 08 Dec 2007 09:13:16 -0800 (PST)
Message-ID: <475ACE83.30609@gmail.com>
Date: Sat, 08 Dec 2007 11:04:03 -0600
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: system_u:system_r:system_chkpwd_t:UNCLASSIFIED, how did I get here?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running F8 with MLS reference policy (in permissive right now) and 
I'm trying to understand how I get into this context. I can understand 
how at some point while authenticating a transition to 
system_u:system_r:system_chkpwd_t would occur by virtue of running 
unix_chkpwd but then why wouldn't a transition to user_u:user_r:<*>_t 
happen? Also I'd like to understand how policy for pam, since it's a 
bunch of shared libraries, works. Are there any good sources of 
information on writing policy for shared libraries?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
