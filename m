Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA16888
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 05:51:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA25015
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 09:51:01 GMT
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com [194.25.134.17])
	by jazzband.ncsc.mil  with ESMTP id JAA25011
	for <selinux@tycho.nsa.gov>; Fri, 6 Apr 2001 09:51:00 GMT
From: Amon Ott <ao@rsbac.org>
To: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
Date: Fri, 6 Apr 2001 08:48:39 +0200
Content-Type: text/plain
References: <Pine.SOL.3.95.1010405083125.16334D-100000@clipper.gw.tislabs.com>
In-Reply-To: <Pine.SOL.3.95.1010405083125.16334D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <01040611503700.00863@marvin>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Don, 05 Apr 2001 Stephen Smalley wrote:
> Ok, let's look at them one by one:

Here we come to argumenting. I will give you some more documented restrictions
and some examples for these models.

> 1) Privacy Model (PM)
> 
> Requirements (from your '98 NISS paper):
> a) A user may only have access to personal data if this access is
> necessary to perform his current task.
> 
> This can be specified in the RBAC/TE configuration by defining 
> appropriate types for personal data and defining appropriate
> roles/domains for users and tasks.

The definition and assignment of roles and types must be done by two PM
roles working together, and that within a given time limit. These roles are
first Data Protection Officer and second Security Manager.

The four-eyes principle is an important base concept in the whole model.

> b) The user may only access data in controlled manner by performing
> a certified transformation procedure for which the user's current
> task is authorized.
> 
> This can be specified in the RBAC/TE configuration by binding
> the domains that can access personal data to specific program
> types, and only labeling certified transformation procedures
> with those types.

The TP definition and labelling must also be done by two different roles within
a given time limit. This time the roles are TP Manager and Security Officer.

This further restricts the real access to personal data to a six-eyes process,
and everything within time limits measured in seconds.

> c) The purpose of the user's task must correspond to the purpose
> for which the personal data was obtained or there must be
> consent by the data subjects.
> 
> This can be specified in the RBAC/TE configuration by encoding
> the purpose in the domains and types and only granting access
> when the purpose is consistent.  Consent can be expressed
> by relabeling the personal data to a type that is consistent
> with the desired purpose.

This might be possible. However, we are already far away from the term 'easy'.
And again, definition and assignment of purposes and tasks need two roles
working together within a time limit.

BTW: Every user can only have one of these roles, or general user or system
admin. This additionally enforces the separation.

There are some more aspects, like control of information flow, which we could
add to this discussion...

> 2) Malware Scan
> 
> As you admit in your model descriptions, this model is not really
> an access control model.  We address the threat of malicious
> software using access control, i.e. controlling the execution of software 
> based on its label and automatically transitioning untrustworthy
> software into less privileged domains.  This model seems out of place
> with the rest of your models, and your web page notes that it is only
> a working demonstration model.  Also, I would argue that
> virus scanning is very poor in comparison to access control 
> techniques for addressing malicious software.

You were talking about 'most RSBAC modules'. No doubt access control can be
effectively used to avoid changes to programs or execution of uncontrolled
code. But that was not the question here.

What, if users must for some reasons be allowed to create or modify
executables, e.g. software developers? How will you know, if the modification
on behalf of the user was done by malicious code without consent?

How about e.g. text documents containing macros? Web pages with Java applets?
Perl, Python, bash scripts, where the execution is done by an interpreter, and
all you see is a read-open?

Still, we can from now on restrict our discussion to access control in the
traditional sense, if you want. I agree that MS is not finished, but it mostly
lacks a full set of scan strings. The model itself is complete.

> 3) Role Compatibility
> 
> I'm not sure what your objection is here, since RC seems mostly
> isomorphic to Type Enforcement, with the substitution of roles for 
> domains, weaker controls over role changes, and special cases
> for inheritance.  Perhaps you mean the ability to authorize roles to
> administer other roles in RC.  If so, then that is true - we 
> haven't implemented such support in our TE implementation.
> But I'm not sure about the safety properties of your model.

RC's strong administration settings are sure my main objection. It enables
separate administration areas, which can be e.g. used to effectively create
separate, but possibly overlapping work groups.

One example:
Just think of two workgroups W1 and W2. Each work group has a manager role, M1
and M2, and several member roles, let's call them R1a, R1b and R2a, R2b.

It is easy to setup an environment with RC, where
- both M1 and M2 can create users and add them to one of their workgroup roles
   (optionally, the creation could be delegated to another role to separate
these tasks)
- none of them can assign users her own manager role
- none of them can change their own role
- none of them can access or assign the other one's roles
- none of them can assign her own managed roles to a user, who already has one
of the other one's roles
- no other role can do anything of the above items
- none of them can change access rights of one of their roles.
- this setup can be forever fixed - at least, unless the system is restarted
with inactive RC

> There has been published work in that area by Jonathan Tidswell and
> also by Tim Fraser for allowing dynamic changes to DTE configurations
> while ensuring that critical security properties are preserved.

I will sure some day soon work through some of these papers. You probably know
the problem of limited time as well as I do.

> 4) Access Control Lists
> 
> SELinux provides support for flexible _mandatory_ access controls.
> Administratively-defined ACLs can be more efficiently represented
> and more easily managed using TE domains and types or RC
> roles and types.  If you are talking about discretionary ACLs,
> we view that as an orthogonal feature.

ACLs can, but need not be discretionary. It depends on the Access Control and
Supervisor rights. They make it easy to have independent administrators for
separate filesystem areas - without any access for the other administrators.

The ACl inheritance scheme with masks and the accumulation of rights from user,
several group and role entries are sure difficult to emulate with roles and
types - you would need a real lot of them.

Again, one important focus lies on separation of duties. With ACL model, every
user can maintain her own set of user groups, which can optionally be used by
herself or other users for administration. E.g., one user maintains all user
groups, and another grants rights for these groups. None can work alone.

One example:
In a company (or government agency) you have a secret workgroup for internal
investigation. To avoid social problems for workgroup members, only the
workgroup leader knows who is in the group. The workgroup has its own
filesystem area on the company server.

ACL setup: Workgroup leader L defines a private user group. The workgroup's
security officer (possibly as member of another private group) has access
control to the secret area and defines appropiate rights for this group.

Now L can add or remove users to or from the private group, without anybody
else's knowledge. L cannot grant individual access to objects.

What if L leaves the company? L transfers the private group to her successor,
who is now the only one with access to the member list.

> 5) Mandatory Access Controls
> 
> You can express traditional MAC using an access matrix, so you
> can represent it using TE, with domains defined to represent
> clearances and types defined to represent classifications.  
> We also provide a separate MLS policy module that is a "native"
> implementation of traditional MAC.

How dows TE enforce *-property? How many roles and types would TE need to
represent all permutations of 253 levels and 64 compartments?
  
> 6) File Flags
> 
> These flags can be represented in TE simply by defining types,
> assigning those types to the desired files, and limiting permissions to 
> those types appropriately.  Or, in RSBAC, you could achieve
> the same effect using RC.

There are some special effects, e.g. search_only is only valid for directories,
write_only only for files and fifos. You can certainly define a dir and file
type for each permutation of FF flags and use all these types. The definition
is probably also quite easy, and with proper type names even usable.
Inheritance can be emulated by changing the type labels of all affected objects.

So I admit that you can emulate this model, but again not easily.
     
> 7) Auth
> 
> This module is just a support module for your other modules.  
> The SELinux policy configuration allows boolean constraints to
> be imposed on permissions, and these constraints are used
> in the example configuration to limit the ability to change our 
> user identity attribute to authorized domains.  The constraints
> can be used with greater precision if desired, e.g. specifying
> that a particular domain can only change identity to a specific
> set of user identities.

Do you also have the concept of only certain programs or processes being able
to extend the set of accessible user ids, e.g. to enforce proper authentication
by only a privileged set of programs (AUTH attribute auth_may_set_cap)?
   

Additionally you can, as intended, use ACL model as an extension of RC model
by using role subjects in the ACL entries.

You did not claim to be able to emulate a combination of RSBAC models with TE,
but combinations are part of the RSBAC framework design.

Amon.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
