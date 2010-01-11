Subject: RE: [PATCH 13/13] semanage store migration script
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Caleb Case <ccase@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E018D799C@exchange2.columbia.tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
	 <1261610760-4724-2-git-send-email-ccase@tresys.com>
	 <1261610760-4724-3-git-send-email-ccase@tresys.com>
	 <1261610760-4724-4-git-send-email-ccase@tresys.com>
	 <1261610760-4724-5-git-send-email-ccase@tresys.com>
	 <1261610760-4724-6-git-send-email-ccase@tresys.com>
	 <1261610760-4724-7-git-send-email-ccase@tresys.com>
	 <1261610760-4724-8-git-send-email-ccase@tresys.com>
	 <1261610760-4724-9-git-send-email-ccase@tresys.com>
	 <1261610760-4724-10-git-send-email-ccase@tresys.com>
	 <1261610760-4724-11-git-send-email-ccase@tresys.com>
	 <1261610760-4724-12-git-send-email-ccase@tresys.com>
	 <1261610760-4724-13-git-send-email-ccase@tresys.com>
	 <1261610760-4724-14-git-send-email-ccase@tresys.com>
	 <1262964893.13162.27.camel@moss-pluto.epoch.ncsc.mil>
	 <1262984376.2093.14.camel@localhost>
	 <06A6610D4F464D4EBEAFBF2C5F86911E0184DDE5@exchange2.columbia.tresys.com>
	 <1263239639.2075.9.camel@localhost>
	 <06A6610D4F464D4EBEAFBF2C5F86911E018D799C@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Jan 2010 15:45:01 -0500
Message-ID: <1263242701.2075.18.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-01-11 at 14:57 -0500, Joshua Brindle wrote:
> On 2010-01-11 James Carter wrote:
> > On Fri, 2010-01-08 at 16:27 -0500, Caleb Case wrote:
> <snip>
> >>> 
> >>> 
> >>> 3)  I can't remove the permissive domain created before the migration
> >>> because the default priority level is 400, but the script put
> >>> everything at priority 100 and I don't know how to change the priority
> >>> for semanage.
> >> 
> >> semanage hasn't been updated yet to let you specify priorities.
> >> 
> > I noticed. ;)
> > So why does the migration script put everything into priority 100
> > instead of the default priority?
> > 
> 
> 
> priority 100 is for policies distributed by the distro, 400 is default for user actions (eg., running semodule without adding a priority)
> 
> I guess we could add some smarts to the migration script to put things like permissive modules and "local.pp" kinds of modules at 400.
> 
> or add a list of modules distributed by red hat *shrug*
> 
> I'm not sure any of these are good ideas, but they might soften the migration blow.
> 
Oh wait.  I was thinking that 100 was a higher priority.  I couldn't
understand why everything was migrated into a higher priority than the
default.  Now it makes sense.

It still might make sense to put local.pp and permissive modules into
the default priority.  It could be very confusing to have these exist in
multiple priorities.

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
