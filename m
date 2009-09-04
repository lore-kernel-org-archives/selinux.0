Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n84D2dxX026615
	for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2009 09:02:39 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n84D3uGl014729
	for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2009 13:03:56 GMT
Message-ID: <4AA10FE8.7040109@redhat.com>
Date: Fri, 04 Sep 2009 09:02:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dennis Wronka <linuxweb@gmx.net>
CC: "Remmolt G. Zwartsenberg" <remmolt@zwartsenberg.eu>, selinux@tycho.nsa.gov
Subject: Re: I cannot change my shell context
References: <CIEOKAFOMGPNJIPMMMAHAEDJCCAA.remmolt@zwartsenberg.eu> <200909032259.29605.linuxweb@gmx.net>
In-Reply-To: <200909032259.29605.linuxweb@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

First off sysadm_r:sysadm_t is only used by people trying to run in a strict policy mode.   Most people use targeted and login as unconfined_t.  If your system has you logging in as something other then unconfined_t then you might have a bug in your configuration.

When using SELinux, you usually do not change your "context" manually.  You usually write transition rules.  A transition rules says something like, when unconfined_t domain executes a file labeled firefox_exec_t it will transition to firefox_t.

So the user does not need to do something like runcon -t firefox_t /usr/bin/firefox.

If you are using commands like runcon to change the context of applications, there are rules in policy that govern what labels you can transition to, and what roles you can change too.

If you are running as unconfined_r, and you try to run an app with a role of sysadm_r, this might get denied.

Finally only certain types can be assigned to a process, you are not allow to assign a file type to a process.  So something like 

rucon -t firefox_exec_t /usr/bin/firefox

Would be rejected since firefox_exec_t is a file type not a process type.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
