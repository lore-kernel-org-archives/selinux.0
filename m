Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA25037
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 10:34:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA20192
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 15:30:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA20188
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 15:30:48 GMT
Message-Id: <200302251541.KAA15178@moss-shockers.ncsc.mil>
Date: Tue, 25 Feb 2003 10:41:35 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Core policy
To: selinux@tycho.nsa.gov, wsalamon@tislabs.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Wayne Salamon wrote:
> The use of macros has grown to be a large problem. The current policy makes 
use
> of macros that call other macros which call macros. Some macros should be
> eliminated; every_domain, every_test_domain for example. Others should be
> pared down to least privilege; the xx_file_perms and xx_dir_perms for example.
> The use of parameterized macros makes it very difficult to analyze the policy
> source files. Also, there are several instances of rules being duplicated
> in the generated policy due to macro usage.

In addition to the problem of overly permissive macros, there are also
a number of problems caused by the use of type attributes such as
'domain' and 'file_type' (as well as the other attributes like pidfile)
in allow rules.  Although there are legitimate cases where this is
appropriate (e.g. allowing init to kill all processes, allowing
setfiles to relabel all files), there is a tendency to misuse type
attributes that map to a very large set of domains/types in allow rules
that should only be applied to a more specific set.  This prevents
people from creating new domains or types that are rigorously isolated
from the rest of the system (unless they omit these attributes from
those domains or types, which then requires them to explicitly
enumerate the legitimate cases that are normally handled by those
attributes and causes problems with assertions that expect those
attributes to include certain functional classes of types).  It would
be helpful to audit the existing macros and domains for such rules and
to consider how we can refine them, e.g. defining new attributes for
more specific sets, explicitly enumerating the sets in certain cases,
eliminating the rule entirely if it isn't truly necessary.

With regard to macros, I think that they are helpful when they provide
a useful abstraction and are carefully limited to that abstraction
(i.e. no granting of permissions only weakly related to that
abstraction).  For example, domain_auto_trans and file_type_auto_trans
provide useful abstractions of the higher level concepts of domain
transitions and file type transitions, although we should audit them to
ensure that they are not being overly permissive.  They would actually
have been incorporated into the base language as primitives except for
the fact that there is some potential variance in the specific set of
permissions that you may want to grant in certain cases (the macros
merely express the common case).  In contrast, every_domain does not
provide any useful abstraction and merely conceals many permissions.
Some of its finer-grained macros might be ok (e.g.
general_domain_access) while others need to be split up further or
eliminated entirely.  Likewise, can_exec_any should likely be
eliminated entirely.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
