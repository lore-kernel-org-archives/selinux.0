Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA26225
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 16:32:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA23953
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 20:31:32 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
        by jazzband.ncsc.mil  with ESMTP id UAA23949 for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 20:31:32 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "Ian Sollars" <ian.sollars@gmx.net>
Subject: RE: Policy creation RFC
Date: Mon, 20 May 2002 16:36:26 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIEELJKDAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4934.1021921674@www51.gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Interesting you raise this issue.  We've been thinking about this problem
for some time, and have actually done some preliminary design work on
something like a policy editor.  I know others are thinking about more
abstract policy languages too.  We've come to the conclusion that selinux
needs to have an official policy language at which point compatibility must
be preserved.  I believe that should the yacc/lex syntax/semantics defined
for policy.conf; i.e., a policy.conf file should be the abstraction level at
which we try to maintain compatibility, and one can create any tools they
want to create an adequate policy.conf.  I don't think we should restrict
ourselves to the conventions used in the current make process (e.g., m4
macros).

We're actually in the final phases of implementing a GUI-based "user
manager" (i.e., seuser) for selinux, which has proven non-trivial.  We've
had to use the full power of our apol analysis library to build adequate
controls in the tool.  This has led us to another conclusion; i.e.,
policy.conf should be installed (e.g., /etc/security/policy.conf) as the
official policy of the system (i.e., don't force one to have the make
directory on an installed system).  In this case, we're struggling with
"operationally dynamic" aspects of the policy (e.g., add users, change audit
setting), which I would expect to vary from system to system, rather than
the "organizationally static" policy aspects (e.g., the TE policy rules),
which I would expect to be more static and centrally controlled.

In our seuser tool, we found ourselves wishing we could directly change the
users section of an installed policy.conf, but instead, decided to support
re-making the policy using the make directory with the users file (for now)
to maintain capability with the current make process.  Long-term, that's not
a good plan for production system

After we release our seuser tool (in a couple of days), I'll make a specific
proposal about installing policy.conf as the official policy.

Frank


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
