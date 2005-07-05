Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j65KH6gA026005
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 16:17:06 -0400 (EDT)
Received: from web51502.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j65KF9En003795
	for <selinux@tycho.nsa.gov>; Tue, 5 Jul 2005 20:15:10 GMT
Message-ID: <20050705201454.97294.qmail@web51502.mail.yahoo.com>
Date: Tue, 5 Jul 2005 13:14:54 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [RFC]Kernel Built-in IDS extension (UPDATED)
To: selinux@tycho.nsa.gov
In-Reply-To: <1120587252.2644.192.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>- As before, I'm not convinced that you can't achieve the same effect by
>extending auditd, using auditallow rules to generate notifications of
>events of interest to it, and letting it (or a helper it runs)
>manipulate booleans based on some other config.

There is already work underway to move audit events around for realtime
notification. It will feature a plugin architecture for filtering and responding
to events. An IDS is one of the applications intended for this. I'll put the code
out sometime soon for review. But with the plugin architecture, it will be easier
for people to extend without affecting the audit daemon's integrity.

-Steve Grubb


		
__________________________________ 
Discover Yahoo! 
Have fun online with music videos, cool games, IM and more. Check it out! 
http://discover.yahoo.com/online.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
