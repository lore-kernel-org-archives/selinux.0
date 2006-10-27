Subject: Re: User object manager context location
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1161961596.1306.8.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885145F7@exchange.columbia.tresys.com>
	 <1161961596.1306.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 13:24:30 -0400
Message-Id: <1161969870.17018.41.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 11:06 -0400, Stephen Smalley wrote:
> Eamon has previously expressed interest in creating a more general
> mechanism for name-to-context mappings that would supplant the current
> ad-hoc per-object manager mechanisms.

What I have been thinking about is a generalization of matchpathcon(3)
which takes as an additional argument a security class.  The security
class would serve to identify the configuration being used: for
SECCLASS_FILE, DIR, BLK_FILE, etc. the file contexts would be used, for
SECCLASS_XEXTENSION the X extensions configuration would be used, for
SECCLASS_DBUS the D-BUS configuration, etc.  Note that the "mode"
argument to matchpathcon currently serves the same purpose for the
various file types.

Since matchpathcon only takes a string as the thing to look up, all
configurations would be restricted to this as the mapping key.  But the
string could be interpreted in various ways by pluggable backends for
each supported security class - such as the regexp format used in the
file contexts.  I think that for the vast majority of cases, a string is
fine.  SECMARK is a counterexample (it provides the mapping for
SECCLASS_PACKET).

> 
> > Also, where should the files go, these are private resources of the
> > object manager that libselinux doesn't know how to parse, the contexts
> > directory is (IMHO) a resource of libselinux so it should understand
> > files there, on the other hand the object labeling files would be policy
> > specific so they need to be handled in such a way that policy changes
> > don't break the object manager.

I think that configurations should be stored in the policy, not in the
individual object managers.  A large part of the X code right now is
just for parsing the text file that provides the mapping at present.
The common string->label model should solve the "random formats"
problem.

> > We've brought up the idea of a generic section in policy packages for
> > this sort of thing but I'm not sure if this is appropriate, once again
> > because there will basically be random files with random formats in an
> > selinux directory, these should probably be considered configuration
> > files for the object manager and not selinux but I'm not sure, the issue
> > feels very fuzzy. Chris disagrees with me adamently and believes the
> > files should go into the contexts directory and be included in policy
> > packages, I'm very unsure of this though.
> 
> They are definitely policy-specific, but we may be able to unify the
> formats and interfaces.
> 
-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
