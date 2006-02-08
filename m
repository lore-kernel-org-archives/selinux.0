Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k18EvEXf009002
	for <selinux@tycho.nsa.gov>; Wed, 8 Feb 2006 09:57:14 -0500 (EST)
Received: from web51512.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k18EvDjH004090
	for <selinux@tycho.nsa.gov>; Wed, 8 Feb 2006 14:57:13 GMT
Message-ID: <20060208145708.49043.qmail@web51512.mail.yahoo.com>
Date: Wed, 8 Feb 2006 06:57:08 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: auditctl examples?
To: David Caplan <dac@tresys.com>, David Slater <ds@hypertechsystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43E9FA00.4070304@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>You said you are interested in using auditctl to do your auditing, but 
>you can also get what you want with selinux policy.

This is true, but I wouldn't recommend that. Its too easy to make a typo and
cause unexpected problems later. In general, people should never need to modify
policy. It makes too many support problems when everyone has tweeked their
policy.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
