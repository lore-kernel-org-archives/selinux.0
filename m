Date: Tue, 4 Jun 2002 11:24:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: =?us-ascii?Q?Vanuxem_gregory?= <gvanuxem@club-internet.fr>
cc: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: MLS changes
In-Reply-To: <ADEEIKPBIEHIINPOFGAOIEEACDAA.gvanuxem@club-internet.fr>
Message-ID: <Pine.GSO.4.33.0206041100040.3949-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 4 Jun 2002, Vanuxem gregory wrote:

> What are, briefly, the changes in MLS code	???
>
> I tried it and I had to change a lot of
> permissions !!!

We added support for identifying specific TE domains as MLS trusted
readers or writers (i.e. they can override the normal MLS restrictions on
reading or writing) and for identifying specific TE types as MLS trusted
objects (i.e. object types that can be accessed without MLS
restrictions, e.g. /dev/null, /dev/tty, /dev/zero).  In some cases, a
domain (e.g. login's domain) may also be marked as a MLS trusted object to
permit file descriptors opened by the domain to be inherited and used by
processes of other levels (e.g. user shells).  Naturally, the TE policy
still controls these domains and types, so it can be used to confine these
MLS trusted subjects to accessing certain types and to further restrict
access by subjects to the MLS trusted object types.  Using TE to support
MLS trusted subjects and to confine such subjects is an old concept, and
was present in varying forms in the predecessors of SELinux.  A comparison
of this approach with using POSIX.1e capabilities can be found in
http://www.securecomputing.com/pdf/secureos.pdf.

We also replaced the conditional code in libsecure with a runtime test for
the presence of the MLS policy in the running kernel, so that it is no
longer necessary to use a different libsecure with the MLS-enabled kernel.

The MLS option is still marked experimental, and we still don't recommend
it except for experimentation purposes, as noted in the README.MLS file.
Some tasks that need to be performed to provide better MLS support
include:
1) A newlevel program and domain similar to newrole needs to be created
for level changes within a session.  This should be straightforward.
2) A more detailed analysis of the mapping from the SELinux permissions to
MLS information flows needs to be performed.
3) The policy configuration needs further work in identifying domains
and types that should be marked as MLS trusted readers, writers or
objects.

The more difficult problem is dealing with usage issues when the MLS
policy is enabled, since a typical Linux environment isn't oriented toward
MLS-style restrictions.  We also don't have any support for multi-level
directories, and LSM doesn't provide any direct support for such
mechanisms.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com








--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
