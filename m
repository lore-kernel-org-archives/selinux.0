Subject: Re: Latest policycoreutils patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43CE8AB3.1070103@cornell.edu>
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com>
	 <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com>
	 <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com>
	 <43CDE7ED.4020908@cornell.edu> <43CE6261.8030204@redhat.com>
	 <43CE824E.6010904@cornell.edu>  <43CE8520.5050008@cornell.edu>
	 <1137609022.8926.194.camel@moss-spartans.epoch.ncsc.mil>
	 <43CE8AB3.1070103@cornell.edu>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 13:52:23 -0500
Message-Id: <1137610343.8926.202.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-18 at 11:36 -0700, Ivan Gyurdiev wrote:
> Stephen Smalley wrote:
> > If you want this to be useable by ordinary users (subject only to policy
> > restrictions), then you likely want it to act on the installed seusers
> > file instead of the libsemanage-managed one.
> >   
> Shouldn't the policy server improve this situation when it's merged?

Policy server avoids the need for the client program to pass DAC checks
on the module store, but a) some kind of checking will certainly be
applied by the policy server on client requests, and b) use of policy
server will not be mandatory at least in the short term (even after it
is merged).

Also, the current usage pattern for file_contexts and seusers is that
libselinux reads the installed files for runtime operation rather than
getting the information from libsemanage, so I'm not sure why chcat -L
-l wouldn't just read the installed seusers file too (preferably via
libselinux function).  The installed files already have DAC modes that
allow user read access, subject only to policy restrictions.

> (By the way, now that you've merged my patches, there's no more 
> dependency on semanage_store.c in database.c, which means there's no 
> further known obstacles to implementing a pserver backend to the 
> database, if the server is merged, and line protocol is decided upon).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
