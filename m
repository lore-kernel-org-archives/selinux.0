Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBBDApRb002912
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 08:10:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBBD9nlU017927
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 13:09:49 GMT
Received: from smtp-bedford.mitre.org (smtp-bedford-x.mitre.org [192.160.51.76])
	by jazzswing.ncsc.mil  with ESMTP id hBBD9nSX017924
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 13:09:49 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id hBBDAYU06144
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 08:10:34 -0500
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "Joshua D. Guttman disp: current" <guttman@mitre.org>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Information flow models
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	<1070906232.6729.53.camel@colossus.columbia.tresys.com>
	<ogtu148yfom.fsf@divan.mitre.org>
	<1071069077.6729.108.camel@colossus.columbia.tresys.com>
	<ogt8ylky9mn.fsf@divan.mitre.org>
	<1071070628.6729.118.camel@colossus.columbia.tresys.com>
	<nha3cbsv6fv.fsf@malabar.mitre.org>
	<1071087506.6729.175.camel@colossus.columbia.tresys.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 11 Dec 2003 08:10:32 -0500
In-Reply-To: <1071087506.6729.175.camel@colossus.columbia.tresys.com>
Message-ID: <ogtr7zbebzr.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan <kmacmillan@tresys.com> writes:

> The arrows are directed edges (arcs if you prefer). They mean that
> there was 1 or more allow rules that defined an information flow
> between the nodes.

and from a previous note:

> Obviously the "<-" represents an edge. If you follow the edges it
> appears there is a flow between a_t and c_t when in fact there isn't.
> The new version would generate a graph that looks like this:
>
> [a_t]<-[b_t:blk_file] [b_t:tcp_socket]<-[c_t]

You documentation states that flows occur between types, but your
graph has type class pairs as nodes, sometimes as a source and
sometimes as a destination.  What does it mean for information to
originate from b_t:blk_file?  What does it mean for information to get
to b_t:tcp_socket?

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
