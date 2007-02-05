Subject: Re: [RFC] new libsepol policy representation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45C23E5F.5050503@mentalrootkit.com>
References: <45C23E5F.5050503@mentalrootkit.com>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:08:52 -0500
Message-Id: <1170688132.12293.245.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-01 at 14:24 -0500, Karl MacMillan wrote:
> This is an RFC about a series of patches I have been working on to 
> simplify the policy representation used in libsepol. The patch set can 
> be seen at 
> http://people.redhat.com/kmacmill/patches/selinux/policy-parser-rewrite/. 
> I'm not going to post the patch series to the list (unless requested) 
> since it is large and not ready for merging.
> 
> The goal is to replace the current parsing, module representation 
> (including file format), linking, and expanding code in libsepol with 
> this new representation. Backwards compatibility with existing module 
> files would, of course, be preserved.
> 
> BACKGROUND
> 
> This work started with my policy generation tools (initially madison, 
> now sepolgen). The strategy I employed with those tools was to parse the 
> reference policy headers and other policy (source and binary) to gather 
> information needed to generate better policy. That includes calls to 
> reference policy interfaces.
> 
> This parsing was done using a separate parser written in Python. My 
> thought was that the needs of that parser / representation were 
> divergent enough from the current uses of libsepol that a separate 
> parser was simpler and more maintainable.
> 
> Several things have changed my mind about keeping a separate parser:
> 
> * Making the sepolgen parser complete enough to do what I need will 
> result in a parser capable of handling _all_ selinux policy and overlap 
> significantly with checkpolicy / libsepol.
> 
> * I need to extract information from policy modules (mainly attributes 
> and rules that reference attributes). Having to use a completely 
> separate representation to extract that information is difficult and 
> error prone.
> 
> * The policy representation I designed for sepolgen is much more in line 
> with how compilers are usually implemented than what is currently in 
> libsepol. After working with the sepolgen representation I became 
> convinced that it was far superior both for what sepolgen needs 
> (generation and analysis) and for what libsepol / checkpolicy needs 
> (semantic / syntactic checking, optimization, and conversion to a kernel 
> policy).
> 
> Given this I decided to look at creating a similar representation in 
> libsepol and converting checkpolicy / checkmodule to use that.
> 
> STATUS
> 
> This patch set implements several new data structures (some of which I 
> have sent to the list before) and an incomplete version of the policy 
> representation and checkpolicy changes. I am posting it now because it 
> is complete enough that feedback is possible. I believe that it already 
> shows the value of this approach.
> 
> ADVANTAGES
> 
> Unlike the current libsepol representation, the structures in the 
> representation are based on trees and use strings (more like the 
> "records" that Ivan added). This representation has several advantages:
> 
> * The tree structure more closely aligns the libsepol representation 
> with the policy structure, eliminating the need to store scoping 
> information separately. The current scope information in libsepol is 
> cumbersome, incomplete, and space consuming. See idtab_check_scope in 
> policy_check.c for an example of how this structure simplifies handling 
> scoping - compare to the similar operation in the parser / linker.
> 
> * The use of strings rather than numeric ids for components makes 
> manipulating and merging the policy much simpler (e.g., all of the 
> mapping that is done in link.c just goes away - that code has been very 
> difficult to get right and is difficult to maintain).
> 
> * Policy components (e.g., types or booleans) can exist outside of a 
> larger policy structure. That makes it possible to merge this 
> representation with the "records" currently used in libsepol / libsemanage.
> 
> * The object pool and object sets mitigate most of the disadvantages of 
> using strings by storing only a single copy of every string. This 
> removes much of the extra space and allows string comparisons to devolve 
> into pointer comparisons in many cases. The use of the pooling is 
> optional, however, to simplify the use of the data structures separate 
> from a policy.
> 
> * All of the current ordering constraints in the parser are removed. 
> This should remove most of the hacks that the reference policy currently 
> needs to build correctly.
> 
> * The parser is now single pass.
> 
> * The parser can handle arbitrary nesting of components (including 
> conditionals) much more easily.
> 
> * The semantic checking can be shared _completely_ by the parser and the 
> linker/expander. Currently these are only partially shared (and the 
> linker / expander don't check everything that the parser does).
> 
> * Implementing planned language extensions to directly support the 
> reference policy will be greatly simplified.
> 
> * This structures will be usable for policy generation (which started 
> all of this!).
> 
> PATCHES
> 
> 01-sepol-list-iter.patch
> Add a list data type and iterators.
> 
> 02-sepol-symtab-export.patch
> Export functions for hashing and comparing strings.
> 
> 03-sepol-hashtab-iter.patch
> Add iterators to the hashtab data type.
> 
> 04-sepol-objpool.patch
> Add the object pool data type, for managing a pool of reference counted 
> objects (e.g., strings).
> 
> 05-sepol-objset.patch
> Add the object set data type for keeping sets of objects (with 
> guaranteed uniqueness - this is modeled on 
> http://docs.python.org/lib/types-set.html).
> 
> 06-sepol-policy.patch
> Add a tree-based policy representation.
> 
> 07-sepol-policy-check.patch
> Add an example semantic check that uses the tree-based representation.
> 
> 08-checkpolicy.patch
> Convert the parser to generate the tree-based representation. This is 
> the least complete and most invasive patch in the series. Note that some 
> of the grammar changes are very helpful for making nested conditionals / 
> optionals work naturally separate from the policy representation changes.
> 
> FUTURE
> 
> The next steps are to:
> 
> * Finish the parser and semantic checker
> 
> * Implement serialization for the policy trees to create a new module 
> file format (the package format won't change). I anticipate that this 
> could also be used for the libsemanage wire protocol, which currently 
> requires an entirely separate set of serialization functions.
> 
> * Implement conversion from the tree representation to the kernel data 
> structures (which will replace expansion - linking comes basically for 
> free with this representation).
> 
> * Implement a reader for the current module format to the new tree 
> structure - this will provide backwards compatibility.
> 
> At this point I'm looking for:
> 
> * Fundamental objections
> * Feedback on the general approach
> * Ideas on how to integrate this work while avoiding the "big bang" 
> style integration we had with the policy module work.
> * Help!
> 
> Any feedback is welcome.

I'm not fundamentally opposed; we have in the past called for an
appropriate IR for policy as a common basis for tools and
infrastructure.

In skimming through the patch set, I'm unclear as to which aspects are
intended to be part of the shared library interface vs. the static
library interface.  In the current libsepol, include/sepol/policydb/
contains private state that is only made available to shared library
users, while the top-level header files in include/sepol define the
shared library interface.  Of course, libsepol.map is the authoritative
definition of the shared library interface.  If you intend to export
things like hashtabs to shared library users, then we naturally need
proper encapsulation and namespacing of them.

As a nit, there is a name collision between the existing sepol_node
struct (for node aka host records) and your new sepol_node struct for
the tree. 

Similarly, you would need to reconcile your sepol_security_context*
functions with the existing sepol_context* record functions.  There may
be other points of duplication/overlap; I haven't yet looked thoroughly.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
