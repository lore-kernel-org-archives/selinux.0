Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBAFBKRb028102
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 10:11:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBAFAYlU006462
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 15:10:35 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
	by jazzswing.ncsc.mil  with ESMTP id hBAFAYSX006459
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 15:10:34 GMT
Subject: Re: Information flow models
From: Karl MacMillan <kmacmillan@tresys.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <ogtu148yfom.fsf@divan.mitre.org>
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	 <1070906232.6729.53.camel@colossus.columbia.tresys.com>
	 <ogtu148yfom.fsf@divan.mitre.org>
Content-Type: text/plain
Message-Id: <1071069077.6729.108.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Wed, 10 Dec 2003 10:11:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-12-10 at 08:18, John D. Ramsdell wrote:

> I'm afraid I am unable to understand the model of information flow you
> describe.  I expected a permission would be a part of what is used to
> label either an edge or a node, but no such label appears.
> 

Permissions determine whether an edge exists. 

> How does your representation handle information flow caused by system
> calls that must meet the file setattr control requirement?
> 

All of this is explained in our documentation and can be explored by
using the tool. The quick answer is that we provide an editor that
allows you to map permissions on object classes to read, write, or no
flows. The MLS file is a good starting point, but our experience with
information flow analysis has shown that more flexibility is needed.

> Additionally, please expand on the discussion on transitivity.  I
> could not see why you changed away from nodes as types, and edges
> labeled with a control requirement.  What was the motivation for the
> change?
> 

To make it possible to perform transitive closure or other types of
reachability analysis efficiently.

> We need to agree on what is meant by information flow before this
> discussion is useful, so I'll get back to you on this one.
> 

Our documentation has an extensive discussion on how we define
information flow in terms of SELinux policies.

> We use a model checker because our security goals make assertions
> about all possible paths through the information flow graph.  Using
> graph traversal algorithms to perform the same checks would require the
> enumeration of every path in the flow graph.  Furthermore, many paths
> are infinite, so one would have to handle loops.
> 

This is not the case - there is no reason to examine all paths in a
graph to determine whether a flow exists if the graph is carefully
constructed. The bottom line is that none of this is any different from
what network routers do every day and they certainly aren't examining
all paths through a network. Instead, they use algorithms very similar
to the ones that I am using.

Karl

> John
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
