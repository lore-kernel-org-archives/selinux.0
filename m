Date: Wed, 15 Aug 2001 16:02:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Eric Peters <eric@peters.org>
cc: SELinux@tycho.nsa.gov
Subject: Re: RBAC/Types Hierarchy
In-Reply-To: <002a01c125c1$ed4ee110$020144c0@windows>
Message-ID: <Pine.SOL.3.95.1010815155923.14211C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> When installing SELinux, the install process requires an effective reboot
> after changing the file_contexts so that the new contexts can be enforced on
> the system.

Sorry, I don't understand this statement.  After updating file_contexts,
you do a 'make relabel'.  You only need to restart processes that
were already started in a different domain based on the old labels.
The reboot during the install is just for the initial setup. 
And after updating the policy config, you can do a 'make load'.
Of course, if your system is in enforcing mode, then these
actions can only be done from the sysadm_r role.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
