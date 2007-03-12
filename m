Subject: Re: [ANN] SE-PostgreSQL 8.2.3-1.0 alpha release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov, Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <45F5899E.9070408@tycho.nsa.gov>
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
	 <1173458274.3241.122.camel@moss-spartans.epoch.ncsc.mil>
	 <45F5899E.9070408@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 12 Mar 2007 13:50:14 -0400
Message-Id: <1173721814.2738.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-12 at 13:10 -0400, Eamon Walsh wrote:
> Stephen Smalley wrote:
> > Ok, you'll need to figure out the optimal approach there, as you need
> > low runtime overhead for the actual permission checks.  They would be
> > changing from having the form:
> > 	rc = avc_has_perm(ssid, tsid, SECCLASS_DATABASE,
> > DATABASE__ACCESS, ...);
> > to having a form like:
> > 	rc = pgres_has_perm(ssid, tsid, PGRES_DATABASE_ACCESS, ...);
> > where pgres_has_perm() could do something like:
> > 	rc = index2policy(PGRES_DATABASE_ACCESS, &tclass, &perms);
> > 	if (rc) return rc;
> > 	rc = avc_has_perm(ssid, tsid, tclass, perms, ...);
> > 
> > So you'd have a postgres-private index value for each distinct
> > permission check it performs, mapped to a (class, perms) pair by the
> > index2policy() function, using a lookup table generated once during
> > startup from the string names using the libselinux functions (and
> > revalidated upon policy reload notification).
> 
> If having an index2policy table is going to be a common usage model for 
> userspace object managers then perhaps support for it should be included 
> in libselinux.

Hmmm..well, the userspace object manager knows the number of discrete
permission checks it performs, and it knows the (class, permission)
string pairs involved, so it should be able to allocate and generate an
optimal table for mapping its own permission checks to (class,
permission) value pairs using only libselinux functions for mapping
class and permission strings to policy values to populate the table at
startup.  Not sure what the tradeoffs would be in abstracting that table
generation behind a libselinux interface.

Of course, one would also have to deal with the situation where a given
permission check passes a computed permission set value instead of a
fixed permission set, like selinux_inode_permission or selinux_capable
in the kernel.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
