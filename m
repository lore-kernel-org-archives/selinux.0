Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBBKOKRb005485
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 15:24:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBBKNxRV009390
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 20:23:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hBBKNwta009387 for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 20:23:58 GMT
Subject: Re: Information flow models
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>, SE Linux <selinux@tycho.nsa.gov>,
   Joshua Guttman <guttman@mitre.org>
In-Reply-To: <1070906232.6729.53.camel@colossus.columbia.tresys.com>
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	 <1070906232.6729.53.camel@colossus.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1071174228.11140.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 11 Dec 2003 15:23:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-12-08 at 12:57, Karl MacMillan wrote:
> allow a_t b_t : blk_file { read };
> allow c_t b_t : tcp_socket { write };
> 
> If nodes represent types, then the graph might look like this:
> 
> [a_t]<-[b_t]<-[c_t]
> 
> Obviously the "<-" represents an edge. If you follow the edges it
> appears there is a flow between a_t and c_t when in fact there isn't.
> The new version would generate a graph that looks like this:
> 
> [a_t]<-[b_t:blk_file] [b_t:tcp_socket]<-[c_t]
> 
> Clearly no flow between a_t and c_t. This demonstrates why the object
> class information must be present in the nodes.

True in that example, although I wouldn't expect the same type to ever
be applied to both a blk_file and a tcp_socket.  But this approach
breaks down in the case where there is an implicit relationship between
objects of different classes, e.g. the labeling of /proc/pid files with
the domain of the corresponding process.  That yields a situation where:
	allow a_t b_t : file read;
	allow c_t b_t : process signal; # i.e. write
does produce an actual flow between a_t and c_t, because the b_t:file
can be the /proc/pid entries of a b_t process and contain information
about its signal state.

Note that the /proc/pid files should be the only files that are labeled
with domains.  At times, we have discussed the possibility of using a
derived type for each domain's /proc/pid entries, as we already do for
each domain's devpts entries, which would eliminate this overlap
completely.  Not clear if doing that is worthwhile.

> There are also problems
> if you don't separate the types used as source from those used as
> target. 
> One more example:
> 
> allow b_t a_t : blk_file { read };
> allow c_t b_t : blk_file { read };
> 
> If nodes represent types, then the graph might look like this:
> 
> [c_t]<-[b_t]<-[a_t]

As with the above, I wouldn't expect a process and a blk file to ever
have the same type.   A process and a /proc/pid file might have the same
type, but in that case, the above rules would create a flow.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
