Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87JGqrT028786
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 15:16:52 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87JGpll024231
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 19:16:51 GMT
Subject: Re: Please review openssh patch for selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <4139A554.9020604@redhat.com>
References: <200408241818.40064.russell@coker.com.au>
	 <41371628.2020408@redhat.com>
	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
	 <200409022338.20644.russell@coker.com.au>
	 <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
	 <413741A3.3070305@redhat.com>
	 <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
	 <41377927.3080703@redhat.com>
	 <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>
	 <41377E8A.2030707@redhat.com>
	 <1094215690.19206.73.camel@moss-spartans.epoch.ncsc.mil>
	 <4139A554.9020604@redhat.com>
Content-Type: text/plain
Message-Id: <1094584497.15891.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 07 Sep 2004 15:14:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-09-04 at 07:21, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> >As per the earlier discussion on the list, I think we want a new
> >libselinux function similar to get_default_context() that also takes the
> >optional role, and rather than simply substituting the role (if
> >specified) and its default type, it would check the array returned by
> >get_ordered_context_list for the first entry that matches the role and
> >return the entry or fail if no such entry exists.  That would ensure
> >that we immediately abort if the role is not reachable by sshd, and also
> >allow an admin to prevent use of this feature for a given role simply by
> >not listing it in the sshd entry in defualt_contexts.
> >
> >  
> >
> Ok, can you create the function?

Ok, done.  Function prototype is:

int get_default_context_with_role(const char* user, 
				  const char *role,
				  security_context_t fromcon,
				  security_context_t *newcon);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
