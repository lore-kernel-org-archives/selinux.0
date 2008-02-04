MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libsemanage: free policydb before fork
Date: Mon, 4 Feb 2008 10:14:05 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880181EED5@exchange.columbia.tresys.com>
In-Reply-To: <47A5311F.2020703@manicmethod.com>
References: <47A5311F.2020703@manicmethod.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> While testing the recent memory-related patches on a low memory
> machine (512m total) I found that semodule still failed. It turns out
> that fork() requires enough free ram for the amount of private dirty
> memory in the parent process to succeed (even if it is never written
> to in the child process).

I would suggest trying to use vfork() instead of fork() in
semanage_exec_prog().
This should result in less of the parent's memory being copied into the
child.
You would also have to change the exit() following execve() failure to
_exit()
but that should be it.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
