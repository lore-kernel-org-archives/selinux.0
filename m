Subject: Re: [PATCH] libsepol - cond_expr mapping and package num_sections
	bugs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43DE68BF.5060201@tresys.com>
References: <43DA88D1.5000408@tresys.com>
	 <1138396578.3728.6.camel@moss-spartans.epoch.ncsc.mil>
	 <1138647067.7076.160.camel@moss-spartans.epoch.ncsc.mil>
	 <43DE68BF.5060201@tresys.com>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 15:22:42 -0500
Message-Id: <1138652562.7076.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-01-30 at 14:27 -0500, Joshua Brindle wrote:
> ah! this is very close to a patch I was getting ready to send you, looks 
> good to me, should solve the problem.

Included in libsepol 1.11.10 along with Ivan's changes.
> 
> Btw, also getting ready to send a patch that adds 2 new sections to the 
> package format so we'll see how flexible this really is then.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
