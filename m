Message-ID: <003401c125c5$38944270$020144c0@windows>
From: "Eric Peters" <eric@peters.org>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.SOL.3.95.1010815155923.14211C-100000@clipper.gw.tislabs.com>
Subject: Re: RBAC/Types Hierarchy
Date: Wed, 15 Aug 2001 13:02:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Sorry, I don't understand this statement.  After updating file_contexts,
> you do a 'make relabel'.  You only need to restart processes that
> were already started in a different domain based on the old labels.
> The reboot during the install is just for the initial setup. 
> And after updating the policy config, you can do a 'make load'.
> Of course, if your system is in enforcing mode, then these
> actions can only be done from the sysadm_r role.

perfect, thanks

Eric



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
