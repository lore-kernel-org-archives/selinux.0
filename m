Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GDaZL9015476
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 08:36:35 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GDZIfs007335
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 13:35:19 GMT
Date: Wed, 16 Feb 2005 13:45:21 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050216134521.GM31121@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net> <1108559280.19756.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108559280.19756.52.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 08:08:00AM -0500, Stephen Smalley wrote:
> On Tue, 2005-02-15 at 17:53, Luke Kenneth Casson Leighton wrote:
> > on the setcon(), because i happened to be in sshd_privsep_t, and because
> > i happened to be setting the context to user_t, and because it was
> > sshd_exec_t doing the setting, i expect an "automatic" transition
> > to occur to sshd_privsep_user_t.
> 
> That makes no sense.  If you want to compute a derived context to pass
> to the setcon() call, you can use security_compute_create() to get one
> from policy, 

 okay, my apologies: i wasn't aware of this function.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
