Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBADINRb027541
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 08:18:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBADHYlU027813
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 13:17:34 GMT
Received: from smtp-bedford.mitre.org (smtp-bedford-x.mitre.org [192.160.51.76])
	by jazzswing.ncsc.mil  with ESMTP id hBADHYSX027810
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 13:17:34 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id hBADIIU02353
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 08:18:18 -0500
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Information flow models
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	<1070906232.6729.53.camel@colossus.columbia.tresys.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 10 Dec 2003 08:18:17 -0500
In-Reply-To: <1070906232.6729.53.camel@colossus.columbia.tresys.com>
Message-ID: <ogtu148yfom.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@tresys.com> writes:

> In the soon to be released version nodes represent either a
> type used as a source or a type / object class pair used as a
> target. 

...

> The new version would generate a graph that looks like this:
> 
> [a_t]<-[b_t:blk_file] [b_t:tcp_socket]<-[c_t]

I'm afraid I am unable to understand the model of information flow you
describe.  I expected a permission would be a part of what is used to
label either an edge or a node, but no such label appears.

The mls file I'm currently using states that system calls that must
meet the file getattr control requirement have read-like flow, and the
ones that meet the file setattr control requirement have write-like
flow.  System calls that must meet file relabelfrom have information
flow in both direction, and the ones that meet file lock have no flow
as a result of this requirement.

How does your representation handle information flow caused by system
calls that must meet the file setattr control requirement?

Additionally, please expand on the discussion on transitivity.  I
could not see why you changed away from nodes as types, and edges
labeled with a control requirement.  What was the motivation for the
change?

> I have no idea how slat handles these problems (or even if it does). I
> tried to empirically test these examples with slat, but couldn't get
> things working in the time I had to devote to this.

If you send me specific questions with transcripts, I'll help you get
slat running.  Be sure to include a description of the platform on
which you are running slat.  As a first pass, I recommend running on a
version of Linux that does not have SELinux enabled so you don't have
to worry about policy violations.  Model checking goes faster if you
have a machine with muscle.

> > Using a security context as a node gives a model that more accurately
> > reflects the policy being analyzed,
> 
> I'm not convinced that the information gained is useful or important in
> the context of information flow.

We need to agree on what is meant by information flow before this
discussion is useful, so I'll get back to you on this one.

> First, how large are the graphs? I have large policies that create
> graphs with over 8,000 nodes that our system handles easily
> (analysis takes less than 5 seconds).
>
> Model checkers might be a valid way to solve these problems, but I
> doubt that the graphs are large enough that standard graph
> algorithms fail.

We use a model checker because our security goals make assertions
about all possible paths through the information flow graph.  Using
graph traversal algorithms to perform the same checks would require the
enumeration of every path in the flow graph.  Furthermore, many paths
are infinite, so one would have to handle loops.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
