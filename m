Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: James Morris <jmorris@redhat.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1119558539.16753.74.camel@celtics.boston.redhat.com>
References: <200506231939.j5NJdXqc031369@gotham.columbia.tresys.com>
	 <1119558539.16753.74.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 08:21:50 -0400
Message-Id: <1119615710.12865.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 16:28 -0400, Ivan Gyurdiev wrote:
> it still takes 4 seconds for useradd to load the policy.
> It's awfully slow.... that's 2x policydb_read, because of
> the verify-after-write. 

This is something that I think merits further discussion.  I think that
the real problem is that the avtab size has grown far beyond what we
originally anticipated and this is hurting us both in time (to
manipulate policies, to load policies, and even to search the avtab) and
in space (kernel memory consumption by the avtab is huge).  We certainly
didn't expect the avtab to reach 484,677 distinct entries (FC4 strict
policy) and even the targeted policy in FC4 is now up to 215886 entries.
While the loadable/binary policy module work may help somewhat by
allowing us to omit policy modules easily for packages that are not
installed and the userspace security server will allow us to omit
userspace policy from the kernel, I still expect this to be a problem
for default installs and general purpose systems, particularly as we
begin to extend SELinux into securing the desktop.  This suggests that
we may need to refactor the data representation for the avtab, replacing
it with a more compact representation that will require more complex and
likely slower computation in the kernel for security_compute_av (but
this should mostly be hidden by the AVC).  In effect, something more
like the avrules of the module work, i.e. more like policy.conf itself,
where we can store multiple classes and multiple types in a single
entry, and possibly even preserve the notion of type attributes to
reduce the need for storing the same (large) type set repeatedly.  Also,
a direct representation of the notion of unconfined might be useful in
eliminating policy bloat, although that is difficult to capture and
targeted policy has been denying even unconfined certain permissions if
certain booleans are disabled (e.g. execmem/execmod).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
