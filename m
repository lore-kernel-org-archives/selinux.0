Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FGdUL9008682
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:39:30 -0500 (EST)
Subject: Re: Setting loginuid
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
In-Reply-To: <20050215162704.15893.qmail@web50201.mail.yahoo.com>
References: <20050215162704.15893.qmail@web50201.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1108485083.17854.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 15 Feb 2005 11:31:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 11:27, Casey Schaufler wrote:
> Some programs that use PAM, including su, are
> not login sessions and hence must not set the
> loginuid.

That can be handled by not including the pam_audit or pam_loginuid
(whatever it is called) module in the pam configuration for su (i.e.
/etc/pam.d/su).  It doesn't necessarily requiring patching the
individual programs; it just means that you have to insert individual
pam_audit entries in desired program-specific pam configuration files
rather than just putting it in the generic system-auth one.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
