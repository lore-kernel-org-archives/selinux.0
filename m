Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Janak Desai <jdesai@us.ibm.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120073041.20484.70.camel@celtics.boston.redhat.com>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 15:50:57 -0400
Message-Id: <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 15:24 -0400, Ivan Gyurdiev wrote:
> Can you explain how this would work a bit?
> How would matchpathcon work on a polyinstantiated directory?

I'm not sure what you are asking.  Basic concept is that the user
actually has a separate home directory (and /tmp and whatever else) per
role, and the right one is automatically bind mounted onto their
official home directory location at login time (and adjusted as needed
upon su, newrole, etc).  The code allows for dynamic creation of those
per-role home directories on demand, e.g. when the user logs in at a
given role, but of course, that will leave them with an empty directory
at present.  We would need to deal with setup, e.g. initial copying of
skeleton files when the per-role directory is first created, which could
be handled at login time.  Chad Sellers posted example patches earlier
for login, gdm, and su.  Implementation would be greatly simplified by
unshare(2) call, which would allow handling it in libpam rather than
patching each login-like program - Janak was working on such a patch.
Current implementation creates the per-role directories as
subdirectories of the official home directory location, but others have
suggested making that location configurable.

So at that point you no longer need to keep home directory contexts in
file_contexts at all, and you just exclude home directories from
relabeling.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
