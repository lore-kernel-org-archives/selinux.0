Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB1LOEga019790
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 16:24:14 -0500
Subject: Re: [PATCH 0/5] libselinux: labeling API for userspace object
	managers (try 2)
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        kaigai@kaigai.gr.jp
In-Reply-To: <457060BB.5090305@mentalrootkit.com>
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
	 <456F976D.9020905@tresys.com>  <457060BB.5090305@mentalrootkit.com>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 16:24:12 -0500
Message-Id: <1165008252.2794.309.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-12-01 at 12:04 -0500, Karl MacMillan wrote:
> Joshua Brindle wrote:
> > If we go forward with this do we really expect every object manager that 
> > has context matching more complicated than exact matches to upstream 
> > changes to libselinux? This doesn't seem to scale well.. Policy server 
> > would need a backend, do you know if dbus and X would need new backends? 
> > I still don't think this is the right approach, LDAP and rdbms's, for 
> > example, would likely have their initial contexts in the schema.

Exact string matching with a default fallback match meets the needs of
both dbus and X in their current forms.  However I've said that I
support adding regex matching to the generic backend as well.  I really
think that this will satisfy the requirements in most cases.  The only
major holdup I can think of is where there might be an arbitrary number
of keys involved (see database discussion below).

> > 
> 
> I agree that this would be problematic - very specific libselinux 
> dependencies are going to be a nightmare for distributions. Seems like 
> it should be possible to have a callback style api that would allow 
> sufficient customization for almost all object managers.

I will try to work in such callbacks on the next go-round.  Thanks for
the suggestion.

> 
> > I can think of few object managers that this scheme works with. Things 
> > like groupware apps, chat servers, mail servers, etc are going to have 
> > labeling done at runtime (based on who creates an object or where it 
> > comes from), 

security_compute_create() can be used to do the labeling in the case
where you have a related object.  The proposed interface is _only_ for
the case where security_compute_create() is not sufficient because
additional meaning is vested in some string name, path, key, etc.

> databases will certainly store contexts in their schema, etc. 

What if you change policies and your database needs to be relabeled?
What if you are importing bulk data?  It's just like the filesystem,
there will have to be a "setfiles" equivalent built into the DBMS, and
for each row, some mapping from the column contents to the security
context for that row.

This brings up the point that perhaps lookups should support more than
one key, and perhaps numeric keys as well as string keys.  KaiGai, do
you have any input based on the Postgres work?
 

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
