Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBL3BiIi019227
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 22:11:44 -0500 (EST)
Subject: Re: User Space Auditing
From: Linux <linux@linuon.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <1103570153.6674.58.camel@moss-spartans.epoch.ncsc.mil>
References: <200412182031.43836.linux@linuon.com>
	 <1103570153.6674.58.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 12:11:38 +0900
Message-Id: <1103598698.3953.25.camel@pc-1.linuon.co.jp>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> There is a mailing list for discussions of the Linux audit framework,
> see http://www.redhat.com/mailman/listinfo/linux-audit.  Peter
> Martucelli has taken over from Rik Faith, who originally developed the
> framework (I don't know anything about any connection with hert.org),
> and has the sample auditd code at
> http://people.redhat.com/peterm/audit/, but I believe that there is
> ongoing work to significantly enhance both the kernel framework and the
> userspace tools.  If you aren't running an auditd, then the audit data
> is just channeled to klogd in the usual manner.  Please see the
> linux-audit mailing list archives.

Hi Stephen,

Thank you for your info. Though the mailing list seems not working
anymore, the readme file on Peter's page contains useful info. THX!
I realized that I'm gonna have to work on this audit stuff in kernel.
Maybe we need some unified logging facility with netfilter or
let them use audit.
Is there any discussion between you SELinux guys and netfilter guys
about this logging/auditing stuff and other overlapped part?

Thank you,

-- Junji Kanemaru
Linuon Inc.
Tokyo Japan



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
