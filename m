Subject: Re: user guide draft: "SELinux Contexts and Attributes" review
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48BB93D2.8090909@redhat.com>
References: <48B4FA3E.3000602@redhat.com>
	 <1219844836.5708.92.camel@moss-spartans.epoch.ncsc.mil>
	 <48BB93D2.8090909@redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 02 Sep 2008 08:58:44 -0400
Message-Id: <1220360324.26711.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-09-01 at 17:03 +1000, Murray McAllister wrote:
> How about:
> 
> ...SELinux provides flexible MAC that supports a variety of different 
> security models. On Fedora 10, SELinux provides a combination of 
> role-based access control (RBAC), Type Enforcement® (TE), and 
> optionally, Multi-Level Security (MLS). Subjects and objects are labeled 
> with an SELinux context that contains additional information, such as an 
> SELinux user, role, and a type.

user, role, type, and optionally a level/range.

> How about "...role:type:sensitivity"?

:level or :range is more accurate than :sensitivity, as the sensitivity
is merely one component of the level/range.

> Output may differ from system to system. The Login Name column lists 
> Linux users, and the the SELinux User column lists which SELinux user is 
> mapped to which Linux user. For subjects, the SELinux user limits which 
> roles and levels are accessible. The last column, MLS/MCS Range, are 
> levels and categories that are used by Multi-Level Security (MLS) and 
> Mutli-Category Security (MCS). MLS and MCS levels and categories are 
> discussed briefly later.
> 
> Would removing "For subjects" from the 3rd sentence make it accurate?

No, the user<->role and user<->level restriction is only applied to
subjects.

> role:
> Part of SELinux is the Role Based Access Control (RBAC) security model. 
> The role is an attribute of RBAC. SELinux users are authorized for 
> roles, and roles are authorized for domain types. The role serves as an 
> intermediary between domains types and SELinux users. The roles that can 
> be entered determine which domain types can be entered - ultimately, 
> this controls which object types can be accessed. This helps reduce 
> vulnerability to privileged escalation attacks.

privilege escalation, not privileged escalation.

> This part is in progress. I do not understand the difference between 
> levels/categories and ranges. Can you recommend any papers or books on 
> this? This is what is there now, keeping in mind I don't understand:

MLS is a hierarchical model where you have a set of security levels that
are partially ordered, and those levels form a lattice.  There are
numerous descriptions of it, see for example:
http://www.cs.stthomas.edu/faculty/resmith/r/mls/index.html

In SELinux, the last component of the security context is a MLS range.
A MLS range takes the form of lowlevel-highlevel.  The degenerate case
is where the lowlevel equals the highlevel; in this case, we simply
write the level once.  Each level takes the form of
sensitivity:category-set.  If the category set is empty, then we simply
write the sensitivity.  The category-set takes the form of
category-1,category-2,....  If there are a set of contiguous categories
like c0,c1,c2,...,c1024 then this is written as c0.c1024 for
compactness.

The MLS range has two user-visible representations:
1) A human-readable string label, like "SystemLow-SystemHigh" or
"unclassified-top_secret:nato".  This is the form of the label produced
by mcstransd and displayed to the user.
2) The raw kernel security context format, like "s0-s15:c0.c1024".  The
user may also see this format if not using mcstransd or if mcstransd
lacks a translation for a given range.  The user can also provide a
label in this format directly if desired.

> The level is an attribute of MLS and Multi-Category Security (MCS). 
> There is a single sensitivity level, s0, which is the only sensitivity 
> level used.

The one-sensitivity limitation is only true of MCS, not MLS, and only
because MCS only uses the categories, not the sensitivity.  And while
MCS is limited to one sensitivity, it supports a large number of
categories (1024 in Fedora), and thus a large number of levels (where
level == combination of the one sensitivity s0 with a category set).

>  This level is used when running the SELinux MLS policy, but 
> not when running the SELinux targeted policy.

The level is used whenever MCS or MLS is enabled, as the targeted policy
in Fedora does enable MCS.

> > A process in one domain transitions to another domain by executing a new
> > program with the entrypoint type for the new domain.
> 
> How about:
> 
> A subject in one domain transitions to another domain by executing an 
> object that is labeled with a file type that has entrypoint permission 
> for the new domain. The entrypoint permission is used in SELinux policy, 
> and controls which domains an object can enter. The following example...

Not exactly:
1) A new domain has entrypoint permission to the file type, not the
other way around.
2) The entrypoint permission controls which programs can be used to
enter a domain, not the other way around.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
