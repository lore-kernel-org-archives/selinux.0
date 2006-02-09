Subject: Re: [PATCH] Add version option to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Selinux@tycho.nsa.gov, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <1139515788.3452.37.camel@moss-spartans.epoch.ncsc.mil>
References: <200602081445.14747.glommer@br.ibm.com>
	 <1139515788.3452.37.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 15:12:54 -0500
Message-Id: <1139515974.3452.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 15:09 -0500, Stephen Smalley wrote:
> At present, your patch causes newrole to display the version number of
> the entire collection (policycoreutils), not an individual version tied
> to the newrole program itself.  Thus, I think it should display the
> PACKAGE string as well (already defined) as part of the message, e.g.:
> 	printf("%s:  %s version %s\n", argv[0], PACKAGE, VERSION);
> yielding output like:
> 	newrole:  policycoreutils version 1.29.20
> 
> Otherwise, the patch seems sane and suitable for the other utilities as
> well.  A few of the utilities appear to have their own version string at
> present, but I think you can just drop that as no one is maintaining
> that - only the top-level VERSION for the entire collection is
> meaningful.

Also, using -v is ambiguous, as it often means to run a program under a
verbose mode (extra output), and several utilities are using -v in that
way, so use -V and/or --version instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
