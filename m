Received: from [144.51.25.121] (moss-spartans [144.51.25.121])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l2QI1CO7018810
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 14:01:12 -0400
Subject: Developer summit minutes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 26 Mar 2007 13:55:43 -0400
Message-Id: <1174931743.3864.204.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Below are the minutes from the developer summit that followed the 2007
SELinux Symposium.

SELinux developer summit / March 16 2007
-----------------------------------------

Purpose
-------
The purpose of the developer summit was to provide a forum for
focused, detailed technical discussion of ongoing development and
future plans for SELinux among core SELinux developers and
contributors.


Attendees
---------
James Antill, Red Hat
Joshua Brindle, Tresys / Gentoo
Dave Caplan, Tresys
Jim Carter, NSA
Darrel Goeddel, TCS
Chad Hanson, TCS
Trent Jaeger, Penn State Univ
KaiGai Kohei, NEC / JSELUG
Peter Loscocco, NSA
Karl MacMillan, Red Hat
Paul Moore, HP
James Morris, Red Hat
Eric Paris, Red Hat
Chris PeBenito, Tresys / Gentoo
Chad Sellers, Tresys
Stephen Smalley, NSA
Brian Sniffen, MITRE
Manoj Srivastava, Debian
Chris Vance, SPARTA
Eamon Walsh, NSA
Dan Walsh, Red Hat

Agenda
------
Opening Session
        Welcome and introductions.
        Take any final suggestions for topic or schedule changes.
        Discuss general topics.
		- Central project site / pan-distribution support.
		- Dealing with different user groups and their needs.
Policy Session
		- Policy language/toolchain.
		- Policy tools/infrastructure.
		- Policy configuration.
Userland Session
		- Securing the desktop.
		- Improved userland integration.
		- Userspace object managers.
		- Embedded support.
		- MCS
		- User interface / label translation.
Networking Session
		- Labeled networking.
		- SECMARK.

General Topics
---------------
The summit began with an hour-long opening session to introduce the
participants, take any final suggestions for topic or schedule
changes, and discuss several general topics.  The main topics that
were covered during the initial session included a central project
site for SELinux and dealing with different user groups and their
needs.


Central Project Site/Pan-Distribution Support
---------------------------------------------
The first topic of discussion was on the issue of having a central
project site for all SELinux-related information and improving
pan-distribution support.  At present, information and code for
SELinux is distributed among a disparate collection of web sites and
repositories (nsa.gov/selinux, selinux.sourceforge.net,
selinuxnews.org, oss.tresys.com, tresys.com/selinux, kernel.org,
distribution-specific resources), with no single jumping off point for
everything related to SELinux.  It was agreed that a centralized wiki
that could be directly edited by core SELinux developers and
distribution maintainers would be helpful, but that there was no need
to centralize all of the SELinux content and repositories.  James
Morris may set this up eventually, but is also open to someone else
doing so sooner.  It would require a site that could provide accounts
for all core participants to enable direct editing.

Related to this topic was the topic of handling the SELinux userland
patches, which have migrated into the per-distribution packages and
have no selinux upstream repository presently.  It was agreed that
extracting the remaining patches from the distribution-specific
packages, re-basing them against some upstream baseline, and keeping
them in a form that could be consumed by all the different
distributions would be very difficult and not maintainable long term.
Instead, the suggestion was made to simply provide a definitive list
per distribution of the remaining patches and where they can be found
via the wiki, and to foster greater communication among the
distributions about the patches and future changes to them, as well as
continuing to strive towards upstream acceptance for the remaining
patches where feasible.  This also requires encouraging package
maintainers to notify the right people when making changes to the
selinux userland patches in their packages.  Dan Walsh took the action
of generating a list of SELinux userland modifications in Fedora.

During the discussion of the userland patches, it was noted that the
selinux patches have become very intertwined in Fedora with
MLS/MCS-specific functionality and with audit functionality, so the
question was raised as to the portability of those patches to other
distributions.  At present, MLS/MCS functionality is not of interest
to the Gentoo selinux maintainers but is of interest to the Debian
selinux maintainers (which are also enabling MCS by default), and
audit userland support is not yet in Debian and is not up-to-date in
Gentoo.


Dealing with Different User Groups/Needs
----------------------------------------
The second main topic of discussion was how to deal with different
user groups (e.g. government vs. corporate, embedded vs. general
purpose) in a manner that satisfies their needs but doesn't lead to
trying to impose the same solution on everyone or to fragmentation of
SELinux into specialized variants.  Dave Caplan noted that most of
Tresys' work for government customers has not required the use of the
MLS support at all, as Type Enforcement has met the real need more
directly and effectively.  Karl MacMillan suggested that the only case
where the MLS support provided value was when the customer needed
thousands of categories.  In the common case, the call for MLS was
simply driven by existing (paper) policy and procedures, customers
used to legacy systems with certain functionality, and the existing
(niche) market for "trusted" operating systems.  Nonetheless, it was
acknowledged that the MLS support would need to be retained long term
to support such users, and that MLS support in SELinux can serve as an
enabler for introducing TE to the existing MLS user base.

The need for a general API for certain label manipulation functions to
support the small set of policy-aware applications was then discussed,
such as an interface to compute a label that dominates a set of input
labels or an interface to order a set of labels.  Such an API could be
provided by libsepol based on a policy file or by libselinux using new
selinuxfs nodes to query the active kernel policy, although in some
cases the detailed label logic is hidden in the context translation
library (as when using the MITRE label encodings library).  It was
agreed that SELinux should provide general APIs for such functions to
applications as needed, seeking to encapsulate as much as possible
(e.g.  acting on entire contexts rather than just the MLS field, even
though the rest of the context may not presently have any real
ordering).

If the MLS support is to be sustained long term, it needs to be
attractive to ordinary users.  Labeled printing was cited as an
example of functionality that could be useful to non-government users,
although the current labeled printing support doesn't (yet) support
preserving the document label.  Desktop integration was cited as
another example where MLS and/or MCS style functionality could
potentially be more useful due to more human-meaningful labels.
However, the inherent limitation of MLS/MCS to confidentiality (not
integrity) and its inflexible model was noted by Karl MacMillan as a
fundamental impediment to widespread use, and TE could provide the
same benefits for labeled printing and desktop operations if types are
translated to more meaningful labels (using the existing context
translation facilities already employed for MLS) and made more
directly accessible to end users. In the end, it wasn't clear that MLS
support could be made attractive outside of specialized users due to
its inherent limitations.

One of the aspects of SELinux in general that has been attractive to
users is labeling data based on what it is, not who can access it
(unlike ACLs).  Users are also interested in support for roles for
administrative decomposition, although in practice RBAC is often
applied at the application level rather than the OS level.

There was some discussion of what MLS offers that TE doesn't do well
today.  In addition to supporting large numbers of categories (and
their combinations), the implicit support for hierarchy and ranges in
MLS and its more direct link back to the user was cited as possible
advantages.  It was noted that it should be possible to build higher
level tools and languages for expressing hierarchical relationships
among types more easily, mapping them down to the low level access
matrix.  However, particularly with increasing number of roles, the
number of types and their relationships tend to explode, suggesting
that we may ultimately need/want more compact ways of expressing
related types even in the low level representation.  One simple
example would be easily expressing that a new type should have all of
the permissions of an existing type plus a specific list of additional
permissions.  Prototyping such support in a higher level
representation first and then later assessing whether it should be
migrated into the userspace policy module format or even down into the
kernel representation was viewed as the best approach for exploring
these ideas.


Policy Session
--------------
The remainder of the morning was spent in the policy session.  This
session included discussions on the policy language and toolchain, the
policy tools and infrastructure, and the policy configuration.


Policy Language/Toolchain
-------------------------
This topic began with discussion of the proposed new libsepol policy
representation aka the policy IR that had been posted to the list as
an RFC.  There was agreement that such an IR would facilitate a number
of improvements to the language and toolchain and was desirable.  Karl
MacMillan requested help in completing the implementation in a timely
manner, and there will be a followup meeting among Karl, Joshua, and
Stephen to discuss the current code and approach.  The basic steps are
to finish the parser, remove the module format support from the
policydb, generate the policydb from the tree representation, provide
convertors to and from the tree representation for compatibility, and
introduce the new binary on-disk format.  The serialization code
developed for policy management server should largely be unaffected,
although it may wish to take advantage of the string compression
support as an optimization.  A branch will be created for joint
development on sourceforge.

Language support for reference policy interface is still planned, but
is blocked on the completion of the new policy representation.
Automatic generation of require statements and deprecation of require
statements altogether is also still planned.  There was a concern
about being able to unambiguously distinguish types from attributes,
although that should be discernible at expand time.

A concern about being able to ship a single policy package (.pp) file
that can support multiple base policies was raised.  In the past, the
notion of fat policy packages was considered but rejected.  The
problem will be partly addressed through link-time expansion of
interfaces, but there will still be dependencies on particulars of the
base policies (e.g. MLS vs. non-MLS, particular types defined by a
given policy, etc).

On the package management front, the plan in Fedora is still to
install policy packages from %post and restorecon afterward.  The view
is that restorecon is needed after install regardless due to files
created from %post scriptlets.  There are still issues to be resolved
with the installer, such as generating a full file contexts
configuration during build for use by the installer.  We also need to
resolve what other files need to be installed by software packages
beyond the .pp file, such as the interface files (possibly eliminated
by introduction of link-time expansion of interfaces) and
help/documentation files.  There was some debate as to whether such
files belongs in the .pp file itself or as separate auxiliary files.
It was also noted that package managers still have no way to
transparently support policy upgrades where the decomposition of
policy changes, such as moving a policy module in or out of the base.
Although semodule does support such transactions (e.g. semodule -r
x.pp -i base.pp), there is no way for the package manager to
automatically determine the right incantation presently.  Finally,
removing of types still presents a problem for per-package policy


Policy Tools/Infrastructure
---------------------------
This topic began with discussion of policy generation and development
tools, with a call to eliminate and avoid duplication among the tools
efforts, ensure that we are working toward a common goal, and making
sure that we are reaching the user.  There was a question as to
whether the use of python by Madison/SEPolgen and other policy tools
(like Polgen or semanage) is an impediment to integration with other
tools efforts and whether the use of a scripting language for such
tools is a security concern for SELinux.  

SLIDE is presently limited to using Madison/SEPolgen via helper
programs as jython lacks adequate support.  SETools has no problems
with the use of python.  The larger concern seems to be with the
stability of the python language.  However, there are no plans to
move away from python.

The security concerns can be addressed by providing a binary wrapper
for the python scripts that performs adequate sanitization and ensures
that the proper script is invoked.  Such a wrapper has already been
created for the CLIP work from the upstream python, and should be
integrated into policycoreutils and used as the gate to our python
scripts.

Tools for generating new types from existing ones with small deltas
are needed, e.g. creating a new cgi domain that is identical to the
base one except for adding or removing a small set of permissions, and
then applying that domain to a particular script.  Similarly for
firefox, in order to easily construct separate firefox domains for
e.g. internal vs. external access.

Discussion then moved into policy management tools.  Dan Walsh asked
whether we should be moving all object context definitions (e.g. port
contexts) out of the base policy and into semanage as Brickwall has
done to enable full customizability, rewriting policy to use
attributes more.  This will require introducing support into
libsemanage for system definitions of these object contexts separate
from local definitions or modules (e.g. ports vs. ports.local), as has
been done for some objects.  There is a concern that rewriting the
policy in terms of attributes to such an extent could harm
understandability.

Management of the home directory labeling was noted a crucial problem
for enabling strict policy and user roles.  Home directories are the
most common place for labeling problems to manifest, and relabeling
entire home directories is too expensive.  Joshua noted that we need a
general facility for per-user types that covers all objects, not just
user home directories as in genhomedircon.  This is to be taken up on
list.

Dan noted that allowing setting of specific booleans for a less
privileged user role is currently impossible because libsemanage
regenerates the entire policy and resets all booleans, even for
non-persistent boolean changes.  Some investigation into what is
happening presently and whether libsemanage needs to be refactored is
required.

Dan also noted that non-modular configuration files such as the
default_contexts file and default_type files pose a problem for fully
modular policy and adding roles.  We need to support specification and
manipulation of such data via semanage or in the .pp files or in the
policy module sources.

The policy management server (PMS) RFC release was discussed.  One of
the immediate potential applications of the server, delegation of
access to booleans, isn't presently supportable since the current
boolean controls are based on file-level labeling and access control.
Karl recommended just emulating the file-based checks in the server.
The PMS patches will be coordinated with the new policy representation
patches.

[editorial note: Moved some discussion notes down to the Policy
Configuration section as they fit under it more cleanly.]

It was agreed that front-end tools for policy could be included in the
"upstream" selinux.  system-config-selinux needs to be cleaned up and
converted over to executing helper programs rather than directly using
python bindings to ensure that the security relevant functionality
runs in its own domain.  Management of local policy modules should be
integrated into such tools to help users with preserving the results
of prior modules.  Integration with Madison/SEPolgen is planned.


Policy Configuration
--------------------
This topic began with discussion of the hierarchical apache policy RFC
was discussed.  The hierarchical type system provides a way for a
higher level administrator to define a broad container type with a
maximal set of permissions to the rest of the system that he is
willing to delegate to a subordinate administrator, and then allow the
subordinate administrator to subdivide that container type into any
number of specific types, and the hierarchical apache policy is a
rewrite of the apache policy with no functional changes that provides
such a decomposition.  Applications of the approach could include
delegation to application administrators, representation of a
meta-policy for a virtualized platform with multiple policies being
enforced by the hypervisor and individual guest OSes, enabling users
to craft more limited policies for user cgis bounded by the general
cgi policy, etc.

Several concerns about the practical applicability of the hierarchical
type scheme were raised, such as whether the abstract container types
would effectively grow to effectively being unconfined, whether policy
writers can effectively predefine the right set of container types for
end administrators, and whether end administrators can make effective
use of such a mechanism.  Karl argued that real administrators would
either require subordinates to pass policy changes through them for
review and committing or only use very coarse-grained delegation
(e.g. at the machine/VM level). He also expressed concern that the
meta-policy will quickly grow to being as complex as normal policy if
we go beyond very coarse-grained container types, reducing management
of meta-policy to the same level as regular policy.

The question was raised as to whether there would be any objection to
merging the hierarchical apache policy into reference policy, as it
should be functionally equivalent to the original apache policy, in
order to retain a worked example of how to use the type hierarchy for
users.  The only concern was compatibility due to the current practice
of tying the hierarchy to the type names.  Although type aliases are
defined in the hierarchical apache policy to preserve compatibility,
the kernel will always use the primary type names when reporting the
contexts to users via kernel interfaces and audit logs, so the new
hierarchical type names would be user-visible.  As specific type names
have become well-known to users, particularly for dealing with apache
policy and other targeted domains, we no longer have the freedom to
arbitrarily change them even with type aliases.  However, if the
hierarchy can be defined explicitly separate from the naming, there is
no fundamental objection to merging the hierarchical apache policy.  
Language support for such hierarchy definition needs to be done.

Discussion then moved on to improving the security of the policy.  Dan
argued that we need to move away from high level interfaces in
reference policy because they foster poor policy writing - users will
always pick the most abstract interface that meets their needs, and
thus the most permissive.  When users had to always write policy
manually, such high level interfaces were required, but with tools
like SEPolgen that can generate interface calls based on need and
loadable module support, we can migrate back to using the lowest level
interfaces and building up from the bottom.  Dan was also concerned
that the hierarchical type system would lead to misuse of the abstract
container types by users in the same manner.  We need to ensure that
reference policy is providing the right set of primitive interfaces
and that tools favor least privilege.  Dan suggested that we need some
lower level primitives than apache_template and user_template.  Dan
also argued that we can begin tightening reference policy
significantly since users now have the tools they need to generate
their own local policy easily, and get the system into a
secure-by-default state instead of shipping a relatively open policy
and requiring users to manually tighten it via booleans or other
mechanisms.

Plans for merging of strict and targeted policy were discussed, using
presence of the unconfined module as the selector.  unconfined_u, _r,
_t would be added by the module. A boolean/tunable may be needed for
other unconfined domains under targeted.  Handling of user home
directory labeling is still being worked out; the current idea is to
introduce a new user role and types for confined users under targeted
so that no change is required for existing unconfined users.

The last topic under the policy session was on how to improve policy
QA to minimize regressions.  A large part of the problem is simply
getting packagers to test with SELinux prior to releasing new or
updated packages.  It was noted that Red Hat has a QA process for RHEL
that checks for the presence of AVC messages, mislabeled files,
devices left in device_t, processes left in initrc_t, etc.  It would
be beneficial to have something similar for Fedora and other
distributions.


Userland Session
----------------
The afternoon began with a session on userland issues.  This session
included discussions on securing the desktop, improved userland
integration, userspace object managers, embedded support,
Multi-Category Security (MCS), user interface, and label translation
issues.

On the desktop front, XACE/XSELinux work is progressing well and on
target for upstreaming.  There is some uncertainty as to the optimal
window manager / desktop environment for continuing the work.
metacity / GNOME would be advantageous from a user base / technology
transfer point of view, but there are concerns with the size,
complexity, level of interactions among components, and vibrancy of
the development community (seemingly little activity on public lists).
Dan Walsh recommended talking to the head of the desktop team at Red
Hat, and will provide a POC to Eamon and Jim.  With continued
migration over to D-BUS, things should be well positioned for SELinux
to control.

Another concern for the desktop work is the lack of robust error
handling in X clients, primarily due to Xlib.  As a result, permission
denials have destructive effects on applications.

Handling cut-and-paste is still planned, but there are some problems
with the existing mechanism, and a number of applications implement
their own custom mechanisms for cut-and-paste that might also need to
be addressed.  Some in the X community have proposed starting over
fresh with a new approach to cut-and-paste functionality.

Related to the desktop, Karl mentioned the ConsoleKit and PolicyKit
work on freedesktop.  They are creating their own infrastructure to
support simple policies over actions like the ability to mount usb
drives.  Karl has tried to encourage them to leverage SELinux, but the
problem is that they need to support some form of access control on
all distributions, so they can't bind to SELinux alone.  We need a
LSM-like framework for ConsoleKit and/or PolicyKit to enable them to
achieve their goals (e.g. via an ACL module) without precluding proper
integration with SELinux (e.g. via a Flask/SELinux module).  Eamon and
Jim will try to talk with them further, although they can't scale to
handle all such applications.

It was also discussed whether something like the userspace security
server could enable broader use of SELinux access controls in
userspace without requiring full use of SELinux underneath.  However,
one would still need some underlying support for e.g. getpeercon
functionality, and one would still need SELinux policy and tools for
the application policies, so it isn't clear that such an approach is
useful.

Discussion then turned to userspace object managers, in particular the
SEPostgreSQL work by KaiGai Kohei.  KaiGai discussed issues he had
encountered in his work, such as the need to create a custom userspace
AVC for performance reasons (avoid indirection through AVC SID table
when the object manager needs to directly deal with contexts e.g. for
persistent labeling), to enable sharing of the AVC (via shared memory)
and the netlink thread among all PostgreSQL instances.  He also
discussed the need to deal with contexts invalidated by a policy
reload, as the userspace AVC presently has no way to detect such
contexts easily (security_compute_av just returns EINVAL) or to remap
them to an unlabeled context (as the kernel does).  It was agreed that
the userspace AVC in libselinux should be extended to better support
such functionality, and discussion will follow up on the list.

KaiGai still plans to work on converting to dynamic lookup of classes
and permissions for SEPostgreSQL, using the libselinux interfaces that
presently just use the generated tables internally.  The file format
issues were also discussed, but James Antill of Red Hat noted that
PostgreSQL file format changes are not uncommon and are not a
fundamental obstacle.

Next KaiGai presented work done by JSELUG on SEBusybox and SEDiet.
The SEBusybox work is proceeding well.  There was a proposed solution
to busybox domain transitions using dynamic context transitions, but
this approach has been discarded in favor of the wrapper binary or
decomposition approach due to its lack of real separation.

SEDiet is a new activity by JSELUG to work on reducing the resource
requirements of SELinux to facilitate embedded use.  libsepol and
policy are of particular concern.  They have some patches to reduce
the need for libsepol, which they should submit for discussion on
list.  One point of uncertainty was what was meant by removing
libsepol, as libsepol (or some subset of it) is required for loading
policy, and if using shared libraries, it shouldn't require more than
one instance of the library code.  Karl also noted that libsepol is
expected to get smaller through the new policy representation.  It is
also likely that libsepol can be reduced through eliminating legacy
functionality (e.g. see prior RFC on Dropping setlocaldefs support
from list), although that raises a question for the embedded SELinux
community as to whether they still need such support for handling
local booleans without needing libsemanage.  Discussion should follow
up on list.

The SEDiet effort also proposed a couple ways of reducing policy size,
both of which leveraged greater use of type attributes.  The first
approach (aggregation of macros) replaced multiple macro calls with a
series of typeattribute declarations followed by a single macro call
on the attribute.  The preferred approach there is to instead perform
the typeattribute statement in the macro/interface, and continue to
call the macro/interface on each type in the policy.  Such an approach
has already been leveraged in refpolicy for unconfined and could be
applied to other frequently used interfaces, such as the one for using
shared libraries.

The second approach (replacing allow rules with typeattributes)
proposed converting series of allow rules with the same accesses to a
series of typeattribute statements with a single allow rule, possibly
using a tool that would analyze and rewrite binary policy
automatically.  The consensus was that we should instead focus on
applying such improvements at the source level in reference policy,
except possibly for certain specialized optimizations that cannot be
done effectively in the sources, such as optimization of allow rules
with type set exclusions (e.g. { a -b -c }) and rearranging the types
to put the most frequently used ones near the beginning in an effort
to shrink the ebitmaps in the binary representation.

There are also a number of improvements that can still be applied to
libsemanage for space optimization, such as removing files after
installation and incorporating bzip2 support.  These have been
discussed on list but need to be brought to completion.

Discussion then moved onto Multi-Category Security (MCS).  Points of
agreement here include the desire to improve general SELinux userland
integration, make TE more accessible and usable to end users, and keep
the MLS engine viable for its user community.  Whether or not MCS will
or will not ultimately prove useful remains uncertain at this point,
but we are unlikely to know for sure until we have greater userland
integration.  Hence, it was suggested that we leave MCS intact,
continue to work toward better SELinux userland integration (in
general, not limited to MCS), and let the users decide.  A concern was
raised however about a lack of a common user experience for SELinux
since not all distributions enable the MLS engine or use MCS.  On the
one hand, this helps ensure that both MLS and non-MLS code paths are
being tested by users, but on the other hand, it yields a different
user interface, could create confusion, and could yield applications
that work in one environment but not another.  One option here would
be to take the next logical step for the MLS engine, having already
moved from a compile-time option to a runtime option, and make it
always enabled in SELinux

It was also suggested that MCS integration would serve as a proof of
concept for integration for MLS later (although there are issues with
such an approach, particularly in the discretionary MCS model, as what
works for MCS may very well break under MLS) and as a stepping stone
to greater functionality.  Some believe that MLS/MCS labels are
inherently more understandable to end users and transferable across
systems than TE types, while others believe that TE types can and
should be made understandable and transferable.

Related to this discussion, it was noted that the user interface
necessarily exposes policy-specific knowledge, such as what types mean
(e.g. httpd_sys_content_t).  We need tools and conventions for how a
tool or user can find out what types are accessible, what they mean,
etc.  Discussion also touched on the abstract label translation work
prototyped at Tresys for crossing administrative domains, and on the
need for a policy-driven translation service for SELinux, used by
everything that imports or exports labeled data.


Networking Session
------------------
The last session focused on networking issues.  This session
included discussions on improving the labeled networking support
and enabling use of SECMARK.

The first topic was labeled networking improvements.  These fell into
two categories: labeling of network buffers over loopback, and
handling packet forwarding.  On loopback, the basic need is to
propagate the security label with the sk_buff.  In CIPSO, this is
effectively faked by putting the label in the payload/data, but the
same approach doesn't work for labeled IPSEC.  Attempts were made to
enable labeled IPSEC over loopback, but various problems arose,
including with the IKE daemon.  Paul Moore suggested adding code in
the loopback driver to add another pseudo header on top of the
ethernet header to convey the information.  Pete suggested creating a
fake IP security option for loopback.  James Morris suggested
hijacking the MAC address.  Paul Moore will follow up.

For forwarding, Paul Moore suggested introducing a mechanism that
would be exclusive of SECMARK, using preroute, postroute, and
forwarding hooks.  The forwarding hook can look at the label on the
packet and should know where it is going, so it should be able to
apply a check at that time.

On enabling use of SECMARK, a number of concerns were raised with the
usability of SECMARK today, including impact on users who disable
iptables, bad interactions with management tools and user
customizations, understandability, synchronization of updates with
policy, and possible performance implications.  Red Hat would like a
boolean for every domain to switch between allowing all network
traffic and only allowing secmark-labeled traffic, although there was
some question as to whether that was truly desirable vs. the existing
compat_net global.  netfilter_contexts is presently built from
refpolicy and shipped in policy packages (.pp files), including
libsemanage support, yet completely unused today.  The short term plan
is to stop generating and shipping netfilter_contexts (possibly
deprecating it and removing it altogether if it cannot be integrated)
and simply allow users who wish to use secmark to manually enable it
and manage it using the usual iptables tools.  James Morris will follow up
on list with some ideas for enabling more effective use of secmark.

---<end>---

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
