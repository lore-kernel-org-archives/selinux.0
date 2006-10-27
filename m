Subject: Re: User object manager context location
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885145F7@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885145F7@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 11:06:36 -0400
Message-Id: <1161961596.1306.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 10:02 -0400, Joshua Brindle wrote:
> With more object managers showing up (eg., Gconf, policy server, X) I
> think we need to make a decision about how the object labeling files are
> kept and managed. As of right now semanage cannot manage any object
> labeling files for userspace object managers and I'm not sure that it
> should.

Eamon has previously expressed interest in creating a more general
mechanism for name-to-context mappings that would supplant the current
ad-hoc per-object manager mechanisms.

> Also, where should the files go, these are private resources of the
> object manager that libselinux doesn't know how to parse, the contexts
> directory is (IMHO) a resource of libselinux so it should understand
> files there, on the other hand the object labeling files would be policy
> specific so they need to be handled in such a way that policy changes
> don't break the object manager.
> 
> We've brought up the idea of a generic section in policy packages for
> this sort of thing but I'm not sure if this is appropriate, once again
> because there will basically be random files with random formats in an
> selinux directory, these should probably be considered configuration
> files for the object manager and not selinux but I'm not sure, the issue
> feels very fuzzy. Chris disagrees with me adamently and believes the
> files should go into the contexts directory and be included in policy
> packages, I'm very unsure of this though.

They are definitely policy-specific, but we may be able to unify the
formats and interfaces.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
