Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5KXdRb007898
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 15:33:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB5KWXlU013167
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 20:32:48 GMT
Received: from smtp-bedford.mitre.org (smtp-bedford-x.mitre.org [192.160.51.76])
	by jazzswing.ncsc.mil  with ESMTP id hB5KVtSX013129
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 20:32:12 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id hB5KWZU04862
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 15:32:35 -0500
To: "SE Linux" <selinux@tycho.nsa.gov>
Cc: ramsdell@mitre.org
Subject: Information flow models
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 05 Dec 2003 15:32:35 -0500
In-Reply-To: <BAY1-DAV25idcOHuICu0000353b@hotmail.com>
Message-ID: <ogtfzfzqa3g.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan of Tresys and I were having a discussion about
information flow models used for policy analysis, and thought the
people on this list might like to participate.

The Tresys Setools package and MITRE's SLAT analyze SELinux policy
configurations.  They both extract an abstraction of a policy that
models information flow within the system.  Both models can be
described in terms of graphs.  The nodes of the graph say something
about a security context.  Each edge in the graph is labeled with a
control requirement, i.e. a class-permission pair.  An edge is in the
graph if the policy allows information to flow from one node to
another.  If the edge corresponds to a write-like flow, the source of
the edge is the subject, and if the edge corresponds to a read-like
flow, the target of the edge is the subject.

The two tools differ in what constitutes a node in the model.  In
SLAT, a node is a security context--a triple consisting of a type, a
role, and a user.  In Setools, a node is a type.

Using a security context as a node gives a model that more accurately
reflects the policy being analyzed, however, the graphs are large.  As
a result, the SLAT implementors have had to resort to model checkers
to perform their analysis.

If one ignores role-allow, role-type, user-role, and constraint
statements in a policy configuration file, one is left with a model in
which nodes can simply be types.  The graphs in this model are
obviously much smaller and easier to analyze, however, it may allow
some flows that are not permitted by a more fine grained analysis.
The question is: from an engineering perspective, is a more detailed
analysis worth the overhead of using techniques that handle the large
graphs?  Most likely, there will be times when an analysis based only
on types is appropriate, and others when an analysis based on security
contexts is appropriate, but how does one decide which to use, and when?

John





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
