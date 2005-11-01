Subject: Re: [ SEMANAGE ] Install seusers, rename some files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux-dev@tresys.com,
   SELinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <4367E142.1030502@cornell.edu>
References: <4366C114.9080708@cornell.edu>
	 <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil>
	 <4367D13A.1050305@cornell.edu>
	 <1130877661.22731.308.camel@moss-spartans.epoch.ncsc.mil>
	 <4367DA3C.3020308@cornell.edu> <4367D88F.1080309@tresys.com>
	 <4367E142.1030502@cornell.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 16:40:45 -0500
Message-Id: <1130881246.22731.333.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-01 at 16:42 -0500, Ivan Gyurdiev wrote:
> >> - copy /etc/selinux/?/local.users into 
> >> /etc/selinux/?/modules/active/users.local [ renamed ]
> > this could potentially be done the same way as booleans below, except 
> > that there isn't a user of the user api in libsemanage yet, so that 
> > would be written; with seuser handling the vast majority of users now 
> > this isn't very high priority.
> >
> >> - copy /etc/selinux/?/booleans.local into 
> >> /etc/selinux/?/modules/active/booleans.local
> > not sure about this. It would not be difficult to read the old 
> > booleans file and pipe the info through setsebool -p.
> setsebool -p does not go through libsemanage as of right now...
> I haven't written any users of libsemanage - I've been focusing on the 
> library so far..

Yes, but the plan is to move setsebool from libselinux to
libsemanage/utils or policycoreutils and rewrite it to use libsemanage.
Nonetheless, I can't see running it all through setsebool as being
particularly desirable.  Makes more sense to me to just move the files
once for migration and be done with it.  That also simplifies the
problem of atomically setting up the entire sandbox; we can move all of
the local files first, then run semodule -b, and the final commit should
just work since everything will be in place.  I suppose one could
alternatively install the base module first via semodule -b (possibly
with -n too to avoid immediate load), and then apply setsebool -P.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
