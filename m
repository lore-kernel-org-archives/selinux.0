Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBKJL4Ii016560
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 14:21:04 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBKJJJkB002309
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 19:19:19 GMT
Subject: Re: User Space Auditing
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linux <linux@linuon.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <200412182031.43836.linux@linuon.com>
References: <200412182031.43836.linux@linuon.com>
Content-Type: text/plain
Message-Id: <1103570153.6674.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 20 Dec 2004 14:15:53 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-12-18 at 06:31, Linux wrote:
> I have a quick question regarding auditing facility in SELinux.
> It might not be really relating to SELinux, could be stupid 
> question though.
> What I want to do is capture SELinux audit logs directly from user space
> daemon, just like netfilter's ulogd. Is there any daemon like ulogd already?
> If not, are there any programs that use the audit facility that 
> I can refer to?
> It seems not right thing to do that porting SELinux to use ulog facility.
> I looked for info about audit but there's almost no useful info available on
> the internet.  I found there's Hert.org who seems to be original developer of 
> linux audit facility but all related info had been removed from their server
> now. Even Faith's, who is author of auditd, audit page on RedHat's site has
> been removed.
> If anyone out there know how to use linux audit facility then 
> please enlighten me. 

There is a mailing list for discussions of the Linux audit framework,
see http://www.redhat.com/mailman/listinfo/linux-audit.  Peter
Martucelli has taken over from Rik Faith, who originally developed the
framework (I don't know anything about any connection with hert.org),
and has the sample auditd code at
http://people.redhat.com/peterm/audit/, but I believe that there is
ongoing work to significantly enhance both the kernel framework and the
userspace tools.  If you aren't running an auditd, then the audit data
is just channeled to klogd in the usual manner.  Please see the
linux-audit mailing list archives.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
