Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <45F17C70.70707@kaigai.gr.jp>
References: <45EC0D21.2070706@kaigai.gr.jp>  <45EC2C10.6050603@kaigai.gr.jp>
	 <1173284267.10747.9.camel@sgc>  <45F010A4.4020201@kaigai.gr.jp>
	 <1173360830.10467.29.camel@moss-spartans.epoch.ncsc.mil>
	 <45F022A0.3020105@kaigai.gr.jp>
	 <1173366058.10467.67.camel@moss-spartans.epoch.ncsc.mil>
	 <45F02A09.5060301@tresys.com>  <45F02A80.5050708@tresys.com>
	 <1173367847.10467.72.camel@moss-spartans.epoch.ncsc.mil>
	 <45F038C5.4070003@tycho.nsa.gov>
	 <1173385436.3241.54.camel@moss-spartans.epoch.ncsc.mil>
	 <45F17C70.70707@kaigai.gr.jp>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 11:37:54 -0500
Message-Id: <1173458274.3241.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-03-10 at 00:25 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-03-08 at 11:24 -0500, Eamon Walsh wrote:
> >> Stephen Smalley wrote:
> >>
> >>> There are already string_to_security_class() and string_to_av_perm()
> >>> functions provided by libselinux, although they should likely have
> >>> properly namespaced versions (selinux_ prefix).
> >> If we're talking about the API in this area: I had a request for 
> >> security_class_to_string and av_perm_to_string functions, I believe from 
> >> KaiGai.  The patch in the below e-mail adds them; this could be applied 
> >> as an independent patch.
> >>
> >> http://marc.theaimsgroup.com/?l=selinux&m=116486019626891&w=2
> > 
> > Ok, so we could:
> > - introduce new versions of the existing string_to_* functions with a
> > security_ or selinux_ prefix for namespace cleanliness,
> > - merge that patch, using the same convention for naming (either as is
> > with security_ or replacing with selinux_,
> > - have KaiGai rewrite his code to use these functions to map class and
> > permission strings to policy values during startup of SEPostgreSQL,
> > generating lookup tables for later use by the actual permission checks
> > (where the lookup tables would map internal indices private to
> > SEPostgreSQL to the policy-defined values obtained from libselinux).
> > The tables would need to be revalidated and potentially refreshed upon a
> > policy reload, which could be done from an AVC callback.
> > 
> > Then SEPostgreSQL no longer needs to be compile-time bound to specific
> > policy values for its classes and permissions.
> 
> I also think it's an excellent idea!
> I'll rewrite a part of implementation to generate classes/access vectors
> lookup table and to use them.

Ok, you'll need to figure out the optimal approach there, as you need
low runtime overhead for the actual permission checks.  They would be
changing from having the form:
	rc = avc_has_perm(ssid, tsid, SECCLASS_DATABASE,
DATABASE__ACCESS, ...);
to having a form like:
	rc = pgres_has_perm(ssid, tsid, PGRES_DATABASE_ACCESS, ...);
where pgres_has_perm() could do something like:
	rc = index2policy(PGRES_DATABASE_ACCESS, &tclass, &perms);
	if (rc) return rc;
	rc = avc_has_perm(ssid, tsid, tclass, perms, ...);

So you'd have a postgres-private index value for each distinct
permission check it performs, mapped to a (class, perms) pair by the
index2policy() function, using a lookup table generated once during
startup from the string names using the libselinux functions (and
revalidated upon policy reload notification).

> > Same could be done for XSELinux, right?
> > 
> > Then when we have the dynamic discovery mechanism implemented, it can
> > just be used by those libselinux functions internally, with no further
> > change to the object managers.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
