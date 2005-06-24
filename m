Message-Id: <200506241430.j5OEUbqc015010@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <ivg2@cornell.edu>
Cc: "'James Morris'" <jmorris@redhat.com>, <selinux@tycho.nsa.gov>,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: RE: file contexts and modularity
Date: Fri, 24 Jun 2005 10:30:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1119615710.12865.57.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, June 24, 2005 8:22 AM
> To: ivg2@cornell.edu
> Cc: James Morris; Karl MacMillan; selinux@tycho.nsa.gov; 'Daniel J Walsh'
> Subject: RE: file contexts and modularity
> 
> On Thu, 2005-06-23 at 16:28 -0400, Ivan Gyurdiev wrote:
> > it still takes 4 seconds for useradd to load the policy.
> > It's awfully slow.... that's 2x policydb_read, because of
> > the verify-after-write.
> 
> This is something that I think merits further discussion.  I think that
> the real problem is that the avtab size has grown far beyond what we
> originally anticipated and this is hurting us both in time (to
> manipulate policies, to load policies, and even to search the avtab) and
> in space (kernel memory consumption by the avtab is huge).  We certainly
> didn't expect the avtab to reach 484,677 distinct entries (FC4 strict
> policy) and even the targeted policy in FC4 is now up to 215886 entries.

And this seems to be one of the most common complaints that people make.

> While the loadable/binary policy module work may help somewhat by
> allowing us to omit policy modules easily for packages that are not
> installed and the userspace security server will allow us to omit
> userspace policy from the kernel, I still expect this to be a problem
> for default installs and general purpose systems, particularly as we
> begin to extend SELinux into securing the desktop. 

I agree - the loadable modules will probably be a small help.

> This suggests that
> we may need to refactor the data representation for the avtab, replacing
> it with a more compact representation that will require more complex and
> likely slower computation in the kernel for security_compute_av (but
> this should mostly be hidden by the AVC).  In effect, something more
> like the avrules of the module work, i.e. more like policy.conf itself,
> where we can store multiple classes and multiple types in a single
> entry, and possibly even preserve the notion of type attributes to
> reduce the need for storing the same (large) type set repeatedly.

This seems like too large a step. What's really funny is that we added a
hashtable similar to the avtab to libapol for sediff because the rule storage
(which is similar to what was added for the module work) was too slow /
cumbersome for certain types of analysis. Additionally, I think that we want to
avoid data structures that force memory allocation in the security_compute_av
code path.

The most obvious compromise is simply putting attributes in the avtab. This
would require adding a reverse map from types to attributes probably. Lookup
complexity would be, I think, worst case O(N^2) where N is the number
attributes. Actually O(N^2 + N^2) because of the conditional avtab lookup.

Other ideas:
- reducing our namespaces to 16bits. Do we really need 32 bits for types,
attributes, and object classes?

- Automatic merging of similar/identical type/object class triplets. This would
be a big win for the 10,000 domain web hosting machine use case.

>  Also,
> a direct representation of the notion of unconfined might be useful in
> eliminating policy bloat, although that is difficult to capture and
> targeted policy has been denying even unconfined certain permissions if
> certain booleans are disabled (e.g. execmem/execmod).
> 

Interesting - maybe store unconfined as exceptions rather than what is allowed?

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
