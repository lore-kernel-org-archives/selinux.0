Subject: Re: Security policy analysis - MITRE
To: SELinux@tycho.nsa.gov
Message-ID: <OF229C7F97.F61A66BF-ON85256AE2.005FF114@pok.ibm.com>
From: "Trent Jaeger" <jaegert@us.ibm.com>
Date: Thu, 11 Oct 2001 13:28:59 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[Sorry, to any who have received twice]

Hi,

We at IBM are also interested in LInux security policies and tools to
analyze them.  At present, we have a start on the latter, and are getting
oriented to work more specifically on the former.

In particular, we are interested in the managing the safety of an access
control policy and hoping that better safety management will lead to
simpler policies.

Basically, we use the current access control configuration to partition the
authorization space into: (1) that is known to be authorized; (2) that is
known to be precluded (e.g., by constraints or DTE assertions); and (3) the
remainder which is unknown with respect to safety.  While the system will
only permit accesses in the authorized space at any time, configuration
changes could alter this space and require more assertions to maintain
safety.   Eliminating the unknown space and keeping the number and
complexity of assertions small is key to keeping access control
configurations simple in our opinion.  Ideas like determining which rules
prevent a particular authorization would also we useful for us to identify
overlapping or subsumed assertions, as well as identiying the impact of
removing an assertion.

I realize that this description is a bit abstract, but I would appreciate
any comments.

Because we have a model for analysis that is different than the SELinux/DTE
environment, we are working on conversion between DTE and our analysis
model.  I guess that I would agree with Jon that another model for analysis
is likely to be different.  A library for reading DTE specs with hooks for
conversion into analysis models would be useful to us.

We are still in the process of such a conversion before we can actually
start to do analysis on DTE policies.

Regards,
Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
30 Saw Mill River Road
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595


---------------------- Forwarded by Antony Edwards/Watson/IBM on 10/10/2001
02:50 PM ---------------------------

Jon Crowley <jonathan@mitre.org>@tycho.nsa.gov on 10/10/2001 01:02:20 PM

Sent by:  owner-selinux@tycho.nsa.gov


To:   Stephen Smalley <sds@tislabs.com>
cc:   Frank Mayer <mayerf@tresys.com>, SELinux@tycho.nsa.gov,
      slinux@scotty.mitre.org
Subject:  Re: Security policy analysis



> Some people at MITRE have been working on similar policy analysis tools.


Yes, MITRE is developing tools for policy analysis.

We intend on developing functions to do the following first:

1. List the process transitions for type "T"
2. List the file transitions for type "T"
3. List the type enforcement entries for type "T"
4. List all roles for type "T"
5. List all roles to which role "R" can transition
6. List all roles that can transition to role "R"
7. List all types with permission "P" in class "C" to type "T"
8. List all types with attribute "A".
9. List contexts with attribute "A".
10. Which policy rule is blocking a particular permission "P" between
two contexts "C1" and "C2"?
11. Trace how a process in context C1 gains access (as a set of one or
more permissions) to an object with context C2.
12. Which file does rule "R" come from? (And where in that file is it?)
13. List all equivalent types in the policy. Already done in
checkpolicy.c, but may need refinement.
14. Show the difference(s) between type "T1" and "T2" in the policy.
15. Identify types that are within some "delta" of each other in the
policy.  Useful for identifying possibly redundant types.
16. List all process types reachable from type "T" and show the path to
them.
17. List all object types to which data of type "T" can flow and show
the path to them.
18. Graph (or describe) all paths by which data might flow from type
"T1" to type "T2"

For testing purposes, we implemented some of these functions (1-6, 7
under construction) as small, individual programs borrowing code from
checkpolicy sources.  Eventually we would like to combine these programs
into one tool that provides policy analysis capabilities. Because we see
the above list as growing and want it to be as flexible as possible to
be able to handle tailored requests from the policy administrator, we
plan on implementing an interactive query language front-end to this
tool, as Steve suggested.

Steve also suggested incorporating these functions into checkpolicy.
With the interactive query front-end, this would become the policy
analysis tool.  However, our take on checkpolicy is that it is intended
to compile policies and to assist in debugging specific to security
identifiers.  We are thinking it might be cleaner to keep policy
analysis tools separate from a policy compiling/debugging tool.  Though
perhaps we have the wrong take on checkpolicy.  More thoughts on this?

The problem with building a separate tool is that both tools will share
some of the same code.  Does it makes sense to pull out commonly-used
code in checkpolicy, specifically the code that reads in the binary and
text versions of the policy into data structures, and put this code into
some sort of library?  It seems this code may be useful to future
applications, and it would be easier to maintain and more accessible if
it was in a library.

Jon Crowley
MITRE Corporation

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.









--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
