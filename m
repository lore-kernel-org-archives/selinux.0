Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDGIL9015286
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:16:18 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050215225329.GH26294@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
	 <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
	 <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215200355.GB26294@lkcl.net>  <20050215225329.GH26294@lkcl.net>
Content-Type: text/plain
Message-Id: <1108559280.19756.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 08:08:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 17:53, Luke Kenneth Casson Leighton wrote:
> on the setcon(), because i happened to be in sshd_privsep_t, and because
> i happened to be setting the context to user_t, and because it was
> sshd_exec_t doing the setting, i expect an "automatic" transition
> to occur to sshd_privsep_user_t.

That makes no sense.  If you want to compute a derived context to pass
to the setcon() call, you can use security_compute_create() to get one
from policy, e.g. see the corresponding logic in rpm_execcon(3) in
libselinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
