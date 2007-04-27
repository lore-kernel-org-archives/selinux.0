Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RJF4XY002150
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 15:15:04 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3RJF4Kw026047
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 19:15:04 GMT
Subject: [RFC] Policy Representation Overview
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 19:14:27 +0000
Message-Id: <1177701267.3570.63.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is an overview of the new policy representation [1].  It includes
much of the initial design as we understand it, plus a few
modifications.  The significant differences are:

1. A single symbol table at the root node of the abstract syntax tree,
rather than a symbol table per block.

2. The distinction between types and attributes.  The two implement the
'Typeset Object' interface, but are not subclasses to each other.

3. The distinction of 'policy statements'.  Examples are 'typeattribute'
and 'typealias'.

Here are the reasons for these three changes:

1. A single symbol table allows for easier name symbol resolution.
Consider if one optional block defines a symbol that another optional
block uses.  With a single symbol table, the latter optional only need
to search the top-most, authoritative symbol table for the symbol's
existence.  Otherwise it would need to recurse into every single block
to find the symbol as that the top-most did not define it.

2. Although types and attributes may be used interchangably within AV
rules, they are not valid tokens in many other parts of a policy.  For
example, the default of a 'type_transition' must be a type, not an
attribute.  Likewise, the one cannot assign an attribute to a type
within 'typeattribute'; the operation is really adding the type to an
attribute's type list.

3. The inclusion of the statements simplify the process of linking in
modules.  Because modules can have typeattribute statements, it is
necessary to append a type to an attribute's type list.  It is possible
that either the type or attribute is defined in the module; thus it is
necessary to defer resolving the 'typeattribute' until after symbols
have been linked.

[1] http://oss.tresys.com/projects/setools/chrome/site/policy-rep/overview.pdf

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
