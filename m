Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB8HvSRb017724
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 12:57:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB8HuilU012944
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 17:56:44 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
	by jazzswing.ncsc.mil  with ESMTP id hB8HudSX012933
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 17:56:39 GMT
Subject: Re: Information flow models
From: Karl MacMillan <kmacmillan@tresys.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <ogtfzfzqa3g.fsf@divan.mitre.org>
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
Content-Type: text/plain
Message-Id: <1070906232.6729.53.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Mon, 08 Dec 2003 12:57:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-05 at 15:32, John D. Ramsdell wrote:
> Karl MacMillan of Tresys and I were having a discussion about
> information flow models used for policy analysis, and thought the
> people on this list might like to participate.
> 

Thanks for sending this John. I think this is an interesting area and am
very glad to give it some public discussions.

> The Tresys Setools package and MITRE's SLAT analyze SELinux policy
> configurations.  They both extract an abstraction of a policy that
> models information flow within the system.  Both models can be
> described in terms of graphs.  The nodes of the graph say something
> about a security context.  Each edge in the graph is labeled with a
> control requirement, i.e. a class-permission pair.  An edge is in the
> graph if the policy allows information to flow from one node to
> another.  If the edge corresponds to a write-like flow, the source of
> the edge is the subject, and if the edge corresponds to a read-like
> flow, the target of the edge is the subject.
> 
> The two tools differ in what constitutes a node in the model.  In
> SLAT, a node is a security context--a triple consisting of a type, a
> role, and a user.  In Setools, a node is a type.
> 

This description of setools information flow is no longer accurate (not
that you would know that since it does reflect the currently released
version). In the soon to be released version nodes represent either a
type used as a source or a type / object class pair used as a target. It
is necessary to use this representation so that there is a transitive
relation between nodes in the graph (i.e. so that if there is a flow
A->B and a flow B->C there is a flow A->C). If the nodes simply
represent types (or possible contexts) this transitive relation doesn't
hold. Some examples might help. Take this policy snippet (these are the
only rules in the policy):

allow a_t b_t : blk_file { read };
allow c_t b_t : tcp_socket { write };

If nodes represent types, then the graph might look like this:

[a_t]<-[b_t]<-[c_t]

Obviously the "<-" represents an edge. If you follow the edges it
appears there is a flow between a_t and c_t when in fact there isn't.
The new version would generate a graph that looks like this:

[a_t]<-[b_t:blk_file] [b_t:tcp_socket]<-[c_t]

Clearly no flow between a_t and c_t. This demonstrates why the object
class information must be present in the nodes. There are also problems
if you don't separate the types used as source from those used as
target. One more example:

allow b_t a_t : blk_file { read };
allow c_t b_t : blk_file { read };

If nodes represent types, then the graph might look like this:

[c_t]<-[b_t]<-[a_t]

Again, this implies a flow that doesn't exist (between c_t and a_t). The
new version generates a graph that looks like this:

[b_t]<-[a_t:blk_file] [c_t]<-[b_t:blk_file]

This correctly reflects that there are no flow between a_t and c_t.

I have no idea how slat handles these problems (or even if it does). I
tried to empirically test these examples with slat, but couldn't get
things working in the time I had to devote to this.

> Using a security context as a node gives a model that more accurately
> reflects the policy being analyzed,

I'm not convinced that the information gained is useful or important in
the context of information flow. I could definitely be wrong, but so far
I haven't come up with a situation where the full context is needed.
Could you elaborate? Do you have any examples of situations in real
policies where the full context prevented a false positive?

> however, the graphs are large.  As
> a result, the SLAT implementors have had to resort to model checkers
> to perform their analysis.
> 

First, how large are the graphs? I have large policies that create
graphs with over 8,000 nodes that our system handles easily (analysis
takes less than 5 seconds).

Model checkers might be a valid way to solve these problems, but I doubt
that the graphs are large enough that standard graph algorithms fail. It
seems to me if the graph representation is carefully constructed
checking for a flow is a simple test of connectivity that can be
accomplished with a standard search algorithm. Trusted types and paths
can be handled by removing nodes or edges in the graph. If the standard
searches are too slow it should be possible to use disjoint sets. I have
used disjoint sets to do connectivity testing on very large graphs in
the past (tens of thousands of nodes with millions of edges).

> If one ignores role-allow, role-type, user-role, and constraint
> statements in a policy configuration file, one is left with a model in
> which nodes can simply be types.  The graphs in this model are
> obviously much smaller and easier to analyze, however, it may allow
> some flows that are not permitted by a more fine grained analysis.
> The question is: from an engineering perspective, is a more detailed
> analysis worth the overhead of using techniques that handle the large
> graphs?  Most likely, there will be times when an analysis based only
> on types is appropriate, and others when an analysis based on security
> contexts is appropriate, but how does one decide which to use, and when?
> 

I definitely would like to explore these questions. Like I said above, I
can't come up with any compelling reasons to include the context, but I
haven't put much thought into the problem. Since it seems that you have
spent more time on this, could you give some more detail?

Karl

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
