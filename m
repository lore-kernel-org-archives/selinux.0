Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBBKkWRb005624
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 15:46:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBBKjklU026471
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 20:45:46 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
	by jazzswing.ncsc.mil  with ESMTP id hBBKjfSX026462
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 20:45:41 GMT
Subject: Re: Information flow models
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "John D. Ramsdell" <ramsdell@mitre.org>, SE Linux <selinux@tycho.nsa.gov>,
   Joshua Guttman <guttman@mitre.org>
In-Reply-To: <1071174228.11140.127.camel@moss-spartans.epoch.ncsc.mil>
References: <ogtfzfzqa3g.fsf@divan.mitre.org>
	 <1070906232.6729.53.camel@colossus.columbia.tresys.com>
	 <1071174228.11140.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1071175582.6729.227.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 11 Dec 2003 15:46:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-12-11 at 15:23, Stephen Smalley wrote:

> > [a_t]<-[b_t:blk_file] [b_t:tcp_socket]<-[c_t]
> > 
> > Clearly no flow between a_t and c_t. This demonstrates why the object
> > class information must be present in the nodes.
> 
> True in that example, although I wouldn't expect the same type to ever
> be applied to both a blk_file and a tcp_socket.
>   But this approach
> breaks down in the case where there is an implicit relationship between
> objects of different classes, e.g. the labeling of /proc/pid files with
> the domain of the corresponding process.  That yields a situation where:
> 	allow a_t b_t : file read;
> 	allow c_t b_t : process signal; # i.e. write
> does produce an actual flow between a_t and c_t, because the b_t:file
> can be the /proc/pid entries of a b_t process and contain information
> about its signal state.
> 

Interesting. This seems like a special case to me - "implicit
relationship" seems to mean that the information is flowing to that proc
file outside of the control of the policy. Just to make certain that I
understand, am I correct that information can only flow to proc files in
this example? In other words, if there was a plain text file labeled b_t
no information could flow through it from c_t to a_t without another
rule:

allow b_t b_t : file write;

Are there any implicit relationships like this?

> Note that the /proc/pid files should be the only files that are labeled
> with domains.  At times, we have discussed the possibility of using a
> derived type for each domain's /proc/pid entries, as we already do for
> each domain's devpts entries, which would eliminate this overlap
> completely.  Not clear if doing that is worthwhile.
> 

I'm not certain if it is worth it either - we are looking for overt
flows and much of the information in proc would seem to be covert.

> > There are also problems
> > if you don't separate the types used as source from those used as
> > target. 
> > One more example:
> > 
> > allow b_t a_t : blk_file { read };
> > allow c_t b_t : blk_file { read };
> > 
> > If nodes represent types, then the graph might look like this:
> > 
> > [c_t]<-[b_t]<-[a_t]
> 
> As with the above, I wouldn't expect a process and a blk file to ever
> have the same type.   A process and a /proc/pid file might have the same
> type, but in that case, the above rules would create a flow.

I agree that this isn't a likely situation (we have yet to see this
false positive in a real policy), but one of the goals of automated
tools is to detect poorly written policies. However, both of these
strategies help prevent a false positive where it can appear that
information flows between 2 objects without a subject, which is a likely
situation.

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
