Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FCorI4017529
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 08:50:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4FCoXl5004083
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 12:50:33 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h4FCoXNc004080
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 12:50:33 GMT
Subject: Re: about the safety problem in SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux list <selinux_list@yahoo.it>
Cc: Russell Coker <russell@coker.com.au>, Pete Loscocco <pal@epoch.ncsc.mil>,
   Howard Holm <hdholm@epoch.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <3EC2C366.5060901@yahoo.it>
References: <3EC2792D.1020209@yahoo.it>
	 <200305150539.40186.russell@coker.com.au>  <3EC2C366.5060901@yahoo.it>
Content-Type: text/plain
Message-Id: <1053003033.4729.674.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 May 2003 08:50:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-05-14 at 18:29, selinux list wrote:  
> This is exactly what is prescribed by TE (and its variants like DTE).
> It is why I am so sure the safety problem in SELinux is so trivially
> solved...SELinux should be safe because with Type Enforcement every
> time a subject moves from a domain to another domain, the rights it
> had are lost and others are acquired. 

SELinux implements MAC, so a process cannot transfer rights
(descriptors) to another process unless the recipient process is also
authorized to access the object in the same manner by the MAC policy
(which can only be changed administratively).  SELinux controls
descriptor inheritance across execve (when security context transitions
occur for a process) and descriptor transfer via Unix domain socket IPC.
It also typically revalidates permission on access to deal with
revocation due to a file relabel or policy change; however, this is not
yet complete - we do not presently provide revocation for memory-mapped
files.  Security context transitions are controlled by the policy, as
are file relabels.

Of course, proving specific security properties requires an analysis of
the particular policy configuration.  SELinux just provides the
mechanism for enforcing the policy.

> I completely agree, but SELinux seems safe to me not becouse of RBAC
> support (it is just a user-centric concept to group some user
> identities to assign to some domains...probably SELinux could work
> fine even without RBAC support at all...), but thanks to TE.

Correct.  However, some people like to use the RBAC component as a
further boundary on domain transitions, e.g. you could potentially allow
domain D1 to transition to domain D2 but only permit role R1 to enter
domain D1 and role R2 to enter domain D1 and domain D2.  Using the RBAC
component in that manner is a bit dangerous, as you have to make sure
that there aren't any other permissions granted from D1 to D2 that could
allow R1:D1 to interfere with R2:D2, e.g. signal permissions.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
