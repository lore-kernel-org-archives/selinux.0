Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA02804
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 16:54:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA27737
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 20:53:03 GMT
Received: from smtpproxy1.mitre.org (smtpproxy1.mitre.org [192.160.51.75])
        by jazzband.ncsc.mil  with ESMTP id UAA27733 for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 20:53:02 GMT
Date: Tue, 21 May 2002 16:54:16 -0400
From: Amy L Herzog <aherzog@mitre.org>
To: Trent Jaeger <jaegert@us.ibm.com>
Cc: Frank Mayer <mayerf@tresys.com>, selinux@tycho.nsa.gov,
        Ian Sollars <ian.sollars@gmx.net>
Subject: Re: Policy creation RFC
Message-ID: <20020521165416.M15398@golconda.mitre.org>
References: <OF8E41A9E0.D4ECB574-ON85256BC0.00522D85@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF8E41A9E0.D4ECB574-ON85256BC0.00522D85@us.ibm.com>; from jaegert@us.ibm.com on Tue, May 21, 2002 at 01:56:51PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


We at MITRE have also been performing some policy analysis work,
though policy generation is still a future concern of ours. Like Frank
and Trent, we've chosen policy.conf as the basis for policy analysis
and feel that it is the appropriate level of abstraction for tool
compatibility.

One line of work parses the statements and deposits them in a
relational database; a variety of simple queries can then be answered
quickly. Another line of work requires more specialized data
structures.

We're implementing this second line of work right now, but here's a
rough idea of what we've done so far:

   - We developed and formalized a semantics for the policy language.

   - We formalized statements of security goals. 

   - We developed a decision method which, given a system
     configuration and a goal, will determine if the system enforces
     the goal. 

We formalized the security goals (integrity and confidentiality, of
various levels of complexity) as temporal logic statements; the
decision method as a relation coupled with requirements for truth; we
model the policy as a state-machine graph. We're in the process of
implementing a tool around a model checker to verify the presence (or
absence) of the requirements for a given system. 

This approach obviously does not create any policy; however, we hope
it will lead naturally to methods of policy creation. At the very
least, after heuristics were used to create a policy, this tool could
give you a definitive answer about what sorts of things the policy
actually achieves. We feel, however, that the use of policy.conf as
the official version of the policy is a good idea; the current system
of policy creation will not work for some. 

To answer one of Trent's points: 

Trent Jaeger wrote:

  > --- Analysis -- Several folks are looking at analyses of various kinds.
  > However, we are probably using concepts that are only slightly
  > different (probably could be built on the same base).  However, we
  > are all starting (and splitting-off) from a low-level.  This
  > argues for doing some work defining high-level semantic concepts,
  > but it is not in any single group's best interests.  We need some
  > good ideas here.


We are very concerned that the various groups attempting policy
analysis coordinate more, so that our tools will behave appropriately
when used together. To make this more possible, we're happy to share
our semantics with those who are interested. 

More thoughts?

-- 
Amy Herzog
Senior INFOSEC Engineer
The MITRE Corporation - G021
781.271.5271

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
