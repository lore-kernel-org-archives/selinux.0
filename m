Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88CQErT002905
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 08:26:15 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88CQEfe014619
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 12:26:14 GMT
Subject: Re: PAM in suse9.1 (Re: SuSE 9.1 SELinux)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Takuya Mishina <TMISHINA@jp.ibm.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <OF0DD26E97.7776F6AA-ON49256F08.007DAD0E-49256F09.0007B661@jp.ibm.com>
References: 
	 <OF0DD26E97.7776F6AA-ON49256F08.007DAD0E-49256F09.0007B661@jp.ibm.com>
Content-Type: text/plain
Message-Id: <1094646254.20215.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 08 Sep 2004 08:24:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-09-07 at 21:24, Takuya Mishina wrote:
> I don't know the difference of pam_unix.so and pam_unix2.so, but in my 
> test, it seems no problem using pam_unix.so instead of pam_unix2.so.
> ( cat /etc/pam.d/newrole | sed 's/pam_unix/pam_unix2/' > 
> /etc/pam.d/newrole.new )
> 
> the best may be the combination use of pam_unix2.so and unix_chkpwd, but 
> to be enable SELinux with SuSE 9.1, the easiest way is to setuid 
> /usr/bin/newrole or to patch pam_unix.so and use it.
> 
> 
> I'll report again if something happens on suse (esp. policy).

Did you look at Thomas Bleher's SELinux packages (and policy) for SuSE
9.0?  Available from  http://www.cip.ifi.lmu.de/~bleher/selinux/suse/.

SuSE Linux 9.1 was based on an older snapshot of the SELinux packages
and patches. I don't know if SuSE has released updates or not to bring
them up to date with the latest versions from nsa.gov and a more
up-to-date kernel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
