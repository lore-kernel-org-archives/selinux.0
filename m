Subject: Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <james.antill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1162239394.31104.13.camel@code.and.org>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <1161620097.667.10.camel@code.and.org>
	 <1161722236.667.20.camel@code.and.org>
	 <1161776892.3987.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1161778937.3987.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1161784251.667.28.camel@code.and.org>
	 <1161784759.3987.295.camel@moss-spartans.epoch.ncsc.mil>
	 <1161803724.29689.57.camel@code.and.org>
	 <1161804290.3987.388.camel@moss-spartans.epoch.ncsc.mil>
	 <1161970810.29689.88.camel@code.and.org>
	 <1161974293.1306.167.camel@moss-spartans.epoch.ncsc.mil>
	 <1162238632.31104.11.camel@code.and.org>
	 <1162239394.31104.13.camel@code.and.org>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 09:23:30 -0500
Message-Id: <1162304610.32614.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-30 at 15:16 -0500, James Antill wrote:
> On Mon, 2006-10-30 at 15:03 -0500, James Antill wrote:
> > On Fri, 2006-10-27 at 14:38 -0400, Stephen Smalley wrote:
> > 
> > > Look at Darrel's patch for mcstransd to apply a permission check between
> > > the level of the caller and the level being translated for context
> > > translations. 
> > 
> >  Thanks to much discussion with Dan and Stephen, I'm pretty sure I have
> > this correct now.
> 
> 
>  Here is the reference policy part of the patches (libselinux came
> previously and PAM is next).

In addition to the permission name, I'd have expected the rule (and the
check in the code) to always use the same type in both contexts, so the
rules could just be:
	allow $1 self:context <permissionname>;

Not allow $1 domain:context, which will yield many more rules without
any real justification.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
