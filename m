Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBLCB4Ii020615
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2004 07:11:04 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBLCB7um013173
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2004 12:11:07 GMT
Subject: Re: User Space Auditing
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linux <linux@linuon.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1103598698.3953.25.camel@pc-1.linuon.co.jp>
References: <200412182031.43836.linux@linuon.com>
	 <1103570153.6674.58.camel@moss-spartans.epoch.ncsc.mil>
	 <1103598698.3953.25.camel@pc-1.linuon.co.jp>
Content-Type: text/plain
Message-Id: <1103630743.19693.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 21 Dec 2004 07:05:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-12-20 at 22:11, Linux wrote:
> Thank you for your info. Though the mailing list seems not working
> anymore, the readme file on Peter's page contains useful info. THX!
> I realized that I'm gonna have to work on this audit stuff in kernel.
> Maybe we need some unified logging facility with netfilter or
> let them use audit.
> Is there any discussion between you SELinux guys and netfilter guys
> about this logging/auditing stuff and other overlapped part?

The linux-audit mailing list is working, and has recently re-started
active discussions.  We are engaged with others on the linux-audit list
about enhancements to the kernel audit framework and tools.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
