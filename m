Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBBG4GRb004037
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 11:04:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBBG4GRV026593
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 16:04:16 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id hBBG4Fta026583 for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 16:04:15 GMT
Subject: Re: Information flow models
From: Karl MacMillan <kmacmillan@tresys.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: "Joshua D. Guttman disp: current" <guttman@mitre.org>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <ogtr7zbebzr.fsf@divan.mitre.org>
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	 <1070906232.6729.53.camel@colossus.columbia.tresys.com>
	 <ogtu148yfom.fsf@divan.mitre.org>
	 <1071069077.6729.108.camel@colossus.columbia.tresys.com>
	 <ogt8ylky9mn.fsf@divan.mitre.org>
	 <1071070628.6729.118.camel@colossus.columbia.tresys.com>
	 <nha3cbsv6fv.fsf@malabar.mitre.org>
	 <1071087506.6729.175.camel@colossus.columbia.tresys.com>
	 <ogtr7zbebzr.fsf@divan.mitre.org>
Content-Type: text/plain
Message-Id: <1071158641.6729.185.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 11 Dec 2003 11:04:01 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-12-11 at 08:10, John D. Ramsdell wrote:
> Karl MacMillan <kmacmillan@tresys.com> writes:
> 
> > The arrows are directed edges (arcs if you prefer). They mean that
> > there was 1 or more allow rules that defined an information flow
> > between the nodes.
> 
> and from a previous note:
> 
> > Obviously the "<-" represents an edge. If you follow the edges it
> > appears there is a flow between a_t and c_t when in fact there isn't.
> > The new version would generate a graph that looks like this:
> >
> > [a_t]<-[b_t:blk_file] [b_t:tcp_socket]<-[c_t]
> 
> You documentation states that flows occur between types, but your
> graph has type class pairs as nodes, sometimes as a source and
> sometimes as a destination.  What does it mean for information to
> originate from b_t:blk_file?  What does it mean for information to get
> to b_t:tcp_socket?
> 

The nodes are simply more specific - if information flows between a_t
(as a source) and b_t (as a target associated with blk_file) it means
that there was a flow between a_t and b_t. My graph simply records more
of the specifics: that a_t was the source in the allow rule and b_t was
associated with a blk_file object class in the allow rule (the specific
permission is recored in the edge). There are a lot of details required
for a flow to be valid: i.e. one of the types must be in the source
field of the rule, one of the types must be in the target field, there
must be an associated object class, and the permission on the object
class must map to a read and/or write. My graph representation simply
reflects this. If you have nodes with only types (or type plus role and
user) you lose a lot of information that is required to determine if a
multi-step path is valid.

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
