Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDIhL9015318
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:18:43 -0500 (EST)
Subject: Re: sshd transition points
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>, g@lkcl.net
In-Reply-To: <20050216000437.GD30341@lkcl.net>
References: <20050215155323.GC23765@lkcl.net>
	 <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215191640.GA26294@lkcl.net>
	 <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil>
	 <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net>
	 <20050215231707.GC29523@lkcl.net>  <20050216000437.GD30341@lkcl.net>
Content-Type: text/plain
Message-Id: <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 08:10:25 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-15 at 19:04, Luke Kenneth Casson Leighton wrote:
> ... isn't this a _lot_ simpler than pissing about creating hard-coded
> security contexts, or fiddling around adding kludges into libselinux
> to be able to create security contexts or read some pseudo-default?

Auto-magically changing the context passed in by the setcon(3) by the
application considered harmful.  If the application wants such
derivations, it calls security_compute_create() first, then calls
setcon() on the result.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
