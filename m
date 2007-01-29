Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TJ7j3r026233
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 14:07:45 -0500
Received: from web36606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0TJ8kF5002620
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 19:08:47 GMT
Date: Mon, 29 Jan 2007 11:08:39 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH] sysctl selinux: Don't look at table->de
To: Stephen Smalley <sds@tycho.nsa.gov>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1170096231.8720.102.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <493253.19989.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> True, but a system that disables proc is likely a
> system with a custom
> policy anyway, and dependency on proc is fairly
> basic to selinux these
> days (due to reliance on /proc/self/attr for process
> attribute
> manipulation in place of the old selinux syscalls). 
> Possibly we should
> just make selinux depend on proc and drop the #ifdef
> there.

Alternativly you could move the SELinux specific
bits out of /proc/self/attr into an equivalent
/selinux/self/attr and avoid that /proc dependency.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
