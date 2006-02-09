Subject: Re: [PATCH] Add version option to newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Selinux@tycho.nsa.gov, Steve G <linux_4ever@yahoo.com>
In-Reply-To: <200602081445.14747.glommer@br.ibm.com>
References: <200602081445.14747.glommer@br.ibm.com>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 15:09:48 -0500
Message-Id: <1139515788.3452.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-02-08 at 14:45 -0200, Glauber de Oliveira Costa wrote:
> Here's a new version that incorporates your suggestions. I moved the constant 
> definition to the makefile, and also, I'm gathering the data from the version 
> file. Also, Steve, I would like to hear from you why do you think the -v 
> option is not that descriptive.
> 
> If you guys accept this patch, my obvious next step would be adding it to the 
> manpage. 

At present, your patch causes newrole to display the version number of
the entire collection (policycoreutils), not an individual version tied
to the newrole program itself.  Thus, I think it should display the
PACKAGE string as well (already defined) as part of the message, e.g.:
	printf("%s:  %s version %s\n", argv[0], PACKAGE, VERSION);
yielding output like:
	newrole:  policycoreutils version 1.29.20

Otherwise, the patch seems sane and suitable for the other utilities as
well.  A few of the utilities appear to have their own version string at
present, but I think you can just drop that as no one is maintaining
that - only the top-level VERSION for the entire collection is
meaningful.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
