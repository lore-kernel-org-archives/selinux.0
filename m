Subject: Re: file context ordering
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
References: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 08:44:18 -0400
Message-Id: <1122641058.6573.86.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-28 at 15:16 -0400, Christopher J. PeBenito wrote:
> One of the problems we've come against with reference policy (also in
> loadable modules) is the fact that the file context specifications are
> not ordered correctly, since the system file_contexts are taken from the
> modules and concatenated in an arbitrary order.  The matchpathcon code
> finds a match by going through all of the specs, and the last one that
> is matched is used.

To be precise, matchpathcon searches the specs in reverse order and
stops as soon as it finds a matching one.  And matchpathcon_filespec_add
uses the ordering to choose which spec to apply when multiple hard links
to an inode match conflicting specifications.

> There is a little sorting in matchpathcon, to push the specs with
> regular expressions to the top and explicit matches (those without
> regular expressions) to the bottom.  This has worked for the current
> policy since the specs in file_contexts/program/*.fc are generally
> specific matches and types.fc has always been at the top.  Types.fc has
> most of the very unspecific regular expressions, and is hand ordered.
> With reference policy, all of these specs are split up into their
> respective modules, so there is no ordering of file contexts, except
> within a module.

So we need an explicit ordering notation in the file_contexts file?  An
optional field specifying an ordering value, so that they can still be
ordered relative to one another even when they are in separate modules.

> To try to fix this we looked for regular expression sorting algorithms,
> but pretty much came up empty.  So we wrote support/fc_sort.c to do a
> stable sort (merge sort) with this comparison function:
> 
> 1. does one have a meta chars and the other not
> 2. length of the spec up to the first meta char
> 3. length of the entire spec
> 4. does one have a specific file type (--, -d, etc.) and the other not

Back when NAI looked into modifying setfiles originally to sort the .fc
entries, I had looked briefly into techniques for computing the
generality of a given pathname regex as a way of ordering them, but they
didn't want to pursue that approach due to time limitations and concerns
about complexity and ambiguity.  I have that email somewhere if you want
me to dig it out.

> This still does not end up being perfect, since we have specs that are
> of about the same specificity, and end up being in a different order
> then the current fc.  For example, these two specs end up being in the
> opposite order that they are in the NSA example policy:
> 
> /usr(/.*)?/bin(/.*)?        system_u:object_r:bin_t
> /usr(/.*)?/lib(64)?(/.*)?   system_u:object_r:lib_t
> 
> So this results in a handful of mislabeled files
> (think /usr/lib/foo/bin/*).
> 
> What are your thoughts on how to fix this?

The simplest approach would seem to just be:
- introduce an optional ordering value field so that the policy writer
can explicitly order entries relative to each other even when they are
in separate modules (but this naturally has issues when different people
are writing different modules without knowing exactly what is in the
other modules),
- have matchpathcon check for multiple matching specifications with the
same ordering value (whether explicitly specified or implicitly
determined using your algorithm) and issue warnings in those cases so
that we get warnings on such ambiguity, just as it presently warns about
multiple hard links that match conflicting specifications.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
