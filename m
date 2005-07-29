Subject: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 12:49:59 -0400
Message-Id: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch set reduces the number of avtab nodes by preserving
attributes in TE allow/dontaudit/auditallow rules when possible rather
than expanding them during policy compilation, and having the kernel use
a type->attribute reverse map to perform the access vector computation,
per the earlier discussions on the list.  This slows down security
server computations, but these only occur on AVC cache misses, so the
expected performance impact is negligible.  I have not yet attempted to
measure the performance impact.  If it proves to be measurable at all,
we can likely optimize it in the same manner that I used for the
assertion checking code (see below).

Unlike the first patchset, where you could just patch the kernel and see
the memory savings from the reduction in the per-node size even with a
policy.19 file, this patch set requires you to patch your kernel,
libsepol, and checkpolicy and build a policy.20 policy in order to see
the reduction in nodes, as that is handled during compilation.

This patchset is relative to the prior patch set.  I've also made the
two patch sets available under http://www.cs.utah.edu/~sds/avtab1 and
http://www.cs.utah.edu/~sds/avtab2 respectively, along with prepatched
tarballs of libsepol and checkpolicy for convenience.  These include the
bug fixes for the first patch set and a re-base to the latest cvs.

Some notes:
- Expansion of attributes is only suppressed in type sets in
allow/dontaudit/auditallow rules, and only if the type set does not
include a negative set (e.g. file_type - shadow_t), wildcard (*), or
complement (~) and only if the rule is not a self rule.   I didn't
originally catch the latter (self rules), which had an interesting
effect (allow x self:process p; was being mis-interpreted as allow x
x:process p; for every t in x by the kernel).

- I didn't increment the policy version again for this patch set,
so it is still version 20, as with the prior patch set.  If we
were to upstream these patches separately, I'd split them into separate
versions, but if we roll them up for a single upstream change, there is
no reason to separate them.

- Compatibility code for writing older policy versions from the patched
checkpolicy is not written yet, unlike with the prior patchset.  Looks
rather painful (and I thought it was already painful with the last
patchset), as I'd have to expand the avtab and we've already discarded
the attribute->type mappings at this point (the type->attribute reverse
mappings aren't quite as helpful for such expansion).

- Assertion checking is significantly slower.  I added some new inline
ebitmap operations to help speed it up, but it is still a lot slower
than previously.

- A possible solution to both of the above problems would be to build a
fully expanded avtab during module expansion in addition to the
non-expanded one and saving it in the policydb for later use in
assertion checking and writing older policy versions.  But that will
obviously slow down module expansion and consume a lot more memory when
constructing policies.  Thoughts?  Patches?

Some data on the file size, number of slab objects (avtab nodes) and
slab object size (avtab node size) is below for the unpatched code
(version 19), the first patchset (reduce avtab node size, split multiple
data entries), and this second patchset (reduce number of nodes).  As I
didn't create separate policy versions for each patchset, 20.1 refers to
the first patchset and 20.2 refers to the second patchset.  Since the
first patchset reduces the node size, it has essentially the same impact
on targeted and strict policies, i.e. roughly halving the memory size.
In contrast, since the second patchset only reduces the number of nodes
and only when attributes are used in rules, it has a markedly different
impact on targeted vs. strict policy, although it reduces the memory
size for both.  In general, as policies move toward greater least
privilege, this patch set will provide less of an improvement, although
it is unlikely that we will ever get away completely from having some
rules that use attributes.

Targeted Policy
Vers | File | #Objs  | ObjSize
------------------------------
19   | 8.0M | 347387 |  32
20.1 | 4.1M | 350813 |  16
20.2 | 391K | 23751  |  16

Strict Policy
Vers | File | #Objs | ObjSize
------------------------------
19   | 16M  | 664756 | 32
20.1 | 8.0M | 689183 | 16
20.2 | 2.9M | 229295 | 16

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
