Message-Id: <200406022032.i52KWuSf003348@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Fedora SELinux support list for users & developers.'" <fedora-selinux-list@redhat.com>
Subject: Summary of Informal SELinux Meeting on May 6, 2004
Date: Wed, 2 Jun 2004 16:33:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An informal meeting of SELinux developers was held on May 6, 2004 at Tresys
Technology in Columbia, Maryland. Below are some notes from that meeting.

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134






Summary of Informal SELinux Meeting 
Columbia, Maryland, USA, 6 May, 2004

An informal meeting involving a group of some of the key contributors to the
development of SELinux was held on May 6, 2004, at Tresys Technology, in
Columbia, Maryland, USA. A small gathering was initially prompted by Russell
Coker's visit to the Washington, D.C. area, but evolved into a larger
informal meeting. The purpose of the meeting was to have informal, real-time
discussions about the current status, challenges, and future of SELinux.
	
ATTENDANCE

Joshua Brindle		Hardened Gentoo
David Caplan		Tresys Technology
Jim Carter			National Security Agency
Russell Coker		Red Hat
James Griffin
Howard Holm			National Security Agency
Jeff Johnson		Red Hat
Peter Loscocco		National Security Agency
Karl MacMillan		Tresys Technology
Frank Mayer			Tresys Technology
Stephen Smalley		National Security Agency
Eamon Walsh			National Security Agency

Via conference call:
James Morris		Red Hat
Dan Walsh			Red Hat

WORKSHOP

There was discussion of whether there was a need for establishing a regular
forum, similar in nature to this meeting, aimed at examining the state of
SELinux development. Specific issues discussed included the target audience,
duration, scheduling, and potential sponsorship of the meetings. Tresys
volunteered to organize an initial meeting in the Baltimore/Washington area
some time in the fall. It was assumed that this area would accommodate the
largest likely user participation. Additionally, there was some discussion
as to whether the audience should be limited to core developers or extend to
a more general population. The consensus was to model it after the Ottawa
Linux kernel conference, which involves an initial meeting of core
contributors followed by a more general symposium. The possibility of adding
tutorials to this structure was also discussed. Finally, corporate
sponsorship and government participation will be investigated.

FEDORA CORE

A brief update on the status of SELinux and Fedora Core 2 was given. The
need for transparency and limited user interaction with SELinux was
mentioned as a motivating requirement for much of the work that Red Hat has
done. The discussion quickly branched off into details about the policy and
policy management as Russell mentioned specific challenges Red Hat had
encountered with their integration of SELinux.

POLICY

The current state of the public "default" policies was discussed. The set of
default policies includes the original example base policy distributed by
the NSA, the Fedora core policy, and the recently released targeted (or
relaxed) policy. The new targeted policy was written with the aim of
isolating a limited set of services or daemons and allowing the rest of the
system to be relatively unaffected by the SELinux policy. The purpose of
this is to provide an example policy that the general Linux population will
be comfortable with (i.e., one that will minimally interfere with their
accustomed operations) yet would show how SELinux can provide a level of
protection from a service that at some time may be compromised. It makes the
initial policy easier to analyze and provides groundwork for slowly
introducing increased protection from the policy.

Providing the targeted policy as the default might help SELinux gain
acceptance, but it is not without potential drawbacks. A possible con to
this strategy is that it may make application developers less likely to
alter their software to work with SELinux or, where appropriate, be aware of
SELinux. This goes against the strong objective to have application
developers accept and integrate SELinux controls. Additionally, the targeted
policy makes only limited use of the user and role features of SELinux
because all users are placed in the same context. It is not clear whether
this exposes an area of the policy language that needs additional thought.

The desirability of modifying applications to be SELinux aware was
discussed. A goal of SELinux is to allow the use of unmodified applications.
Certain core system utilities need to be modified to be aware of SELinux
(init for example), but in general it is possible to create policies that
work with unmodified applications. There was a general consensus that the
requirement to modify applications has been a limiting factor to the
acceptance of other operating systems with mandatory access controls. This
does not mean, however, that it is not desirable to make SELinux specific
modifications to certain trusted system services.

One example that was mentioned is that it is difficult to create optimal
policies for certain types of applications. In particular, the Samba daemon
needs the ability to access files with a wide variety of labels in order to
service the requests of different users. It is desirable, however, to have
SELinux limit the types of files that Samba will access on behalf of a
specific user. The standard practices for handling this situation, like
executing a separate Samba daemon for each user, will not work in this
circumstance because of some details of the SMB/CIFS protocol. It was argued
that Samba is a trusted application and it would be appropriate, therefore,
to allow it to enforce SELinux access decisions by becoming a user-space
object manager. See the "Policy Management" and "Security Enhanced X Status"
sections for more details about user-space object managers. The conditional
policy features were briefly discussed. It was suggested the conditional
policy features could be used to grant privileges to daemons only on
startup, similar to a setuid application dropping capabilities. Using the
fine-grained labeling of the boolean files in the selinuxfs it is possible
for an application to remove access privileges (through setting a boolean)
and not have sufficient access privileges to turn them on again. The policy
discussion ended with a consensus that it is a mistake to try to overreach
on our goals (and likely come up short) on the initial versions of SELinux
policies for mainstream users; instead, the initial goal should be to manage
expectations of the general community to gain acceptance of type enforcement
a little bit at a time.

POLICY MANAGEMENT

There was a lengthy discussion on how best to manage policy and the
associated file context information. It was clear from the discussion that
this is an area that has many unsolved challenges. Though no definitive
solutions were determined, several motivating requirements emerged from the
discussion and are detailed below.

Local customizations

One of the issues that has arisen as part of the Fedora Core 2 development
process is how to handle local customizations to the policy on upgrade.
Currently, user modified changes are overwritten by RPM on upgrade of the
policy unless they are marked noreplace in the rpm spec file (tunables.te
for example). Users must manually merge the changes from the update for
files marked noreplace that had local customizations. All of the other
customizations to the policy are lost on update. Gentoo handles this problem
by presenting the user with diffs for all changes to files in /etc. The
general consensus was that this is not an appropriate solution for the
target audience of Fedora Core, but no other solution emerged.

RPM Integration

There was a lengthy discussion of integration with RPM. RPM is seen as a
primary delivery mechanism for policy and file labels. Currently, RPM can
record a single label for each file in the package and sets that label at
installation time. The policy for each application is not contained with the
package that provides that application. Instead, the entire policy is
contained in a single RPM.

After the previous discussions on default policies, it was clear that RPM
needs to support multiple policies and that a single label per file is not
sufficient. Several people suggested that modifying RPM to support multiple
labels per file would solve this problem. Concerns were voiced about placing
multiple labels in each package, however. It was argued that this would
enlarge the package size, perhaps substantially, without solving the
underlying problem of supporting multiple, arbitrary policies. This problem
has some similarities to translation strings in that a potentially large
number of translations needs to be provided for each package, they are not
necessarily known at package creation time, and it is desirable to upgrade
the translations without changing the packages. The translations are
supported by allowing RPM to query an external translation database at
installation time. There was a consensus that a similar scheme should be
adopted by RPM for file labels.

Policy Packaging and Dependencies

There was some discussion about the way policy is currently associated with
packages and how the dependency issues are solved. Fedora Core 2 provides a
single package with the entire policy for the system. Hardened Gentoo
provides a separate package for the policy for each application. The policy
packages are automatically installed by marking them as dependencies of the
application packages. The Gentoo package management system has a complex
infrastructure for optional dependencies to allow the installation of
different dependent packages based on user settings or system properties
(architecture for example). These optional dependencies allow for
considerable flexibility when managing SELinux policy packages.

Binary Policy Modules

The current work by Tresys on developing binary policy modules was
discussed. This will allow for the management of policies without source,
provide infrastructure and language support for specifying and tracking
dependencies, and optionally manage file labeling on the installation and
removal of policy modules. Some of the expected benefits of this work would
be the looser coupling between portions of the policy and simplified policy
management. For example, adding a user to the policy currently requires a
full policy development environment including the source for the entire
policy. The binary policy modules would allow the addition of a user without
source or policy development tools.

The desire to protect certain application by creating a separate domain for
each user domain in a system was brought up. This is currently accomplished
using macros that will be unavailable in the binary policy modules. It
suggested that this could be solved using inheritance. It was agreed to
investigate these additional policy language semantics.

User-space Object Managers

The need for better support of user-space object managers was discussed (see
"Security Enhanced X Status" for more discussion). In particular, it was
suggested that it is desirable to provide a mechanism that allows the policy
for user-space object managers to be selectively separated from each other
and the kernel policy. This is access control for policy modification and
can be implemented through namespace separation and creating an object
abstraction of the policy. Tresys stated that they are starting a research
project on this topic which will result in a user-mode policy server based
on the binary policy module work.

SECURITY ENHANCED X STATUS

A summary of the work done by the NSA to adapt user space SELinux type
controls to X windows was presented. This work involved two main tasks:
creating a user-space access vector cache and implementing the object
classes and access control within X. The user-space access vector cache has
been completed and is available as part of the standard NSA distribution.
The implementation is a port of the kernel access vector cache and includes
support for flushing on policy reload. The user-space cache is notified of
the policy reloads through a netlink socket.

The changes required to implement access control for X include the creation
of eleven new object classes and modifications to the X server. The new
object classes closely mirror those described in the technical report
"Securing The X Window System With SELinux" by NAI labs. It was reported
that the X developers are enthusiastic about the SELinux work and have
accepted the changes to the X server in a branch of the upstream CVS
repository. See http://www.x.org for more information.

NFS

A report on the progress of integrating SELinux mechanisms into NFS version
3 by the NSA was given. The current implementation was described as
relatively simple and experimental. In particular, the implementation does
not address many issues and has several assumptions including:

	* the underlying security problems with NFS are not addressed,
	* a secure network is assumed,
	* the client and server must both have the same policy,
	* and the issues with revocation caused by NFS caching are not
	  addressed.

Despite these issues, it is possible to have SELinux access control enforced
on NFS mounted file systems. This is done by extending the NFS protocol to
handle extended attributes so that a client can retrieve the labels of files
of NFS file systems and extending the client to enforce access based on
those labels. Additionally, mount options were added to specify that these
features should be used.

The current implementation is for NFS version 3, but it is expected that in
the future work will be done on NFS version 4. It is not clear whether the
NFS version 3 implementation will be acceptable upstream, but it is hoped
that the future work on NFS version 4 will be. The NFS version 3 patches are
available from the NSA website (http://www.nsa.gov/selinux). Finally, it was
mentioned that the NFS work has exposed several bugs related to the labeling
of sockets created by the kernel. Patches for these problems exist and were
merged into the 2.6.6 kernel.

TRAINING AND DOCUMENTATION

It was reported that there has recently been a large amount of new interest
expressed from both the corporate and government side for training. Tresys
is in the process of refreshing their SELinux course material and will be
offering a new set of classes shortly. The NSA is also working on updating
past reference papers to reflect the more recent generation of SELinux.

ASSURANCE

Assurance was mentioned several times throughout the symposium. No SELinux
system has currently been Common Criteria evaluated at any EAL level, though
it is expected that one of the distributions that is currently seeking
certification will have a system certified that includes SELinux. SELinux
cannot be evaluated separately; only a complete system can be evaluated.

BUSINESS CASE FOR SELINUX

There was a discussion of strategies for making a case for the use of
SELinux to decision makers in organizations. It was argued that making the
case to managers can be different than making a case to front-line technical
people. It was suggested that the fundamental question that needs to be
answered for managers is how does the technology solve an important problem
that they have.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
