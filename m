Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA10335
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 09:37:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA03645
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 13:37:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA03641
	for <selinux@tycho.nsa.gov>; Thu, 5 Apr 2001 13:37:31 GMT
Date: Thu, 5 Apr 2001 09:36:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Amon Ott <ao@rsbac.org>
cc: selinux@tycho.nsa.gov, rsbac@compuniverse.de
Subject: Re: Rule Set Based Access Control (RSBAC)
In-Reply-To: <01040509250501.00859@marvin>
Message-ID: <Pine.SOL.3.95.1010405083125.16334D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Ok, let's look at them one by one:

1) Privacy Model (PM)

Requirements (from your '98 NISS paper):
a) A user may only have access to personal data if this access is
necessary to perform his current task.

This can be specified in the RBAC/TE configuration by defining 
appropriate types for personal data and defining appropriate
roles/domains for users and tasks.

b) The user may only access data in controlled manner by performing
a certified transformation procedure for which the user's current
task is authorized.

This can be specified in the RBAC/TE configuration by binding
the domains that can access personal data to specific program
types, and only labeling certified transformation procedures
with those types.

c) The purpose of the user's task must correspond to the purpose
for which the personal data was obtained or there must be
consent by the data subjects.

This can be specified in the RBAC/TE configuration by encoding
the purpose in the domains and types and only granting access
when the purpose is consistent.  Consent can be expressed
by relabeling the personal data to a type that is consistent
with the desired purpose.

2) Malware Scan

As you admit in your model descriptions, this model is not really
an access control model.  We address the threat of malicious
software using access control, i.e. controlling the execution of software 
based on its label and automatically transitioning untrustworthy
software into less privileged domains.  This model seems out of place
with the rest of your models, and your web page notes that it is only
a working demonstration model.  Also, I would argue that
virus scanning is very poor in comparison to access control 
techniques for addressing malicious software.

3) Role Compatibility

I'm not sure what your objection is here, since RC seems mostly
isomorphic to Type Enforcement, with the substitution of roles for 
domains, weaker controls over role changes, and special cases
for inheritance.  Perhaps you mean the ability to authorize roles to
administer other roles in RC.  If so, then that is true - we 
haven't implemented such support in our TE implementation.
But I'm not sure about the safety properties of your model.
There has been published work in that area by Jonathan Tidswell and
also by Tim Fraser for allowing dynamic changes to DTE configurations
while ensuring that critical security properties are preserved.

4) Access Control Lists

SELinux provides support for flexible _mandatory_ access controls.
Administratively-defined ACLs can be more efficiently represented
and more easily managed using TE domains and types or RC
roles and types.  If you are talking about discretionary ACLs,
we view that as an orthogonal feature.

5) Mandatory Access Controls

You can express traditional MAC using an access matrix, so you
can represent it using TE, with domains defined to represent
clearances and types defined to represent classifications.  
We also provide a separate MLS policy module that is a "native"
implementation of traditional MAC.

6) File Flags

These flags can be represented in TE simply by defining types,
assigning those types to the desired files, and limiting permissions to 
those types appropriately.  Or, in RSBAC, you could achieve
the same effect using RC.

7) Auth

This module is just a support module for your other modules.  
The SELinux policy configuration allows boolean constraints to
be imposed on permissions, and these constraints are used
in the example configuration to limit the ability to change our 
user identity attribute to authorized domains.  The constraints
can be used with greater precision if desired, e.g. specifying
that a particular domain can only change identity to a specific
set of user identities.

8) Functional Control

You agreed that TE can represent this model.

9) Security Information Modification

You agreed that TE can represent this model.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
